X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] git-pack-objects progress flag documentation and cleanup
Date: Tue, 07 Nov 2006 10:51:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611071047230.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 7 Nov 2006 15:52:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31074>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhTEw-0005lI-KQ for gcvg-git@gmane.org; Tue, 07 Nov
 2006 16:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754069AbWKGPvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 10:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbWKGPvZ
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 10:51:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35543 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1754069AbWKGPvY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 10:51:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8D00JJPAPNJML0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Tue,
 07 Nov 2006 10:51:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This adds documentation for --progress and --all-progress, remove a 
duplicate --progress handling and make usage string more readable.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 5ebe34e..fdc6f97 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -99,6 +99,23 @@ base-name::
         Only create a packed archive if it would contain at
         least one object.
 
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if
+	the standard error stream is not directed to a terminal.
+
+--all-progress::
+	When --stdout is specified then progress report is
+	displayed during the object count and deltification phases
+	but inhibited during the write-out phase. The reason is
+	that in some cases the output stream is directly linked
+	to another command which may wish to display progress
+	status of its own as it processes incoming pack data.
+	This flag is like --progress except that it forces progress
+	report for the write-out phase as well even if --stdout is
+	used.
+
 -q::
 	This flag makes the command not to report its progress
 	on the standard error stream.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 270bcbd..69e5dd3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -15,7 +15,12 @@
 #include <sys/time.h>
 #include <signal.h>
 
-static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--delta-base-offset] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] [--all-progress] [--revs [--unpacked | --all]*] [--stdout | base-name] <ref-list | <object-list]";
+static const char pack_usage[] = "\
+git-pack-objects [{ -q | --progress | --all-progress }] \n\
+	[--local] [--incremental] [--window=N] [--depth=N] \n\
+	[--no-reuse-delta] [--delta-base-offset] [--non-empty] \n\
+	[--revs [--unpacked | --all]*] [--stdout | base-name] \n\
+	[<ref-list | <object-list]";
 
 struct object_entry {
 	unsigned char sha1[20];
@@ -1520,14 +1525,6 @@ int cmd_pack_objects(int argc, const cha
 			local = 1;
 			continue;
 		}
-		if (!strcmp("--progress", arg)) {
-			progress = 1;
-			continue;
-		}
-		if (!strcmp("--all-progress", arg)) {
-			progress = 2;
-			continue;
-		}
 		if (!strcmp("--incremental", arg)) {
 			incremental = 1;
 			continue;
@@ -1550,6 +1547,10 @@ int cmd_pack_objects(int argc, const cha
 			progress = 1;
 			continue;
 		}
+		if (!strcmp("--all-progress", arg)) {
+			progress = 2;
+			continue;
+		}
 		if (!strcmp("-q", arg)) {
 			progress = 0;
