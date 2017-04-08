Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7D71FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 10:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbdDHK7I (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 06:59:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:58474 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752254AbdDHK7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 06:59:06 -0400
Received: (qmail 7921 invoked by uid 109); 8 Apr 2017 10:59:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 10:59:03 +0000
Received: (qmail 10951 invoked by uid 111); 8 Apr 2017 10:59:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 06:59:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 06:59:01 -0400
Date:   Sat, 8 Apr 2017 06:59:01 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jo@durchholz.org
Subject: Re: [PATCH] submodule: prevent backslash expantion in submodule names
Message-ID: <20170408105901.2osi2zadboqxhf34@sigill.intra.peff.net>
References: <CAGZ79ka7PEWy2iA8V9s11n2kyD=vHyS2y1K3SJzDq-5HsY7how@mail.gmail.com>
 <20170407172306.172673-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170407172306.172673-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 10:23:06AM -0700, Brandon Williams wrote:

> When attempting to add a submodule with backslashes in its name 'git
> submodule' fails in a funny way.  We can see that some of the
> backslashes are expanded resulting in a bogus path:
> 
> git -C main submodule add ../sub\\with\\backslash
> fatal: repository '/tmp/test/sub\witackslash' does not exist
> fatal: clone of '/tmp/test/sub\witackslash' into submodule path
> 
> To solve this, convert calls to 'read' to 'read -r' in git-submodule.sh
> in order to prevent backslash expantion in submodule names.

This looks sane overall, without digging into the individual read calls.

The reason I mentioned escaping earlier is I wondered what would happen
when the submodule starts with a double-quote, or has a newline in the
name. Git's normal quoting would include backslash escape sequences, and
I wondered if we might be relying on any of these "read" calls to
interpret them. But I don't think so, for two reasons.

One, because that quoting also puts double-quotes around the name. So
plain "read" would not be sufficient to de-quote for us anyway.

And two, because these are being fed from "submodule--helper", which
does not seem to quote in the first place.

So I think your patch is fine there. But it does raise a few concerns.
It looks like git-submodule does not cope well with exotic filenames:

  $ git submodule add /some/repo "$(printf 'sub with\nnewline')"
  Cloning into '/home/peff/tmp/sub with
  newline'...
  done.
  error: invalid key (newline): submodule.sub with
  newline.url
  error: invalid key (newline): submodule.sub with
  newline.path
  Failed to register submodule 'sub with
  newline'

I'm not too worried about that. It's a nonsense request, and our config
format has no syntactic mechanism to represent that key. So tough luck.
But what I am more worried about is:

  $ git submodule--helper list
  160000 576053ed5ad378490974fabe97e4bd59633d2d1e 0	sub with
  newline

That's obviously nonsense that git-submodule.sh is going to choke on.
But what happens when the filename is:

  foo\n16000 <sha1> 0\t../../escaped

or something. Can a malicious repository provoke git-submodule.sh to
look at or modify files outside the repository?

-Peff
