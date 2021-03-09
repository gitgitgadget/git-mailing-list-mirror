Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA61C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6665267
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCIKeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 05:34:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:56782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhCIKeW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 05:34:22 -0500
Received: (qmail 30059 invoked by uid 109); 9 Mar 2021 10:34:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Mar 2021 10:34:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9261 invoked by uid 111); 9 Mar 2021 10:34:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Mar 2021 05:34:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Mar 2021 05:34:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/7] oid_object_info(): return "enum object_type"
Message-ID: <YEdPLEgjzPT/jWxC@coredump.intra.peff.net>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308200426.21824-4-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:04:22PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Change oid_object_info() to return an "enum object_type", this is what
> it did anyway, except that it hardcoded -1 instead of an
> OBJ_BAD.

It does return -1 in the error case, and otherwise returns the "type"
field it got from the odb-specific fields. Which presumably is always
greater than 0, but...

> Let's instead have it return the "enum object_type", at which point
> callers will expect OBJ_BAD. This allows for refactoring code that
> e.g. expected any "< 0" value, but would only have to deal with
> OBJ_BAD (= -1).

Some of these conversions are not just "< 0", like:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index bad57488079..253cfb07fbd 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -236,8 +236,8 @@ static unsigned check_object(struct object *obj)
>  
>  	if (!(obj->flags & FLAG_CHECKED)) {
>  		unsigned long size;
> -		int type = oid_object_info(the_repository, &obj->oid, &size);
> -		if (type <= 0)
> +		enum object_type type = oid_object_info(the_repository, &obj->oid, &size);
> +		if (type == OBJ_BAD)

I kind of doubt that we could get OBJ_NONE here, but it seems like a
much riskier change than just "let's prefer OBJ_BAD to -1".

Did you trace through all of the paths that oid_object_info() can end up
in? (I did very briefly and I _think_ it's OK, but...).

-Peff
