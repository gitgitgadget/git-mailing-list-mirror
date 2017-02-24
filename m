Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3DDC2022D
	for <e@80x24.org>; Fri, 24 Feb 2017 00:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdBXAsY (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:48:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:33097 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbdBXAru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:47:50 -0500
Received: (qmail 32728 invoked by uid 109); 24 Feb 2017 00:41:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 00:41:08 +0000
Received: (qmail 5357 invoked by uid 111); 24 Feb 2017 00:41:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:41:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 19:41:05 -0500
Date:   Thu, 23 Feb 2017 19:41:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
Message-ID: <20170224004105.ayddcwlnpmq7tifu@sigill.intra.peff.net>
References: <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
 <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
 <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
 <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
 <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
 <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
 <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
 <20170223055831.u3yofkby3c56t7l4@sigill.intra.peff.net>
 <xmqqo9xt8jcf.fsf@gitster.mtv.corp.google.com>
 <xmqqy3ww5wbl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3ww5wbl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 03:19:58PM -0800, Junio C Hamano wrote:

> > But you are right.  config-parse-key does have the simpler string
> > that can just be given to the canonicalize thing and we should be
> > able to reuse it.
> 
> Actually, I think we can just use the existing config_parse_key()
> instead of adding the new function.  It adds one allocation and
> deallocation, but it's not like this is a performance-critical
> codepath that we absolutely avoid extra allocations.  After all, we
> are still using the strbuf-split thing :-/.

Yeah, you're right. This is much nicer, and everything else was
premature optimization.

> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 23 Feb 2017 15:04:40 -0800
> Subject: [PATCH] config: reject invalid VAR in 'git -c VAR=VAL command' and
>  keep subsection intact

Long subject. :)

I'd have just said:

  config: pass variables through git_config_parse_parameter()

That is "what", but the "why" can come in the next paragraph.

> The parsing of one-shot assignments of configuration variables that
> come from the command line historically was quite loose and allowed
> anything to pass.  It also downcased everything in the variable name,
> even a three-level <section>.<subsection>.<variable> name in which
> the <subsection> part must be treated in a case sensible manner.
> 
> Existing git_config_parse_key() helper is used to parse the variable
> name that comes from the command line, i.e. "git config VAR VAL",
> and handles these details correctly.  Replace the strbuf_tolower()
> call in git-config_parse_parameter() with a call to it to correct
> both issues.  git_config_parse_key() does a bit more things that are
> not necessary for the purpose of this codepath (e.g. it allocates a
> separate buffer to return the canonicalized variable name because it
> takes a "const char *" input), but we are not in a performance-critical
> codepath here.

Nicely explained.

> diff --git a/config.c b/config.c
> index b8cce1dffa..39f20dcd2c 100644
> --- a/config.c
> +++ b/config.c
> @@ -295,7 +295,9 @@ int git_config_parse_parameter(const char *text,
>  			       config_fn_t fn, void *data)
>  {
>  	const char *value;
> +	char *canonical_name;
>  	struct strbuf **pair;
> +	int ret = 0;
>  
>  	pair = strbuf_split_str(text, '=', 2);
>  	if (!pair[0])

Hmm. I suspect one cannot do:

  git -c 'section.subsection with an = in it.key=foo' ...

Definitely not a new problem, nor something that should block your
patch. But if we want to fix it, I suspect the problem will ultimately
involve parsing left-to-right to get the key first, then confirming it
has an =, and then the value.

> @@ -313,13 +315,15 @@ int git_config_parse_parameter(const char *text,
>  		strbuf_list_free(pair);
>  		return error("bogus config parameter: %s", text);
>  	}
> -	strbuf_tolower(pair[0]);
> -	if (fn(pair[0]->buf, value, data) < 0) {
> -		strbuf_list_free(pair);
> +
> +	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL))
>  		return -1;
> -	}

I think git_config_parse_key() will free canonical_name itself if it
returns failure. But do you need to strbuf_list_free(pair) here?

Or alternatively:

  int ret = -1;
  if (!parse(...))
          ret = fn(...);

or use a "got out". Whatever. You don't need me to teach you about error
exits. :)

> +	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
> +
> +	free(canonical_name);
>  	strbuf_list_free(pair);
> -	return 0;
> +	return ret;

Looks good.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 923bfc5a26..ea371020fa 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh

I just skimmed these, as they look like the previous ones.

So overall I like it, modulo the minor error-leak.

-Peff
