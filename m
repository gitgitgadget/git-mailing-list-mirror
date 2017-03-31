Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF791FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbdCaXRl (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:17:41 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33285 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdCaXRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:17:40 -0400
Received: by mail-pg0-f52.google.com with SMTP id x125so83706307pgb.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iq9RIWfuQL/z1zbNze2WDit4tEMzi2f4gBsEX+i7HnU=;
        b=P5f+wiyd05q4IIahR8ACPbzse2tS7eBp9hK//WUSS62Ap7Ge+OthxBF/jgjo8AJ+uo
         vQl4Bjj2WtnuFajgTjvZ2mccTHATRJIsnqYXYcK52gQJVtZV2lwxsCp/ACoD24tjW0W4
         XcOtgVnRWrrjGipSsCodN/EksTDZSNBuhYRX8qSqE4Sx5sX1N4OK5UBTS7l/pA5Axtl9
         ojhzFT8rgkEmEo/bkACTgRnAJHmvpzQQXXob6Qw+mWh/bXi0IIToAJJDlQFntsOHE0fL
         +mDUw5vw+0Yku8+xrwykHtXgfcIszfzthLsP4/Xit+y2NcuZk+ZmKqznGVeTHUPCkK67
         wW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iq9RIWfuQL/z1zbNze2WDit4tEMzi2f4gBsEX+i7HnU=;
        b=N2sdhQRqgCDFdOr1SETZ27GoBELnGqVROEOjhTM0qE45W2WrHSqBaEK1KXALbVSYWy
         IlM3QU4JRNYddcNdbNG4m+EgfANCeOi/JvgD5l03AYvUXigy7VGsPpEIWtjHBK2RrOCz
         eeKBAbmCDV6CqVVP30gk60wwy+yNaxc8GrbKIxqACFH3XZBwpNxQ+P1sXZO+VzVvyCuy
         6Tk9qMqTwPY05N/4+Lk/PYXYHo/4QobZ8Vw9mtC3JmHAlccP9ZlvaynS5BgH9P00eD6T
         R4fod+/VKFr9Ik9+L7KhiZv/BltO/iin0DZ/VjYOncX7X7eH4picy4SEQoxFMEogTvCv
         vF8w==
X-Gm-Message-State: AFeK/H3Ttiv+B1zdoc7SJ87vmMr7pkB5vlOWZojepcw3RK1w50vmRiNL9jFB4jZ0pusScTIE
X-Received: by 10.99.127.12 with SMTP id a12mr5303553pgd.5.1491002259902;
        Fri, 31 Mar 2017 16:17:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:240e:6326:bc58:48a9])
        by smtp.gmail.com with ESMTPSA id c1sm12413880pfk.112.2017.03.31.16.17.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:17:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org, daveparrish@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Re: git diff --submodule=diff fails with submodules in a submodule
Date:   Fri, 31 Mar 2017 16:17:31 -0700
Message-Id: <20170331231733.11123-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.576.g7be6e4ba40.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came up with a patch that fixes the issue locally.
(It is the first patch, such that we can track the first patch down to maint)

While doing so, I noticed 2 issues:
* when having nested submodules, we probably want to have --submodule=diff
  to recurse into the nested submodules, so pass on the option.
  (2nd patch)
* the tests in t4060 hardcode hashes literally. I do not have a patch for that
  yet, but I will send patches later. (c.f. "sanitize_output" in t4202)
  
Thanks,
Stefan

Stefan Beller (2):
  diff: submodule inline diff to initialize env array.
  diff: recurse into nested submodules for inline diff

 submodule.c                                  |  4 +-
 t/t4060-diff-submodule-option-diff-format.sh | 70 ++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

-- 
2.12.2.576.g7be6e4ba40.dirty

