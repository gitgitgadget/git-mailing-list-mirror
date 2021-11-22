Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FAC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhKVSuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:50:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:36568 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240431AbhKVSum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:50:42 -0500
Received: (qmail 22018 invoked by uid 109); 22 Nov 2021 18:47:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 18:47:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23613 invoked by uid 111); 22 Nov 2021 18:47:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 13:47:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 13:47:34 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 5/5] run-command API: remove "argv" member, always use
 "args"
Message-ID: <YZvlxn8EdL1V4Cg6@coredump.intra.peff.net>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-5.5-ea1011f7473-20211122T153605Z-avarab@gmail.com>
 <YZvUN0kuTpmf9Q7P@coredump.intra.peff.net>
 <211122.86wnl0xd24.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211122.86wnl0xd24.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 07:19:14PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I did have this with a strvec_attach() locally, but figured I'd get
> comments about growing scope & with just one caller.

I do think I'd rather see us avoiding have to do this attach() by
refactoring the Windows code. But I sympathize with your pain in the
guess-and-wait-for-CI loop with Windows (I have an unrelated series I've
done that with, and it's rather awful).

> This version seems to be duplicating things in the existing API though,
> I just had the below, which I think works just as well without the
> duplication. Perhaps you missed strvec_push_nodup()?
> 
> diff --git a/strvec.c b/strvec.c
> index 61a76ce6cb9..c10008d792f 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -106,3 +106,9 @@ const char **strvec_detach(struct strvec *array)
>                 return ret;
>         }
>  }
> +
> +void strvec_attach(struct strvec *array, const char **items)
> +{
> +       for (; *items; items++)
> +               strvec_push_nodup(array, *items);
> +}

This isn't taking ownership of "items", though. We've attached the
things it points to, but not the array itself. It would perhaps be OK to
free() it here under the notion that we took ownership of it and it is
ours to do with as we please. Potentially a caller might expect that
we'd continue to use the attached buffer, but any such assumption is
invalid once another strvec_push() is called, since that could replace
the array anyway.

It's also slightly less efficient (it grows a new array unnecessarily),
but I doubt that matters much in practice.

-Peff
