From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] git-format-patch: add --output-directory long option again
Date: Tue, 6 Jun 2006 16:19:46 +0200
Message-ID: <20060606141946.G59b8a1fd@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 06 16:20:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FncPS-0005zI-TH
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 16:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWFFOTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 10:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWFFOTw
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 10:19:52 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:51090 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932183AbWFFOTv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 10:19:51 -0400
Received: from leonov.stosberg.net (p213.54.78.77.tisdip.tiscali.de [213.54.78.77])
	by ncs.stosberg.net (Postfix) with ESMTP id CD8C6AEBA005
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 16:19:42 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id D2D5F108139; Tue,  6 Jun 2006 16:19:46 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Tue, 06 Jun 2006 16:09:16 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21377>

Additionally this fixes two minor issues:

(1) git-format-patch left an empty directory behind if an invalid
    option was given on the command line.

(2) mkdir() was called with a NULL argument (argv[argc]), if -o was
    the last option on the command line.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 builtin-log.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 6612f4c..0018d13 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -206,14 +206,12 @@ int cmd_format_patch(int argc, const cha
 			keep_subject = 1;
 			rev.total = -1;
 		}
-		else if (!strcmp(argv[i], "-o")) {
-			if (argc < 3)
-				die ("Which directory?");
-			if (mkdir(argv[i + 1], 0777) < 0 && errno != EEXIST)
-				die("Could not create directory %s",
-						argv[i + 1]);
-			output_directory = strdup(argv[i + 1]);
+		else if (!strcmp(argv[i], "-o") ||
+				!strcmp(argv[i], "--output-directory")) {
 			i++;
+			if (i == argc)
+				die ("Which directory?");
+			output_directory = strdup(argv[i]);
 		}
 		else if (!strcmp(argv[i], "--signoff") ||
 			 !strcmp(argv[i], "-s")) {
@@ -243,6 +241,12 @@ int cmd_format_patch(int argc, const cha
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
+	if (output_directory && !stdout) {
+		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
+			die("Could not create directory %s",
+			    output_directory);
+	}
+
 	if (rev.pending_objects && rev.pending_objects->next == NULL) {
 		rev.pending_objects->item->flags |= UNINTERESTING;
 		add_head(&rev);
-- 
1.3.3+git20060602-dest0
