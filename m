From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH 3/3] Add option to set initial In-Reply-To/References
Date: Mon, 10 Jul 2006 11:42:12 -0700
Message-ID: <1152556932.8890.50.camel@josh-work.beaverton.ibm.com>
References: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152550451.git.josh@freedesktop.org>
Reply-To: git@vger.kernel.org, josht@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 10 20:42:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G00hz-0007bW-N2
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 20:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWGJSmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWGJSmN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 14:42:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:11935 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422753AbWGJSmM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 14:42:12 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AIgANu007647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 14:42:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6AIfK6V292402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:41:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6AIg9iX031370
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:42:09 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6AIg9FS031344
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 12:42:09 -0600
To: git@vger.kernel.org
In-Reply-To: <5b476cb7f1440875f348842a2ef581ab882e7d0d.1152550451.git.josh@freedesktop.org>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23634>

Add the --in-reply-to option to provide a Message-Id for an initial
In-Reply-To/References header, useful for including a new patch series as part
of an existing thread.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Same behavior as git-send-email.

 Documentation/git-format-patch.txt |    6 ++++++
 builtin-log.c                      |   10 ++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 81e3a9a..6a805c3 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--no-thread]
 	           [-s | --signoff] [--diff-options] [--start-number <n>]
+		   [--in-reply-to=Message-Id]
 		   <since>[..<until>]
 
 DESCRIPTION
@@ -70,6 +71,11 @@ OPTIONS
 	Do not add In-Reply-To and References headers to make the
 	second and subsequent mails appear as replies to the first.
 
+--in-reply-to=Message-Id::
+	Make the first mail (or all the mails with --no-thread) appear as a
+	reply to the given Message-Id, which avoids breaking threads to
+	provide a new patch series.
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each
diff --git a/builtin-log.c b/builtin-log.c
index 97df715..d0d70c4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -243,6 +243,7 @@ int cmd_format_patch(int argc, const cha
 	int keep_subject = 0;
 	int ignore_if_in_upstream = 0;
 	int thread = 1;
+	char *in_reply_to = NULL;
 	struct diff_options patch_id_opts;
 	char *add_signoff = NULL;
 	char message_id[1024];
@@ -314,6 +315,14 @@ int cmd_format_patch(int argc, const cha
 			ignore_if_in_upstream = 1;
 		else if (!strcmp(argv[i], "--no-thread"))
 			thread = 0;
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
1.4.1.gf029
