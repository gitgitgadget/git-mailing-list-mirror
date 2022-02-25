Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A15C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiBYJJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiBYJJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:09:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEE725290B
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:09:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d28so3431475wra.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3i3kiFwzUPrJ6REiuthwmETG5GKt0Wd1r2TEMsYOqLQ=;
        b=m2ETkRTfWFiv9VCohJSB1xmatlB+Ez9g4DtAtdHhozPctuHKwJ3be94lgVzfW9PRDo
         m+2iR76vgmc7HQR2rxupOmnMhS8fnUywFrSpfyEuDizIHRm2Fpd5yFsMPsBEKckQ0YPJ
         Tgn+7R+29KuGSEIgIz9yCfuttt1zsobJNBI9IZE3NS/yvVu4amRmdKtcy2wtE8LpnkZA
         jW1WcDEX0JxGLmqn/P+wuhGWwH3I+XVTC72orwdQwe2LH+Tz7++IOu64RVbUeYz4aOsd
         Mwo2fGHvSpcH9MY0VuqrnX6oEGDP1A2bh4yPErcrYU5N+ihABsU572gb8gaZzrr8qCVj
         2Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3i3kiFwzUPrJ6REiuthwmETG5GKt0Wd1r2TEMsYOqLQ=;
        b=Vn6s2YeUcqYnAqCdoB1ujom1TYiNX2B92RjIVkTiarWYga09IE8eeNSFh35tnYijiy
         DcLfMT0KCKrJg/SNOt1lVWl9rHmB44gbSK9aV9RhmYtF1VhYOySwnVaKw4qV5rQ077LF
         eVndHQdE/Iq9WCBZiV7dVuFx5ORxaDqz/AUXcber/mIJI8YqVuQIOaN305SwsVFEwfn1
         /wi9K63B30GluVA9CHb0X8SB9mxBckg0WnomOFLtHC/GyQQ9COCxReQc5U/GSH3lK0Rq
         p969hDGvp3WQj09GNwVEqxTABSMLSt10rKcWD+GcvV4iSeiNMho+Ziz9Z2x3xQm5erlS
         WRIg==
X-Gm-Message-State: AOAM533cfx2mLnw8Tb2M0/imrCVn1PLsBbsgCjne4DXJ7c/wkD2CkWzJ
        pJ7RD/5Ji1NKfb/Y6KpvbxfJJhkuJchzuw==
X-Google-Smtp-Source: ABdhPJz72M4ZCd3FSK8YDBJcCjPGIhdxYb/HBBj8SYmgfiKefsF2MutbtmZ2glSmPvgb1OS+9rmejQ==
X-Received: by 2002:adf:ec05:0:b0:1ef:5a9b:2906 with SMTP id x5-20020adfec05000000b001ef5a9b2906mr2757937wrn.624.1645780156155;
        Fri, 25 Feb 2022 01:09:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u14-20020adfed4e000000b001e3323611e5sm1711713wro.26.2022.02.25.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:09:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] http API: fix dangling pointer issue noted by GCC 12.0
Date:   Fri, 25 Feb 2022 10:09:11 +0100
Message-Id: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
References: <patch-1.1-1cec367e805-20220126T212921Z-avarab@gmail.com>
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

The GCC warning is specifically about pointers that survive the exit
of the function. See a comment added to
"pass_waccess::use_after_inval_p" in the GCC commit that added the
warning, or:

    /* The use is one of a dangling pointer if a clobber of the variable
      [the pointer points to] has not been found before the function exit
      point.  */
    [...]

There's a few possible ways to fix this, but the simplest is to assign
NULL to "slot->finished" at the end of run_active_slot(), it's the
only caller that ever assigns non-NULL to it. It was suggested[2] to
guard that with "if (slot->finished == &finished)", but that'll still
trigger the warning.

1. https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=9d6a0f388eb048f8d87f47af78f07b5ce513bfe6
2. https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A much simpler fix for a warning new in the GCC v12 pre-release.

