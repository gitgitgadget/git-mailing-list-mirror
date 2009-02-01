From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] split notes [was: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)]
Date: Sun, 01 Feb 2009 16:09:20 +1300
Message-ID: <1233455960.17688.122.camel@maia.lan>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901220606040.3586@pacific.mpi-cbg.de>
	 <1233384354.10045.170.camel@maia.lan>
	  <20090131073640.GF3033@coredump.intra.peff.net>
Mime-Version: 1.0
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 04:11:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTSkI-00043w-W8
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 04:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZBADKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 22:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbZBADKP
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 22:10:15 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:48335 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbZBADKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 22:10:14 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 51FF221D985; Sun,  1 Feb 2009 16:09:56 +1300 (NZDT)
In-Reply-To: <20090131073640.GF3033@coredump.intra.peff.net>
X-Mailer: Devolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107975>

[re-sent with correct envelope from so hopefully it will get to the
list this time]

On Sat, 2009-01-31 at 02:36 -0500, Jeff King wrote:
> Actually, lookup is even easier than that: we iterate through the entire
> tree recursively and add everything to a flat hash. So we really don't
> care there what the layout is like (just take the first 40 characters of
> any directory name as a hash).

Sure, but if you do want to scale to a hundred thousand notes, then I
think it would pay to have a plan for making it lazy as required.  ie,
if a run just wants notes for 20 commits and there are 256 sub-trees
then only read 20 of them.  Doesn't matter if it's not implemented
initially of course, so long as the on-disk format is supported by the
tools in the first release they will be backward compatible.  And it's
not that complicated; see attached.

> But it violates the usual git principle of "content has a unique name".
> What happens when I add "a/b" and you add "ab"? A dumb merge will let
> both co-exist, but which one do you return for lookup?

It should only be tools adding to it, the trees shouldn't be modified
directly by users.  In the below patch I make these all get deleted on
'git notes edit'.

Depending on the semantics of the notes, it might not be an error to
have multiple notes for a commit.  In my patch this is "tolerated" to
some extent but not supported by git-notes.sh porcelain yet.

> I agree that there should be multiple note hierarchies, and multiple
> keys within each hierarchy. I have posted some thoughts on that before
> (and you should be able to find them searching for "notes" in the list
> archive), but unfortunately I have not had time to sit down and really
> work out a notes implementation that matches what I posted (which I
> don't think is that far from Dscho's work in next).

I had a brief look and couldn't find it, this was about the best one I
found from you in terms of links to previous discussions;
http://kerneltrap.org/mailarchive/git/2008/12/16/4427794 If there's
another thread you'd like me to read please fish it out and respond!
The more messages we have linking to the previous discussions the
better :).

> And I think what you are proposing (here and in the rest of your
> message) is that certain notes hierarchies may have particular formats
> and semantics. And that sounds reasonable to me.

Yes that was one part of it.  But also make a convention that the
'commits' notes, ie the default ones, an RFC822 message if they begin
with "known" headers.  Then porcelain such as log can inject them into
the fields at the appropriate point.

Anyway, without further ado here's the XX/XXXX split patch.

Subject: [PATCH] git-notes: allow for arbitrary split of entries into sub-trees

It might later turn out for performance reasons that a single tree for
notes will not be sufficient.  While this does not solve the
performance problem as it still loads the entire lot of notes into a
hash at start-up, it does mean that such a change does not have to
worry about backward compatibility with git versions that don't yet
support it.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-notes.sh     |   45 ++++++++++++++++++++++++++++++++++++++-------
 notes.c          |   39 ++++++++++++++++++++++++++++++++-------
 t/t3301-notes.sh |   11 +++++++++++
 3 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/git-notes.sh b/git-notes.sh
index bfdbaa8..e07499f 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -10,15 +10,35 @@ ACTION="$1"; shift
 
 test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="$(git config core.notesref)"
 test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="refs/notes/commits"
+export GIT_NOTES_REF
 
 COMMIT=$(git rev-parse --verify --default HEAD "$@") ||
 die "Invalid commit: $@"
+NOTES_PATH=$COMMIT
+case "$GIT_NOTES_SPLIT" in
+	[1-9]|[1-4][0-9])
+		NOTES_PATH=$( echo $COMMIT | perl -pe 's{^(.{'$GIT_NOTES_SPLIT'})}{$1/}' )
+		;;
+esac
 
 MESSAGE="$GIT_DIR"/new-notes-$COMMIT
 trap '
 	test -f "$MESSAGE" && rm "$MESSAGE"
 ' 0
 
+show_note() {
+	COMMIT=$1
+	NOTE_PATH=$( git ls-tree --name-only -r $GIT_NOTES_REF | perl -nle '
+		$x = $_; s{/}{}g;
+		if (m{'$COMMIT'}) {
+			print $x;
+			exit;
+		}
+	' )
+	[ -n "$NOTE_PATH" ] &&
+		git cat-file blob $GIT_NOTES_REF:$NOTE_PATH
+}
+
 case "$ACTION" in
 edit)
 	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
