Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD03920966
	for <e@80x24.org>; Tue,  4 Apr 2017 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbdDDGs5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 02:48:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:56358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbdDDGs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 02:48:56 -0400
Received: (qmail 8286 invoked by uid 109); 4 Apr 2017 06:48:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 06:48:45 +0000
Received: (qmail 4275 invoked by uid 111); 4 Apr 2017 06:49:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 02:49:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Apr 2017 02:48:45 -0400
Date:   Tue, 4 Apr 2017 02:48:45 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix 'git am' in-body header continuations
Message-ID: <20170404064844.argmnrdb7tuk2wkj@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1704021746180.22832@i7.lan>
 <f5763dab-b829-f216-a377-8a71fc4f0c1e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5763dab-b829-f216-a377-8a71fc4f0c1e@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 11:00:09AM -0700, Jonathan Tan wrote:

> > diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> > index 89a5bacac..44807e218 100755
> > --- a/t/t4150-am.sh
> > +++ b/t/t4150-am.sh
> > @@ -983,7 +983,9 @@ test_expect_success 'am works with multi-line in-body headers' '
> >  	rm -fr .git/rebase-apply &&
> >  	git checkout -f first &&
> >  	echo one >> file &&
> > -	git commit -am "$LONG" --author="$LONG <long@example.com>" &&
> > +	git commit -am "$LONG
> > +
> > +    Body test" --author="$LONG <long@example.com>" &&
> 
> Instead of "Body test", I would write something more descriptive like "Not a
> continuation line because of blank line above", but I'm fine with either.

Yeah. I also wonder if we can make the indentation more obvious. I
thought at first that the patch was whitespace mangled. :-/

Maybe:

  SP=" " &&
  cat >msg <<-EOF &&
  $LONG

  $SP This line is indented but not a header continuation.
  EOF
  git commit -F msg ...

or something.

It might also be easier to understand what's going on if this gets its
own test. This is really just testing mailinfo. I wonder if it would
make more sense in t5100, where we would not have to deal with all the
commit/format-patch cruft.

-Peff
