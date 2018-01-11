Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2271F1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 12:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeAKMLq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 07:11:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:41106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753826AbeAKMLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 07:11:46 -0500
Received: (qmail 32504 invoked by uid 109); 11 Jan 2018 12:11:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 12:11:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22838 invoked by uid 111); 11 Jan 2018 12:12:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 07:12:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 07:11:44 -0500
Date:   Thu, 11 Jan 2018 07:11:44 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: read test snippet from stdin [was: [PATCH] t3900: add some more
 quotes]
Message-ID: <20180111121143.GA6357@sigill.intra.peff.net>
References: <20180110195323.GA26186@sigill.intra.peff.net>
 <20180111113928.6412-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180111113928.6412-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 12:39:28PM +0100, SZEDER Gábor wrote:

> > diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> > index 9e4e694d93..09ad4d8878 100755
> > --- a/t/t3900-i18n-commit.sh
> > +++ b/t/t3900-i18n-commit.sh
> > @@ -39,14 +39,14 @@ test_expect_success 'UTF-16 refused because of NULs' '
> >  	test_must_fail git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
> >  '
> >  
> > -test_expect_success 'UTF-8 invalid characters refused' '
> 
> Note that the test snippet started right after that last single quote,
> i.e. it started with a newline.
> 
> > -	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
> > +test_expect_success 'UTF-8 invalid characters refused' - <<\EOT
> > +	test_when_finished 'rm -f "$HOME/stderr $HOME/invalid"' &&
> 
> And now it starts at the beginning of this line, i.e. without that
> leading neline.  This change leads to the following when run with '-v':

Yeah, I noticed that, too. It would be easy enough to add the extra
newline ourselves when printing the verbose output (quite a few of our
older tests don't start with a newline already, so it would be improving
them, too).

Alternatively, I considered adding a whole new helper function that
would skip the need to say "-" as the test body. And then it would
always know we were reading from the here-doc.

> > +		# command substitution eats trailing whitespace, so we add
> > +		# and then remove a non-whitespace character.
> > +		eval "$1=\$(cat; printf x)"
> > +		eval "$1=\${$1%x}"
> > +	fi
> > +}
> 
> Command substitutions don't eat trailing whitespaces in general, only
> trailing newlines.  POSIX:

Yeah, I wondered about that, but didn't bother digging since the
solution is the same either way.

> How about this alternative (also adding the missing leading newline
> mentioned above):
> 
> +		eval "$1='
> +'\$(cat)'
> +'"
> 
> The indentation is yuck, but overall perhaps a bit less hacky...

I wrote something very similar at first, before finding the printf trick
on Stack Overflow. I thought the indentation on what I wrote was too
ugly. :)

I don't have a strong preference, and certainly if one is more portable
than the other, we should choose that.

The main point of my email was just to say "do people even like the
concept/direction?"

-Peff
