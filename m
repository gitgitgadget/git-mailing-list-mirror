From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule init: fail gracefully with a missing .gitmodules file
Date: Thu, 28 Apr 2016 11:28:39 -0700
Message-ID: <1461868119-9146-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 28 20:29:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avqgM-0007Bv-UZ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 20:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbcD1S2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 14:28:54 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33400 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbcD1S2x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 14:28:53 -0400
Received: by mail-pa0-f54.google.com with SMTP id zm5so39085770pac.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AtIOPb4JZ1eCqMnbbBOMiFdk4DhY46aW6mCR/ALpFIM=;
        b=kqkroh1Dc70MWhAqFZe0aAT3v3hcXv0CbBgjO6hfIqJcjkIrLLnNJT9ynVsoJn3+m0
         7td74yAPBCvMnPDZyjS2dhhJQY45t1eEGkJHAqQXfbY+VHHKwvkdztNgIBC4w+oeRo6f
         21fhU2jITlSMIqTIzLqkn1CLCsfI1RhtQY4lh7WhvigvDUbgIkf1jtD3nHlQsF9lcSNC
         QWb/sjh8HmjvnDiuIXx8RCH1lGm/Kefc5oSdlMYPL6mdnT6WF7IVVhdwqjGJXiQHn06J
         IJpxLN/7SMI0n6rh128SmF/41GTqvZOumYz5241+KyRCCmplqrarzs7CQjnbiKTnp8wC
         uE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AtIOPb4JZ1eCqMnbbBOMiFdk4DhY46aW6mCR/ALpFIM=;
        b=WEe0/ts8KsSAahyl8KAoK+EYILv8A/6wlwpSebDbJBKlK9HRHoxRC2SvACWjlFdq79
         rbZKR0cu6T4yZFVsbS3/usP9PNlDuyEYES0rgQ8yi74BWwtA3j/S6YBg27Q2h0pt1TYh
         lbGwAURIyNAYMlP+PK2m3keQVvVodbHDHqC6g4WgHvoGBP7KJBhpIYtlVO6veNffd0Io
         hLeaIXNoCFYdMgp/NXuv3N324aKP6UtJGBq+LJHNWg4+aOsy9OSKRi9f0789YuHjBv4h
         wO1n+rPnwcyWsNRYwig/n0PqFSIlniXmvQx+Ew7J6V4KaiG2xYxYuUie/wtYTdwn+1mo
         zgCw==
X-Gm-Message-State: AOPr4FWGhODbONcDtk98LV/xZE/pfTlQNhu03E3hWG4+7Rojk3yYhUGjcl0NfYOqA4hAcy5I
X-Received: by 10.66.164.39 with SMTP id yn7mr22790595pab.107.1461868132537;
        Thu, 28 Apr 2016 11:28:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fce0:3f2f:7f7d:8246])
        by smtp.gmail.com with ESMTPSA id t126sm16846351pfb.73.2016.04.28.11.28.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 11:28:51 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.26.g3604242.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292933>

When there is no .gitmodules file availabe to initialize a submodule
from, `submodule_from_path` just returns NULL. We need to check for
that and abort gracefully. When `submodule init` was implemented in shell,
a missing .gitmodules file would result in an error message

    No url found for submodule path '%s' in .gitmodules

While that is technically true, I think we can broaden the error message
and just say there is no section for the submodule in the .gitmodules file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This goes on top of sb/submodule-init (I added the base-commit
 below, just in case anyone uses that feature already. Though I did
 that manually :)
 
 Thanks,
 Stefan

 builtin/submodule--helper.c | 10 +++++++---
 t/t7400-submodule-basic.sh  |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6d4f27..af5406e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -314,13 +314,17 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
 
-	sub = submodule_from_path(null_sha1, path);
-
 	if (prefix) {
 		strbuf_addf(&sb, "%s%s", prefix, path);
 		displaypath = strbuf_detach(&sb, NULL);
 	} else
-		displaypath = xstrdup(sub->path);
+		displaypath = xstrdup(path);
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (!sub)
+		die(_("No section found for submodule path '%s' in .gitmodules"),
+			displaypath);
 
 	/*
 	 * Copy url setting when it is not set yet.
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f99f674..f2b3519 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -18,6 +18,14 @@ test_expect_success 'setup - initial commit' '
 	git branch initial
 '
 
+test_expect_success 'sane abort on missing .gitmodules file' '
+	test_when_finished "git update-index --remove sub" &&
+	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
+	# missing the .gitmodules file here
+	test_must_fail git submodule init 2>actual &&
+	test_i18ngrep "No section found for submodule path" actual
+'
+
 test_expect_success 'configuration parsing' '
 	test_when_finished "rm -f .gitmodules" &&
 	cat >.gitmodules <<-\EOF &&
-- 
2.8.0.26.g3604242.dirty

base-commit: 3604242f080a813d6f20a7394def422d1e55b30e
