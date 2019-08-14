Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461571F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 12:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfHNMKr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 08:10:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:43158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726263AbfHNMKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 08:10:47 -0400
Received: (qmail 14155 invoked by uid 109); 14 Aug 2019 12:10:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Aug 2019 12:10:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15442 invoked by uid 111); 14 Aug 2019 12:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2019 08:11:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Aug 2019 08:10:46 -0400
From:   Jeff King <peff@peff.net>
To:     Bo Zhang <zhangbodut@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Potential asterisk expansion bug in Windows Git Bash?
Message-ID: <20190814121045.GA30302@sigill.intra.peff.net>
References: <CAO=KXnspgZa=R9=8wvPY-Y8pvuAah-D+Jc4CM_+cdemYGUJ09A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO=KXnspgZa=R9=8wvPY-Y8pvuAah-D+Jc4CM_+cdemYGUJ09A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 14, 2019 at 07:50:47PM +0800, Bo Zhang wrote:

> Today I noticed that on Windows Git Bash, the asterisk (*) is
> incorrectly expanded even when it’s in a quote or following a
> backslash (\). I’m wondering if this is the correct behaviour (which
> seems like to me NOT).
> 
> Step to reproduce (in Windows git bash):
> 
> zhb@zhb-PC MINGW64 ~/Desktop
> $ bash --version
> GNU bash, version 4.4.19(2)-release (x86_64-pc-msys)
> Copyright (C) 2016 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> 
> This is free software; you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> 
> zhb@zhb-PC MINGW64 ~/Desktop
> $ cat 1.sh
> echo $1

Your script doesn't quote "$1", so whatever you pass in will be subject
to wildcard expansion inside the shell running the script.

Try this:

  $ cat bad.sh
  echo $1
  $ cat good.sh
  echo "$1"

  $ bash bad.sh '*'
  bad.sh good.sh

  $ bash good.sh '*'
  *

> zhb@zhb-PC MINGW64 ~/Desktop
> $ bash 1.sh '*'
> $A 1.sh 1.txt

So this is the case I showed above.

> zhb@zhb-PC MINGW64 ~/Desktop
> $ bash 1.sh "*"
> $A 1.sh 1.txt

And this is equivalent. The quotes suppress wildcard expansion in your
interactive shell, but the script itself does another round of
expansion.

> zhb@zhb-PC MINGW64 ~/Desktop
> $ bash 1.sh \*
> 1.sh 1.txt

And same here.

-Peff
