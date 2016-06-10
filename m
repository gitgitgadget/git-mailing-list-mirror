From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule--helper: initial clone learns retry logic
Date: Thu,  9 Jun 2016 17:35:36 -0700
Message-ID: <20160610003536.27924-1-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 10 02:35:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBAQO-0005HW-WE
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 02:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbcFJAfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 20:35:45 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35855 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbcFJAfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 20:35:44 -0400
Received: by mail-pf0-f171.google.com with SMTP id t190so17805435pfb.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bLZqGOrZ6Evd1L2JCKUZ0PuAeInlRtuIdymzMEKT8l4=;
        b=DDywtCns4rgmWbhcD4Pf/cT2sfFsjV0yobY6YQrJBsMCsdFgmtP7K94VsKRiN/LBcc
         22Prg/9RsquXGQpX68C+Lc4duo9+h32WVA0RspdG4NXB61DZDgizxhQqbAcTI4CggwJh
         bwOhRxrwrznzhd6JpaADuRnL/UPil0O2/QUPfM0DfTituoLgzI2S3l44Dm7A0z79itFx
         Udid/8f2esUMUro2OkIHWKImYPfcdkJs7D5F7fcRVH1NQ1TCdLjVYr9GREwXFBe7snoD
         iwHHGMDg5jRuTHhHXo28D3vU2qRp7xPm6IKsamZ4ch4F0shudPBZWxR7C1USPJzKnCI4
         En+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bLZqGOrZ6Evd1L2JCKUZ0PuAeInlRtuIdymzMEKT8l4=;
        b=lKxl6USpd6H5uUzleN8nWaWVaOzp3yUuhidlB1g8dYSn5FhdFVNBvQ9o6BlxxLIJhr
         e3Rq8UjRD5DUa42m2flVO5G2pWXzLe7ULVwC6kq3MSuCOGxpe0Xk3PCtcFC3tO3O96Tp
         fgO/dRRtISmWW6VkpzHH9gi0mI7PMxA0WMghowxpvErijEy7eCSAXYvvquxGRE9Cyr4H
         qrxDgLWQzKuUDF0M6Kf5GEAJnXcv4B3eWaSnx2s0H1O2AsHyggQ3Ko/+jswrzNqqVAmU
         54EVMXhvn+T7Ow3kwsn8jN5wEaTVWT0MP0skqZt52+tezWXfvOa7W4cyTd/XRP8bI0Dk
         Eekg==
X-Gm-Message-State: ALyK8tK+sTXJ4BtUFsXVgQszJIcy/W5V5Zh3Lddr4uvniPHSafa4Mt0o0PnAdPiL+1UU6W1x
X-Received: by 10.98.105.138 with SMTP id e132mr7488031pfc.59.1465518943071;
        Thu, 09 Jun 2016 17:35:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2099:4ff:ce85:68a])
        by smtp.gmail.com with ESMTPSA id ez6sm12779729pab.12.2016.06.09.17.35.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Jun 2016 17:35:42 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc2.365.gb48bdfb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296942>

Each submodule that is attempted to be cloned, will be retried once in
case of failure after all other submodules were cloned. This helps to
mitigate ephemeral server failures and increases chances of a reliable
clone of a repo with hundreds of submodules immensely.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This patch doesn't do pointer forbidden magic, also we don't abuse the
 prio queue.
 
 The API for running parallel commands isn't quite designed for this
 though as we need to pass around an int instead of a pointer, so we wrap
 the int into a int*, which will create a xmalloc/free for each submodule.
 
 This replaces the patch [1/2] in the series 
 "[PATCH 0/2] Dealing with a lot of submodules" 
 
 Thanks,
 Stefan

 builtin/submodule--helper.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c7deb55..6424b40 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -590,10 +590,14 @@ struct submodule_update_clone {
 
 	/* If we want to stop as fast as possible and return an error */
 	unsigned quickstop : 1;
+
+	/* failed clones to be retried again */
+	const struct cache_entry **failed_clones;
+	int failed_clones_nr, failed_clones_alloc;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
-	STRING_LIST_INIT_DUP, 0}
+	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -718,23 +722,47 @@ cleanup:
 static int update_clone_get_next_task(struct child_process *child,
 				      struct strbuf *err,
 				      void *suc_cb,
-				      void **void_task_cb)
+				      void **idx_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
+	const struct cache_entry *ce;
+	int index;
 
 	for (; suc->current < suc->list.nr; suc->current++) {
-		const struct cache_entry *ce = suc->list.entries[suc->current];
+		ce = suc->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
+			int *p = xmalloc(sizeof(*p));
+			*p = suc->current;
+			*idx_task_cb = p;
 			suc->current++;
 			return 1;
 		}
 	}
+
+	/*
+	 * The loop above tried cloning each submodule once, now try the
+	 * stragglers again, which we can imagine as an extension of the
+	 * entry list.
+	 */
+	index = suc->current - suc->list.nr;
+	if (index < suc->failed_clones_nr) {
+		int *p;
+		ce = suc->failed_clones[index];
+		if (!prepare_to_clone_next_submodule(ce, child, suc, err))
+			die("BUG: ce was a submodule before?");
+		p = xmalloc(sizeof(*p));
+		*p = suc->current;
+		*idx_task_cb = p;
+		suc->current ++;
+		return 1;
+	}
+
 	return 0;
 }
 
 static int update_clone_start_failure(struct strbuf *err,
 				      void *suc_cb,
-				      void *void_task_cb)
+				      void *idx_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
 	suc->quickstop = 1;
@@ -744,15 +772,39 @@ static int update_clone_start_failure(struct strbuf *err,
 static int update_clone_task_finished(int result,
 				      struct strbuf *err,
 				      void *suc_cb,
-				      void *void_task_cb)
+				      void *idx_task_cb)
 {
+	const struct cache_entry *ce;
 	struct submodule_update_clone *suc = suc_cb;
 
+	int *idxP = *(int**)idx_task_cb;
+	int idx = *idxP;
+	free(idxP);
+
 	if (!result)
 		return 0;
 
-	suc->quickstop = 1;
-	return 1;
+	if (idx < suc->list.nr) {
+		ce  = suc->list.entries[idx];
+		strbuf_addf(err, _("Failed to clone '%s'. Retry scheduled"),
+			    ce->name);
+		strbuf_addch(err, '\n');
+		ALLOC_GROW(suc->failed_clones,
+			   suc->failed_clones_nr + 1,
+			   suc->failed_clones_alloc);
+		suc->failed_clones[suc->failed_clones_nr++] = ce;
+		return 0;
+	} else {
+		idx = suc->current - suc->list.nr;
+		ce  = suc->failed_clones[idx];
+		strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
+			    ce->name);
+		strbuf_addch(err, '\n');
+		suc->quickstop = 1;
+		return 1;
+	}
+
+	return 0;
 }
 
 static int update_clone(int argc, const char **argv, const char *prefix)
-- 
2.9.0.rc2.365.gb48bdfb
