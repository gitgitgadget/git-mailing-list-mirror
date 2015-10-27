From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/9] submodule-config: "goto" removal in parse_config()
Date: Tue, 27 Oct 2015 11:15:45 -0700
Message-ID: <1445969753-418-2-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:17:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8o1-0003rR-I9
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbbJ0SQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:58 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35793 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965018AbbJ0SQC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:02 -0400
Received: by pasz6 with SMTP id z6so229284574pas.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HWBBm90rsYcyuwiN1KQ3Yq9lMxY9VCQOUX0pFzd5Unc=;
        b=Zr4ymJy0f3R3R6qMw7RmWcb7MDPBOgyMjRdNWWoGUmKgBXO3gsJvFwpC5ON+AER9HY
         DQxRYt+K9+csEqzi4D2t2SOn36FM3uZWrDdV6x2nxOHcuFEj1DtQjSCU1tcDQbQd8ZZn
         277UPfa3ksB6a2kh1jAz0Pm/uaPhYPWczyy98VGSgxX8HNmsS7a05fabrQX6My5cahck
         0+qJGeV5t3sWZZq3eDsAO0V612MnttH2VjEYh5000kpt/Wc5iVOc3LOQtf9Kf05MsNyQ
         AdQ35NBNdg/kfaSTljioU6W/7HaAp8P7gE00fKgcK643wA4T0waPeiCOp0c0cohSs1pU
         NrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HWBBm90rsYcyuwiN1KQ3Yq9lMxY9VCQOUX0pFzd5Unc=;
        b=JglVUF+rbGqdj0gZtyL2Uf9Nf8adjGNFZdohDc7HKbJmNLYe+n8vCrfXbSnztnTqqE
         KhT/HdPFCXemdseXDFG/idLvLMBkRNuI7W0qkyx5eNgwVlWMeDkrYIuDnFO1KQU0Je81
         kyAuXUIzkrabrTzmjy8i9wMmeKDo9I4a5T4yXCYQ8RxoSQutYe8AfP/B1frqPAMGVL7L
         uCr2jdQx7YIwCTRpaNVuwWOrRnApU6Afx8SRQkpE/el4cTp/84BNVs2RcVl4uBdDaGtT
         IAKhGUXAatb5Uw6EvdxqWG89PYTLilZSoDqdqhipt/u7wG70rTX5X7XZBFwgKaMZErCO
         oBEg==
X-Gm-Message-State: ALoCoQmz/ooZPpqQK+lKVK3RM1toKqHsLN0AE7S73F2ISTPO0B8unOrizA5dRbAw9j2I40/w4KTK
X-Received: by 10.68.213.162 with SMTP id nt2mr29579358pbc.86.1445969761990;
        Tue, 27 Oct 2015 11:16:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id ou1sm35146320pbc.7.2015.10.27.11.16.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280283>

Many components in if/else if/... cascade jumped to a shared
clean-up with "goto release_return", but we can restructure the
function a bit and make them disappear, which reduces the line count
as well.  Also reformat overlong lines and poorly indented ones
while at it.

The order of rules to verify the value for "ignore" used to be to
complain on multiple values first and then complain to boolean, but
swap the order to match how the values for "path" and "url" are
verified.

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
2.5.0.283.g1a79c94.dirty
