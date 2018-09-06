Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B246F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 14:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbeIFTdF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:33:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:41134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729355AbeIFTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:33:05 -0400
Received: (qmail 10759 invoked by uid 109); 6 Sep 2018 14:57:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 14:57:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30505 invoked by uid 111); 6 Sep 2018 14:57:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 10:57:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 10:57:09 -0400
Date:   Thu, 6 Sep 2018 10:57:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
Message-ID: <20180906145708.GA1209@sigill.intra.peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180906101658.1865-1-timschumi@gmx.de>
 <87pnxqrags.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnxqrags.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 04:01:39PM +0200, Ævar Arnfjörð Bjarmason wrote:

> If we don't have some test for these sort of aliasing loops that fails
> now, we really should add that in a 1/2 and fix it in this patch in 2/2.

Yes, I'd agree that this is worth adding a test (especially if the
output routines get more complex).

> That makes sense from an implementaion perspective, i.e. we lookup "bar"
> twice. But let's do better. If I have aliase like:
> 
>     a = b
>     b = c
>     c = d
>     d = e
>     e = c
> 
> It should be telling me that my "e" expansion looped back to the "c = d"
> expansion. Here's a patch to implement that, feel free to either squash
> it in with my Signed-Off-By, or tacked onto a v4 version of this,
> whichever you think makes sense:

I don't have a strong opinion on whether this is worth it, but I think
your implementation could be a little simpler:

> diff --git a/git.c b/git.c
> index 64f5fbd572..38f1033e52 100644
> --- a/git.c
> +++ b/git.c
> @@ -692,8 +692,64 @@ static int run_argv(int *argcp, const char ***argv)
>  		/* .. then try the external ones */
>  		execv_dashed_external(*argv);
> 
> -		if (string_list_has_string(&cmd_list, *argv[0]))
> -			die(_("loop alias: %s is called twice"), *argv[0]);
> +		if (string_list_has_string(&cmd_list, *argv[0])) {
> +			struct strbuf sb = STRBUF_INIT;
> +			int i, seen_at_idx = -1;
> +
> +			/*
> +			 * Find the re-entry point for the alias
> +			 * loop. TODO: There really should be a
> +			 * "return the index of the first matching"
> +			 * helper in string-list.c.
> +			 */
> +			for (i = 0; i < cmd_list.nr; i++) {
> +				if (!strcmp(*argv[0], cmd_list.items[i].string))
> +					seen_at_idx = i;
> +			}
> +			assert(seen_at_idx != -1);

The string-list code doesn't generally deal in indices. You can use
string_list_find_insert_index(), but its return value is a little funky
for the existing case. You can also just do:

  struct string_list_item *seen;
  ...
  seen = string_list_lookup(&cmd_list, *argv[0]);
  if (seen) {
	/* we have a loop */
	int idx = seen - cmd_list.items;

That's a little intimate with the string-list implementation as an array
of string_list, but it's already pretty standard to walk over and
dereference that list (including in your patch). But also see below.

Side note: there's actually a bigger problem with the original patch:
the string list is unsorted (because it uses string_list_append(), and
which is why your linear walk works here). But string_list_has_string()
assumes it is sorted.  So I think we'd actually want to use
unsorted_string_list_has_string() or unsorted_string_list_lookup().

> +			for (i = 1; i < cmd_list.nr; i++) {
> +				if (i - 1 == seen_at_idx)
> +					/*
> +					 * TRANSLATORS: This is a the
> +					 * re-enttry point in the list
> +					 * printed out by the "alias
> +					 * loop" message below.
> +					 */
> +					strbuf_addf(&sb, _("    %d. %s = %s <== The re-entry point in the loop\n"),
> +						    i,
> +						    cmd_list.items[i - 1].string,
> +						    cmd_list.items[i].string);

This is always going to show the right-hand of the equals as the
left-hand on the next line. Would it be simpler to just show the list?
Likewise, the last item in the list is always going to be "where the
loop started". Do we need to say that?

E.g., something like:

  seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
  if (seen) {
          for (i = 0; i < cmd_list.nr; i++) {
		struct string_list *item = cmd_list.items[i];

		strbuf_addf(&sb, "  %s", item->string);
		if (item == seen)
			strbuf_add(&sb, " <==");
		strbuf_addch(&sb, '\n');
	  }
	  /* We never added this to the list, but we were about to */
	  strbuf_addch("  %s\n", seen->string);
	  die(...);
  }

I guess it's not that far off of yours. Not using words to describe the
loop entry and exit points avoids translation, which avoids notes to
translators, which is most of what makes your patch long. ;)

-Peff
