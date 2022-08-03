Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A1C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 17:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiHCR3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiHCR3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 13:29:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FED1F638
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 10:29:16 -0700 (PDT)
Received: (qmail 8323 invoked by uid 109); 3 Aug 2022 17:29:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Aug 2022 17:29:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13210 invoked by uid 111); 3 Aug 2022 17:29:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Aug 2022 13:29:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Aug 2022 13:29:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/6] log: fix a memory leak in "git show <revision>..."
Message-ID: <Yuqwa6NSG0Ee+7ev@coredump.intra.peff.net>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
 <patch-v3-3.6-83fc1835fe5-20220802T152925Z-avarab@gmail.com>
 <YuqwCEqL4xZkxjL8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuqwCEqL4xZkxjL8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 03, 2022 at 01:27:36PM -0400, Jeff King wrote:

> > diff --git a/builtin/log.c b/builtin/log.c
> > index 88a5e98875a..b4b1d974617 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -743,11 +743,17 @@ int cmd_show(int argc, const char **argv, const char *prefix)
> >  			rev.shown_one = 1;
> >  			break;
> >  		case OBJ_COMMIT:
> > +		{
> > +			struct object_array old;
> > +
> > +			memcpy(&old, &rev.pending, sizeof(old));
> >  			rev.pending.nr = rev.pending.alloc = 0;
> >  			rev.pending.objects = NULL;
> >  			add_object_array(o, name, &rev.pending);
> >  			ret = cmd_log_walk_no_free(&rev);
> > +			memcpy(&rev.pending, &old, sizeof(rev.pending));
> >  			break;
> > +		}
> 
> Here we overwrite the one-item rev.pending without freeing it, but just
> immediately after instead of before. It's a little subtle, but your
> comment in the commit message:
> 
>   [...] and only free the new "rev.pending" in the "OBJ_COMMIT" case arm
>   as prepare_revision_walk() would draw it down.
> 
> covers that. IMHO that could be spelled out a bit more (particularly
> that this only works for OBJ_COMMIT, but that's OK because that's the
> only type we're adding), but I can live with it.

Ah, I see that you did add a comment in the next commit. That's
sufficient, though I really think it makes more sense here, where we're
actually dealing with leaks.

-Peff
