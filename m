Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D871F453
	for <e@80x24.org>; Wed, 17 Oct 2018 09:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeJQRHD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 13:07:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:43226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726922AbeJQRHD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 13:07:03 -0400
Received: (qmail 17796 invoked by uid 109); 17 Oct 2018 09:12:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 09:12:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18696 invoked by uid 111); 17 Oct 2018 09:11:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 05:11:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 05:12:15 -0400
Date:   Wed, 17 Oct 2018 05:12:15 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     git@vger.kernel.org, rpeterso@redhat.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] revision: Add --sticky-default option
Message-ID: <20181017091215.GA2052@sigill.intra.peff.net>
References: <20181016212438.30176-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016212438.30176-1-agruenba@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 11:24:38PM +0200, Andreas Gruenbacher wrote:

> here's a long-overdue update of my proposal from August 29:
> 
>   [RFC] revision: Don't let ^<rev> cancel out the default <rev>
> 
> Does this look more acceptable that my first shot?

I think it's going in the right direction.

The name "--sticky-default" did not immediately make clear to me what it
does. Is there some name that would be more obvious?

> Some commands like 'log' default to HEAD if no other revisions are
> specified on the command line or otherwise.  Currently, excludes
> (^<rev>) cancel out that default, so when a command only excludes
> revisions (e.g., 'git log ^origin/master'), it will produce no output.
> 
> With the --sticky-default option, the default becomes more "sticky" and
> is no longer canceled out by excludes.
> 
> This is useful in wrappers that exclude certain revisions: for example,
> a simple alias l='git log --sticky-default ^origin/master' will show the
> revisions between origin/master and HEAD when invoked without arguments,
> and 'l foo' will show the revisions between origin/master and foo.

Your explanation makes sense.

> ---
>  revision.c     | 31 +++++++++++++++++++++++++++----
>  revision.h     |  1 +
>  t/t4202-log.sh |  6 ++++++

We'd probably want an update to Documentation/rev-list-options.txt (I
notice that "--default" is not covered there; that might be worth
fixing, too)>

> +static int has_revisions(struct rev_info *revs)
> +{
> +	struct rev_cmdline_info *info = &revs->cmdline;
> +
> +	return info->nr != 0;
> +}

So this function is going to replace this flag:

> @@ -2401,8 +2423,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			argv_array_pushv(&prune_data, argv + i);
>  			break;
>  		}
> -		else
> -			got_rev_arg = 1;
>  	}

Are we sure that every that hits that "else" is going to trigger
info->nr (and vice versa)?

If I say "--tags", I think we may end up with entries in revs->cmdline,
but would not have set got_rev_arg. That's captured separately in
revs->rev_input_given. But your cancel_default logic:

> @@ -2431,7 +2451,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		opt->tweak(revs, opt);
>  	if (revs->show_merge)
>  		prepare_show_merge(revs);
> -	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
> +	cancel_default = revs->sticky_default ?
> +			 has_interesting_revisions(revs) :
> +			 has_revisions(revs);
> +	if (revs->def && !revs->rev_input_given && !cancel_default) {

doesn't handle that. So if I do:

  git rev-list --count --sticky-default --default HEAD --not --tags

I should see everything in HEAD that's not tagged. But we don't even
look at cancel_default, because !revs->rev_input_given is not true.

I think you could solve that by making the logic more like:

  if (revs->sticky_default)
	cancel_default = has_interesting_revisions();
  else
	cancel_default = !revs->rev_input_given && !got_rev_arg;

which leaves the non-sticky case exactly as it is today.

> diff --git a/revision.h b/revision.h
> index 2b30ac270..570fa1a6d 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -92,6 +92,7 @@ struct rev_info {
>  
>  	unsigned int early_output;
>  
> +	unsigned int	sticky_default:1;
>  	unsigned int	ignore_missing:1,
>  			ignore_missing_links:1;

Maybe it would make sense to put this next to "const char *def"?

The bitfield would not be as efficient, but I don't think we care about
packing rev_info tightly.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 153a50615..9517a65da 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -213,6 +213,12 @@ test_expect_success 'git show <commits> leaves list of commits as given' '
>  	test_cmp expect actual
>  '
>  
> +printf "sixth\nfifth\n" > expect
> +test_expect_success '--sticky-default ^<rev>' '
> +	git log --pretty="tformat:%s" --sticky-default ^HEAD~2 > actual &&
> +	test_cmp expect actual
> +'

Yuck, t4202 is a mix of older and newer styles. I'm OK with this as-is
because you've matched the surrounding code, but these days I'd probably
write:

  test_expect_success '--sticky-default ^<rev>' '
	{
		echo sixth
		echo fifth
	} >expect &&
	git log --format=%s --sticky-default ^HEAD~2 >actual &&
	test_cmp expect actual
  '

-Peff
