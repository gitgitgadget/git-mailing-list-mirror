From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC 1/3] Add "auto-eol" attribute and "core.eolStyle" config variable
Date: Fri,  7 May 2010 00:27:33 +0200
Message-ID: <a8bc571bb092967a1e481f74f3e97ced5135ff34.1273183206.git.eyvind.bernhardsen@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Cc: hasan.aljudy@gmail.com, kusmabite@googlemail.com,
	torvalds@linux-foundation.org, prohaska@zib.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:27:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9Xv-0003zw-C7
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab0EFW1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:27:47 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:37527 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab0EFW1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:27:45 -0400
Received: by ewy20 with SMTP id 20so136755ewy.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=47376j5kLHaq9xw4N1jUxA8JaL6f7wxGcMPLw6uOvUg=;
        b=ClnjGcdqhbXscKQY549otv+AGVtxr/7SrVeqIYMJ1bsyiv79Tp+po8pG7T4HVvSwzY
         cjfaRP6VNk/f+hP7BBuHRw6RQ9osCyZEfq/IlMaPZjAy48rxSZPLhmXZmb9SmtfkzRjk
         C3XbvbfZUsFtkQMDqI2D1k6XpyTQs0imuqkNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mWFf4PeOP51GVKCCtIDH9Etmi9ksyXOtjsAE2ghcrC+APJYYhIbzqJ85HXEP+Ytrzd
         kSkcwgg6D7jpq+uvZu5/y3fUVJtLp4qH26jD4e94hfB7SzQKx6NJAdb9KNyUtWGct+sm
         35/IEXG7dIkZN+qb+b0mvkoOTqiUAcSDj4+G8=
Received: by 10.213.55.209 with SMTP id v17mr3759734ebg.98.1273184863957;
        Thu, 06 May 2010 15:27:43 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm843521ewy.15.2010.05.06.15.27.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 15:27:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146505>

Introduce a new attribute called "auto-eol" and a config variable,
"core.eolStyle", which will enable line ending normalisation using the
autocrlf mechanism.

The intent is to enable autocrlf in an alternative way, splitting the
existing "core.autocrlf" config variable into two:

- a per-repository "line endings should be normalised in this
  repository" setting, activated by setting the auto-eol attribute
  (usually on all files in the repository)

- a config variable, "core.eolStyle" which lets the user decide which
  line endings are preferred in the working directory

Possible values for "core.eolStyle" are:

- "lf", meaning that LF line endings are preferred
- "crlf", meaning that CRLF line endings are preferred
- "native" (the default), crlf or lf according to platform
- "false", which disables end-of-line conversion even when auto-eol is
  set

"core.autocrlf" will override auto-eol when set to anything but "false".

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Makefile      |    3 +++
 cache.h       |   19 +++++++++++++++++++
 config.c      |   16 +++++++++++++++-
 environment.c |    1 +
 4 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..419532e 100644
--- a/Makefile
+++ b/Makefile
@@ -224,6 +224,8 @@ all::
 #
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-coded
 # dependency rules.
+#
+# Define NATIVE_CRLF if your platform uses CRLF for line endings.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -989,6 +991,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	NATIVE_CRLF = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
diff --git a/cache.h b/cache.h
index 5eb0573..690511e 100644
--- a/cache.h
+++ b/cache.h
@@ -561,6 +561,25 @@ enum safe_crlf {
 
 extern enum safe_crlf safe_crlf;
 
+enum auto_crlf {
+	AUTO_CRLF_FALSE = 0,
+	AUTO_CRLF_TRUE = 1,
+	AUTO_CRLF_INPUT = -1,
+};
+
+enum eol_style {
+	EOL_STYLE_FALSE = AUTO_CRLF_FALSE,
+	EOL_STYLE_CRLF = AUTO_CRLF_TRUE,
+	EOL_STYLE_LF = AUTO_CRLF_INPUT,
+#ifdef NATIVE_CRLF
+	EOL_STYLE_NATIVE = EOL_STYLE_CRLF,
+#else
+	EOL_STYLE_NATIVE = EOL_STYLE_LF,
+#endif
+};
+
+extern enum eol_style eol_style;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index 6963fbe..8a11052 100644
--- a/config.c
+++ b/config.c
@@ -461,7 +461,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
-			auto_crlf = -1;
+			auto_crlf = AUTO_CRLF_INPUT;
 			return 0;
 		}
 		auto_crlf = git_config_bool(var, value);
@@ -477,6 +477,20 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.eolstyle")) {
+		if (value && !strcasecmp(value, "lf"))
+			eol_style = EOL_STYLE_LF;
+		else if (value && !strcasecmp(value, "crlf"))
+			eol_style = EOL_STYLE_CRLF;
+		else if (value && !strcasecmp(value, "native"))
+			eol_style = EOL_STYLE_NATIVE;
+		else if (! git_config_bool(var, value))
+			eol_style = EOL_STYLE_FALSE;
+		else
+			return error("Malformed value for %s", var);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/environment.c b/environment.c
index 876c5e5..05cd1d5 100644
--- a/environment.c
+++ b/environment.c
@@ -40,6 +40,7 @@ const char *editor_program;
 const char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 int read_replace_refs = 1;
+enum eol_style eol_style = EOL_STYLE_NATIVE;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
-- 
1.7.1.3.gb95c9
