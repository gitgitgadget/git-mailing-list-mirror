Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A7C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2AC6101E
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 17:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhDIRxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:53:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:46510 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDIRxm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 13:53:42 -0400
Received: (qmail 511 invoked by uid 109); 9 Apr 2021 17:53:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 17:53:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14392 invoked by uid 111); 9 Apr 2021 17:53:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 13:53:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 13:53:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] object.c: initialize automatic variable in
 lookup_object()
Message-ID: <YHCUmM7CqJ83ZXrL@coredump.intra.peff.net>
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <patch-2.3-f1fcc31717-20210409T080534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-f1fcc31717-20210409T080534Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 10:07:28AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Initialize a "struct object obj*" variable to NULL explicitly and
> return it instead of leaving it uninitialized until the "while"
> loop.
> 
> There was no bug here, it's just less confusing when debugging if the
> "obj" is either NULL or a valid object, not some random invalid
> pointer.
>
> [...]
>
>  struct object *lookup_object(struct repository *r, const struct object_id *oid)
>  {
>  	unsigned int i, first;
> -	struct object *obj;
> +	struct object *obj = NULL;
>  
>  	if (!r->parsed_objects->obj_hash)
> -		return NULL;
> +		return obj;

I actually prefer the original style (where any "can we bail early"
checks just explicitly return NULL, rather than making you check to see
that obj is NULL). But it's pretty subjective, and I don't feel
strongly.

>  	first = i = hash_obj(oid, r->parsed_objects->obj_hash_size);
>  	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {

The important thing is that "obj" is not used uninitialized, which it
isn't (before or after).

-Peff
