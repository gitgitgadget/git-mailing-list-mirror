Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CAF20756
	for <e@80x24.org>; Tue, 17 Jan 2017 17:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbdAQRnK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 12:43:10 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35005 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdAQRnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 12:43:08 -0500
Received: by mail-qt0-f193.google.com with SMTP id f4so23152155qte.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UQ20SJe1XfHS7+Sf3h45DGqKeLu63vngLb5wJ2GcayY=;
        b=XmzU6c+8C7Zu5HeOMl0NQR7zoOvT8OJvZNzDxUQF7UQvxrOzy63BtWXaUelJ7DMMsF
         Rex0AJH4NCdxhffs72HMN6Gt5EonviHXZOhkDcmbpdufHTpDSzeEV6toalSwGw+RRoQA
         ipWQy41++fWyVSNPbJOV5XDF9+vwK7GBU/17ZOP6fT8gBSOL+XZlN+2kEb7FQJh9ftYw
         P74JfhrP1RDAU4St+WKvXlGFC+Z9L9oLVFNpHKmVrLZUPFxehTX0gtiHTb86NgCUnO3x
         2Ky8mGHq3jrkCZzFfT0+to13KDjq626TjOm4Y+gwT8SJPRfaeFL1OiAVGF4zVtms6IgV
         GA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQ20SJe1XfHS7+Sf3h45DGqKeLu63vngLb5wJ2GcayY=;
        b=ZoD6EYh0xDaViRNqZCPanGV8no2mzynzu03EMUkJm1ZbDebKxsIAZMgkcHbapeaL26
         uH3tKwG2iqGzJDHBU2ZrUgKCu9npjqQ/pAjvrgeHbxLqygKdEex0/ywPh4bD3GXY9zKn
         ojFnWEjmfRjvveyGVjylMxZdkpr0DnxiCo7C9MKigJ5A1Y9iAD5ICf2/GXKnP87TZ//K
         leN8LOK1/6uxaR+lr3LeRvlkrk/Vj4MyWot9n6TvhrgxbV5MxyxzO6oCg13l2xZD0XLx
         8El+BUXnBHPL6TmgVDtNhOKsrO5PsLD8tzfKyejmaxx8IVF01bnuiQuserzEck9U0PTu
         mAtw==
X-Gm-Message-State: AIkVDXKorkBogjw40ygvO7nIg+2dCDfdAHYbCx1Pe8iHQAxj/PWlhx+jzECaXUPPYMXkAYnL
X-Received: by 10.200.53.150 with SMTP id k22mr37666235qtb.19.1484674468385;
        Tue, 17 Jan 2017 09:34:28 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c41sm19290086qtd.3.2017.01.17.09.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 09:34:28 -0800 (PST)
Date:   Tue, 17 Jan 2017 12:34:27 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 5/7] builtin/tag: add --format argument for tag -v
Message-ID: <20170117173427.sq3kpo4jls6setkf@LykOS.localdomain>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-6-santiago@nyu.edu>
 <20170117153404.jp3ftdlzeyut6e7a@sigill.intra.peff.net>
 <20170117170018.nqk4yy5rrpomxr32@LykOS.localdomain>
 <20170117173239.ir6jxbz46vwwzoht@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4j2izw3neumihhta"
Content-Disposition: inline
In-Reply-To: <20170117173239.ir6jxbz46vwwzoht@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


