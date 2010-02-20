From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 11/12] filter-branch: learn how to filter notes
Date: Sat, 20 Feb 2010 23:16:32 +0100
Message-ID: <09f864c096dd15378ebabbc294c959da555da5fa.1266703765.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 00:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nixdc-0006LF-AU
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 23:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab0BTWRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 17:17:22 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:6942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756903Ab0BTWRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 17:17:15 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:58 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:39 +0100
X-Mailer: git-send-email 1.7.0.137.gfe3f1
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140569>

Teach filter-branch a new option --notes-filter that acts as a pipe
filter (much like --msg-filter) for the commit notes.  For consistency
with the note copying support in amend/rebase, it defaults to 'cat' if
notes.rewrite.filter-branch is set.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config.txt            |    8 ++++++--
 Documentation/git-filter-branch.txt |   13 +++++++++++++
 Documentation/githooks.txt          |    8 ++++----
 git-filter-branch.sh                |   18 +++++++++++++++++-
 t/t7003-filter-branch.sh            |   22 ++++++++++++++++++++++
 5 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9c3b337..5e1d734 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1312,8 +1312,8 @@ GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
 
 notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, git
+	When rewriting commits with <command> (currently `amend`,
+	`rebase` or `filter-branch`) and this variable is set to `true`, git
 	automatically copies your notes from the original to the
 	rewritten commit.  Defaults to `true`, but see
 	"notes.rewriteRef" below.
@@ -1324,6 +1324,10 @@ notes.rewriteMode::
 	the target commit already has a note.  Must be one of
 	`overwrite`, `concatenate`, or `ignore`.  Defaults to
 	`concatenate`.
++
+Note that 'git-filter-branch' ignores this setting and always
+overwrites; see the description of `--notes-filter` in
+linkgit:git-filter-branch[1].
 
 notes.rewriteRef::
 	When copying notes during a rewrite, specifies the ref whose
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 28a705f..6fd97d7 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -161,6 +161,19 @@ to other tags will be rewritten to point to the underlying commit.
 	The result will contain that directory (and only that) as its
 	project root.  Implies --remap-to-ancestor.
 
+--notes-filter <command>::
+	This filter rewrites the notes (see linkgit:git-notes[1]).  It
+	gets the old notes on standard input, and its standard output
+	is written as the new note (overwriting any existing notes).
++
+Defaults to doing nothing, unless the `notes.rewrite.filter-branch`
+option is set, in which case it copies the notes (i.e., defaults to
+`cat`).
++
+In addition to the usual variables, GIT_NEW_COMMIT is set to the
+result of the rewriting so that the filter can get at the existing
+notes, if any.
+
 --remap-to-ancestor::
 	Rewrite refs to the nearest rewritten ancestor instead of
 	ignoring them.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index c33a38e..f9252dd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -350,11 +350,11 @@ rebase::
 filter-branch::
 	Commits that were processed by 'git-filter-branch', but not
 	changed, are not included in the list.  If the list is empty
-	after this filtering, the hook is not invoked at all.
+	after this filtering, the hook is not invoked at all.  Also
+	see the `--post-rewrite` option in
+	linkgit:git-filter-branch[1].
 
-There is no default 'post-rewrite' hook, but see the
-`post-receive-copy-notes` script in `contrib/hooks` for an example
-that copies your git-notes to the rewritten commits.
+There is no default 'post-rewrite' hook.
 
 
 GIT
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 301c497..ad2da4e 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -101,7 +101,7 @@ USAGE="[--env-filter <command>] [--tree-filter <command>]
             [--index-filter <command>] [--parent-filter <command>]
             [--msg-filter <command>] [--commit-filter <command>]
             [--tag-name-filter <command>] [--subdirectory-filter <directory>]
-	    [--post-rewrite <command>]
+	    [--post-rewrite <command>] [--notes-filter <command>]
             [--original <namespace>] [-d <directory>] [-f | --force]
             [<rev-list options>...]"
 
@@ -134,6 +134,12 @@ else
 	post_rewrite=:
 fi
 
+if test "$(git config --bool notes.rewrite.filter-branch)"; then
+	filter_notes=cat
+else
+	filter_notes=
+fi
+
 while :
 do
 	case "$1" in
@@ -198,6 +204,9 @@ do
 		filter_subdir="$OPTARG"
 		remap_to_ancestor=t
 		;;
+	--notes-filter)
+		filter_notes="$OPTARG"
+		;;
 	--post-rewrite)
 		post_rewrite="$OPTARG"
 		post_rewrite_given=t
@@ -374,6 +383,13 @@ while read commit parents; do
 	if test $commit != $new_commit; then
 		echo $commit $new_commit >> "$workdir"/../rewritten
 	fi
+	if test -n "$filter_notes"; then
+		if git notes show $commit >../note 2>/dev/null; then
+			export GIT_NEW_COMMIT="$new_commit"
+			eval "$filter_notes" <../note |
+			git notes add -F- -f $new_commit
+		fi
+	fi
 done <../revs
 
 # If we are filtering for paths, as in the case of a subdirectory
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 0da13a8..6dc21e8 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -306,6 +306,28 @@ test_expect_success '--remap-to-ancestor with filename filters' '
 	test $orig_invariant = $(git rev-parse invariant)
 '
 
+test_expect_success '--notes-filter off' '
+	git checkout master &&
+	test_commit notes-foo &&
+	git notes add -mtestnote &&
+	git filter-branch -f --tree-filter "touch notes-1" HEAD^.. &&
+	test_must_fail git notes show
+'
+
+test_expect_success '--notes-filter manually' '
+	git reset --hard notes-foo &&
+	git filter-branch -f --notes-filter "sed s/test/foo/" \
+		--tree-filter "touch notes-2" HEAD^.. &&
+	test foonote = "$(git notes show)"
+'
+
+test_expect_success '--notes-filter implicit' '
+	git reset --hard notes-foo &&
+	git config notes.rewrite.filter-branch true &&
+	git filter-branch -f --tree-filter "touch notes-3" HEAD^.. &&
+	test testnote = "$(git notes show)"
+'
+
 test_expect_success 'setup submodule' '
 	rm -fr ?* .git &&
 	git init &&
-- 
1.7.0.59.g783f8
