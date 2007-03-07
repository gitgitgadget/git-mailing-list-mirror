From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-bundle: avoid packing objects which are in the prerequisites
Date: Thu, 8 Mar 2007 00:43:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703080039420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com> <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com> <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45EE36A1.30001@gmail.com> <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
 <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8geikk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP5mr-0006yN-M2
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 00:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965746AbXCGXnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 18:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965751AbXCGXnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 18:43:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:44939 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965746AbXCGXnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 18:43:07 -0500
Received: (qmail invoked by alias); 07 Mar 2007 23:43:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 08 Mar 2007 00:43:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pmB5KPPDpcNt9IsjcLUqTDDbllVQ4HdKqbyo1dH
	Aoc7nd3PMODn37
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy8geikk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41705>


When saying something like "--since=1.day.ago" or "--max-count=5",
git-bundle finds the boundary commits which are recorded as
prerequisites. However, it failed to tell pack-objects _not_ to
pack the objects which are in these.

Fix that. And add a test for that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 7 Mar 2007, Junio C Hamano wrote:

	> What's not fixed is that we still use "rev-list --objects 
	> --max-*" given by the user, which is not the semantics 
	> git-bundle wants.  We should rewrite the revspec to drive 
	> pack-objects when generating the packfile part of the bundle to 
	> do "<revs> --not <boundaries>" internally in git-bundle.

	Since we already calculate the prerequisites, it's easy to pass
	them as uninteresting, too. It does not hurt to keep the max*
	limiters, so they are not unset.

 builtin-bundle.c |   15 ++++++++++++---
 t/t5510-fetch.sh |   11 +++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 3b3bc25..70d4479 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -305,6 +305,10 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	/* write signature */
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
 
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	init_revisions(&revs, NULL);
+
 	/* write prerequisites */
 	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
 	argv_boundary[0] = "rev-list";
@@ -316,8 +320,15 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	if (pid < 0)
 		return -1;
 	while ((i = read_string(out, buffer, sizeof(buffer))) > 0)
-		if (buffer[0] == '-')
+		if (buffer[0] == '-') {
+			unsigned char sha1[20];
 			write_or_die(bundle_fd, buffer, i);
+			if (!get_sha1_hex(buffer + 1, sha1)) {
+				struct object *object = parse_object(sha1);
+				object->flags |= UNINTERESTING;
+				add_pending_object(&revs, object, buffer);
+			}
+		}
 	while ((i = waitpid(pid, &status, 0)) < 0)
 		if (errno != EINTR)
 			return error("rev-list died");
@@ -325,8 +336,6 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		return error("rev-list died %d", WEXITSTATUS(status));
 
 	/* write references */
-	save_commit_buffer = 0;
-	init_revisions(&revs, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
 	revs.blob_objects = 1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ce96b4b..7be9793 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -121,4 +121,15 @@ test_expect_success 'unbundle 2' '
 	test "tip" = "$(git log -1 --pretty=oneline master | cut -b42-)"
 '
 
+test_expect_success 'bundle does not prerequisite objects' '
+	cd "$D" &&
+	touch file2 &&
+	git add file2 &&
+	git commit -m add.file2 file2 &&
+	git bundle create bundle3 -1 HEAD &&
+	sed "1,4d" < bundle3 > bundle.pack &&
+	git index-pack bundle.pack &&
+	test 4 = $(git verify-pack -v bundle.pack | wc -l)
+'
+
 test_done
-- 
1.5.0.3.2562.gfcfe0
