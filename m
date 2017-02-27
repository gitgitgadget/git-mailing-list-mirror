Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969841F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdB0VMo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:12:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:35139 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdB0VMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:12:42 -0500
Received: (qmail 29543 invoked by uid 109); 27 Feb 2017 21:12:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 21:12:19 +0000
Received: (qmail 19955 invoked by uid 111); 27 Feb 2017 21:12:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 16:12:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 16:12:17 -0500
Date:   Mon, 27 Feb 2017 16:12:17 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-clone --config order & fetching extra refs during initial
 clone
Message-ID: <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
 <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
 <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 11:16:35AM -0800, Junio C Hamano wrote:

> >> TL;DR: git-clone ignores any fetch specs passed via --config.
> >
> > I agree that this is a bug. There's some previous discussion and an RFC
> > patch from lat March (author cc'd):
> >
> >   http://public-inbox.org/git/1457313062-10073-1-git-send-email-szeder@ira.uka.de/
> >
> > That discussion veered off into alternatives, but I think the v2 posted
> > in that thread is taking a sane approach.
> 
> Let's see how well it fares by cooking it in 'next' ;-) 
> 
> I think it was <1459349623-16443-1-git-send-email-szeder@ira.uka.de>,
> which needs a bit of massaging to apply to the current codebase.

Yeah, that is the most recent one I found.

I didn't actually review it very carefully before, but I'll do so now
(spoiler: a few nits, but it looks fine).

>  static struct ref *wanted_peer_refs(const struct ref *refs,
> -		struct refspec *refspec)
> +		struct refspec *refspec, unsigned int refspec_count)

Most of the changes here and elsewhere are just about passing along
multiple refspecs instead of a single, which makes sense.

> @@ -856,7 +861,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	int submodule_progress;
>  
>  	struct refspec *refspec;
> -	const char *fetch_pattern;
> +	unsigned int refspec_count = 1;
> +	const char **fetch_patterns;
> +	const struct string_list *config_fetch_patterns;

This "1" seems funny to up here by itself, as it must be kept in sync
with the later logic that feeds exactly one non-configured refspec into
our list. The current code isn't wrong, but it would be nice to have it
all together. I.e., replacing:

> +	if (config_fetch_patterns)
> +		refspec_count = 1 + config_fetch_patterns->nr;
> +	fetch_patterns = xcalloc(refspec_count, sizeof(*fetch_patterns));
> +	fetch_patterns[0] = value.buf;

with:

  refspec_count = 1;
  if (config_fetch_patterns)
	refspec_count += config_fetch_patterns->nr;
  ...

Though if I'm bikeshedding, I'd probably have written the whole thing
with an argv_array and avoided counting at all.

> +	refspec = parse_fetch_refspec(refspec_count, fetch_patterns);
>  
> +	strbuf_reset(&key);
>  	strbuf_reset(&value);
>  
>  	remote = remote_get(option_origin);

I do also notice that right _after_ this parsing, we use remote_get(),
which is supposed to give us this config anyway. Which makes me wonder
if we could just reorder this to put remote_get() first, and then read
the resulting refspecs from remote->fetch.

> diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
> index e4850b778c..3bed17783b 100755
> --- a/t/t5611-clone-config.sh
> +++ b/t/t5611-clone-config.sh
> @@ -37,6 +37,30 @@ test_expect_success 'clone -c config is available during clone' '
>  	test_cmp expect child/file
>  '
>  
> +test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
> +	rm -rf child &&
> +	git update-ref refs/grab/it refs/heads/master &&
> +	git update-ref refs/keep/out refs/heads/master &&
> +	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
> +	(
> +		cd child &&
> +		git for-each-ref --format="%(refname)" refs/grab/ >../actual
> +	) &&
> +	echo refs/grab/it >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
> +	rm -rf child &&
> +	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
> +	(
> +		cd child &&
> +		git for-each-ref --format="%(refname)" refs/grab/ >../actual
> +	) &&
> +	echo refs/grab/it >expect &&
> +	test_cmp expect actual
> +'

These look reasonable. Using "git -C for-each-ref" would save a
subshell, but that's minor.

If we wanted to be thorough, we could also check that the feature works
correctly with "--origin" (I think it does).

-Peff
