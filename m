Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB7F1FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 09:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168151AbdDXJrC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 05:47:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:38925 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168141AbdDXJrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 05:47:00 -0400
Received: (qmail 18279 invoked by uid 109); 24 Apr 2017 09:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 09:46:56 +0000
Received: (qmail 4851 invoked by uid 111); 24 Apr 2017 09:47:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 05:47:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 05:46:54 -0400
Date:   Mon, 24 Apr 2017 05:46:54 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
Message-ID: <20170424094654.eucylyv7k2l332jw@sigill.intra.peff.net>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
 <20170420165230.5951-1-szeder.dev@gmail.com>
 <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
 <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
 <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
 <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
 <xmqq60hu1mhq.fsf@gitster.mtv.corp.google.com>
 <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net>
 <18ee407c-db3b-16a2-4822-0ff302045b27@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ee407c-db3b-16a2-4822-0ff302045b27@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 11:39:26AM +0200, Torsten Bögershausen wrote:

> []
> > > 
> > > -		cd "$(dirname "$remove_trash")" &&
> > > -		rm -rf "$(basename "$remove_trash")" ||
> > > -		error "Tests passed but test cleanup failed; aborting"
> > > +			cd "$(dirname "$TRASH_DIRECTORY")" &&
> > > +			rm -fr "$TRASH_DIRECTORY" ||
> > > +			error "Tests passed but test cleanup failed; aborting"
> > > +		fi
> > 
> > Yeah, that looks good to me.
> 
> Does it ?
> Checking the error code of "rm -f" doesn't work as expected from the script:
> rm -rf DoesNotExist ; echo $?
> 0

ENOENT is treated specially by "rm -f". We cover that case explicitly
with the "test -d" above (in the bit you didn't quote), and then rely on
"rm" to report other errors.  Like:

  $ rm -rf /etc/passwd ; echo $?
  rm: cannot remove '/etc/passwd': Permission denied
  1

> I think it should be
> 
> > > +			cd "$(dirname "$TRASH_DIRECTORY")" &&
> > > +			rm -r "$TRASH_DIRECTORY" ||
> > > +			error "Tests passed but test cleanup failed; aborting"

I think we need the "-f" to overcome rm's tendency to prompt in some
cases:

  $ echo content >foo
  $ chmod 0 foo
  $ rm foo
  rm: remove write-protected regular file 'foo'? ^C
  $ rm -f foo
  [no output; it just works]

-Peff
