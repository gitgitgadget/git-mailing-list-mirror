Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA7D1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756992AbcHXQ02 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:26:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:60523 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757005AbcHXQ01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:26:27 -0400
Received: (qmail 8072 invoked by uid 109); 24 Aug 2016 16:19:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 16:19:42 +0000
Received: (qmail 4229 invoked by uid 111); 24 Aug 2016 16:19:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 12:19:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 12:19:40 -0400
Date:   Wed, 24 Aug 2016 12:19:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] cat-file: optionally convert to worktree version
Message-ID: <20160824161939.d2h4qlaxhhi6limm@sigill.intra.peff.net>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <cover.1472041389.git.johannes.schindelin@gmx.de>
 <xmqqk2f6rvx9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2f6rvx9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 09:09:06AM -0700, Junio C Hamano wrote:

> >  +	if (!path)
> >  +		path = obj_context.path;
> >  +	else if (obj_context.mode == S_IFINVALID)
> >  +		obj_context.mode = 0100644;
> >  +
> >   	buf = NULL;
> >   	switch (opt) {
> >   	case 't':
> 
> The above two hunks make all the difference in the ease of reading
> the remainder of the function.  Very good.

Yeah, I agree. Though it took me a moment to figure out why we were
setting obj_context.mode but not obj_context.path; the reason is that
"mode" is convenient to use as local storage, but "path" is not, because
it is not a pointer but an array.

So it would have been a little clearer to me as:

  const char *path;
  unsigned mode;
  ...
  if (!force_path) {
	/* use file info from sha1 lookup */
	path = obj_context.path;
	mode = obj_context.mode;
  } else {
	/* use path requested by user, and assume it is a regular file */
	path = force_path;
	mode = 0100644;
  }

but I don't know if that is even worth a re-roll.

> >  +test_expect_success '----path=<path> complains without --textconv/--filters' '
> >  +	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
> >  +	test_must_fail git cat-file --path=hello.txt blob $sha1 >actual 2>err &&
> >  +	test ! -s actual &&
> >  +	grep "path.*needs.*filters" err
> >  +'
> 
> This will need to become test_i18ngrep once the error message is
> made translatable, but it is correct for now.  I personally think
> there is no need to check "actual" or "err", though---just running
> cat-file under test_must_fail should be sufficient.
> 
> Thanks, will queue.

The whole thing looks good to me, except for the weird doubled "--" in
the test description you quoted above. :)

-Peff
