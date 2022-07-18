Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72869C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiGROvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiGROvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 10:51:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A7275D0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 07:51:05 -0700 (PDT)
Received: (qmail 32184 invoked by uid 109); 18 Jul 2022 14:51:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Jul 2022 14:51:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9826 invoked by uid 111); 18 Jul 2022 14:51:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Jul 2022 10:51:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Jul 2022 10:51:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] log: make the intent of cmd_show()'s "rev.pending"
 juggling clearer
Message-ID: <YtVzWMKRezUYuhkn@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-3.6-7f3bf3f0e40-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.6-7f3bf3f0e40-20220713T130511Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 03:10:32PM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/builtin/log.c b/builtin/log.c
> index 88a5e98875a..e0f40798d45 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -668,10 +668,12 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
>  int cmd_show(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info rev;
> -	struct object_array_entry *objects;
> +	struct object_array blank = OBJECT_ARRAY_INIT;
> +	struct object_array cp = OBJECT_ARRAY_INIT;

I'm not sure what "cp" stands for. Maybe just "pending" would be a more
descriptive name?

> @@ -698,12 +700,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  	if (!rev.no_walk)
>  		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
>  
> -	count = rev.pending.nr;
> -	objects = rev.pending.objects;
> +	memcpy(&cp, &rev.pending, sizeof(rev.pending));

OK, so now "cp" is a copy of the original "rev.pending". But that
original is still in place. If I understand the intent of this code
correctly, we'd never want to look at it again. The only place that
should do so is the call to cmd_log_walk_no_free():

>  		case OBJ_COMMIT:
> -			rev.pending.nr = rev.pending.alloc = 0;
> -			rev.pending.objects = NULL;
> +			memcpy(&rev.pending, &blank, sizeof(rev.pending));
>  			add_object_array(o, name, &rev.pending);
>  			ret = cmd_log_walk_no_free(&rev);
>  			break;

but both before and after your patch, we clear rev.pending before doing
so.

So perhaps it would make the intent more clear if we fully transferred
ownership out of the rev struct? I.e., something like:

  memcpy(&cp, &rev.pending, sizeof(rev.pending));
  memcpy(&rev.pending, &blank, sizeof(rev.pending));
  for (i = 0; i < cp.nr; i++) {
     ...stuff...
  }
  object_array_clear(&cp);

> @@ -726,7 +727,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  			if (!o)
>  				ret = error(_("could not read object %s"),
>  					    oid_to_hex(oid));
> -			objects[i].item = o;
> +			cp.objects[i].item = o;
>  			i--;
>  			break;
>  		}

Wow, this "overwrite the current item and back up one" strategy is truly
horrific. But it's neither here nor there for your series; you don't
make it any worse, and because "item" is not a free-able pointer, you
don't need to worry about it for leaking.

I suspect the cleaner way of doing it would be to push all of this
switch logic into a function, and then call the function recursively
when dereferencing a tag. But let's put that aside so as not to distract
from your goal.

-Peff