@@ -32,7 +52,7 @@ edit)
 	else
 		PARENT="-p $CURRENT_HEAD"
 		git read-tree "$GIT_NOTES_REF" || die "Could not read index"
-		git cat-file blob :$COMMIT >> "$MESSAGE" 2> /dev/null
+		show_note $COMMIT >> "$MESSAGE"
 	fi
 
 	${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
@@ -42,15 +62,26 @@ edit)
 	if [ -s "$MESSAGE" ]; then
 		BLOB=$(git hash-object -w "$MESSAGE") ||
 			die "Could not write into object database"
-		git update-index --add --cacheinfo 0644 $BLOB $COMMIT ||
+		git update-index --add --cacheinfo 0644 $BLOB $NOTES_PATH ||
 			die "Could not write index"
 	else
-		test -z "$CURRENT_HEAD" &&
-			die "Will not initialise with empty tree"
-		git update-index --force-remove $COMMIT ||
-			die "Could not update index"
+		NOTES_PATH=dummy
 	fi
 
+	git ls-files | perl -nle '
+		$x = $_; s{/}{}g;
+		if (m{'$COMMIT'} and $x ne q{'$NOTES_PATH'}) {
+			print $x;
+		}' |
+		while read path
+			do
+				git update-index --force-remove $path ||
+			    		die "Could not update index"
+			done
+	
+	[ -z "$(git ls-files)" -a -z "$CURRENT_HEAD" ] &&
+		die "Will not initialise with empty tree"
+
 	TREE=$(git write-tree) || die "Could not write tree"
 	NEW_HEAD=$(echo Annotate $COMMIT | git commit-tree $TREE $PARENT) ||
 		die "Could not annotate"
@@ -58,7 +89,7 @@ edit)
 		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
 ;;
 show)
-	git show "$GIT_NOTES_REF":$COMMIT
+	show_note $COMMIT
 ;;
 *)
 	usage
diff --git a/notes.c b/notes.c
index bd73784..d763b50 100644
--- a/notes.c
+++ b/notes.c
@@ -70,28 +70,53 @@ static void add_entry(const unsigned char *commit_sha1,
 	hashcpy(hash_map.entries[index].notes_sha1, notes_sha1);
 }
 
-static void initialize_hash_map(const char *notes_ref_name)
+static void initialize_hash_map_recursive(const char *tree_sha1, const char *path)
 {
 	unsigned char sha1[20], commit_sha1[20];
+	unsigned char path_combined[40];
 	unsigned mode;
 	struct tree_desc desc;
 	struct name_entry entry;
+	int length = strlen(path);
+	int length_combined;
 	void *buf;
 
-	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
-	    get_tree_entry(commit_sha1, "", sha1, &mode))
+	strcpy(path_combined, path);
+
+	if (get_tree_entry(tree_sha1, "", sha1, &mode))
 		return;
 
 	buf = fill_tree_descriptor(&desc, sha1);
 	if (!buf)
-		die("Could not read %s for notes-index", sha1_to_hex(sha1));
+		die("Could not read %s for notes-index", sha1_to_hex(tree_sha1));
+
+	while (tree_entry(&desc, &entry)) {
+		length_combined = length + strlen(entry.path);
+		if (length_combined >= 40) {
+			strncpy(path_combined + length, entry.path,
+				41 - length);
+			if (!get_sha1(path_combined, commit_sha1))
+				add_entry(commit_sha1, entry.sha1);
+		}
+		else {
+			strcpy(path_combined + length, entry.path);
+			initialize_hash_map_recursive(entry.sha1, path_combined);
+		}
+	}
 
-	while (tree_entry(&desc, &entry))
-		if (!get_sha1(entry.path, commit_sha1))
-			add_entry(commit_sha1, entry.sha1);
 	free(buf);
 }
 
+static void initialize_hash_map(const char *notes_ref_name)
+{
+	unsigned char commit_sha1[20];
+
+	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1))
+		return;
+
+	initialize_hash_map_recursive( commit_sha1, "" );
+}
+
 static unsigned char *lookup_notes(const unsigned char *commit_sha1)
 {
 	int index;
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 9393a25..3734b55 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -92,4 +92,15 @@ test_expect_success 'show multi-line notes' '
 	test_cmp expect-multiline output
 '
 
+test_expect_success 'create split notes tree' '
+	: > a4 &&
+	git add a4 &&
+	test_tick &&
+	git commit -m 4th &&
+	MSG="b4" GIT_NOTES_SPLIT=2 git notes edit &&
+	[ "$(git notes show)" = "b4" ] &&
+	[ -n "$(git ls-tree --name-only -r refs/notes/commits | grep /)" ] &&
+	[ -n "$(git log -1 | grep Notes:)" ]
+'
+
 test_done
-- 
debian.1.5.6.1
