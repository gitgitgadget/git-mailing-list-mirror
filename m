From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-bundle: Make thin packs
Date: Thu, 8 Mar 2007 01:27:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703080121210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45ECEB40.4000907@gmail.com>  <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com>  <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com>  <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
  <45EE36A1.30001@gmail.com>  <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
 <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703071516330.5963@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 01:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP6U3-0002ur-6c
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 01:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992790AbXCHA1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 19:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992809AbXCHA1r
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 19:27:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:45868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992790AbXCHA1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 19:27:46 -0500
Received: (qmail invoked by alias); 08 Mar 2007 00:27:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 08 Mar 2007 01:27:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185mWcKFHc5lco5UT+V+JA7pnCTpSu9HQf0MZMu2I
	d7XxjmgOVBQs7a
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703071516330.5963@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41707>


Thin packs are way smaller, but they rely on the receiving end to have the 
base objects. However, Git's pack protocol also uses thin packs by 
default. So make the packs contained in bundles thin, since bundles are 
just another transport.

The patch looks a bit bigger than intended, mainly because --thin
_implies_ that pack-objects should run its own rev-list. Therefore, this 
patch removes all the stuff we used to roll rev-list ourselves.

This commit also changes behaviour slightly: since we now know early 
enough if a specified ref is _not_ contained in the pack, we can avoid 
putting that ref into the pack. So, we don't die() here, but warn() 
instead, and skip that ref.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	It came to me as a surprise that --thin implies --revs, and
	I have to admit that I still don't understand it.

	Anyway, this commit deletes more than double the lines as it
	adds, so I'm not complaining.

	On Wed, 7 Mar 2007, Linus Torvalds wrote:

	> On Wed, 7 Mar 2007, Johannes Schindelin wrote:
	> 
	> > We don't do thin packs. Should we?
	> 
	> Since a bundle doesn't make any sense *anyway* unless you have 
	> the prerequisites at the other end, I think you might as well do 
	> thin packs. That will cut down on the bundle size a *lot* for 
	> the common cases.

	Well, I disagree on the blanket "*anyway*". Shallow fetches are no 
	longer possible from these bundles (at least after this commit 
	_and_ ":/git-bundle: avoid packing" which I just sent out).

	But then, people who want shallow fetches via bundles are more 
	likely to want tar balls _anyway_.

 builtin-bundle.c |   85 ++++++++++++++++-------------------------------------
 1 files changed, 26 insertions(+), 59 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 70d4479..6163358 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -257,45 +257,15 @@ static int list_heads(struct bundle_header *header, int argc, const char **argv)
 	return list_refs(&header->references, argc, argv);
 }
 
-static void show_commit(struct commit *commit)
-{
-	write_or_die(1, sha1_to_hex(commit->object.sha1), 40);
-	write_or_die(1, "\n", 1);
-	if (commit->parents) {
-		free_commit_list(commit->parents);
-		commit->parents = NULL;
-	}
-}
-
-static void show_object(struct object_array_entry *p)
-{
-	/* An object with name "foo\n0000000..." can be used to
-	 * confuse downstream git-pack-objects very badly.
-	 */
-	const char *ep = strchr(p->name, '\n');
-	int len = ep ? ep - p->name : strlen(p->name);
-	write_or_die(1, sha1_to_hex(p->item->sha1), 40);
-	write_or_die(1, " ", 1);
-	if (len)
-		write_or_die(1, p->name, len);
-	write_or_die(1, "\n", 1);
-}
-
-static void show_edge(struct commit *commit)
-{
-	; /* nothing to do */
-}
-
 static int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
 	int bundle_fd = -1;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
-	const char **argv_pack = xmalloc(4 * sizeof(const char *));
+	const char **argv_pack = xmalloc(5 * sizeof(const char *));
 	int pid, in, out, i, status;
 	char buffer[1024];
 	struct rev_info revs;
-	struct object_array tips;
 
 	bundle_fd = (!strcmp(path, "-") ? 1 :
 			open(path, O_CREAT | O_WRONLY, 0666));
@@ -319,16 +289,20 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	pid = fork_with_pipe(argv_boundary, NULL, &out);
 	if (pid < 0)
 		return -1;
-	while ((i = read_string(out, buffer, sizeof(buffer))) > 0)
+	while ((i = read_string(out, buffer, sizeof(buffer))) > 0) {
+		unsigned char sha1[20];
 		if (buffer[0] == '-') {
-			unsigned char sha1[20];
 			write_or_die(bundle_fd, buffer, i);
 			if (!get_sha1_hex(buffer + 1, sha1)) {
 				struct object *object = parse_object(sha1);
 				object->flags |= UNINTERESTING;
 				add_pending_object(&revs, object, buffer);
 			}
+		} else if (!get_sha1_hex(buffer, sha1)) {
+			struct object *object = parse_object(sha1);
+			object->flags |= SHOWN;
 		}
+	}
 	while ((i = waitpid(pid, &status, 0)) < 0)
 		if (errno != EINTR)
 			return error("rev-list died");
@@ -336,14 +310,10 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		return error("rev-list died %d", WEXITSTATUS(status));
 
 	/* write references */
-	revs.tag_objects = 1;
-	revs.tree_objects = 1;
-	revs.blob_objects = 1;
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	if (argc > 1)
 		return error("unrecognized argument: %s'", argv[1]);
 
-	memset(&tips, 0, sizeof(tips));
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
 		unsigned char sha1[20];
@@ -353,11 +323,20 @@ static int create_bundle(struct bundle_header *header, const char *path,
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
 			continue;
+		/*
+		 * Make sure the refs we wrote out is correct; --max-count and
+		 * other limiting options could have prevented all the tips
+		 * from getting output.
+		 */
+		if (!(e->item->flags & SHOWN)) {
+			warn("ref '%s' is excluded by the rev-list options",
+				e->name);
+			continue;
+		}
 		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, ref, strlen(ref));
 		write_or_die(bundle_fd, "\n", 1);
-		add_object_array(e->item, e->name, &tips);
 		free(ref);
 	}
 
@@ -368,39 +347,27 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	argv_pack[0] = "pack-objects";
 	argv_pack[1] = "--all-progress";
 	argv_pack[2] = "--stdout";
-	argv_pack[3] = NULL;
+	argv_pack[3] = "--thin";
+	argv_pack[4] = NULL;
 	in = -1;
 	out = bundle_fd;
 	pid = fork_with_pipe(argv_pack, &in, &out);
 	if (pid < 0)
 		return error("Could not spawn pack-objects");
-	close(1);
-	dup2(in, 1);
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object *object = revs.pending.objects[i].item;
+		if (object->flags & UNINTERESTING)
+			write(in, "^", 1);
+		write(in, sha1_to_hex(object->sha1), 40);
+		write(in, "\n", 1);
+	}
 	close(in);
-	prepare_revision_walk(&revs);
-	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object);
-	close(1);
 	while (waitpid(pid, &status, 0) < 0)
 		if (errno != EINTR)
 			return -1;
 	if (!WIFEXITED(status) || WEXITSTATUS(status))
 		return error ("pack-objects died");
 
-	/*
-	 * Make sure the refs we wrote out is correct; --max-count and
-	 * other limiting options could have prevented all the tips
-	 * from getting output.
-	 */
-	status = 0;
-	for (i = 0; i < tips.nr; i++) {
-		if (!(tips.objects[i].item->flags & SHOWN)) {
-			status = 1;
-			error("%s: not included in the resulting pack",
-			      tips.objects[i].name);
-		}
-	}
-
 	return status;
 }
 
-- 
1.5.0.3.2562.gfcfe0
