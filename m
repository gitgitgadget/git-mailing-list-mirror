From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 1/2] Add custom subject prefix support to format-patch (take 3)
Date: Wed, 11 Apr 2007 16:58:07 -0700
Message-ID: <1176335888349-git-send-email-robbat2@gentoo.org>
References: <11763358884124-git-send-email-robbat2@gentoo.org>
Cc: junkio@cox.net, Robin@orbis-terrarum.net,
	H.Johnson@orbis-terrarum.net, <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 01:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmhi-0007j8-7e
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbXDKX6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbXDKX6O
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:58:14 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:40828 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932263AbXDKX6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:58:12 -0400
Received: (qmail 26203 invoked from network); 11 Apr 2007 23:58:11 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 11 Apr 2007 23:58:11 +0000
Received: (qmail 15425 invoked from network); 11 Apr 2007 16:58:35 -0700
Received: from buck-int.local.orbis-terrarum.net (HELO buck-int.orbis-terrarum.net) (172.16.9.3)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 11 Apr 2007 16:58:35 -0700
Received: (nullmailer pid 26911 invoked by uid 0);
	Wed, 11 Apr 2007 23:58:08 -0000
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11763358884124-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44282>

From: Robin H. Johnson <robbat2@gentoo.org>

Add a new option to git-format-patch, entitled --subject-prefix that allows
control of the subject prefix '[PATCH]'. Using this option, the text 'PATCH' is
replaced with whatever input is provided to the option. This allows easily
generating patches like '[PATCH 2.6.21-rc3]' or properly numbered series like
'[-mm3 PATCH N/M]'. This patch provides the implementation and documentation.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 Documentation/git-format-patch.txt |   17 ++++++++++++-----
 builtin-log.c                      |   10 ++++++++--
 log-tree.c                         |   14 ++++++++++----
 revision.h                         |    1 +
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 111d7c6..9965745 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -10,11 +10,12 @@ SYNOPSIS
 --------
 [verse]
 'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--thread]
-	           [--attach[=<boundary>] | --inline[=<boundary>]]
-	           [-s | --signoff] [<common diff options>] [--start-number <n>]
-		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
-		   [--ignore-if-in-upstream]
-		   <since>[..<until>]
+                 [--attach[=<boundary>] | --inline[=<boundary>]]
+                 [-s | --signoff] [<common diff options>]
+                 [--start-number <n>] [--in-reply-to=Message-Id]
+                 [--suffix=.<sfx>] [--ignore-if-in-upstream]
+                 [--subject-prefix=Subject-Prefix]
+                 <since>[..<until>]
 
 DESCRIPTION
 -----------
@@ -98,6 +99,12 @@ include::diff-options.txt[]
 	patches being generated, and any patch that matches is
 	ignored.
 
+--subject-prefix=<Subject-Prefix>::
+	Instead of the standard '[PATCH]' prefix in the subject
+	line, instead use '[<Subject-Prefix>]'. This
+	allows for useful naming of a patch series, and can be
+	combined with the --numbered option.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specifed suffix.  A common alternative is
diff --git a/builtin-log.c b/builtin-log.c
index 71df957..4a4890a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -417,6 +417,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int numbered = 0;
 	int start_number = -1;
 	int keep_subject = 0;
+	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
 	const char *in_reply_to = NULL;
@@ -434,6 +435,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.ignore_merges = 1;
 	rev.diffopt.msg_sep = "";
 	rev.diffopt.recursive = 1;
+	rev.subject_prefix = "PATCH";
 
 	rev.extra_headers = extra_headers;
 
@@ -509,8 +511,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			if (i == argc)
 				die("Need a Message-Id for --in-reply-to");
 			in_reply_to = argv[i];
-		}
-		else if (!prefixcmp(argv[i], "--suffix="))
+		} else if (!prefixcmp(argv[i], "--subject-prefix=")) {
+			subject_prefix = 1;
+			rev.subject_prefix = argv[i] + 17;
+		} else if (!prefixcmp(argv[i], "--suffix="))
 			fmt_patch_suffix = argv[i] + 9;
 		else
 			argv[j++] = argv[i];
@@ -521,6 +525,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		start_number = 1;
 	if (numbered && keep_subject)
 		die ("-n and -k are mutually exclusive.");
+	if (keep_subject && subject_prefix)
+		die ("--subject-prefix and -k are mutually exclusive.");
 
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
 	if (argc > 1)
diff --git a/log-tree.c b/log-tree.c
index 8797aa1..dad5513 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -165,14 +165,20 @@ void show_log(struct rev_info *opt, const char *sep)
 		if (opt->total > 0) {
 			static char buffer[64];
 			snprintf(buffer, sizeof(buffer),
-					"Subject: [PATCH %0*d/%d] ",
+					"Subject: [%s %0*d/%d] ",
+					opt->subject_prefix,
 					digits_in_number(opt->total),
 					opt->nr, opt->total);
 			subject = buffer;
-		} else if (opt->total == 0)
-			subject = "Subject: [PATCH] ";
-		else
+		} else if (opt->total == 0) {
+			static char buffer[256];
+			snprintf(buffer, sizeof(buffer),
+					"Subject: [%s] ",
+					opt->subject_prefix);
+			subject = buffer;
+		} else {
 			subject = "Subject: ";
+		}
 
 		printf("From %s Mon Sep 17 00:00:00 2001\n", sha1);
 		if (opt->message_id)
diff --git a/revision.h b/revision.h
index 55e6b53..5f3f628 100644
--- a/revision.h
+++ b/revision.h
@@ -78,6 +78,7 @@ struct rev_info {
 	const char	*add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
+	const char	*subject_prefix;
 	int		no_inline;
 
 	/* Filter by commit log message */
-- 
1.5.1
