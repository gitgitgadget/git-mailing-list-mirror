From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Add option to enable threading headers
Date: Fri, 14 Jul 2006 17:49:04 -0700
Message-ID: <1152924544.3148.2.camel@josh-work.beaverton.ibm.com>
References: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152924479.git.josh@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 15 02:49:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1YLW-0003PJ-SS
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 02:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945958AbWGOAtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 20:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945960AbWGOAtK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 20:49:10 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44734 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1945958AbWGOAtF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 20:49:05 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6F0n4Ux008621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 20:49:05 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6F0n4NY268360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 18:49:04 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6F0n4E1011196
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 18:49:04 -0600
Received: from IBM-882E9B45D97.beaverton.ibm.com (IBM-882E9B45D97.beaverton.ibm.com [9.47.18.143] (may be forged))
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6F0n4r5011167
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 18:49:04 -0600
To: git@vger.kernel.org
In-Reply-To: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152924479.git.josh@freedesktop.org>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23922>

Add a --thread option to enable generation of In-Reply-To and References
headers, used to make the second and subsequent mails appear as replies to the
first.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Documentation/git-format-patch.txt |   10 +++++++++-
 builtin-log.c                      |   21 +++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4ca0014..305bd79 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--thread]
 	           [-s | --signoff] [--diff-options] [--start-number <n>]
 		   <since>[..<until>]
 
@@ -35,6 +35,10 @@ they are created in the current working 
 If -n is specified, instead of "[PATCH] Subject", the first line
 is formatted as "[PATCH n/m] Subject".
 
+If given --thread, git-format-patch will generate In-Reply-To and
+References headers to make the second and subsequent patch mails appear
+as replies to the first mail; this also generates a Message-Id header to
+reference.
 
 OPTIONS
 -------
@@ -63,6 +67,10 @@ OPTIONS
 --attach::
 	Create attachments instead of inlining patches.
 
+--thread::
+	Add In-Reply-To and References headers to make the second and
+	subsequent mails appear as replies to the first.  Also generates
+	the Message-Id header to reference.
 
 CONFIGURATION
 -------------
diff --git a/builtin-log.c b/builtin-log.c
index 9d0cae1..4572295 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -242,6 +242,7 @@ int cmd_format_patch(int argc, const cha
 	int start_number = -1;
 	int keep_subject = 0;
 	int ignore_if_in_upstream = 0;
+	int thread = 0;
 	struct diff_options patch_id_opts;
 	char *add_signoff = NULL;
 	char message_id[1024];
@@ -311,6 +312,8 @@ int cmd_format_patch(int argc, const cha
 			rev.mime_boundary = argv[i] + 9;
 		else if (!strcmp(argv[i], "--ignore-if-in-upstream"))
 			ignore_if_in_upstream = 1;
+		else if (!strcmp(argv[i], "--thread"))
+			thread = 1;
 		else
 			argv[j++] = argv[i];
 	}
@@ -373,15 +376,17 @@ int cmd_format_patch(int argc, const cha
 		commit = list[nr];
 		rev.nr = total - nr + (start_number - 1);
 		/* Make the second and subsequent mails replies to the first */
-		if (nr == (total - 2)) {
-			strncpy(ref_message_id, message_id,
-				sizeof(ref_message_id));
-			ref_message_id[sizeof(ref_message_id)-1] = '\0';
-			rev.ref_message_id = ref_message_id;
+		if (thread) {
+			if (nr == (total - 2)) {
+				strncpy(ref_message_id, message_id,
+					sizeof(ref_message_id));
+				ref_message_id[sizeof(ref_message_id)-1]='\0';
+				rev.ref_message_id = ref_message_id;
+			}
+			gen_message_id(message_id, sizeof(message_id),
+				       sha1_to_hex(commit->object.sha1));
+			rev.message_id = message_id;
 		}
-		gen_message_id(message_id, sizeof(message_id),
-			       sha1_to_hex(commit->object.sha1));
-		rev.message_id = message_id;
 		if (!use_stdout)
 			reopen_stdout(commit, rev.nr, keep_subject);
 		shown = log_tree_commit(&rev, commit);
-- 
1.4.1.gd2cb0
