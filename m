Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9E01FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 06:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbcLaGk7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 01:40:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:33497 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbcLaGk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 01:40:58 -0500
Received: (qmail 11488 invoked by uid 109); 31 Dec 2016 06:40:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 06:40:57 +0000
Received: (qmail 2175 invoked by uid 111); 31 Dec 2016 06:41:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 01:41:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Dec 2016 01:40:53 -0500
Date:   Sat, 31 Dec 2016 01:40:53 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 20/23] try_remove_empty_parents(): don't trash
 argument contents
Message-ID: <20161231064053.prvlw6x6qprzkmw7@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <6164af2d1f9eeb5bd339b3913e8046c1ea0b02be.1483153436.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6164af2d1f9eeb5bd339b3913e8046c1ea0b02be.1483153436.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 04:13:00AM +0100, Michael Haggerty wrote:

> It's bad manners and surprising and therefore error-prone.

Agreed.

I wondered while reading your earlier patch whether the
safe_create_leading_directories() function had the same problem, but it
carefully replaces the NUL it inserts.

> -static void try_remove_empty_parents(char *refname)
> +static void try_remove_empty_parents(const char *refname)
>  {
> +	struct strbuf buf = STRBUF_INIT;
>  	char *p, *q;
>  	int i;
> -	p = refname;
> +
> +	strbuf_addstr(&buf, refname);

I see here you just make a copy. I think it would be enough to do:

> @@ -2305,10 +2306,11 @@ static void try_remove_empty_parents(char *refname)
>  			q--;
>  		if (q == p)
>  			break;
> -		*q = '\0';
> -		if (rmdir(git_path("%s", refname)))
> +		strbuf_setlen(&buf, q - buf.buf);
> +		if (rmdir(git_path("%s", buf.buf)))
>  			break;

  *q = '\0';
  r = rmdir(git_path("%s", refname));
  *q = '/';

  if (r)
          break;

or something. But I doubt the single allocation is breaking the bank,
and it has the nice side effect that callers can pass in a const string
(I didn't check yet whether that enables further cleanups).

-Peff
