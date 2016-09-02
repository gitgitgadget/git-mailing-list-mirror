Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65F11FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 19:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbcIBTkT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:40:19 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35287 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932555AbcIBTkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:40:18 -0400
Received: by mail-vk0-f52.google.com with SMTP id j189so22373004vkc.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oT7UAuIV0o2qT7Z/D4PW5YGANTXfiPcKCAEiMC923pY=;
        b=JcRG2KdDmwmYrArnETmhylNYEbdsNHFypbWloyWrxLgYrZvovrMbgC4qnZ/5pvpVpS
         geh3F/751Uzcui0w2nJtAxs4532Wc8EVUSmUyLuTcv+RE4p/53oVEpZ3F9S+FG0xnp70
         6MmyVrkKpEY+3A2tvGphgvSv/ueX1fZqL6XnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oT7UAuIV0o2qT7Z/D4PW5YGANTXfiPcKCAEiMC923pY=;
        b=LdhuK0RA83vfeJFVvJ4EHD0i7MbYt2Xhc3yBdkDioNlghIrYtF3eQqDaS/rnmKreTk
         y7OVP1DauFAhEvg7NfypUfov2DCe748ZpLQYhiBWWc8RpSTrgnj7PeGZRp770ZsxgM67
         Xn8It7ypFDnfpKLwAqJ3rGa5NGnRn3NzNgbcyDa2ugZP4KdtmX67MIIe8dxZk1K6xyjy
         5zBXIP3vWgwvo4BULwVIC9fFwmqhSMpHnXx9Kk31mRAMWlTF3Y4enKXGm2yRof6NfaRA
         5BnLrakRlh+nAAiwu9Bqqc0Jvr7Mz+tLry/pN5jQSw+QR98hl2gPHyD26ig7ZVqbH2Jd
         YMvQ==
X-Gm-Message-State: AE9vXwN9D3WY86dNm0JICCNSoddlJ0QdedoIX2WrKbT6ICsy/ud2mhCijW1LkJ4dBuacUZooN+Bq3pF1VS9Z1Q==
X-Received: by 10.31.13.197 with SMTP id 188mr15022164vkn.87.1472845217555;
 Fri, 02 Sep 2016 12:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.133.210 with HTTP; Fri, 2 Sep 2016 12:39:56 -0700 (PDT)
In-Reply-To: <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Fri, 2 Sep 2016 12:39:56 -0700
Message-ID: <CAJo=hJssMohNq5zDU=wdb1gP4nW59m8pUmxP7eY4jnjr502z0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 10:15 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> +               if (is_null_oid(&old_oid)) {
> +                       if (strcmp(name, "capabilities^{}"))

Its not the zero ID that is special, its the "capabilities^{}" name
that is special when its the first entry in the stream. In the wire
protocol a "x^{}" line is a modifier to a prior "x" line to add a
peeled object to the prior line. But if we see "^{}" on the first line
that is non-sense, there is no prior line to modify with this
identifier.

Further ^{} is used here because its invalid in a name. A server
really cannot have a reference that ends with the sequence ^{}. And a
server should not have a reference named "capabilities" without a
"refs/" prefix on it.

So the entire "capabilities^{}" on the first line is a bunch of
contradictions that violate a number of things about the protocol,
which is why clients should ignore it.

I think the test should be about:

  !*list && !strcmp(name, "capabilities^{}")

> +                               warning("zero object ID received that is not accompanied by a "
> +                                       "capability declaration, ignoring and continuing anyway");

Annoyingly a zero object ID is sort of possible; with a probability of
1/2^160 or something. Its just a very very unlikely value. Slightly
stronger to test against the known invalid name.
