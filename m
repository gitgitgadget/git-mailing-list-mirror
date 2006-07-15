From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Add option to set initial In-Reply-To/References
Date: Fri, 14 Jul 2006 17:49:08 -0700
Message-ID: <1152924548.3148.4.camel@josh-work.beaverton.ibm.com>
References: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152924479.git.josh@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 15 02:49:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1YLT-0003PJ-ME
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 02:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945963AbWGOAtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 20:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945960AbWGOAtL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 20:49:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:27043 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1945959AbWGOAtI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 20:49:08 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6F0n8pb025006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 20:49:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6F0n8L9306304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 18:49:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6F0n8jp012652
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 18:49:08 -0600
Received: from IBM-882E9B45D97.beaverton.ibm.com (IBM-882E9B45D97.beaverton.ibm.com [9.47.18.143] (may be forged))
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6F0n7hX012646
	for <git@vger.kernel.org>; Fri, 14 Jul 2006 18:49:08 -0600
To: git@vger.kernel.org
In-Reply-To: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152924479.git.josh@freedesktop.org>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23921>

Add the --in-reply-to option to provide a Message-Id for an initial
In-Reply-To/References header, useful for including a new patch series as part
of an existing thread.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Documentation/git-format-patch.txt |    6 ++++++
 builtin-log.c                      |   10 ++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 305bd79..67425dc 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--thread]
 	           [-s | --signoff] [--diff-options] [--start-number <n>]
+		   [--in-reply-to=Message-Id]
 		   <since>[..<until>]
 
 DESCRIPTION
@@ -72,6 +73,11 @@ OPTIONS
 	subsequent mails appear as replies to the first.  Also generates
 	the Message-Id header to reference.
 
+--in-reply-to=Message-Id::
+	Make the first mail (or all the mails with --no-thread) appear as a
+	reply to the given Message-Id, which avoids breaking threads to
+	provide a new patch series.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each
diff --git a/builtin-log.c b/builtin-log.c
index 4572295..3ef7b8e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -243,6 +243,7 @@ int cmd_format_patch(int argc, const cha
 	int keep_subject = 0;
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
+	char *in_reply_to = NULL;
 	struct diff_options patch_id_opts;
 	char *add_signoff = NULL;
 	char message_id[1024];
@@ -314,6 +315,14 @@ int cmd_format_patch(int argc, const cha
 			ignore_if_in_upstream = 1;
 		else if (!strcmp(argv[i], "--thread"))
 			thread = 1;
+		else if (!strncmp(argv[i], "--in-reply-to=", 14))
+			in_reply_to = argv[i] + 14;
+		else if (!strcmp(argv[i], "--in-reply-to")) {
+			i++;
+			if (i == argc)
+				die("Need a Message-Id for --in-reply-to");
+			in_reply_to = argv[i];
+		}
 		else
 			argv[j++] = argv[i];
 	}
@@ -371,6 +380,7 @@ int cmd_format_patch(int argc, const cha
 	if (numbered)
 		rev.total = total + start_number - 1;
 	rev.add_signoff = add_signoff;
+	rev.ref_message_id = in_reply_to;
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
-- 
1.4.1.gd2cb0
