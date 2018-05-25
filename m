Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD171F51C
	for <e@80x24.org>; Fri, 25 May 2018 08:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964960AbeEYI7J (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 04:59:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:52562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964806AbeEYI7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 04:59:08 -0400
Received: (qmail 7414 invoked by uid 109); 25 May 2018 08:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 May 2018 08:59:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2018 invoked by uid 111); 25 May 2018 08:59:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 25 May 2018 04:59:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2018 04:59:06 -0400
Date:   Fri, 25 May 2018 04:59:06 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] t: make many tests depend less on the refs being files
Message-ID: <20180525085906.GA2948@sigill.intra.peff.net>
References: <20180523052517.4443-1-chriscool@tuxfamily.org>
 <615f57ad-7591-128a-0c42-660312d34ca2@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <615f57ad-7591-128a-0c42-660312d34ca2@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 10:48:04AM +0200, Michael Haggerty wrote:

> >  test_expect_success "multi-fetch works off a 'clean' repository" '
> > -	rm -r "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" "$GIT_DIR/logs" &&
> > +	rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
> > +	git reflog expire --all --expire=all &&
> >  	mkdir "$GIT_DIR/svn" &&
> >  	git svn multi-fetch
> >  	'
> > 
> 
> `rm -rf "$GIT_DIR/refs/remotes"` is not kosher. I think it can be written
> 
>     printf 'option no-deref\ndelete %s\n' $(git for-each-ref
> --format='%(refname)' refs/remotes) | git update-ref --stdin
> 
> as long as the number of references doesn't exceed command-line limits.
> This will also take care of the reflogs. Another alternative would be to
> write it as a loop.

Perhaps:

  git for-each-ref --format="option no-deref%0adelete %(refname)" refs/remotes |
  git update-ref --stdin

-Peff
