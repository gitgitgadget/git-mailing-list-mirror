X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-file: support -p and -q; fix compile warnings
Date: Wed, 6 Dec 2006 16:45:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061644100.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612061609430.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el6nhv$58n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 15:45:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el6nhv$58n$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33478>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gryxv-0005l3-LB for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935809AbWLFPpp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935858AbWLFPpp
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:45:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:53497 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S935809AbWLFPpo
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:45:44 -0500
Received: (qmail invoked by alias); 06 Dec 2006 15:45:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 06 Dec 2006 16:45:42 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


Now merge-file also understands --stdout and --quiet options. While
at it, two compile warnings were fixed.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Wed, 6 Dec 2006, Jakub Narebski wrote:

	> Johannes Schindelin wrote:
	> 
	> > merge-file has the same syntax as RCS merge, but supports only 
	> > the "-L" option.
	> 
	> Would it be hard to add "-p / --stdout" options, and "-q / 
	> --quiet" option?

	No.

	But the documentation has to be done by somebody else.

 builtin-merge-file.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 11976ea..9ae1009 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -2,7 +2,7 @@
 #include "xdiff/xdiff.h"
 
 static const char merge_file_usage[] =
-"git merge-file [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
+"git merge-file [-p | --stdout] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
 
 static int read_file(mmfile_t *ptr, const char *filename)
 {
@@ -24,18 +24,25 @@ static int read_file(mmfile_t *ptr, const char *filename)
 int cmd_merge_file(int argc, char **argv, char **envp)
 {
 	char *names[3];
-	char *buffers[3];
-	mmfile_t mmfs[3], result = {NULL, 0};
-	int ret = 0, i = 0;
+	mmfile_t mmfs[3];
+	mmbuffer_t result = {NULL, 0};
+	int ret = 0, i = 0, to_stdout = 0;
 
 	while (argc > 4) {
-		if (!strcmp(argv[1], "-L")) {
+		if (!strcmp(argv[1], "-L") && i < 3) {
 			names[i++] = argv[2];
-			argc -= 2;
-			argv += 2;
-			continue;
-		}
-		usage(merge_file_usage);
+			argc--;
+			argv++;
+		} else if (!strcmp(argv[1], "-p") ||
+				!strcmp(argv[1], "--stdout"))
+			to_stdout = 1;
+		else if (!strcmp(argv[1], "-q") ||
+				!strcmp(argv[1], "--quiet"))
+			freopen("/dev/null", "w", stderr);
+		else
+			usage(merge_file_usage);
+		argc--;
+		argv++;
 	}
 
 	if (argc != 4)
@@ -57,7 +64,7 @@ int cmd_merge_file(int argc, char **argv, char **envp)
 
 	if (ret >= 0) {
 		char *filename = argv[1];
-		FILE *f = fopen(filename, "wb");
+		FILE *f = to_stdout ? stdout : fopen(filename, "wb");
 
 		if (!f)
 			ret = error("Could not open %s for writing", filename);
-- 
