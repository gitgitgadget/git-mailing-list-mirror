Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD4A1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 05:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfJWFCH (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 01:02:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:55634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727850AbfJWFCH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 01:02:07 -0400
Received: (qmail 3458 invoked by uid 109); 23 Oct 2019 05:02:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Oct 2019 05:02:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21438 invoked by uid 111); 23 Oct 2019 05:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Oct 2019 01:05:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Oct 2019 01:02:06 -0400
From:   Jeff King <peff@peff.net>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's
 username
Message-ID: <20191023050206.GA29779@sigill.intra.peff.net>
References: <20191022232847.5212-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022232847.5212-1-prarit@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 07:28:47PM -0400, Prarit Bhargava wrote:

> In many projects the number of contributors is low enough that users know
> each other and the full email address doesn't need to be displayed.
> Displaying only the author's username saves a lot of columns on the screen.
> For example displaying "prarit" instead of "prarit@redhat.com" saves 11
> columns.
> 
> Add a "%aU"|"%au" option that outputs the author's email username.

Like others, this seems potentially useful even if I probably wouldn't
use it myself. Another more complicated way to think of it would be to
give a list of domains to omit (so if 90% of the committers are
@redhat.com, we can skip that, but the one-off contributor from another
domain gets their fully qualified name.

But that's a lot more complicated. I don't mind doing the easy thing
now, and even if we later grew the more complicated thing, I wouldn't be
sad to still have this easy one as an option.

> --- a/pretty.c
> +++ b/pretty.c
> @@ -706,6 +706,11 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  		strbuf_add(sb, mail, maillen);
>  		return placeholder_len;
>  	}
> +	if (part == 'u' || part == 'U') {	/* username */
> +		maillen = strstr(s.mail_begin, "@") - s.mail_begin;
> +		strbuf_add(sb, mail, maillen);
> +		return placeholder_len;
> +	}

What happens if the email doesn't have an "@"? I think you'd either end
up printing a bunch of extra cruft (because you're not limiting the
search for "@" to the boundaries from split_ident_line) or you'd
crash (if there's no "@" at all, and you'd get a huge maillen).

There's also no need to use the slower strstr() when looking for a
single character. So perhaps:

  const char *at = memchr(mail, '@', maillen);
  if (at)
          maillen = at - mail;
  strbuf_add(sb, mail, maillen);

> +test_expect_success 'log pretty %an %ae %au' '

As others noted, this could cover %aU, too (which is broken; you need to
handle 'U' alongside 'E' and 'N' earlier in format_person_part()).

> +	git checkout -b anaeau &&
> +	test_commit anaeau_test anaeau_test_file &&
> +	git log --pretty="%an" > actual &&
> +	git log --pretty="%ae" >> actual &&
> +	git log --pretty="%au" >> actual &&

Maybe:

  git log --pretty="%an %ae %au"

or

  git log --pretty="%an%n%ae%n%au"

which is shorter and runs more efficiently?

> +	git log > full &&
> +	name=$(cat full | grep "^Author: " | awk -F "Author: " " { print \$2 } " | awk -F " <" " { print \$1 } ") &&
> +	email=$(cat full | grep "^Author: " | awk -F "<" " { print \$2 } " | awk -F ">" " { print \$1 } ") &&
> +	username=$(cat full | grep "^Author: " | awk -F "<" " { print \$2 } " | awk -F ">" " { print \$1 } " | awk -F "@" " { print \$1 } " ) &&
> +	echo "${name}" > expect &&
> +	echo "${email}" >> expect &&
> +	echo "${username}" >> expect &&

These values come from our hard-coded test setup, so it would be more
readable to just expect those:

  {
	echo "$GIT_AUTHOR_NAME" &&
	echo "$GIT_AUTHOR_EMAIL" &&
	echo "$GIT_AUTHOR_EMAIL" | sed "s/@.*//"
  } >expect

For the last one, also I wouldn't be upset to see test-lib.sh do
something like:

  TEST_AUTHOR_USERNAME=author
  TEST_AUTHOR_DOMAIN=example.com
  GIT_AUTHOR_NAME=$TEST_AUTHOR_USERNAME@$TEST_AUTHOR_DOMAIN

to let tests like this pick out the individual values if they want.

-Peff
