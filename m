From: Jeremy White <jwhite@codeweavers.com>
Subject: [PATCH v2] Enable setting attach as the default in .gitconfig for
 git-format-patch.
Date: Sat, 07 Feb 2009 21:26:26 -0600
Message-ID: <498E50E2.8050309@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070904060205020007070608"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 04:32:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW0P2-0001Nw-LI
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 04:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbZBHD1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 22:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZBHD1c
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 22:27:32 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:54546 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbZBHD1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 22:27:32 -0500
Received: from localhost
	([127.0.0.1] helo=[10.0.0.16] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LW0KR-0004M8-Di
	for git@vger.kernel.org; Sat, 07 Feb 2009 21:27:31 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108914>

This is a multi-part message in MIME format.
--------------070904060205020007070608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Signed-off-by: Jeremy White <jwhite@codeweavers.com>
---
  Documentation/git-format-patch.txt |    4 +++-
  builtin-log.c                      |   15 +++++++++++++++
  2 files changed, 18 insertions(+), 1 deletions(-)



--------------070904060205020007070608
Content-Type: text/x-patch;
 name="7ed4bdd60ca12e71e1438defefbf83075b39a60b.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="7ed4bdd60ca12e71e1438defefbf83075b39a60b.diff"

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 11a7d77..2e8e94e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -174,7 +174,8 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
 in the repository configuration, new defaults for the subject prefix
-and file suffix, and number patches when outputting more than one.
+and file suffix, control attachements, and number patches when outputting
+more than one.
 
 ------------
 [format]
@@ -183,6 +184,7 @@ and file suffix, and number patches when outputting more than one.
 	suffix = .txt
 	numbered = auto
 	cc = <email>
+	attach [ = mime-boundary-string ]
 ------------
 
 
diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..c79895c 100644
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


--------------070904060205020007070608--
