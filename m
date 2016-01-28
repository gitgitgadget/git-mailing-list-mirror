From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/2] Port `git submodule init` from shell to C
Date: Wed, 27 Jan 2016 18:30:35 -0800
Message-ID: <1453948237-9860-1-git-send-email-sbeller@google.com>
References: <xmqqtwm1e0ps.fsf@gitster.mtv.corp.google.com>
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	sunshine@sunshineco.com, j6t@kdbg.org
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 28 03:30:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOcMC-0004Mh-42
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 03:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966409AbcA1Cao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 21:30:44 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36245 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbcA1Cam (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 21:30:42 -0500
Received: by mail-pf0-f177.google.com with SMTP id n128so14838462pfn.3
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 18:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BlysGXUtge9AVSzYF0aJEuZ2uxDFGnYf3m7CTi8pYDU=;
        b=f8IqEw3zJ7lQPCq/m3cDkbrLnt+i+qZHtRTyuCvRZ2XAFw/Vmva74n8gUOs+yc2/KM
         vHMIp69i9S7xYyyzx8ElulsUjjLMSWOBmSDZicj0S64T3vBefXJFWCIXGHZMHFbhr6Dy
         DyUFTg0MAA07TmZpAlO7mvYCXuMVyjRzvbNHhXGAJw2bH+ney1uQekXtfSWmuK+/c9IT
         46fWe8azGTZSbIeE0ivAnvavRfsJLSgQMBa8dHdiv4Y3Wfa3Q38J5Jp0SG2RdwH4Zl8z
         f6j+ovqxG0a8WDI5QN5JPZNoXkA2QU4Rxo4HNpdZa1V3zaJJTGvClxXbkNqyBlMrUiBK
         I6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BlysGXUtge9AVSzYF0aJEuZ2uxDFGnYf3m7CTi8pYDU=;
        b=kJD3j1vXLUG8M3a0hBgmRzSqxYPdx50qk2hGdcClDvWxaihTyz2wupqDJvl4FDx44C
         7OtV0rz8uWNcxGpsZ1MxqxbuGHWGQlKoDphjvU+ETvININ6ltp9vOq25737nad+Yuy1v
         CatN5UHyI8JzoVNRLx0rwIDgKEgRjUfnuZ526+P4Kv/TmmYq7H0sb016lhnzZF9eIN8E
         Iacw5Z4aJ1kA5QgFu8gEHJ4c+CwpuNm7KYSRQRNEvJqNWkI3ear4+U24L+9iXXa1O0La
         p25sA0oRCeL8YGUpShSXWD7YRZ9Id4m8Bs50CEeivKbPHvVfI78DgFHTG3qXc8N5f0qO
         iAkw==
X-Gm-Message-State: AG10YOQBZPQ3zDCUFwjDtTwEup533op1tIvaXaj40WdpbDcrwBfBU0W/C6yGaAyf93HOiIyy
X-Received: by 10.98.68.220 with SMTP id m89mr882538pfi.65.1453948242200;
        Wed, 27 Jan 2016 18:30:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:3c3b:fb4a:fb7e:e6b6])
        by smtp.gmail.com with ESMTPSA id fl9sm9999196pab.30.2016.01.27.18.30.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 18:30:41 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
In-Reply-To: <xmqqtwm1e0ps.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284972>

Hi,

I looked at this patch series again and fixed all memory leaks as found by
coverity scan.

This applies on top of sb/submodule-parallel-update

Thanks,
Stefan

Interdiff to v3:
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c9b0c05..dd8b2a5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -35,7 +35,7 @@ static char *get_default_remote(void)
 	if (git_config_get_string(sb.buf, &dest))
 		ret = xstrdup("origin");
 	else
-		ret = xstrdup(dest);
+		ret = dest;
 
 	strbuf_release(&sb);
 	return ret;
@@ -188,6 +188,7 @@ static int resolve_relative_url(int argc, const char **argv, const char *prefix)
 	res = relative_url(remoteurl, url, up_path);
 	puts(res);
 	free(res);
+	free(remoteurl);
 	return 0;
 }
 
@@ -209,6 +210,7 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	res = relative_url(remoteurl, url, up_path);
 	puts(res);
 	free(res);
+	free(remoteurl);
 	return 0;
 }
 
@@ -222,8 +224,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *url = NULL;
-	const char *upd = NULL;
-	const char *displaypath = relative_path(xgetcwd(), prefix, &sb);
+	char *upd = NULL;
+	char *cwd = xgetcwd();
+	const char *displaypath = relative_path(cwd, prefix, &sb);
 
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
@@ -261,6 +264,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 				remoteurl = xgetcwd();
 			url = relative_url(remoteurl, url, NULL);
 			strbuf_release(&remotesb);
+			free(remoteurl);
 		}
 
 		if (git_config_set(sb.buf, url))
@@ -269,26 +273,27 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		if (!quiet)
 			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
-		free(url);
 	}
 
 	/* Copy "update" setting when it is not set yet */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
-	if (git_config_get_string_const(sb.buf, &upd) && sub->update) {
-		upd = sub->update;
+	if (git_config_get_string(sb.buf, &upd) && sub->update) {
+		upd = xstrdup(sub->update);
 		if (strcmp(sub->update, "checkout") &&
 		    strcmp(sub->update, "rebase") &&
 		    strcmp(sub->update, "merge") &&
 		    strcmp(sub->update, "none")) {
 			fprintf(stderr, _("warning: unknown update mode '%s' suggested for submodule '%s'\n"),
 				upd, sub->name);
-			upd = "none";
+			upd = xstrdup("none");
 		}
 		if (git_config_set(sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
 	}
 	strbuf_release(&sb);
+	free(cwd);
+	free(upd);
+	free(url);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)


Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 326 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 118 +---------------
 t/t0060-path-utils.sh       |  42 ++++++
 3 files changed, 366 insertions(+), 120 deletions(-)

-- 
2.7.0.rc0.42.ge5f5e2d
