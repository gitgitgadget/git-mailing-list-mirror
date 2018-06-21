Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690AF1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 17:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeFURlZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 13:41:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:50884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932695AbeFURlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 13:41:24 -0400
Received: (qmail 31694 invoked by uid 109); 21 Jun 2018 17:41:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Jun 2018 17:41:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8251 invoked by uid 111); 21 Jun 2018 17:41:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Jun 2018 13:41:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2018 13:41:22 -0400
Date:   Thu, 21 Jun 2018 13:41:22 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Kisela <skisela@redhat.com>
Cc:     git@vger.kernel.org, nico@fluxnic.net, larsxschneider@gmail.com,
        lfleischer@lfos.de
Subject: Re: [PATCH] Sanitize escape char sequences coming from server
Message-ID: <20180621174122.GA30249@sigill.intra.peff.net>
References: <20180621121030.1721-1-sebastian.kisela@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621121030.1721-1-sebastian.kisela@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 02:10:30PM +0200, Sebastian Kisela wrote:

> From: Sebastian Kisela <skisela@redhat.com>
> 
> Fix volnurability against MITM attacks on client side
> by replacing non printable and non white space characters
> by "?".
> 
> Fixes: CVE-2018-1000021

I'm not sure if this is a productive direction to pursue or not.

If you're worried about a malicious server (or MITM) sending you bad
messages, you'd also need to worry about them sending you bad repository
content, as we may print filenames to stderr or stdout (and occasionally
file content, too, though typically only as part of a diff, which
_usually_ goes through a pager).

But it's unclear to me if this is worth worrying about or not.
Ultimately it's a vulnerability in the terminal if untrusted output can
do bad things.

It's hard to make an evaluation of whether this plugs the vulnerability
because we haven't really defined a threat model. What are we protecting
against exactly?

As for the patch itself:

> diff --git a/sideband.c b/sideband.c
> index 325bf0e97..8c9d74ace 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -1,3 +1,4 @@
> +#include <wchar.h>
>  #include "cache.h"

System includes should go into git-compat-util.h (because ordering is
often important there).

More importantly, though, does everybody have wchar.h?

> @@ -18,6 +19,20 @@
>  #define ANSI_SUFFIX "\033[K"
>  #define DUMB_SUFFIX "        "
>  
> +int sanitize_server_message(struct strbuf *outbuf)
> +{
> +	wchar_t *wcstring = xmalloc(sizeof(wchar_t) * outbuf->len);

This is a potential integer overflow that can lead to a buffer overflow
(e.g., imagine a system where both wchar_t and size_t are 32-bits; a 1GB
string will wrap around and we'll allocate a much smaller buffer than we
expected).

> +	int len = mbstowcs(wcstring, outbuf->buf, outbuf->len);

I don't think mbstowcs() is always going to do the right thing there.
We're looking at a string that was sent from the remote server. What
encoding is it in? Using mbstowcs() is going to use whatever is in
LC_CTYPE on the local machine.

Also, the return type of mbstowcs is a size_t.

> +	for(int i = 0; i <= len; i++)
> +		if(!isprint(wcstring[i]) && !isspace(wcstring[i]) )
> +			wcstring[i] = '?';
> +		if (wcstombs(outbuf->buf, wcstring, outbuf->len) == -1)
> +			return 1;

Funny indentation. I think the second line is supposed to _not_ be in
the loop, so this is just funny indentation and not wrong code.

Using isprint() here probably doesn't do what you expect, because Git
uses its own locale-agnostic ctype replacements. I didn't check, but I
suspect any non-ascii characters will be marked as non-printable, making
the whole wchar thing pointless.

Your replacement allows existing spaces, which is good; many servers
send carriage-returns as part of progress output (and recv_sideband
detects these and makes sure the line remains prefixed with "remote:").

> @@ -74,6 +89,9 @@ int recv_sideband(const char *me, int in_stream, int out)
>  				} else {
>  					strbuf_addch(&outbuf, *brk);
>  				}
> +
> +				if (sanitize_server_message(&outbuf))
> +					retval = SIDEBAND_REMOTE_ERROR;

"outbuf" may contain partially-received lines at various points, meaning
multi-byte characters could be cut off. I _think_ it's OK to look at it
here, as we'd always be breaking on a "\r" or "\n" at this point.

> @@ -97,6 +115,8 @@ int recv_sideband(const char *me, int in_stream, int out)
>  
>  	if (outbuf.len) {
>  		strbuf_addch(&outbuf, '\n');
> +		if (sanitize_server_message(&outbuf))
> +			retval = SIDEBAND_REMOTE_ERROR;
>  		xwrite(2, outbuf.buf, outbuf.len);
>  	}

Here I think we could get cut off. Since it's the end of input, showing
the partial cutoff character is the best we can do. However, I think
we'd cause mbstowcs() in your sanitize function to report failure,
meaning we wouldn't show the remote message at all.

> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> index 7f278d8ce..cc1f6ca29 100755
> --- a/t/t5401-update-hooks.sh
> +++ b/t/t5401-update-hooks.sh
> @@ -148,4 +148,27 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
>  	git push ./victim.git "+refs/heads/*:refs/heads/*"
>  '
>  
> +cat <<EOF >expect
> +remote: foo?[0;31mbar?[0m
> +To ./victim.git
> + * [new branch]      victim_branch -> victim_branch
> +EOF

I know some tests in this script are already guilty of this, but please
avoid adding commands outside of a test_expect block. And use "<<-\EOF"
to allow proper indentation of the here-doc, and inhibit interpolation
when you don't need it.

> +cat >victim.git/hooks/pre-receive <<'EOF'
> +#!/bin/sh
> +  printf "foo\033[0;31mbar\033[0m"
> +  exit 0
> +EOF
> +chmod u+x victim.git/hooks/pre-receive

This should use write_script, since the $SHELL_PATH may not be /bin/sh.
See nearby tests.

> +test_expect_success 'pre-receive stderr contains ANSI colors' '
> +	rm -f victim.git/hooks/update victim.git/hooks/post-receive &&
> +
> +  git branch victim_branch master &&

Funny non-tab indentation (here and elsewhere).

> +	git push ./victim.git "+refs/heads/victim_branch:refs/heads/victim_branch"\
> +    >send.out 2>send.err &&

Style: include a space before the backslash continuation.

However, this should be the same as "git push victim.git
+victim_branch", which eliminates the need for continuation.

> +  cat send.err > actual &&

Style: we avoid whitespace between redirection operations and filenames
(so just ">actual").

-Peff
