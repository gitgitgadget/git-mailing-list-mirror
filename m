Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC65CC7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 07:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjFLHN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 03:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFLHNz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 03:13:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1765B19AA
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 00:08:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so43812441fa.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686553453; x=1689145453;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nm+egJM0dhciUksxSUn1yT30TRucXaQH/yvy6ceoRlY=;
        b=mEnkHkrYnLfjhZIDK7SWUvWfm40WMnuZINuJeTuxbF5i5oTNRFiaOC04b0L3zJoCOQ
         +SMmSoU4D+3D1zaqgq8sYOMmgtemIk8T2Xf+l/7kdsaSQfNfoNNehupUFV4rVe4wgU9Q
         VwrqiWrK3SEkH2FsTJOJVFrraOGPzKAhwI8Lac1II4Ax7RzRAzuwcNWZh+TUjfa4F2ox
         p2le8Lf2ZDimpj4vmmny9k/WqWvcMe8C07J+ww2rAE4I5iEyFeqyA12nbj63G5xqoAuc
         qXChhR63M8N/nd4ZHhUvTAgGli8kLn6SxQ/U/NY8++H0BujZC/6ikOcRLtBLuJGMNnQC
         sn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686553453; x=1689145453;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm+egJM0dhciUksxSUn1yT30TRucXaQH/yvy6ceoRlY=;
        b=Eb4DnsgEP+dDwxWu5EMBJ2xaYRchGBuae8VrwJZMfEraV3l+WXDRgXHxTQdA2teUcd
         Z+cYE0ESg0OpCsDYca1aq/vHacJNcOM6Xs2YV0pkEQlPjybO69OyY85T/mdo8gUDplcb
         TYHo0IwsTgO5Ssj1hMXqTBvRCd3d0FJ1c0VOPrH2ABAOYK5YpYHGo6Er1cjmJbJXYf1b
         xM4kiLYeGOBwjHB/Bsn3Drvr45Bb4ZzVN6qThLFRRlbqz2n2Y1uP7fx/7meMRputIdEl
         MsbZ6aBcUUFGrffvEbKgiJQIGVK/nD8dBfG5mxuez6/9w1IDH/HmzOHe79+UZot0vOl1
         zEgg==
X-Gm-Message-State: AC+VfDyeUCTHt5kjiREsWO9QX0VmhE+P9hDwvJYijRUktwVVvGvQJhTy
        OZoRodUiLN2+UMtN0Dyb9vjXwZCI2jXlCPya2iAQMV08idw=
X-Google-Smtp-Source: ACHHUZ6g5jv3XjUSgd1AzLZup5XaMbVxNwku+HCyC35g2Dvw2ZjqVZA7563IwaItJleK55p99+76iwgPH/io92j/cdU=
X-Received: by 2002:aa7:d58b:0:b0:514:938c:da74 with SMTP id
 r11-20020aa7d58b000000b00514938cda74mr4217523edq.19.1686552476319; Sun, 11
 Jun 2023 23:47:56 -0700 (PDT)
MIME-Version: 1.0
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Mon, 12 Jun 2023 07:47:19 +0100
Message-ID: <CAGJzqsnkH_dtv-CGsSFJ8K0kXKBf1+QQqy=MEw-Vq9XaEqr=AQ@mail.gmail.com>
Subject: Remembering which http remotes require authentication
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most http remotes require authentication to push. Private repositories
also require authentication to fetch.

If I understand correctly, http_request_reauth [1] first makes an
unauthenticated http request. If this fails with error 401
Unauthorized, then Git retries with authentication. This avoids
potentially expensive `credential fill` unless necessary. (`credential
fill` may be fast, slow or even require user input)

Could Git remember which remotes require authentication for which
operations? On high-latency networks such as 3G or satellite
connections [2], skipping a doomed unauthenticated request could
potentially halve the time taken for some commands.

A complication: if a repository changed from private to public, Git
would continue to authenticate when no longer necessary. A solution
could be to remember to skip the unauthenticated request for a limited
amount of time, or a maximum number of requests, before rechecking.

[1] https://github.com/git/git/blob/fe86abd7511a9a6862d5706c6fa1d9b57a63ba09/http.c#L2123-L2169
[2] https://hpbn.co/primer-on-latency-and-bandwidth/
