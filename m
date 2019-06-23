Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8321F461
	for <e@80x24.org>; Mon, 24 Jun 2019 02:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfFXCms (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 22:42:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:48180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726510AbfFXCms (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 22:42:48 -0400
Received: (qmail 5063 invoked by uid 109); 23 Jun 2019 22:42:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 23 Jun 2019 22:42:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6202 invoked by uid 111); 23 Jun 2019 22:43:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 23 Jun 2019 18:43:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Jun 2019 18:42:45 -0400
Date:   Sun, 23 Jun 2019 18:42:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: 2.22.0 repack -a duplicating pack contents
Message-ID: <20190623224244.GB1100@sigill.intra.peff.net>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
 <20190623180825.3ospajjgat3clwiu@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190623180825.3ospajjgat3clwiu@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 23, 2019 at 06:08:25PM +0000, Eric Wong wrote:

> > I'm not sure of the right solution. For maximal backwards-compatibility,
> > the default for bitmaps could become "if not bare and if there are no
> > .keep files". But that would mean bitmaps sometimes not getting
> > generated because of the problems that ee34a2bead was trying to solve.
> > 
> > That's probably OK, though; you can always flip the bitmap config to
> > "true" yourself if you _must_ have bitmaps.
> 
> What about something like this?  Needs tests but I need to leave, now.

Yeah, I think that's the right direction.

Though...

> +static int has_pack_keep_file(void)
> +{
> +	DIR *dir;
> +	struct dirent *e;
> +	int found = 0;
> +
> +	if (!(dir = opendir(packdir)))
> +		return found;
> +
> +	while ((e = readdir(dir)) != NULL) {
> +		if (ends_with(e->d_name, ".keep")) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	closedir(dir);
> +	return found;
> +}

I think this can be replaced with just checking p->pack_keep for each
item in the packed_git list.

That's racy, but then so is your code here, since it's really the child
pack-objects which is going to deal with the .keep. I don't think we
need to care much about the race, though. Either:

  1. Somebody has made an old intentional .keep, which would not be
     racy. We'd see it in both places.

  2. Somebody _just_ made an intentional .keep; we'll race with that and
     maybe duplicate objects from the kept pack. But this is a rare
     occurrence, and there's no real ordering promise here anyway with
     somebody creating .keep files alongside a running repack.

  3. An incoming fetch/push may create a .keep file as a temporary lock,
     which we see here but which goes away by the time pack-objects
     runs. That's OK; we err on the side of not generating bitmaps, but
     they're an optimization anyway (and if you really insist on having
     them, you should tell Git to definitely make them instead of
     relying on this default behavior).

  4. Like (3), but we _don't _see the temporary .keep here but _do_ see
     it during pack-objects. That's OK, because we'll have told
     pack-objects to pack those objects anyway, which is the right
     thing.

-Peff
