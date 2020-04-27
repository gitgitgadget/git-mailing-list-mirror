Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F15C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 11:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C1E20644
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 11:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgD0LwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:52:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:40702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726260AbgD0LwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 07:52:24 -0400
Received: (qmail 11706 invoked by uid 109); 27 Apr 2020 11:52:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 11:52:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22313 invoked by uid 111); 27 Apr 2020 12:03:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 08:03:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 07:52:23 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v2] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200427115223.GA1718141@coredump.intra.peff.net>
References: <20200426234750.40418-1-carenas@gmail.com>
 <20200427084235.60798-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427084235.60798-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 01:42:35AM -0700, Carlo Marcelo Arenas Belón wrote:

> with the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported failing[1] to parse as valid credentials.

Those were never supposed to work. I'm mildly surprised that they did.
It looks like the username/password check here is what prevented us from
matching an empty line against a very broad pattern:

          while (strbuf_getline_lf(&line, fh) != EOF) {
                  credential_from_url(&entry, line.buf);
                  if (entry.username && entry.password &&
                      credential_match(c, &entry)) {
                          found_credential = 1;

And there was no such thing as a comment character. E.g., a
"commented-out" url like this:

  $ echo "#https://user:pass@example.com/" >creds

would still be matched:

  $ echo host=example.com | git credential-store --file creds get
  host=example.com
  username=user
  password=pass

I guess I'm not really opposed to adding this as a feature, but I think
the justification should be "because it is somehow useful" and not
because it's a bugfix.

> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index d6b54e8c65..0d13318255 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -120,4 +120,23 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
>  	test_must_be_empty "$HOME/.config/git/credentials"
>  '
>  
> +test_expect_success 'get: allow for empty lines or comments in store file' '
> +	q_to_cr >"$HOME/.git-credentials" <<-\EOF &&
> +	#this is a comment and the next line contains leading spaces
> +	    Q
> +	https://user:pass@example.com
> +	Q
> +	EOF

q_to_cr is a little weird here, as we wouldn't expect there to be CRs in
the file. They do get removed by strbuf_trim(), even in non-comment
lines. But perhaps "sed s/Q//" would accomplish the same thing (making
the whitespace more visible) without making anyone wonder whether the CR
is an important part of the test?

-Peff
