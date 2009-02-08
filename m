From: Jeremy White <jwhite@codeweavers.com>
Subject: [PATCH v3] Enable setting attach as the default in .gitconfig for
 git-format-patch.
Date: Sun, 08 Feb 2009 13:24:52 -0600
Message-ID: <498F3184.30809@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 20:27:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFJS-0004to-FD
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 20:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZBHT0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 14:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZBHT0A
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 14:26:00 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:49119 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbZBHTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 14:25:59 -0500
Received: from localhost
	([127.0.0.1] helo=[10.0.0.16] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWFHy-0004kz-Vc
	for git@vger.kernel.org; Sun, 08 Feb 2009 13:25:59 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109002>

---
 Documentation/git-format-patch.txt |    4 +++-
 builtin-log.c                      |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

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
index 2ae39af..dac0dfd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -428,6 +428,8 @@ static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
 static int auto_number = 1;
 
+static char *default_attach;
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
-- 
1.6.1.2.390.gba743.dirty
