From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule-config: Shorten logic in parse_config
Date: Mon, 12 Oct 2015 17:02:47 -0700
Message-ID: <1444694567-17511-1-git-send-email-sbeller@google.com>
References: <xmqqy4f7lwkf.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, jens.lehmann@web.de,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 13 02:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zln3P-000854-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 02:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbbJMACv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 20:02:51 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33614 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbJMACu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 20:02:50 -0400
Received: by pabrc13 with SMTP id rc13so2023880pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RT16iQX8gXifo9FXP5Cn2JR5BX4Zbymab9Tknahsz4U=;
        b=UkSMo4uXav3ifhIe0xYEBq62QWquJOboyO13fVaFcP9JzejrvBkZX7plE/+BrARX8/
         kZW9ngpdP1SmjZO6z62ITg8mUHmVxIiWWUI+672A9iamCca7/qmDvUh17fkSHgtXDxCN
         PIfXwK/11u7F/Mv49FM0AiMFVR0VKX0N5Gd6MXyCSebNVtB46Z4CzotlBT+7HvPKUmnx
         SQReKUqFtkin+cqtP0oiQoLgleD2s8Bc/bBOETOiFRowahD5ZYhfrN3ju8PlRwI7F6M5
         X9RpHkJ1QuiSb0aWw0q6xYWst/cMJV7lDQkkKv1kXkPEDOw+cZr5rlpPil2mfkd38eLR
         JA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RT16iQX8gXifo9FXP5Cn2JR5BX4Zbymab9Tknahsz4U=;
        b=YObxLwmcDMiBhSP6ZamNCSwLXsJB/CNRO/gQA7fWkPTsFKSomEQZWDaEag/5PJFm04
         Wq1Ckn86BhTv9bXkOLwQjVEQn+LRIz15COSFbkI5RBtx57PhQiNswJaRWu0XsLb4bPNE
         bfvpvw3ZhCiBbogaC+L1PL9qOucWqJ9pMFpcEkhMXhmhaJlZI7KkoObLPx3P8fcIMRc7
         KoP6tZ8bwnnLRlVCHWSC5GahCLKCv+6cjJC9+2cshQqEkVty9JPatyDfYKNus1LzpZbz
         z/XZPTdhG2c+ZqCUIyEjmd/bCU3Yc83dzjiwfEWPZPgk+U2stBPcHaaWViz9iIGwMofE
         odPA==
X-Gm-Message-State: ALoCoQlMauM9xgwQhEpAq7WQhQAP8tJrrQihtIkkdcK9LgfL6cAKch8qALu9+1DjG4y39vOXGiTy
X-Received: by 10.66.194.138 with SMTP id hw10mr37566889pac.71.1444694570086;
        Mon, 12 Oct 2015 17:02:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id po4sm126091pbb.64.2015.10.12.17.02.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 17:02:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.267.g8d6e698.dirty
In-Reply-To: <xmqqy4f7lwkf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279474>

This makes the parsing more concise by removing the forward goto as well
as unifying the structure of parsing the {ignore, url, path} options.
By unifying we introduce subtle changes in the error cases. We notice
non-boolean variables before noticing duplicate variables now.

CC: Eric Sunshine <sunshine@sunshineco.com>
CC: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 69 ++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 393de53..96f1a0b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -261,74 +261,57 @@ static int parse_config(const char *var, const char *value, void *data)
 			name.buf);
 
 	if (!strcmp(item.buf, "path")) {
-		struct strbuf path = STRBUF_INIT;
-		if (!value) {
+		if (!value)
 			ret = config_error_nonbool(var);
-			goto release_return;
-		}
-		if (!me->overwrite && submodule->path != NULL) {
+		else if (!me->overwrite && submodule->path != NULL)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
-			goto release_return;
+		else {
+			if (submodule->path)
+				cache_remove_path(me->cache, submodule);
+			free((void *) submodule->path);
+			submodule->path = xstrdup(value);
+			cache_put_path(me->cache, submodule);
 		}
-
-		if (submodule->path)
-			cache_remove_path(me->cache, submodule);
-		free((void *) submodule->path);
-		strbuf_addstr(&path, value);
-		submodule->path = strbuf_detach(&path, NULL);
-		cache_put_path(me->cache, submodule);
 	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
-		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE) {
+		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"fetchrecursesubmodules");
-			goto release_return;
-		}
-
-		submodule->fetch_recurse = parse_fetch_recurse(var, value,
+		else
+			submodule->fetch_recurse = parse_fetch_recurse(
+								var, value,
 								die_on_error);
 	} else if (!strcmp(item.buf, "ignore")) {
-		struct strbuf ignore = STRBUF_INIT;
-		if (!me->overwrite && submodule->ignore != NULL) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->ignore != NULL)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
-			goto release_return;
-		}
-		if (!value) {
-			ret = config_error_nonbool(var);
-			goto release_return;
-		}
-		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
-		    strcmp(value, "all") && strcmp(value, "none")) {
+		else if (strcmp(value, "untracked") &&
+			 strcmp(value, "dirty") &&
+			 strcmp(value, "all") &&
+			 strcmp(value, "none"))
 			warning("Invalid parameter '%s' for config option "
 					"'submodule.%s.ignore'", value, var);
-			goto release_return;
+		else {
+			free((void *) submodule->ignore);
+			submodule->ignore = xstrdup(value);
 		}
-
-		free((void *) submodule->ignore);
-		strbuf_addstr(&ignore, value);
-		submodule->ignore = strbuf_detach(&ignore, NULL);
 	} else if (!strcmp(item.buf, "url")) {
-		struct strbuf url = STRBUF_INIT;
 		if (!value) {
 			ret = config_error_nonbool(var);
-			goto release_return;
-		}
-		if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url != NULL) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
-			goto release_return;
+		} else {
+			free((void *) submodule->url);
+			submodule->url = xstrdup(value);
 		}
-
-		free((void *) submodule->url);
-		strbuf_addstr(&url, value);
-		submodule->url = strbuf_detach(&url, NULL);
 	}
 
-release_return:
 	strbuf_release(&name);
 	strbuf_release(&item);
 
-- 
2.5.0.267.g8d6e698.dirty
