Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A7B201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdEOWJp (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:09:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:52194 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbdEOWJo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:09:44 -0400
Received: (qmail 29895 invoked by uid 109); 15 May 2017 22:09:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 22:09:42 +0000
Received: (qmail 21915 invoked by uid 111); 15 May 2017 22:10:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 18:10:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 18:09:39 -0400
Date:   Mon, 15 May 2017 18:09:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Marc Stevens <marc@marc-stevens.nl>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Kebe <michael.kebe@gmail.com>
Subject: Re: Git 2.13.0 segfaults on Solaris SPARC due to DC_SHA1=YesPlease
 being on by default
Message-ID: <20170515220939.vkgofpkdtpz7u26v@sigill.intra.peff.net>
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
 <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl>
 <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 04:13:58PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Mon, May 15, 2017 at 3:58 PM, Marc Stevens <marc@marc-stevens.nl> wrote:
> > Hi Aevar,
> >
> > Thank you for notifying us of this issue.
> > Big endianness is a tricky issue, also since I don't have access or accurate knowledge about all big endian systems.
> > Our github repo does check correct functioning, including an endianness mistake, with 'make test'.
> > But I guess this is not included for SHA1DC in Git.
> >
> > Anyway, we can easily add the _BIG_ENDIAN macrotest to the git repo and will do so soon.
> >
> > I don't think the segfault is caused by buffer overflow, inproper access, or the endianness issue.
> > But I did notice an unexpected issue: the message block pointer m=0x398ad5 is odd.
> > Can you confirm whether loading an uint32_t from an odd address triggers a hardware interrupt on your platform?
> > This is not problem for x86, but maybe for your platform it is?
> > If it is then we should always copy buffer contents to the sha1context to avoid this issue.
> 
> I don't have access to the box in question, Michael was testing this
> code for me. But unaligned access is probably the cause, although
> according to some info I found online that should give a SIGBUS not a
> SIGSEGV, but that may have changed:

Yeah, I would have expected SIGBUS there. If we have alignment issues,
though, I'd expect that ARM systems will experience problems.

Block-sha1 uses a macro which allows unaligned loads on platforms that
support it, and otherwise does the endian conversion on the fly as we
load the bytes into a local variable (which presumably happens all
in-register). That may be faster than doing a mass copy of the buffer.

-Peff