Range-diff against v1:
1:  1cec367e805 ! 1:  777838267a5 http API: fix dangling pointer issue noted by GCC 12.0
    @@ Commit message
         built from gcc.git's 8bc700f4c3f (Enhance vec_pack_trunc for integral
         mode mask., 2022-01-17).
     
    -    To fix this I first simply made the member "int finished",
    -    i.e. removing the pointer indirection. It turns out that nothing cared
    -    about the state of it being a NULL pointer v.s. "*ptr == 0".
    +    The GCC warning is specifically about pointers that survive the exit
    +    of the function. See a comment added to
    +    "pass_waccess::use_after_inval_p" in the GCC commit that added the
    +    warning, or:
     
    -    But we can instead amend the code added in baa7b67d091 (HTTP slot
    -    reuse fixes, 2006-03-10) to get rid of "int *finished" entirely. I
    -    instrumented the code to add this after every use of slot->finished or
    -    slot->in_use:
    +        /* The use is one of a dangling pointer if a clobber of the variable
    +          [the pointer points to] has not been found before the function exit
    +          point.  */
    +        [...]
     
    -        if (slot->finished && slot->in_use == *slot->finished) BUG("in-use = %d and finished = %d disconnect", slot->in_use, *slot->finished);
    -        if (!slot->finished && !slot->in_use) BUG("have !in-use and no finished pointer");
    +    There's a few possible ways to fix this, but the simplest is to assign
    +    NULL to "slot->finished" at the end of run_active_slot(), it's the
    +    only caller that ever assigns non-NULL to it. It was suggested[2] to
    +    guard that with "if (slot->finished == &finished)", but that'll still
    +    trigger the warning.
     
    -    Which never fires, but we would get occurrences of:
    -
    -        if (!slot->finished && slot->in_use) BUG("have in-use and no finished pointer");
    -
    -    I.e. we can simply drop the field and rely on "slot->in_use" in cases
    -    where we used "finished" before. The two fields were mirror images of
    -    each other, and the tri-state nature of "finished" wasn't something we
    -    relied upon.
    +    1. https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=9d6a0f388eb048f8d87f47af78f07b5ce513bfe6
    +    2. https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## http-walker.c ##
    -@@ http-walker.c: static void process_alternates_response(void *callback_data)
    - 					 alt_req->url->buf);
    - 			active_requests++;
    - 			slot->in_use = 1;
    --			if (slot->finished != NULL)
    --				(*slot->finished) = 0;
    - 			if (!start_active_slot(slot)) {
    - 				cdata->got_alternates = -1;
    - 				slot->in_use = 0;
    --				if (slot->finished != NULL)
    --					(*slot->finished) = 1;
    - 			}
    - 			return;
    - 		}
    -
      ## http.c ##
    -@@ http.c: static void finish_active_slot(struct active_request_slot *slot)
    - 	closedown_active_slot(slot);
    - 	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
    - 
    --	if (slot->finished != NULL)
    --		(*slot->finished) = 1;
    --
    - 	/* Store slot results so they can be read after the slot is reused */
    - 	if (slot->results != NULL) {
    - 		slot->results->curl_result = slot->curl_result;
    -@@ http.c: struct active_request_slot *get_active_slot(void)
    - 	active_requests++;
    - 	slot->in_use = 1;
    - 	slot->results = NULL;
    --	slot->finished = NULL;
    - 	slot->callback_data = NULL;
    - 	slot->callback_func = NULL;
    - 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
     @@ http.c: void run_active_slot(struct active_request_slot *slot)
    - 	fd_set excfds;
    - 	int max_fd;
    - 	struct timeval select_timeout;
    --	int finished = 0;
    - 
    --	slot->finished = &finished;
    --	while (!finished) {
    -+	while (slot->in_use) {
    - 		step_active_slots();
    + 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
    + 		}
    + 	}
    ++	slot->finished = NULL;
    + }
      
    - 		if (slot->in_use) {
    -
    - ## http.h ##
    -@@ http.h: struct active_request_slot {
    - 	int in_use;
    - 	CURLcode curl_result;
    - 	long http_code;
    --	int *finished;
    - 	struct slot_results *results;
    - 	void *callback_data;
    - 	void (*callback_func)(void *data);
    + static void release_active_slot(struct active_request_slot *slot)

 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 229da4d1488..2f67fbb33cd 100644
--- a/http.c
+++ b/http.c
@@ -1367,6 +1367,7 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+	slot->finished = NULL;
 }
 
 static void release_active_slot(struct active_request_slot *slot)
-- 
2.35.1.1175.gf9e1b23ea35

