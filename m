From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] Revert "silence some -Wuninitialized false positives"
Date: Sun,  4 May 2014 01:12:54 -0500
Message-ID: <1399183975-2346-3-git-send-email-felipe.contreras@gmail.com>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 08:23:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgpq2-0000vm-8g
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 08:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbaEDGXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2014 02:23:44 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:37827 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaEDGXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 02:23:42 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so1065874oag.9
        for <git@vger.kernel.org>; Sat, 03 May 2014 23:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4xtV2XDTIYch8qaOcX9jHT2cgG7yma/yaxPApzkxssE=;
        b=mIk4oSPTrQccMNimmAR+sy7pHMtx77WQ7aAuRmdbVPkZsAhVvDfVYLTJsA+icf6zJR
         EWA/9q8DysRrp6x8q5556RW9U6Vouc62HPjqk0AzyUcnPrT2QpMtyYwj8NILokbTJLNU
         uOcXVdJ7cG92NpwlCtOcmTCNeGzClE+dVP6aWnqrzH4WupSeIvS+pLuqXDQJaET/27cv
         exx9rHyws+t8IUvumpI2EoSHf92jFwKO5y7oMi+zYEkbN0uZG+hLf2TX64AAtGt6ae1r
         sk1W7jREdX9avI/gs22BmJvrJvUTpPTnOMbPiWGiFlRNfUmKANv2zlwkKdOsgcAjjHnE
         k9Gg==
X-Received: by 10.60.59.196 with SMTP id b4mr26403142oer.48.1399184622623;
        Sat, 03 May 2014 23:23:42 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm10131967obc.13.2014.05.03.23.23.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 23:23:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
In-Reply-To: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248076>

In recent versions of gcc (4.9.0), we get a few of these:

  notes.c: In function =E2=80=98notes_display_config=E2=80=99:
  notes.c:970:28: warning: right-hand operand of comma expression has n=
o effect [-Wunused-value]
      config_error_nonbool(k);
                            ^
Previous commit explains the reason.

This reverts commit a469a1019352b8efc4bd7003b0bd59eb60fc428c.

Conflicts:
	cache.h
	parse-options.h
---
 cache.h         |  3 ---
 config.c        |  1 -
 parse-options.c | 18 +++++++++---------
 parse-options.h |  4 ----
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index 107ac61..fae077a 100644
--- a/cache.h
+++ b/cache.h
@@ -1271,9 +1271,6 @@ extern int check_repository_format_version(const =
char *var, const char *value, v
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int config_error_nonbool(const char *);
-#if defined(__GNUC__) && ! defined(__clang__)
-#define config_error_nonbool(s) (config_error_nonbool(s), -1)
-#endif
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
=20
diff --git a/config.c b/config.c
index a30cb5c..0083674 100644
--- a/config.c
+++ b/config.c
@@ -1870,7 +1870,6 @@ int git_config_rename_section(const char *old_nam=
e, const char *new_name)
  * Call this to report error for your variable that should not
  * get a boolean value (i.e. "[my] var" means "true").
  */
-#undef config_error_nonbool
 int config_error_nonbool(const char *var)
 {
 	return error("Missing value for '%s'", var);
diff --git a/parse-options.c b/parse-options.c
index b536896..2b4b8e5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -19,6 +19,15 @@ int optbug(const struct option *opt, const char *rea=
son)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
=20
+int opterror(const struct option *opt, const char *reason, int flags)
+{
+	if (flags & OPT_SHORT)
+		return error("switch `%c' %s", opt->short_name, reason);
+	if (flags & OPT_UNSET)
+		return error("option `no-%s' %s", opt->long_name, reason);
+	return error("option `%s' %s", opt->long_name, reason);
+}
+
 static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt=
,
 		   int flags, const char **arg)
 {
@@ -632,12 +641,3 @@ static int parse_options_usage(struct parse_opt_ct=
x_t *ctx,
 	return usage_with_options_internal(ctx, usagestr, opts, 0, err);
 }
=20
-#undef opterror
-int opterror(const struct option *opt, const char *reason, int flags)
-{
-	if (flags & OPT_SHORT)
-		return error("switch `%c' %s", opt->short_name, reason);
-	if (flags & OPT_UNSET)
-		return error("option `no-%s' %s", opt->long_name, reason);
-	return error("option `%s' %s", opt->long_name, reason);
-}
diff --git a/parse-options.h b/parse-options.h
index 3189676..3b140d0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -176,10 +176,6 @@ extern NORETURN void usage_msg_opt(const char *msg=
,
=20
 extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int =
flags);
-#if defined(__GNUC__) && ! defined(__clang__)
-#define opterror(o,r,f) (opterror((o),(r),(f)), -1)
-#endif
-
 /*----- incremental advanced APIs -----*/
=20
 enum {
--=20
1.9.2+fc1.20.g204a630
