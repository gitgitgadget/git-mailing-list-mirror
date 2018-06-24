Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438101F516
	for <e@80x24.org>; Sun, 24 Jun 2018 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeFXJlE (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 05:41:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:53160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751900AbeFXJlE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 05:41:04 -0400
Received: (qmail 32024 invoked by uid 109); 24 Jun 2018 09:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Jun 2018 09:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7969 invoked by uid 111); 24 Jun 2018 09:41:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Jun 2018 05:41:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jun 2018 05:41:02 -0400
Date:   Sun, 24 Jun 2018 05:41:02 -0400
From:   Jeff King <peff@peff.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: ^D to credentials prompt results in "fatal: ... Success"
Message-ID: <20180624094102.GA32079@sigill.intra.peff.net>
References: <CA+dzEB=RNqpduF+hx-y6HMeQYpSKJrBqx_pSu_MS3yDa7JHsww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+dzEB=RNqpduF+hx-y6HMeQYpSKJrBqx_pSu_MS3yDa7JHsww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 22, 2018 at 07:42:38PM -0700, Anthony Sottile wrote:

> A bit of an amusing edge case.
> 
> I'm not exactly sure the correct approach to fix this but here's my
> reproduction, triage, and a few potential options I see.
> 
> Note that after the username prompt, I pressed ^D
> 
> $./prefix/bin/git --version
> git version 2.18.0
> $ PATH=$PWD/prefix/bin:$PATH git clone
> https://github.com/asottile/this-does-not-exist-i-promise
> Cloning into 'this-does-not-exist-i-promise'...
> Username for 'https://github.com': fatal: could not read Username for
> 'https://github.com': Success

Yeah, agreed that is not ideal.

> I see a couple of options here:
> 
> 1. special case EOF in `git_terminal_prompt` / `git_prompt` and
> produce an error message such as:
> 
> fatal: could not read Username for 'https://github.com': EOF
> [...]
>
> 2. treat EOF less specially
> 
> The function this is replacing, `getpass` simply returns an empty
> string on `EOF`.  This patch would implement that:

Either of those would be fine with me. We do not have to adhere to
getpass() behavior exactly (the whole point of having our custom wrapper
is that getpass() behaves badly in a few situations). But I doubt
anybody really cares that much either way, so we might as well have
consistent behavior.

> diff --git a/compat/terminal.c b/compat/terminal.c
> index fa13ee672..8bd08108e 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -122,7 +122,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
>         fputs(prompt, output_fh);
>         fflush(output_fh);
> 
> -       r = strbuf_getline_lf(&buf, input_fh);
> +       strbuf_getline_lf(&buf, input_fh);
>         if (!echo) {
>                 putc('\n', output_fh);
>                 fflush(output_fh);
> @@ -132,8 +132,6 @@ char *git_terminal_prompt(const char *prompt, int echo)
>         fclose(input_fh);
>         fclose(output_fh);
> 
> -       if (r == EOF)
> -               return NULL;
>         return buf.buf;
>  }

I think this goes too far, though. We get EOF from strbuf_getline on
actual EOF _or_ on a real error. And we'd want to keep reporting a real
error, since it may tell the user something useful.

I suspect you probably need to check ferror(input_fh) before closing,
and rewrite "r" to 0 in that case.

-Peff
