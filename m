From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/5] submodule--helper clone: simplify path check
Date: Thu, 31 Mar 2016 14:04:37 -0700
Message-ID: <1459458280-17619-3-git-send-email-sbeller@google.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, jacob.keller@gmail.com,
	norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 23:04:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljls-0008PQ-1V
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145AbcCaVEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:04:48 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35250 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbcCaVEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:04:46 -0400
Received: by mail-pa0-f42.google.com with SMTP id td3so73747958pab.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IPJ/qHNcymVeIcVbZWD2zaalYeaDfQ3+X62+n3aOZzE=;
        b=o8R91VWkGURL4Xvy26VF83SF9ht22W155PELeNSDFsKSmPdIIcOSpl70oGCKC3H1iJ
         s6BUaZSFnfAzncK3PWLimAmwRIjnmeXY6M71nxM0dWoOt+ZLPjn3ZutPU1Yi2d+CnJwb
         lbhONutYKI3AI5RZRrCRtymMWzYuKXrjqaIRx7TmNr01GsSLIQE8Oqb9IG5wzGa7Nvzk
         zzT7e7Rbjdhr6IbBPqrqlINIhxMmj3fso7n4XoC5+r114b+x7fxqNnXASsbhLtJOHfOD
         RMldHfIGevQJCWkXSeBvjCYanuezV0NlzKF3tc7SyTGK3E/mczjizTjX0BmcN5P+8uGE
         QGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IPJ/qHNcymVeIcVbZWD2zaalYeaDfQ3+X62+n3aOZzE=;
        b=WN+pAniiU4XqwFKC2ZPgbMDlWxIYH4OxiQp3+el7cnbcLNOVwDbiiSkKjEbz3vLgy3
         +tLp6PpXKr29w4lPEeeghe2dgxUby6p+xWCUPmoeqVaO5LIrtONYtrY1EYQhkyVNnz8t
         9FOOtQc2ajJwKE7O4qE44XgP/9FhlyWh3h/vwmENSQQo+Z9ztb/sNmGFOvjleZEwREkF
         pQGE7FUepsbIMLksTnUfeGg4/zMLAGEaBqwG1FrIfoQ6N+2QccsBG6NIALExZdx8Z1l9
         pJlP5o5ULDDW+faMvpftpjRCqIjxRslWHiv10wz7oOPH+Wc1ISgCC4iiorwIL34ZUh5p
         euig==
X-Gm-Message-State: AD7BkJJ5LFL/IwDN/S1Cvqc4UP2ozrbrbQqByTagBZ+VCX7ysjezIsZsyfud41+/I3i8q6iO
X-Received: by 10.66.132.37 with SMTP id or5mr25173645pab.144.1459458285867;
        Thu, 31 Mar 2016 14:04:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id 17sm15453876pfp.96.2016.03.31.14.04.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 14:04:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g39f00fe
In-Reply-To: <1459458280-17619-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290467>

The calling shell code makes sure that `path` is non null and non empty.
Side note: it cannot be null as just three lines before it is passed
to safe_create_leading_directories_const which would crash as you feed
it null. That means the `else` part is dead code, so remove it.

To make the code futureproof, add a check for path being NULL or empty
and report the error accordingly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..4f0b002 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -194,6 +194,9 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
+	if (!path || !*path)
+		die(_("submodule--helper: unspecified or empty --path"));
+
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);
 
@@ -215,10 +218,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (safe_create_leading_directories_const(path) < 0)
 		die(_("could not create directory '%s'"), path);
 
-	if (path && *path)
-		strbuf_addf(&sb, "%s/.git", path);
-	else
-		strbuf_addstr(&sb, ".git");
+	strbuf_addf(&sb, "%s/.git", path);
 
 	if (safe_create_leading_directories_const(sb.buf) < 0)
 		die(_("could not create leading directories of '%s'"), sb.buf);
-- 
2.5.0.264.g39f00fe
