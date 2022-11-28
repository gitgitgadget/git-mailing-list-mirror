Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D7AC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiK1NJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiK1NJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:09:48 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D7315FEC
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:09:48 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c15so1098824pfb.13
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG81lG4onpKX6NOFv8m3LwyC7QkwX+p0awFhLkwA8kc=;
        b=h8B7WS8rn64PryDj9Tzv3xbeQ2vt+IdWPRoyvuPYwPGIwfOfxmZQaOQg9o/N+dngiW
         azA5F2rYGsDMMUF64GqewgD2DnBJOISqEq7l5nkQT7MeENoJ5gmRlXpiqJ4aih9rmlSa
         tOOp8AmmJtw3IereItCEU7AYGKPUue+VuAF2oDyIts5gIght9m5f7c8YPPwo4eBvrF+F
         Afj81b6r4sLR+AxFk8ZBpJn/jchE699bitw1RWRdVt4vzWoKhTOn2qZb0Z/fZlN5Bbee
         D8EI3gQA4aVx63xJ1uZSakHz7ifb7kFp/o5/f/Iig/M05cRJcg/3msSsg5UkWuMPDsOj
         pm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG81lG4onpKX6NOFv8m3LwyC7QkwX+p0awFhLkwA8kc=;
        b=jrmtbPEoSAt2m1dfkatQUc59IH7ahg7Yj4jAzEwXHT8efjEodwg9yzdjYBHNP1itiZ
         pvnfx8U0Q7z2tbdEXu7qx9m4HTAgs0SO8APXBrNJKv+YvcBuT+FIHy0y76G+1MmVwzgM
         8KMOULolH6so7ROR3hi+lRSEBuH0RR8yGC+/83mdKbki7jnwkB4fLmYiyRrByfs7Yqk4
         r30S4OM6HDS8JmX6o0BN5fh1UNBuVd4T6uRb6cAzG3mk6tdTvJpcrOjSi95FLE5g7Hdp
         DTA+YVYDq0V0I0DemBUPSiiqSr3FlB3y6/k0I93hzPemATZrbk8JGWgO5MG9cf03vDJk
         fNwg==
X-Gm-Message-State: ANoB5pnUqAS5oVpQLcibFedSM0GvKE31Lmw144sdv18meoZCJjUvVLfd
        9MTqvXWwPAKZE/69JNBEsa4=
X-Google-Smtp-Source: AA0mqf6G000kIzEVE5u9Kn66C6/KM+IIHu8X3DI1FypVG3U7EHNrYbxXG8D8oF2WPOypjqJMm9gKng==
X-Received: by 2002:a05:6a00:a96:b0:554:4162:1ec1 with SMTP id b22-20020a056a000a9600b0055441621ec1mr32858784pfl.64.1669640987522;
        Mon, 28 Nov 2022 05:09:47 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b0018544ad1e8esm8798589plk.238.2022.11.28.05.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:09:46 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 3/4] pack-bitmap.c: break out of the bitmap loop early if not tracing
Date:   Mon, 28 Nov 2022 21:09:40 +0800
Message-Id: <20221128130940.56464-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.473.ga0789512c5a.dirty
In-Reply-To: <xmqqfsebvqg8.fsf@gitster.g>
References: <xmqqfsebvqg8.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Jeff King <peff@peff.net>
>
> When we successfully open a bitmap, we will continue to try to open
> other packs, and when trace2 is enabled, we will report any subsequent
> bitmap ignored information in the log. So when we find that trace2 is
> not enabled, we can actually terminate the loop early.

> The above took me a few reads to understand what it wants to say,
> probably because the "and when trace2 is enabled" comes a bit too
> late to explain why "try to open other" is done.  After reading it a
> few times, here is what I think it wants to say:
>
>     After opening a bitmap successfully, we try opening others only
>     because we want to report that other bitmap files are ignored in
>     the trace2 log.  When trace2 is not enabled, we do not have to
>     do any of that.

Thanks for the reword, will apply in reroll.
