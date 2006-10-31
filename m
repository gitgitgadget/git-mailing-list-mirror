X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make git-push a bit more verbose
Date: Tue, 31 Oct 2006 16:58:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610311648220.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 31 Oct 2006 21:59:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30599>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf1cz-0004rH-AO for gcvg-git@gmane.org; Tue, 31 Oct
 2006 22:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423673AbWJaV6e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 16:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423674AbWJaV6e
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 16:58:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13017 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1423673AbWJaV6d
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 16:58:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J80000KAT1KTJ50@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Tue,
 31 Oct 2006 16:58:32 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Currently git-push displays progress status for the local packing of 
objects to send, but nothing once it starts to push it over the 
connection.  Having progress status in that later case is especially 
nice when pushing lots of objects over a slow network link.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 41e1e74..5f56a95 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -475,11 +475,12 @@ static void write_pack_file(void)
 	unsigned long offset;
 	struct pack_header hdr;
 	unsigned last_percent = 999;
-	int do_progress = 0;
+	int do_progress;
 
-	if (!base_name)
+	if (!base_name) {
 		f = sha1fd(1, "<stdout>");
-	else {
+		do_progress = progress >> 1;
+	} else {
 		f = sha1create("%s-%s.%s", base_name,
 			       sha1_to_hex(object_list_sha1), "pack");
 		do_progress = progress;
@@ -1524,6 +1525,10 @@ int cmd_pack_objects(int argc, const cha
 			progress = 1;
 			continue;
 		}
+		if (!strcmp("--all-progress", arg)) {
+			progress = 2;
+			continue;
+		}
 		if (!strcmp("--incremental", arg)) {
 			incremental = 1;
 			continue;
@@ -1641,7 +1646,7 @@ int cmd_pack_objects(int argc, const cha
 	else {
 		if (nr_result)
 			prepare_pack(window, depth);
-		if (progress && pack_to_stdout) {
+		if (progress == 1 && pack_to_stdout) {
 			/* the other end usually displays progress itself */
 			struct itimerval v = {{0,},};
 			setitimer(ITIMER_REAL, &v, NULL);
diff --git a/send-pack.c b/send-pack.c
index fbd792c..4476666 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -29,6 +29,7 @@ static void exec_pack_objects(void)
 {
 	static const char *args[] = {
 		"pack-objects",
+		"--all-progress",
 		"--stdout",
 		NULL
