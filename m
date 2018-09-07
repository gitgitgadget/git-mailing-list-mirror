Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C461F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeIGIRX (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:17:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725743AbeIGIRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 04:17:23 -0400
Received: (qmail 15872 invoked by uid 109); 7 Sep 2018 03:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 03:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10940 invoked by uid 111); 7 Sep 2018 03:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 23:38:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 23:38:31 -0400
Date:   Thu, 6 Sep 2018 23:38:31 -0400
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180907033831.GB1383@sigill.intra.peff.net>
References: <20180906193516.28909-1-max@max630.net>
 <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
 <20180907032740.GA20545@jessie.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907032740.GA20545@jessie.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 06:27:40AM +0300, Max Kirillov wrote:

> On Thu, Sep 06, 2018 at 02:54:18PM -0700, Junio C Hamano wrote:
> > Max Kirillov <max@max630.net> writes:
> >> This should fix it. I'm not sure should it treat it as 0 or "-1"
> >> At least the tests mentioned by Jeff fails if I try to treat missing CONTENT_LENGTH as "-1"
> >> So keep the existing behavior as much as possible
> > 
> > I am not sure what you mean by the above, between 0 and -1.  The
> > code signals the caller of get_content_length() that req_len is -1
> > which is used as a sign to read through to the EOF, so it appears to
> > me that the code treats missing content-length (i.e. str == NULL
> > case) as "-1".
> 
> I made a mistake in this, it should be "if I try to treat missing
> CONTENT_LENGTH as 0". This, as far as I understand, what the
> RFC specifies.
> 
> That is, after the following change, the test "large fetch-pack
> requests can be split across POSTs" from t5551 starts faliing:
> 
> -- >8 --
> @@ -353,8 +353,12 @@ static ssize_t get_content_length(void)
>         ssize_t val = -1;
>         const char *str = getenv("CONTENT_LENGTH");
>  
> -       if (str && *str && !git_parse_ssize_t(str, &val))
> -               die("failed to parse CONTENT_LENGTH: %s", str);
> +       if (str && *str) {
> +               if (!git_parse_ssize_t(str, &val))
> +                       die("failed to parse CONTENT_LENGTH: %s", str);
> +       } else
> +               val = 0;
> +

Right, I'm pretty sure it is a problem if you treat a missing
CONTENT_LENGTH as "present, but zero". Because chunked encodings from
apache really do want us to read until EOF.

My understanding from Jelmer's report is that a present-but-empty
variable should be counted as "0" to mean "do not read any body bytes".
That matches my reading of RFC 3875, which says:

  If no data is attached, then NULL (or unset).

(and earlier they explicitly define NULL as the empty string). That
said, we do not do what they say for the "unset" case. And cannot
without breaking chunked encoding from apache. So I don't know how much
we want to follow that rfc to the letter, but at least it makes sense to
me to revert this case back to what Git used to do, and what the rfc
says.

In other words, I think the logic we want is:

  if (!str) {
	/*
	 * RFC3875 says this must mean "no body", but in practice we
	 * receive chunked encodings with no CONTENT_LENGTH. Tell the
	 * caller to read until EOF.
	 */
	val = -1;
  } else if (!*str) {
	/*
	 * An empty length should be treated as "no body" according to
	 * RFC3875, and this seems to hold in practice.
	 */
	val = 0;
  } else {
	/*
	 * We have a CONTENT_LENGTH; trust what's in it as long as it
	 * can be parsed.
	 */
	if (!git_parse_ssize_t(str, &val))
	        die(...);
  }

-Peff
