Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B66C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiBXXgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiBXXgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:36:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FE2804FF
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:36:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o5-20020a25d705000000b0062499d760easo1424070ybg.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=DmQ0jHyD9SQOnHZxFqvyX7YbErVm+qCMVvovQ0Joaic=;
        b=YJO7mlrfGajXYxiaf0kRLtqgxEgHqy+w9FUFbvigvcxw84enSB7XPnpViLNW+yF60+
         R3Qr7uslj89xkymQWqRoiA/ft4oQAhDT3wh4K+o0gRR3+l6yJLQXuQqZlh1tJPKTe5K1
         A2aLVuJ/B8XdqgBMoAubULj44qPbqNJKB/qrN+VQZETdUgQQYeL0mpLfA4xv6oD+QW1Q
         kteLB/c8YXKSPxX1WqmZw4s2WFDRee4ap5NVfrj2G1Lr7pnCL0upYYJCnqwYWKbcqK1J
         49f5UbwCP0BfFIRPX/CIsJ94YYxpb/78dC0VnnPPJ+9TJf+Stey1pp5PszzwqE8CB+Ix
         7KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=DmQ0jHyD9SQOnHZxFqvyX7YbErVm+qCMVvovQ0Joaic=;
        b=BapnYhm2A0lupksLzwM5XokrQW4M2fo427nb9pG4htltHwUF40ol4FWg+bRnnjZBrz
         xLrxiHoAWgHe0uGoaLwUp6TmJwmHT96/YRruleTnjL9sO0x7swLgvJFHS3i3EiExg2+M
         +9x0aocOwqU9wLs4247Moui9m1+fNG58YGR83nVoqEOFoNiGRkWfdBikholDvlvO0plJ
         YLosszv43ScsRgCerO/J5czAtHVZB8rYfpwQ/UT5LhwiFUYT/shEPxqT2uGLi6q5rjhR
         YE2vAQh5JtxfnHDchByiNelG4gE5dWJSfemsb4ASV/G7kopLElw7EpTex4v35xEuzM5V
         Lc5A==
X-Gm-Message-State: AOAM531J8x7f1dRePZ8B09xCPGM0FEjbT3Ns2y0T0ZljrRd8G2tigARj
        1IMlZCbYePSBjlg78f2BaJjCTlS7uUj2X/vVYklC
X-Google-Smtp-Source: ABdhPJz+F+1DA8XHhsFdIs4c7da6qrEeZqbeEFgeOaIIPXYs75aHjF+VEQXHurRnPiRNt4UOTxgTGmfagdZR7s9LfmOs
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:296:0:b0:623:a267:ab94 with SMTP
 id 144-20020a250296000000b00623a267ab94mr4843871ybc.430.1645745766938; Thu,
 24 Feb 2022 15:36:06 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:36:04 -0800
In-Reply-To: <20220224100842.95827-9-chooglen@google.com>
Message-Id: <20220224233604.2883270-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: Re: [PATCH v3 08/10] submodule: move logic into fetch_task_create()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> I think this patch could be squashed into the previous one, let me know
> if this is a good idea.

For what it's worth, as a reviewer, I appreciated this patch being its
own. It made it easier to review.

It's unfortunate that the created diff has fetch_task_create() deleted
and readded, but showing it with

  --anchored=" memset(task, 0, sizeof(*task));"

does make it easier to see. (The space before memset is a tab.)

> + cleanup:
> +	fetch_task_release(task);
> +	free(task);
> +	return NULL;
> +}

No space between the left margin and "cleanup".

Otherwise, up to and including this patch looks good.
