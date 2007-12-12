From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Tue, 11 Dec 2007 19:12:54 -0800
Message-ID: <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
References: <20071211195712.GA3865@bitplanet.net>
	<Pine.LNX.4.64.0712111549490.5349@iabervon.org>
	<1197416286.7552.4.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 04:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2I2R-0002A5-4A
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 04:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbXLLDNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 22:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbXLLDNL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 22:13:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbXLLDNJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 22:13:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5226A53AF;
	Tue, 11 Dec 2007 22:13:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A98D953AC;
	Tue, 11 Dec 2007 22:12:57 -0500 (EST)
In-Reply-To: <1197416286.7552.4.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Tue, 11 Dec 2007 18:38:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67986>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> On Tue, 2007-12-11 at 15:59 -0500, Daniel Barkalow wrote:
>> On Tue, 11 Dec 2007, Kristian H=C3=B8gsberg wrote:
>>=20
>> > Ok, don't flame me, I know this isn't appropriate at the moment wi=
th
>> > stabilization for 1.5.4 going on, but I just wanted to post a head=
s up
>> > on this work to avoid duplicate effort.  It's one big patch at thi=
s point
>> > and I haven't even run the test suite yet, but that will change.
>>=20
>> Is that why you misspelled Junio's email address? :)=20
>
> Hehe, yeah, do not mess with maintainers in release mode :)

Actually this is a bit unfortunate, regardless of everybody being in
release and bugfix only mode.

I was hoping that the evolution path for clone would be to first make i=
t
a very thin wrapper around:

	git init
        git remote add -f
        git checkout

sequence.  Currently, the "origin" repository is not quite equal to
other remotes added with "git remote add", but if we enhance "git remot=
e
add" a bit, we should be able to make this happen.  This would hopefull=
y
lose a lot of code from git-clone.  And then after we are done with
that, rewrite the remaining thin wrapper in C.

There are a handful issues in that approach with the current git-remote=
,
and that was why I also thought recent "git remote in C" by Dscho a bit
unfortunate, as enhancements and interface fixes (both user and machine=
)
tend to be much easier in scripted version.

What the current "git clone" does that are not naturally expressed by
the above sequence are:

 * HEAD discovery

   The code can be lifted from the scripted version and transplanted to
   git-remote.  And to make "origin" and other remotes added by "git
   remote add", this logic needs to be moved to "git remote".

   However, before rewriting the "git remote" to C, it would be really
   nice if we can update the native protocol so that we can reliably
   find out which branch HEAD points at.  The current code guesses, onl=
y
   because the native protocol does not carry that information [*1*].
   Worse yet, even though the current code _knows_ this information whe=
n
   going over dumb protocols, it discards it to use the same guessing
   logic as used by the native protocol.

 * --shared optimization

   This is a very easy addition to "git remote add".  You make sure tha=
t
   the added remote repository is on a local machine, and set up
   alternates to point at its object store.

 * --reference optimization

   This is a bit more involved than --shared.  Half the power of this
   optimization is coming from setting up alternates to point at anothe=
r
   local repository, which allows you not to have to _store_ duplicated
   objects yourself, but the other half is coming from being able to li=
e
   to the repository being cloned from that you have branches and tags
   that reference repository has, even though they are not your branche=
s
   and tags, which allows you not to have to _download_ the objects to
   begin with.

   I think this can be added to "git remote add" by making --reference
   also imply -f.  Then while "git remote add" sets up the new remote,
   it can stash the borrowed refs somewhere, just like git-clone does,
   run the git-fetch, and then remove the borrowed refs once done.

 * local optimization (the "cpio" thing)

   I think this part needs to stay in git-clone even after we move the
   above to "git remote add".


[Footnote]

*1* Here is a demonstration of the necessary protocol extension.

-- >8 --
Implement show-symref protocol extension.

This updates the git native "upload-pack" protocol to carry extra
information to show which branch HEAD symref points at.  As is the othe=
r
protocol extension, this is enabled only when both ends of the exchange
supports it.

The receiving end currently does not do anything, and the logic needs t=
o
go to peek-remote more than it needs to go to fetch-pack, but one has t=
o
start from somewhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fetch-pack.c |   86 +++++++++++++++++++++++++++++++++---------=
-------
 upload-pack.c        |   25 +++++++++++++-
 2 files changed, 81 insertions(+), 30 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 807fa93..e9f86d6 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -32,7 +32,7 @@ static const char fetch_pack_usage[] =3D
 #define MAX_IN_VAIN 256
=20
 static struct commit_list *rev_list;
-static int non_common_revs, multi_ack, use_sideband;
+static int non_common_revs, multi_ack, use_sideband, show_symref;
=20
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -141,6 +141,51 @@ static const unsigned char* get_rev(void)
 	return commit->object.sha1;
 }
