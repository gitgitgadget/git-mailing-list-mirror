Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A39C4167B
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 18:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLISRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 13:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLISRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 13:17:09 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD54ABA29
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 10:17:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mg21-20020a17090b371500b00219767e0175so3651938pjb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FxmrDraTeGW7kXjcBcz8q+lGZR6XJMjlz9EjWf1NV/I=;
        b=TPD/+OF7uRyDyNCKumPgh36xGIqtZ06ZlS2Swfsr/4sHCXAHYr+/tNJq7y1DUwqN/H
         iFHJkDozrixGA9yAQfsDQ/iX1hpMsh2a1XR5+18GPPLX5hKA0pL5+OsHy58HWFfiHyjf
         u7LOYhvtHD0BH/cP/KsYTu5G6dyzfld1glj9wgIZzHqb5XxJ6H+quC5lesL3lJ7hO192
         VC3Gs/v5H3539ZDxQYyf7MtQ5wR90kzGjF5AfBTLQwIk0tDH9f74ITXcMQS1qmvg0sVn
         toE9Sn0byv77FNeqHyy+cH0VnVTAZhnqhhAWkmp3keZS96+lePZ+RlmIIIMUQvs1mSms
         +RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxmrDraTeGW7kXjcBcz8q+lGZR6XJMjlz9EjWf1NV/I=;
        b=dQT+utkOVj6JwWr5Sjfb3g78k1od+I44QnfQmilgEUgP4RMNcrVmVNCPAzlHztVZD/
         mu/MlISZf0beXn8siGSc1Uk2dyPbdc4hUAjVAZTrl+vnObJaoREp78rt8OKEcsjkVy/d
         vP1xiuy1IpCtOdjiA25QYnsPCaTSQg8+dyOHxV0EwIkEkyd+J0uA9KM5G0zFovyrBvET
         1JVNhFbej4hz9dhdtw6Gjh/8m7yjSd5u9m6mDQy9aQ5kR6zNyg7KzjSw3FF1U+zhgaq8
         qje6mpw9HdGzOhiraTPwUCgo5gGKjKEAVuxjjG4uXit7hsA6vISf30YAddNj8SL3QVV/
         RYYQ==
X-Gm-Message-State: ANoB5pltZZOe1Kv1+3WMyQXGyYnkD6xlSQHM7+5fevCX+ErnHupVZVDl
        ErVcJYUY3Q/DqHZIEc2aDGL4meHdHWNzfuPrL1i1
X-Google-Smtp-Source: AA0mqf5iLz/w+N/nWolk5evqv98dRuZCk2+fT7wuO9vJQxOoXWuhA5y61LUR161TE1d+T4PQcVco9Wp4zts/3mH6725Q
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:5fc1:0:b0:575:fddc:891e with
 SMTP id t184-20020a625fc1000000b00575fddc891emr36237506pfb.40.1670609827369;
 Fri, 09 Dec 2022 10:17:07 -0800 (PST)
Date:   Fri,  9 Dec 2022 10:17:04 -0800
In-Reply-To: <Y5KWpXwxdRI4QPNl@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221209181704.106534-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 2/4] object-file: refactor map_loose_object_1()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> If you take my suggestion on patch 3, then the only other caller of
> map_loose_object_1() goes away, and we can fold it all into one
> reasonably-named function:

Ah, that is true as of this patch, but patch 3 introduces another caller
of this function. I tried to allude to it in the commit message, but if
there is a clearer way to explain that, please let me know.
