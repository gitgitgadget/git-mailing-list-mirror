From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH 2/3] Add option to disable threading headers
Date: Mon, 10 Jul 2006 11:41:45 -0700
Message-ID: <1152556906.8890.47.camel@josh-work.beaverton.ibm.com>
References: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152550451.git.josh@freedesktop.org>
Reply-To: git@vger.kernel.org, josht@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 10 20:41:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G00hX-0007Yn-Qg
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWGJSlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWGJSlo
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 14:41:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:25540 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422757AbWGJSlo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 14:41:44 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AIfhUs004615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 14:41:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6AIg9Kd165504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:42:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6AIfhBG029979
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:41:43 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AIfgVD029943
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:41:42 -0600
To: git@vger.kernel.org
In-Reply-To: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152550451.git.josh@freedesktop.org>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23633>

Add a --no-thread option to disable generation of In-Reply-To and References
headers, normally used to make the second and subsequent mails appear as
replies to the first.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
As requested by Johannes Schindelin <johannes.schindelin@gmx.de>.

 Documentation/git-format-patch.txt |    8 +++++++-
 builtin-log.c                      |    5 ++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4ca0014..81e3a9a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--no-thread]
 	           [-s | --signoff] [--diff-options] [--start-number <n>]
 		   <since>[..<until>]
 
@@ -35,6 +35,9 @@ they are created in the current working 
 If -n is specified, instead of "[PATCH] Subject", the first line
 is formatted as "[PATCH n/m] Subject".
 
+The generated mails include In-Reply-To and References headers to make
+the second and subsequent patch mails appear as replies to the first
+mail; --no-thread disables this behavior.
 
 OPTIONS
 -------
@@ -63,6 +66,9 @@ OPTIONS
 --attach::
 	Create attachments instead of inlining patches.
 
+--no-thread::
+	Do not add In-Reply-To and References headers to make the
+	second and subsequent mails appear as replies to the first.
 
 CONFIGURATION
 -------------
diff --git a/builtin-log.c b/builtin-log.c
index 9d0cae1..97df715 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -242,6 +242,7 @@ int cmd_format_patch(int argc, const cha
 	int start_number = -1;
 	int keep_subject = 0;
 	int ignore_if_in_upstream = 0;
+	int thread = 1;
 	struct diff_options patch_id_opts;
 	char *add_signoff = NULL;
 	char message_id[1024];
@@ -311,6 +312,8 @@ int cmd_format_patch(int argc, const cha
 			rev.mime_boundary = argv[i] + 9;
 		else if (!strcmp(argv[i], "--ignore-if-in-upstream"))
 			ignore_if_in_upstream = 1;
+		else if (!strcmp(argv[i], "--no-thread"))
+			thread = 0;
 		else
 			argv[j++] = argv[i];
 	}
@@ -373,7 +376,7 @@ int cmd_format_patch(int argc, const cha
 		commit = list[nr];
 		rev.nr = total - nr + (start_number - 1);
 		/* Make the second and subsequent mails replies to the first */
-		if (nr == (total - 2)) {
+		if (thread && nr == (total - 2)) {
 			strncpy(ref_message_id, message_id,
 				sizeof(ref_message_id));
 			ref_message_id[sizeof(ref_message_id)-1] = '\0';
-- 
1.4.1.gf029
