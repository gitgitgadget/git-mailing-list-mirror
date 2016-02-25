From: Michael Procter <michael@procter.org.uk>
Subject: [PATCH] upload-pack: use argv_array for pack_objects
Date: Thu, 25 Feb 2016 12:13:26 +0000
Message-ID: <1456402406-13617-1-git-send-email-michael@procter.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 13:21:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYuvb-0004PP-DY
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 13:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbcBYMVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 07:21:51 -0500
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:41154
	"EHLO know-smtprelay-omc-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbcBYMVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 07:21:51 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2016 07:21:50 EST
Received: from tikuanyin.procter.org.uk ([81.104.240.190])
	by know-smtprelay-7-imp with bizsmtp
	id NcDS1s00K47Agfl01cDSWJ; Thu, 25 Feb 2016 12:13:26 +0000
X-Originating-IP: [81.104.240.190]
X-Spam: 0
X-Authority: v=2.1 cv=JuUM15MC c=1 sm=1 tr=0 a=oahw/N1TFIRcsc7jvv9ITg==:117
 a=oahw/N1TFIRcsc7jvv9ITg==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=jFJIQSaiL_oA:10 a=X2UlObJWAAAA:8 a=pV-U-68TBj-d9zkbImUA:9
Received: from vagrant-ubuntu-trusty-64.local.procter.org.uk (unknown [192.168.73.37])
	by tikuanyin.procter.org.uk (Postfix) with ESMTP id 4F37E603D4
	for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:13:26 +0000 (GMT)
X-Mailer: git-send-email 2.7.2.368.g02f4152
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287364>

Use the argv_array in the child_process structure, to avoid having to
manually maintain an array size.

Signed-off-by: Michael Procter <michael@procter.org.uk>
---
 upload-pack.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b3f6653..dc802a0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -90,35 +90,32 @@ static void create_pack_file(void)
 		"corruption on the remote side.";
 	int buffered = -1;
 	ssize_t sz;
-	const char *argv[13];
-	int i, arg = 0;
+	int i;
 	FILE *pipe_fd;
 
 	if (shallow_nr) {
-		argv[arg++] = "--shallow-file";
-		argv[arg++] = "";
+		argv_array_push(&pack_objects.args, "--shallow-file");
+		argv_array_push(&pack_objects.args, "");
 	}
-	argv[arg++] = "pack-objects";
-	argv[arg++] = "--revs";
+	argv_array_push(&pack_objects.args, "pack-objects");
+	argv_array_push(&pack_objects.args, "--revs");
 	if (use_thin_pack)
-		argv[arg++] = "--thin";
+		argv_array_push(&pack_objects.args, "--thin");
 
-	argv[arg++] = "--stdout";
+	argv_array_push(&pack_objects.args, "--stdout");
 	if (shallow_nr)
-		argv[arg++] = "--shallow";
+		argv_array_push(&pack_objects.args, "--shallow");
 	if (!no_progress)
-		argv[arg++] = "--progress";
+		argv_array_push(&pack_objects.args, "--progress");
 	if (use_ofs_delta)
-		argv[arg++] = "--delta-base-offset";
+		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
-		argv[arg++] = "--include-tag";
-	argv[arg++] = NULL;
+		argv_array_push(&pack_objects.args, "--include-tag");
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 	pack_objects.git_cmd = 1;
-	pack_objects.argv = argv;
 
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
-- 
2.7.2.368.g02f4152
