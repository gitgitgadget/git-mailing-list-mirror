Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3880D1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757876AbcIHIAk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 04:00:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:40014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757862AbcIHIAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 04:00:38 -0400
Received: (qmail 2523 invoked by uid 109); 8 Sep 2016 08:00:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 08:00:37 +0000
Received: (qmail 12899 invoked by uid 111); 8 Sep 2016 08:00:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 04:00:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 04:00:35 -0400
Date:   Thu, 8 Sep 2016 04:00:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
Message-ID: <20160908080035.czwn5y3re5bp5vkg@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
 <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609061521410.129229@virtualbox>
 <20160906182942.s2mlge2vg65f5sy4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609080921030.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609080921030.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 09:29:58AM +0200, Johannes Schindelin wrote:

> sorry for the late answer, I was really busy trying to come up with a new
> and improved version of the patch series, and while hunting a bug I
> introduced got bogged down with other tasks.

No problem. I am not in a hurry.

> > I always assumed the _point_ of re_search taking a ptr/len pair was
> > exactly to handle this case. The documentation[1] says:
> > 
> >    `string` is the string you want to match; it can contain newline and
> >    null characters. `size` is the length of that string.
> > 
> > Which seems pretty definitive to me (that's for re_match(), but
> > re_search() is defined in the docs in terms of re_match()).
> 
> Right. The problem is: I *really* want to avoid using GNU-isms.

I don't think GNU-isms are a problem if we wrap them to give a nice
interface, and if we rely on having compat/regex. But if you mean "I do
not want to rely on using compat/regex everywhere", then OK. I can see
arguments both for and against using a consistent regex library, but I
do not care that much either way myself.

> > We can contain this to the existing compat/regexec/regexec.c, and just
> > provide a wrapper that is similar to regexec but takes a ptr/len pair.
> 
> But we can do even better than that: we can provide a wrapper that uses
> REG_STARTEND where available (which is really the majority of platforms we
> care about: Linux, MacOSX, Windows, and even the *BSDs). Where it is not
> available, we simply malloc(), memcpy() and append a NUL.

Doesn't that make things much _worse_ for people on systems without
REG_STARTEND? If we imagine that most regexec calls would operate on a
NUL-terminated buffer, then they are now paying the extra malloc and
copy for each call to regexec_buf(), even if the buffer was already
NUL-terminated (because they have no idea whether it was or not).

I think I'd rather just have:

  #ifndef REG_STARTEND
  #error "Your regex library sucks. Compile with NO_REGEX=NeedsStartEnd"
  #endif

(or you could just use REG_STARTEND and let the compiler complain, but
then the user has to figure out the right knob to twiddle).


One other question about REG_STARTEND is: what does it do with NULs
inside the buffer? Certainly glibc (and our compat/regex) treat it as a
buffer with a particular length and ignore embedded NULs, as we want.
But the NetBSD documentation says only:

     REG_STARTEND   The string is considered to start at string +
		    pmatch[0].rm_so and to have a terminating NUL
		    located at string + pmatch[0].rm_eo (there need not
		    actually be a NUL at that location), 

Besides avoiding a segfault, one of the benefits of regcomp_buf() is
that we will now find pickaxe-regex strings inside mixed binary/text
files. But it's not clear to me that NetBSD's implementation does this.

I guess we can assume it is fine (it is certainly no _worse_ than the
current behavior), and if people's platforms do not handle it, they can
build with NO_REGEX.

-Peff
