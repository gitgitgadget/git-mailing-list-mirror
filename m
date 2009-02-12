From: Jeremy White <jwhite@codeweavers.com>
Subject: [PATCH v2] Enable setting attach as the default in .gitconfig for
 git-format-patch.
Date: Thu, 12 Feb 2009 09:51:55 -0600
Message-ID: <4994459B.8090002@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 16:53:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXdsT-00053T-4I
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 16:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbZBLPv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 10:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZBLPv5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 10:51:57 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:46853 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbZBLPv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 10:51:56 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LXdr1-0002Wt-S6
	for git@vger.kernel.org; Thu, 12 Feb 2009 09:51:55 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109624>

Signed-off-by: Jeremy White <jwhite@codeweavers.com>
---

This v2 patch reflects a concern from Junio that you could
not temporarily override the configuration setting.


 Documentation/git-format-patch.txt |   11 +++++++++--
 builtin-log.c                      |   19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 11a7d77..f89f73c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git format-patch' [-k] [-o <dir> | --stdout] [--thread]
-		   [--attach[=<boundary>] | --inline[=<boundary>]]
+		   [--attach[=<boundary>] | --inline[=<boundary>] |
+		     [--noattach]]
 		   [-s | --signoff] [<common diff options>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
@@ -117,6 +118,10 @@ include::diff-options.txt[]
 	which is the commit message and the patch itself in the
 	second part, with "Content-Disposition: attachment".
 
+--noattach::
+	Disable the creation of an attachment, overriding the
+	configuration setting.
+
 --inline[=<boundary>]::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
@@ -174,7 +179,8 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
 in the repository configuration, new defaults for the subject prefix
-and file suffix, and number patches when outputting more than one.
+and file suffix, control attachements, and number patches when outputting
+more than one.
 
 ------------
 [format]
@@ -183,6 +189,7 @@ and file suffix, and number patches when outputting more than one.
 	suffix = .txt
 	numbered = auto
 	cc = <email>
+	attach [ = mime-boundary-string ]
 ------------
 
 
diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..991543a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -428,6 +428,8 @@ static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
 static int auto_number = 1;
 
+static char *default_attach = NULL;
+
 static char **extra_hdr;
 static int extra_hdr_nr;
 static int extra_hdr_alloc;
@@ -488,6 +490,14 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		auto_number = auto_number && numbered;
 		return 0;
 	}
+	if (!strcmp(var, "format.attach")) {
+		if (value && *value)
+			default_attach = xstrdup(value);
+		else
+			default_attach = xstrdup(git_version_string);
+		return 0;
+	}
+
 
 	return git_log_config(var, value, cb);
 }
@@ -787,6 +797,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
 
+	if (default_attach) {
+		rev.mime_boundary = default_attach;
+		rev.no_inline = 1;
+	}
+
 	/*
 	 * Parse the arguments before setup_revisions(), or something
 	 * like "git format-patch -o a123 HEAD^.." may fail; a123 is
@@ -849,6 +864,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.mime_boundary = argv[i] + 9;
 			rev.no_inline = 1;
 		}
+		else if (!strcmp(argv[i], "--noattach")) {
+			rev.mime_boundary = NULL;
+			rev.no_inline = 0;
+		}
 		else if (!strcmp(argv[i], "--inline")) {
 			rev.mime_boundary = git_version_string;
 			rev.no_inline = 0;
-- 
1.6.2.rc0.57.g4ab7.dirty
