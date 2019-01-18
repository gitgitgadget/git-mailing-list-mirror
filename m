Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6371F453
	for <e@80x24.org>; Fri, 18 Jan 2019 16:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfARQ6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 11:58:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:41068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727491AbfARQ6D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 11:58:03 -0500
Received: (qmail 7846 invoked by uid 109); 18 Jan 2019 16:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Jan 2019 16:58:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12091 invoked by uid 111); 18 Jan 2019 16:58:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 Jan 2019 11:58:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2019 11:58:01 -0500
Date:   Fri, 18 Jan 2019 11:58:01 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>
Cc:     Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: Change on check-attr behavior
Message-ID: <20190118165800.GA9956@sigill.intra.peff.net>
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net>
 <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 09:41:03AM +0000, Sérgio Peixoto wrote:

> Create a file  .git/info/attributes with contents
> 
> If the contents are:
> [attr]allowed-ext
> *.py allowed-ext=100
> 
> then the problem occurs.
> 
> If contents are:
> #[attr]allowed-ext
> *.py allowed-ext=100
> 
> the problem is gone

Ah, thanks, that's the secret sauce: it only affects macros.

I don't know how representative that attributes file is of your real
repo, but there's possibly one immediate workaround: there's no need for
the [attr] line here. You are free to define your own attributes, and
only need "[attr]" if you're defining a macro that expands to other
attributes.

Now, on to the actual bug. The simplest reproduction is:

  (echo "[attr]foo bar"; echo "* foo") >.gitattributes
  git check-attr foo file

which should report "foo" as set. This bisects to 60a12722ac (attr:
remove maybe-real, maybe-macro from git_attr, 2017-01-27), and it seems
like an unintentional regression there. I haven't yet poked into that
commit to see what the fix will look like.

-Peff
