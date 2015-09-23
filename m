From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 09/14] submodule-config: Untangle logic in parse_config
Date: Tue, 22 Sep 2015 18:45:27 -0700
Message-ID: <1442972732-12118-10-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8L-0007Dx-I7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994AbbIWBpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:45:50 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35758 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759985AbbIWBps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:48 -0400
Received: by pacfv12 with SMTP id fv12so25540738pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQxVvLedRXG4P9ZGMV8yi75Wzk0cT12nmalw/MSPQIw=;
        b=ONVhEac7qGBEvOLbXfed6avjqMVwaALD/lXwqDBuE4Vvnc5eutZjWSjO02t0ucQvP3
         47XHWURf5p84J+UTpP897iNI8kpcMRfO6CyKpD7mwq8hY5fXabIvLbsmCs37LgxUV9AZ
         axu4mpgs0kKHgp/IL/jAhwWV76koJgmlu0u0E8IqDcDnbNoJQz7BXhwRKa0sZbRzeid5
         /o5n5RJB+1PEa3iih+yArluTE2l6EUOnnVXOS9vKPkwYEeA1Ggiu0syf3h1Hx6NzGl26
         EswgbXs/hA2J0SCOHj3hMptmHthoZW8OlEChK1JoOnTGZkHjx3/OFw1qNG0oO36eylkd
         cvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQxVvLedRXG4P9ZGMV8yi75Wzk0cT12nmalw/MSPQIw=;
        b=XD/0FTK3D+8uljo45lUssZ/dHVQOBb9LDXd6TgDLax89/1i+OsGFEHDT29/EJLQc3Q
         TeRSi77oWCf569StGTbqyebri4/6+DvZuB6iWBvl0P8pKSUY2EMQdyo6E/Iz4gdHEGhr
         9qH+cviOdZ13IgOfp6g+XV2E8EWHdiT+1psP5hIDndBGkzMI8R0cA0bkSaKYVjBK0vzZ
         M5A3Tb68H1x6IrNGHfMnmSNyW3BWEYt0wVcFcIB9IlOpHME9USpl73WqeHjbXQ05RViu
         Np8yFPEEa9o1txki6JyjVoPbeCtc2POZ484eoas7stxqfMU0sAmO1HT9oYECrSlsDGVS
         KjAw==
X-Gm-Message-State: ALoCoQnAvpLjcAfuRBqxz6fdI2vxXnmENJwBlDUAw+3vqMI+q2ELjm9GiUGykff66aLovhBUJBVW
X-Received: by 10.68.213.234 with SMTP id nv10mr34746728pbc.145.1442972747585;
        Tue, 22 Sep 2015 18:45:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id xv12sm4593267pac.38.2015.09.22.18.45.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278459>

CC: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 74 +++++++++++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 393de53..afe0ea8 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -257,78 +257,62 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!name_and_item_from_var(var, &name, &item))
 		return 0;
 
-	submodule = lookup_or_create_by_name(me->cache, me->gitmodules_sha1,
-			name.buf);
+	submodule = lookup_or_create_by_name(me->cache,
+					     me->gitmodules_sha1,
+					     name.buf);
 
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
2.5.0.272.ga84127c.dirty
