Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF08C433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiAZVau (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiAZVap (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:30:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647BC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:30:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v123so565186wme.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2x5ocqjnonJcn39KOGtcAmp1zXkLZPFmH1bkE5lNEhY=;
        b=N8pGthT7zGn1KHsJm0hdfSrgbqrf591+Y1KI7pa4jZht1q1G5jglOxcoCmprTwwNtk
         6i3qiQgPuU8Pbl4Eg+gKQECrnmK4HY7epKgCfwl+mvVtbpLkzzkkYSp+HZYYYnqUgb02
         nibLCuUbYccBii0rzLo8iMAMzjspOe2tX9hLWUQoFGFQUvtyZXV5AJ8c4oWb90Gpuc4g
         fYeVM205ZKMuVrdtAA4H1fwa6WUne9oWK7hxC02mxbIWpjaxnSick1GQU+GK5i3GVgSg
         pf8JYbwt+RnmKIY0k+/SspeS76F9kAa/FV8ph//IJ6dp1p7uIPQ6Jk76PXxlD91UTDnq
         OcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2x5ocqjnonJcn39KOGtcAmp1zXkLZPFmH1bkE5lNEhY=;
        b=GXLG0wtgCcxvgNdiydtXJ84OSTnb1uX82z1MkAmGRFamxoWBGeQ0cmwOsl9mrE/xBa
         p9QWA1bpRVKNtUo9IVye400Ph1TG1Ygqv1ndhNugsdfDQeyZCosCfvqyY7FBsYNhGWLO
         Oz/lNEcvUOD51Vg3bEToT0l/aJcZ2nceNdewmztLxDpQhy6275egBJ71JqfOtQ2lmhf8
         oXCi22LFWiQQUpLh+Y4eXGpyecQXpUfrtHb7+f/xJ2Q0yLSTdErdLd/6O+u8BpvlxGfq
         Z9LVKwGQTxq6QgIFLng8f5yXnyOhB1CIy1rgB7nCHfcSjvPQjWmSOIy8Y4WOdZCO/cqI
         FrOg==
X-Gm-Message-State: AOAM532Y0Q2jhRC2m3CrDkyrTmi7prJvE3HTM3h1NALPcgHJA/HrlwPr
        g28Ef1HDklBZ6BEf5r/INbnyvxGJu2Hbxw==
X-Google-Smtp-Source: ABdhPJwJXTtol2bicrWzQjyg7xmACvdwDxU2Txl3tJvt4FBEKjQlL8MhMHpdVNECZSkYapEZAymgnw==
X-Received: by 2002:a7b:c302:: with SMTP id k2mr9162886wmj.182.1643232643643;
        Wed, 26 Jan 2022 13:30:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 1sm316536wmo.37.2022.01.26.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:30:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] http API: fix dangling pointer issue noted by GCC 12.0
Date:   Wed, 26 Jan 2022 22:30:40 +0100
Message-Id: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pre-release GCC 12.0 development branch has a new warning about
dangling pointers in -Wall:

    http.c: In function ‘run_active_slot’:
    http.c:1332:24: error: storing the address of local variable ‘finished’ in ‘*slot.finished’ [-Werror=dangling-pointer=]
     1332 |         slot->finished = &finished;
          |         ~~~~~~~~~~~~~~~^~~~~~~~~~~
    http.c:1330:13: note: ‘finished’ declared here
     1330 |         int finished = 0;
          |             ^~~~~~~~

This is on a locally built "gcc (GCC) 12.0.1 20220120 (experimental)",
built from gcc.git's 8bc700f4c3f (Enhance vec_pack_trunc for integral
mode mask., 2022-01-17).

To fix this I first simply made the member "int finished",
i.e. removing the pointer indirection. It turns out that nothing cared
about the state of it being a NULL pointer v.s. "*ptr == 0".

But we can instead amend the code added in baa7b67d091 (HTTP slot
reuse fixes, 2006-03-10) to get rid of "int *finished" entirely. I
instrumented the code to add this after every use of slot->finished or
slot->in_use:

    if (slot->finished && slot->in_use == *slot->finished) BUG("in-use = %d and finished = %d disconnect", slot->in_use, *slot->finished);
    if (!slot->finished && !slot->in_use) BUG("have !in-use and no finished pointer");

Which never fires, but we would get occurrences of:

    if (!slot->finished && slot->in_use) BUG("have in-use and no finished pointer");

I.e. we can simply drop the field and rely on "slot->in_use" in cases
where we used "finished" before. The two fields were mirror images of
each other, and the tri-state nature of "finished" wasn't something we
relied upon.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A look at GCC's release history suggests that GCC 12.0 will be
released sometime in the next 3-6 months:
https://gcc.gnu.org/releases.html

By addressing this new -Wall warning early we can get ahead of the
annoying compilation error we'll run into with DEVELOPER=1 once it's
released.

 http-walker.c | 4 ----
 http.c        | 8 +-------
 http.h        | 1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 910fae539b8..5cc369dea85 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -225,13 +225,9 @@ static void process_alternates_response(void *callback_data)
 					 alt_req->url->buf);
 			active_requests++;
 			slot->in_use = 1;
-			if (slot->finished != NULL)
-				(*slot->finished) = 0;
 			if (!start_active_slot(slot)) {
 				cdata->got_alternates = -1;
 				slot->in_use = 0;
-				if (slot->finished != NULL)
-					(*slot->finished) = 1;
 			}
 			return;
 		}
diff --git a/http.c b/http.c
index 229da4d1488..4507c9ac9c7 100644
--- a/http.c
+++ b/http.c
@@ -197,9 +197,6 @@ static void finish_active_slot(struct active_request_slot *slot)
 	closedown_active_slot(slot);
 	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
 
-	if (slot->finished != NULL)
-		(*slot->finished) = 1;
-
 	/* Store slot results so they can be read after the slot is reused */
 	if (slot->results != NULL) {
 		slot->results->curl_result = slot->curl_result;
@@ -1204,7 +1201,6 @@ struct active_request_slot *get_active_slot(void)
 	active_requests++;
 	slot->in_use = 1;
 	slot->results = NULL;
-	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
@@ -1327,10 +1323,8 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
-	int finished = 0;
 
-	slot->finished = &finished;
-	while (!finished) {
+	while (slot->in_use) {
 		step_active_slots();
 
 		if (slot->in_use) {
diff --git a/http.h b/http.h
index df1590e53a4..81418d5fd8b 100644
--- a/http.h
+++ b/http.h
@@ -24,7 +24,6 @@ struct active_request_slot {
 	int in_use;
 	CURLcode curl_result;
 	long http_code;
-	int *finished;
 	struct slot_results *results;
 	void *callback_data;
 	void (*callback_func)(void *data);
-- 
2.35.0.890.gd7e422415d9

