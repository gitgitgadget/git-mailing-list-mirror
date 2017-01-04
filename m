Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314F02092F
	for <e@80x24.org>; Wed,  4 Jan 2017 01:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbdADBNq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:13:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:34901 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751552AbdADBNq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:13:46 -0500
Received: (qmail 12363 invoked by uid 109); 4 Jan 2017 01:13:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 01:13:46 +0000
Received: (qmail 28376 invoked by uid 111); 4 Jan 2017 01:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Jan 2017 20:14:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2017 20:13:43 -0500
Date:   Tue, 3 Jan 2017 20:13:43 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d
 git_exec_path()
Message-ID: <20170104011343.oq374uffgiltqzeo@sigill.intra.peff.net>
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
 <cover.1483373635.git.johannes.schindelin@gmx.de>
 <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
 <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 12:11:25PM -0800, Stefan Beller wrote:

> On Mon, Jan 2, 2017 at 8:22 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > Technically, it is correct that git_exec_path() returns a possibly
> > malloc()ed string. Practically, it is *sometimes* not malloc()ed. So
> > let's just use a static variable to make it a singleton. That'll shut
> > Coverity up, hopefully.
> 
> I picked up this patch and applied it to the coverity branch
> that I maintain at github/stefanbeller/git.
> 
> I'd love to see this patch upstream as it reduces my maintenance
> burden of the coverity branch by a patch.

There is another lurking issue in that function, which is that the
return value of getenv() is not guaranteed to last beyond more calls to
getenv() or setenv(). It should probably xstrdup() that result, too.

At that point 2 out of 3 of the return cases would be malloc'd strings,
so we _could_ switch the third and say "caller must free the result".
But I think I prefer something like Dscho's solution (more on that
below).

> Early on when Git was new to coverity, some arguments were made
> that patches like these only clutter the main code base which is read
> by a lot of people, hence we want these quirks for coverity not upstream.
> And I think that still holds.
> 
> If this patch is only to appease coverity (as the commit message eludes
> to) I think this may be a bad idea for upstream.  If this patch fixes an
> actual problem, then the commit message needs to spell that out.

This is a real leak, though in all cases the program typically exits
soon afterwards. But we leak from list_commands(), for example, and it
is not immediately obvious that this is only called right before
exiting.

But I think more important is that caching the result in a static
variable communicates something (both to Coverity and to a reader of the
code). This is a value we expect to live through the life of the
program, and it is OK for it to "leak" when it goes out of scope by the
program exiting.

So even though the behavior does not really change, the annotation has
value.

-Peff
