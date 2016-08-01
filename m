Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4CC11F855
	for <e@80x24.org>; Mon,  1 Aug 2016 22:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbcHAWFu (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 18:05:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:52930 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752754AbcHAWFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 18:05:49 -0400
Received: (qmail 20145 invoked by uid 102); 1 Aug 2016 21:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:59:08 -0400
Received: (qmail 18742 invoked by uid 107); 1 Aug 2016 21:59:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:59:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 17:59:05 -0400
Date:	Mon, 1 Aug 2016 17:59:05 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 0/1 v2] add PAGER_ENV to build
Message-ID: <20160801215904.5oym63j3ewqyqugx@sigill.intra.peff.net>
References: <20160801010557.22191-1-e@80x24.org>
 <20160801214937.4752-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801214937.4752-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 09:49:36PM +0000, Eric Wong wrote:

> Changes from v1:
> 
> * dropped stringify macro in favor for quoting in Makefile
>   (diff below)
>   I'm not sure I like this change, and might be inclined to
>   go in the opposite direction of using the stringify macro
>   more widely to simplify the Makefile; but that is a separate
>   topic.

I think that's a dangerous direction. Try this:

-- >8 --
cat >foo.c <<\EOF
#include <stdio.h>

#define stringify_(x) #x
#define stringify(x) stringify_(x)

int main(void)
{
	printf("%s", stringify(FOO));
	return 0;
}
EOF

while read -r input; do
	gcc -Wall -Werror -DFOO="$input" foo.c
	./a.out
done
-- 8< --

and then try input like:

  this has          a lot of spaces
  this has a \backslash

You should see:

  this has a lot of spaces
  this has aackslash

I'll grant that backslashes and runs of whitespace are not things we'd
expect to find in most of our build-time config, but it still seems like
a bad direction to go (and actually, I wouldn't be surprised if
backslashes do end up in some of our build-time variables on Windows).

-Peff
