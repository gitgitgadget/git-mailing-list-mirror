From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] fsck --lost-found: show found commits human readably
Date: Fri, 28 Mar 2008 15:08:26 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803281505510.18259@racer.site>
References: <7vbq52gezo.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803281504591.18259@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfFH5-0006fl-Sy
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 15:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbYC1OI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbYC1OI2
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 10:08:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:54228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753582AbYC1OI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 10:08:27 -0400
Received: (qmail invoked by alias); 28 Mar 2008 14:08:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 28 Mar 2008 15:08:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4E/4TAVH4g94uhEUdoJIXQAvD68pAI6u4RqJ0cg
	Xf1LhpOGrvwQu7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803281504591.18259@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78412>

From: Junio C Hamano <gitster@pobox.com>

An earlier commit fc8b5f0 (Deprecate git-lost-found, 2007-11-08) declared
"lost-found" deprecated, because "fsck" learned "--lost-found" option that
drops the found objects in $GIT_DIR/lost-found.

But the output from the lost-found program has been much more informative
than the plain vanilla "git fsck" (or "git fsck --lost-found") output.  In
that sense, forcing users to use "fsck --lost-found" when they want to use
"lost-found" is a regression.

This patch slightly enhances the output from "fsck --lost-found" to add
oneline description at the end of the usual "dangling <type> <sha-1>"
message for commit objects it found.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	As for the deprecation of lost-found, I think it is correct, and 
	should not be reverted.  We _do_ have way too many commands, and 
	lost-found logically _belongs_ into fsck.  The proper fix is to 
	fix fsck --lost-found.

	Now, I did not yet look closely at the output of 
	git-lost-found.sh, as I already switched to "master" in the hope 
	that 1.5.5-rc2 will be almost identical to 1.5.5, and I fully 
	intend to push for a quick release (after the pending "fetch" 
	resolutions).

	After 1.5.5, I will tend to lost-found.

 builtin-fsck.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index f01263a..b57cc78 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -149,10 +149,12 @@ static void dangling_object(struct object *obj)
 {
 	char *filename;
 	FILE *f;
-	printf("dangling %s %s\n", typename(obj->type),
-			sha1_to_hex(obj->sha1));
+	enum object_type type;
+	unsigned long size;
+	char *buf = NULL;
+
 	if (!write_lost_and_found)
-		return;
+		goto report_and_exit;
 
 	filename = git_path("lost-found/%s/%s",
 			    obj->type == OBJ_COMMIT ? "commit" : "other",
@@ -164,11 +166,10 @@ static void dangling_object(struct object *obj)
 	}
 	if (!(f = fopen(filename, "w")))
 		die("Could not open %s", filename);
+	if (obj->type == OBJ_BLOB || obj->type == OBJ_COMMIT)
+		buf = read_sha1_file(obj->sha1, &type, &size);
+
 	if (obj->type == OBJ_BLOB) {
-		enum object_type type;
-		unsigned long size;
-		char *buf = read_sha1_file(obj->sha1,
-				&type, &size);
 		if (buf) {
 			fwrite(buf, size, 1, f);
 			free(buf);
@@ -176,6 +177,34 @@ static void dangling_object(struct object *obj)
 	} else
 		fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
 	fclose(f);
+
+	if (obj->type == OBJ_COMMIT) {
+		struct strbuf sb = STRBUF_INIT;
+		struct commit *commit = lookup_commit(obj->sha1);
+		int reported = 0;
+
+		if (!commit->buffer)
+			commit->buffer = buf;
+		if (commit->buffer) {
+			parse_commit(commit);
+			pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb,
+					    0, NULL, NULL, 0, 0);
+			printf("dangling commit %s (%s)\n",
+			       sha1_to_hex(obj->sha1), sb.buf);
+			reported = 1;
+		}
+		strbuf_release(&sb);
+		free(commit->buffer);
+		if (buf && commit->buffer != buf)
+			free(buf);
+		commit->buffer = NULL;
+		if (reported)
+			return;
+	}
+
+ report_and_exit:
+	printf("dangling %s %s\n", typename(obj->type),
+	       sha1_to_hex(obj->sha1));
 }
 
 /*
-- 
1.5.5.rc2.186.gbac51
