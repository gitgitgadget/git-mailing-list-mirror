Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B8C20951
	for <e@80x24.org>; Tue, 14 Mar 2017 23:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbdCNXI6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:08:58 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35804 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdCNXI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 19:08:58 -0400
Received: by mail-it0-f47.google.com with SMTP id m27so56630968iti.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZkcKwCptwoEyX9HW37LUgIpRdazpqiy+b/b3rtyVzSc=;
        b=ZCddew33R1JiBLklZo4HOB6qmyDdFpJmL7zg46wxJsbNiI27jP1f8ogmPcKB7cjfpf
         JKWmqINIIlNhRWvnrLTG2drPzqjXLCS1VU4hCnQDKnNH7jfVqnPblR3FCDwEsWWnUEYz
         lQzPaYYkS0KqMzTdYzyf7Cn6tMBYLqRL5cSMRikSCUfTm6PwsACoRnjrRQyhYfuv3Rdc
         QsPDJCGWOkTtDBglF8IQHt3X9+wPoNNGTNnGg/RJGPqBCBNMWVT9vL/L1oIxCHoaNM6y
         FKviv4mXDR5g6sl9fYrHnAWFcFyVDsRLfFOcUn4vZ648g1Jcsm0pmN3Nw21ZcRAbsXzg
         iZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZkcKwCptwoEyX9HW37LUgIpRdazpqiy+b/b3rtyVzSc=;
        b=dBnbmOW61y0X/Zd2zC7pfY2D4BWdtc37JBLK65xv0st65tAr7nhsjbHkDbEYKUfYR2
         rle3HTAmr7dCIzbXeeYVBKjdLqJZ5cetLXM1xMKh1zWF5zEMnzhD5yNLgFF6oy/OEPPN
         n7ddDgOv0XNO6jcvbHMeuMr9foLBr/aKXw/hNdgc6sqYYp4W0AdSgLzJZQjuvkLy6DcY
         44vKJnm9sdIa7HCJijvzsBQifmoyW/1wHsD+uMFOCKh5i8zBkGgAvJWC3hbrM2aUI/Je
         0OxzpQVhD2gDF4AwOSfcoV9MGq6eT4udGi+9BCk5avUVdFVCYHLdLRvPxK73sBZ1MXNm
         McLw==
X-Gm-Message-State: AFeK/H0g8R0LyYr/BuwJCHI5BwTPvP2ZPYDq828woJQf6a5MKOJo8lB5Scdqi70v4k+RbgnkepEHv9KK7suNhQ==
X-Received: by 10.36.95.85 with SMTP id r82mr2336749itb.91.1489532936478; Tue,
 14 Mar 2017 16:08:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 14 Mar 2017 16:08:35 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 15 Mar 2017 00:08:35 +0100
Message-ID: <CACBZZX7Um==4pWfUVcLM8Kbk-ry8HQAmDoUVGjVPmhY3ZXUNYg@mail.gmail.com>
Subject: BUG: "git revert -m 0 <commit>" considered to be "git revert <commit>"
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both of these emit the "is a merge but no -m option was given" when
<commit> is a merge.

I tried to track this down for a bit in the options parsing code but
couldn't see where it was happening, but at some point we're setting
opts->mainline to 0 both when it's not provided, and when it's
explicitly provided as 0.

Instead we should e.g. pass "no option" through as NULL to the
sequencer, and emit some better error about how -m isn't zero-indexed.
