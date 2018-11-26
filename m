Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34EFB1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 16:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeK0Dhc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 22:37:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:51142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726203AbeK0Dhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 22:37:32 -0500
Received: (qmail 9074 invoked by uid 109); 26 Nov 2018 16:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Nov 2018 16:42:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13684 invoked by uid 111); 26 Nov 2018 16:42:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Nov 2018 11:42:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Nov 2018 11:42:52 -0500
Date:   Mon, 26 Nov 2018 11:42:52 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com
Subject: Re: t5570 shaky for anyone ?
Message-ID: <20181126164252.GA27711@sigill.intra.peff.net>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
 <20181125220138.GK4883@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181125220138.GK4883@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 25, 2018 at 10:01:38PM +0000, Thomas Gummerer wrote:

> On 11/25, Torsten Bögershausen wrote:
> > After running the  "Git 2.20-rc1" testsuite here on a raspi,
> > the only TC that failed was t5570.
> > When the "grep" was run on daemon.log, the file was empty (?).
> > When inspecting it later, it was filled, and grep would have found
> > the "extended.attribute" it was looking for.
> 
> I believe this has been reported before in
> https://public-inbox.org/git/1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com/,
> but it seems like the thread never ended with actually fixing it.
> Reading the first reply Peff seemed to be fine with just removing the
> test completely, which would be the easiest solution ;)  Adding him to
> Cc: here.

Yes, I don't think there is a way to make this race-proof without
somehow convincing "cat" to flush (and let us know when it has). Which
really implies killing the daemon, and wait()ing on cat to process the
EOF and exit.  And that makes the tests a lot more expensive if we have
to start the daemon for each snippet.

So I'm still fine with just dropping this test.

> > diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> > index 7466aad111..e259fee0ed 100755
> > --- a/t/t5570-git-daemon.sh
> > +++ b/t/t5570-git-daemon.sh
> > @@ -192,6 +192,7 @@ test_expect_success 'daemon log records all attributes' '
> >  	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
> >  		git -c protocol.version=1 \
> >  			ls-remote "$GIT_DAEMON_URL/interp.git" &&
> > +	sleep 1 &&
> >  	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
> >  	test_cmp expect actual
> >  '
> > ----------------
> > A slightly better approach may be to use a "sleep on demand":
> > 
> > +	( grep -i -q extended.attribute daemon.log || sleep 1 ) &&

That doesn't really fix it, but just broadens the race window. I dunno.
Maybe that is enough in practice. We could do something like:

  repeat_with_timeout () {
	local i=0
	while test $i -lt 10
	do
		"$@" && return 0
		sleep 1
	done
	# no success even after 10 seconds
	return 1
  }

  repeat_with_timeout grep -i extended.attribute daemon.log

to make the pattern a bit more obvious (and make it easy to extend the
window arbitrarily; surely 10s is enough?).

-Peff
