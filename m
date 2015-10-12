From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule-config: Untangle logic in parse_config
Date: Mon, 12 Oct 2015 10:58:58 -0700
Message-ID: <1444672738-2944-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 19:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlhO4-0001I0-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbbJLR7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:59:48 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33258 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbJLR7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 13:59:47 -0400
Received: by pabrc13 with SMTP id rc13so24833752pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KGPw8FEBTv0HsN1kxdhcR4v50417w1hdEkt/bxfw1qI=;
        b=aiQUc7Hc2lxGhpBHHY2fIlqv6l5zz47Mt55q33XcLpDR/fbJoLgwrEFAb9FLHHJHNR
         WrErAvAPp9htJpeN9+Wih/QDMvIjazKa+6L1KX+kOZLhRQyLO19dfAMCm30ABUPqEzbU
         /xsNcFE9d18zu1IiW1X8s9F56HiNOG7IFGigC5HtQKHqY4DCfOuOA+kWYBG6lVaz5yeg
         YOJMxA+AW88IOQE5HOYdFQTU0y1zEyu6axwRXgI+7k9DAMy41ZNOMy5YEQLy4e5opkSM
         LmXFIPmVi31CnBqnJv568+uebD/VP6kZyjMyHu3zQvrJXAyKuY5kGSNPrv/k6wlRE5hv
         TVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KGPw8FEBTv0HsN1kxdhcR4v50417w1hdEkt/bxfw1qI=;
        b=gdhFQVCmyvU51VDB4DgGGrat6A0AZNxYo/Ke8zOwKB8YXn7RPdf6rIA4PsZFntCIn3
         excjIZ6Qp2qkF7IY1p8FrVsj/lp0Irc4RjW6uDcNg9inVLqtVmQlDVotIyavVOSdGsvx
         6BwXNM9v4RrU/dhRQ8heMNMZZLBR8qJzfqwDtp7CzEzACoMofP/RXmIGBSTDoihUQ2mW
         v7oSXId1gEPf8d7gsvShb3TA+57M9imPFNRVyBh+D/pI/SufpZjnK6nI/JFQ53F0uOTK
         PZcdmsHndUCBlZZ6s0M+mnD5xB+4T/GzO4dY8NN0hVYAbE1NHOnOxLL0mKQSlaEjyka9
         u62A==
X-Gm-Message-State: ALoCoQmF1nZNaxn60WqJAGURwU7TacXON8k2nIkacJVy8U8cA01OGl4oeNMUlqTK1g/YPM+zWj/s
X-Received: by 10.68.142.42 with SMTP id rt10mr14958363pbb.14.1444672787250;
        Mon, 12 Oct 2015 10:59:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id ci2sm19502730pbc.66.2015.10.12.10.59.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 10:59:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.274.g94829aa.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279390>

This improves readability of the parse_config logic by making it more concise.

CC: Eric Sunshine <sunshine@sunshineco.com>
CC: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Eric commented on this during the long series for parallelizing 
 fetching submodules. I realized this can be added as an independant patch
 as it doesn't interfere with the series at all, but rather was needed for the
 next series I planned to put on top (parallelize git submodule). I need to
 rethink the next series anyway, so I extracted this patch as a useful
 readability improvement. 
 
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
2.5.0.274.g94829aa.dirty
