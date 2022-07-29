Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B435AC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiG2Szk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiG2Szh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:55:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991B50049
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:55:36 -0700 (PDT)
Received: (qmail 22088 invoked by uid 109); 29 Jul 2022 18:55:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 18:55:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27758 invoked by uid 111); 29 Jul 2022 18:55:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 14:55:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 14:55:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] log: fix common "rev.pending" memory leak in "git
 show"
Message-ID: <YuQtJ2DxNKX/y70N@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <patch-v2-4.6-54b632c1124-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-4.6-54b632c1124-20220729T082919Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 10:31:06AM +0200, Ævar Arnfjörð Bjarmason wrote:

> @@ -701,6 +701,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
>  
>  	memcpy(&pending, &rev.pending, sizeof(rev.pending));
> +	memcpy(&rev.pending, &blank, sizeof(rev.pending));
>  	rev.diffopt.no_free = 1;
>  	for (i = 0; i < pending.nr && !ret; i++) {
>  		struct object *o = pending.objects[i].item;

OK, so now "pending" is completely separate from what's in "rev". And
then in the later hunk we clear it:

> @@ -752,6 +752,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  			ret = error(_("unknown type: %d"), o->type);
>  		}
>  	}
> +	object_array_clear(&pending);

Good. But in the middle hunk...

> @@ -744,7 +745,6 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  			rev.shown_one = 1;
>  			break;
>  		case OBJ_COMMIT:
> -			memcpy(&rev.pending, &blank, sizeof(rev.pending));
>  			add_object_array(o, name, &rev.pending);
>  			ret = cmd_log_walk_no_free(&rev);
>  			break;

We now do not do anything to clean up rev.pending. On the first pass,
we'd see our blank pending array and add to it. But on a subsequent pass
(i.e., because we are showing two or more commits), what will we see?

My initial assumption was we'd have the last pass's commit in "pending"
here, so we'd be leaking it. But I think in practice it's OK. We end up
in prepare_revision_walk(), which blanks the list again, and then
processes each element. Non-commits _do_ end up back in the pending
list, which would be a leak. But we know that this code triggers only
for commits, which are placed only in the "commits" list (and that's
cleaned up as we walk it via get_revision()).

That might be worth mentioning in the commit message, or even including
a comment like:

  /*
   * No need to clean up rev.pending here; commits are removed from it
   * as part of prepare_revision_walk().
   */

-Peff
