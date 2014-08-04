From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 10/11] alias.c: replace `git_config()` with `git_config_get_string()`
Date: Mon,  4 Aug 2014 11:33:48 -0700
Message-ID: <1407177229-30081-11-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:35:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN6R-0008Me-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbaHDSfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:35:16 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56323 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbaHDSfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:35:15 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so10109382pdj.28
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLnr6j9uGv/2u0rpJ149Ek53dA4XvpZP33nIXVWBtwo=;
        b=LFx2HvG11NJvJpQ5Y4uP0vJyVtOWaS1y4W42SaOVfvTOvtOwjJWrdJGdn1XKkksVZb
         kc9O2hn3fo6FBtorD6sjF1TtHj8fCrwroJfpTakCwScmv5s5fWRcD01BC00H6IdfCq5s
         ovcRGMBwue2ANC1FMRFSIZAuHYaTCHqDkuhS/GfUSYEnSsi5fJUvKo5dhWf9iXkEBwYB
         6JIC1GE28/Lj5W3sXIho/yvtu0pZ2K1W3f7+qPfn6PbB9YG9iIJ5Dlx/V/QwNpS0PmeJ
         ADN6qA4hyuKB5W4PskwqC5QUIBcMDKd059Ep32NrTAE3MikM0VK1kqF34djS1+I6l3Ws
         y1kw==
X-Received: by 10.66.249.71 with SMTP id ys7mr5118162pac.112.1407177315308;
        Mon, 04 Aug 2014 11:35:15 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.35.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:35:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254762>

Use `git_config_get_string()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 alias.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/alias.c b/alias.c
index 758c867..6aa164a 100644
--- a/alias.c
+++ b/alias.c
@@ -1,26 +1,13 @@
 #include "cache.h"
 
-static const char *alias_key;
-static char *alias_val;
-
-static int alias_lookup_cb(const char *k, const char *v, void *cb)
-{
-	const char *name;
-	if (skip_prefix(k, "alias.", &name) && !strcmp(name, alias_key)) {
-		if (!v)
-			return config_error_nonbool(k);
-		alias_val = xstrdup(v);
-		return 0;
-	}
-	return 0;
-}
-
 char *alias_lookup(const char *alias)
 {
-	alias_key = alias;
-	alias_val = NULL;
-	git_config(alias_lookup_cb, NULL);
-	return alias_val;
+	char *v = NULL;
+	struct strbuf key = STRBUF_INIT;
+	strbuf_addf(&key, "alias.%s", alias);
+	git_config_get_string(key.buf, &v);
+	strbuf_release(&key);
+	return v;
 }
 
 #define SPLIT_CMDLINE_BAD_ENDING 1
-- 
1.9.0.GIT