=20
+static void handle_shallow(int fd[2])
+{
+	char line[1024];
+	unsigned char sha1[20];
+	int len;
+
+	while ((len =3D packet_read_line(fd[0], line, sizeof(line)))) {
+		if (!prefixcmp(line, "shallow ")) {
+			if (get_sha1_hex(line + 8, sha1))
+				die("invalid shallow line: %s", line);
+			register_shallow(sha1);
+			continue;
+		}
+		if (!prefixcmp(line, "unshallow ")) {
+			if (get_sha1_hex(line + 10, sha1))
+				die("invalid unshallow line: %s", line);
+			if (!lookup_object(sha1))
+				die("object not found: %s", line);
+			/* make sure that it is parsed as shallow */
+			parse_object(sha1);
+			if (unregister_shallow(sha1))
+				die("no shallow found: %s", line);
+			continue;
+		}
+		die("expected shallow/unshallow, got %s", line);
+	}
+}
+
+static void handle_symref(int fd[2], struct ref *refs)
+{
+	char line[1024];
+	int len;
+
+	while ((len =3D packet_read_line(fd[0], line, sizeof(line)))) {
+		if (!prefixcmp(line, "symref ")) {
+			/*
+			 * Here you would remember what symbolic ref
+			 * pointed at what real ref to use that
+			 * information later.
+			 */
+			fputs(line, stderr);
+		}
+	}
+}
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
@@ -173,8 +218,9 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 		}
=20
 		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s%s%s\n",
+			packet_write(fd[1], "want %s%s%s%s%s%s%s%s\n",
 				     sha1_to_hex(remote),
+				     (show_symref ? " show-symref" : ""),
 				     (multi_ack ? " multi_ack" : ""),
 				     (use_sideband =3D=3D 2 ? " side-band-64k" : ""),
 				     (use_sideband =3D=3D 1 ? " side-band" : ""),
@@ -193,32 +239,11 @@ static int find_common(int fd[2], unsigned char *=
result_sha1,
 	if (!fetching)
 		return 1;
=20
-	if (args.depth > 0) {
-		char line[1024];
-		unsigned char sha1[20];
-		int len;
-
-		while ((len =3D packet_read_line(fd[0], line, sizeof(line)))) {
-			if (!prefixcmp(line, "shallow ")) {
-				if (get_sha1_hex(line + 8, sha1))
-					die("invalid shallow line: %s", line);
-				register_shallow(sha1);
-				continue;
-			}
-			if (!prefixcmp(line, "unshallow ")) {
-				if (get_sha1_hex(line + 10, sha1))
-					die("invalid unshallow line: %s", line);
-				if (!lookup_object(sha1))
-					die("object not found: %s", line);
-				/* make sure that it is parsed as shallow */
-				parse_object(sha1);
-				if (unregister_shallow(sha1))
-					die("no shallow found: %s", line);
-				continue;
-			}
-			die("expected shallow/unshallow, got %s", line);
-		}
-	}
+	if (args.depth > 0)
+		handle_shallow(fd);
+
+	if (show_symref)
+		handle_symref(fd, refs);
=20
 	flushes =3D 0;
 	retval =3D -1;
@@ -558,6 +583,11 @@ static struct ref *do_fetch_pack(int fd[2],
 	get_remote_heads(fd[0], &ref, 0, NULL, 0);
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
+	if (server_supports("show-symref")) {
+		if (args.verbose)
+			fprintf(stderr, "Server supports show-symref\n");
+		show_symref =3D 1;
+	}
 	if (server_supports("multi_ack")) {
 		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack\n");
diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..351d501 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -27,7 +27,7 @@ static const char upload_pack_usage[] =3D "git-upload=
-pack [--strict] [--timeout=3Dn
 static unsigned long oldest_have;
=20
 static int multi_ack, nr_our_refs;
-static int use_thin_pack, use_ofs_delta, no_progress;
+static int use_thin_pack, use_ofs_delta, no_progress, show_symref;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -477,6 +477,10 @@ static void receive_needs(void)
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
+
+		/* Protocol extensions */
+		if (strstr(line+45, "show-symref"))
+			show_symref =3D 1;
 		if (strstr(line+45, "multi_ack"))
 			multi_ack =3D 1;
 		if (strstr(line+45, "thin-pack"))
@@ -557,7 +561,7 @@ static void receive_needs(void)
 static int send_ref(const char *refname, const unsigned char *sha1, in=
t flag, void *cb_data)
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow no-progress";
+		" side-band-64k ofs-delta shallow no-progress show-symref";
 	struct object *o =3D parse_object(sha1);
=20
 	if (!o)
@@ -580,6 +584,18 @@ static int send_ref(const char *refname, const uns=
igned char *sha1, int flag, vo
 	return 0;
 }
=20
+static int send_symref(const char *refname, const unsigned char *sha1,=
 int flag, void *cb_data)
+{
+	unsigned char object_name[20];
+	const char *symref;
+	int what;
+
+	symref =3D resolve_ref(refname, object_name, 1, &what);
+	if (symref && (what & REF_ISSYMREF))
+		packet_write(1, "symref %s %s\n", refname, symref);
+	return 0;
+}
+
 static void upload_pack(void)
 {
 	reset_timeout();
@@ -587,6 +603,11 @@ static void upload_pack(void)
 	for_each_ref(send_ref, NULL);
 	packet_flush(1);
 	receive_needs();
+	if (show_symref) {
+		send_symref("HEAD", NULL, 0, NULL);
+		for_each_ref(send_symref, NULL);
+		packet_flush(1);
+	}
 	if (want_obj.nr) {
 		get_common_commits();
 		create_pack_file();
--=20
1.5.3.7-1157-gbf82a
