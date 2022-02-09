Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F26C433FE
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 19:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiBIT3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:29:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiBIT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 14:28:06 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A17E017B92
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 11:26:47 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e11so1653138ils.3
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tHeZfP8dv+XSYTwVHwUjK/iSNG63lea/czlk5NuLdyI=;
        b=ddwsatiCJETT3bISOXEMwvKcZALuvoHaURmM21S+GU/h4kp0uBuhS7i9/YCJ5vU2l9
         OAfOoiCc/f91i9IkybBELezd1lB7Bqp847EymmWi7aDRSa1aSn0purctLZMOj2UHzHuP
         4AZKLklsfSwpeyTohpKZZgCMQfbs8US6rwaPOHKgW6zwxX1f9L1lP7+SwvpCj/4hBV3L
         7Tk3H/V9DUNcX0bdGcOCHM0K57WFQGUORfvgPRum33+YCVLjK+1WPXX82rbvKmwgw0NW
         DrHZ1mHuV05bLy7Om2r11EoB5bKpp2tno4t30q/WfQD7METDqIgCtd7ck97RYfmU07WB
         esyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tHeZfP8dv+XSYTwVHwUjK/iSNG63lea/czlk5NuLdyI=;
        b=gUDkzywDCLQXgZTvTRxb7y1QuIQL9ntxP0ju1ZCcqLrflH57YounnsDv8pmZrUNv7b
         8z8JrJa8EsyVXXUtnlC37dCF7f1A4sqfLeObOlKJsad9yjWTWI7dBHmpl+XOdvZD/QRE
         /zE3p2bGPbpu5pIc6CXu64q2fd8JzcvC8NfXjXrYhs6ce/k5LP19TYrE32XvHf4iTQqv
         nEcu+k00Ts+v4v1CwiryzpLHf9XVPUBy7HaAHR2skN8t7fZlsGrP72ylZJoxf/FJOqcI
         y2tIY7HhJK1p4ZO/BmOzRiQ81hHjvev3HcqzOOCNsp0OBhjwLXnqgosKupYnv4Mtwgg1
         xXCQ==
X-Gm-Message-State: AOAM532wpmbc6XQnGlzaGjHHmYpfCXCjsMFAe214l/h5jaRQVc8ADyGo
        I67ZTJx7JI84WhP7ityDsKqQp0wRMHBRJg==
X-Google-Smtp-Source: ABdhPJxZZiT3m7R3p+yAj5vvuYCCm73vDdGkao92OKn7vDDV6cQqWm1124bNIDWhXRrW/9mkVEJagw==
X-Received: by 2002:a92:bd09:: with SMTP id c9mr1941998ile.232.1644434806313;
        Wed, 09 Feb 2022 11:26:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d12sm9516640ilv.42.2022.02.09.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:26:45 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:26:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH 0/1] midx: prevent writing a bitmap with zero objects
Message-ID: <cover.1644434802.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small patch I wrote after getting an alert that we tried to call
pack_pos_to_midx(..., 0) on a MIDX that contained zero objects.

The patch causes us to no longer write a bitmap for such a MIDX. More detailed
notes are within, and this is based on tb/midx-bitmap-corruption-fix. (The only
reason is that both this topic and that one add a new test to t5326, so merging
this one after that avoids a textual conflict).

Thanks in advance for your review.

Taylor Blau (1):
  midx: prevent writing a .bitmap without any objects

 midx.c                        |  9 +++++++++
 t/t5326-multi-pack-bitmaps.sh | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.35.1.73.gccc5557600
