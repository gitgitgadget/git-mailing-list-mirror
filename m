From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Tue, 26 Aug 2014 08:34:27 -0400
Message-ID: <20140826123427.GD29180@peff.net>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
 <20140825194641.GS20185@google.com>
 <20140825200042.GJ30953@peff.net>
 <20140825204516.GT20185@google.com>
 <xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
 <20140825212705.GU20185@google.com>
 <xmqq4mx0kyrx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:34:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMFxJ-0004S8-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 14:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbaHZMe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 08:34:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:59161 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751006AbaHZMe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:34:28 -0400
Received: (qmail 16509 invoked by uid 102); 26 Aug 2014 12:34:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 07:34:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 08:34:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mx0kyrx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255895>

On Mon, Aug 25, 2014 at 03:08:50PM -0700, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> >> Wouldn't it be sufficient to start digging not from "*" but from
> >> "??*"?
> >
> > Gah, the * was supposed to be . in my examples (though it doesn't
> > hurt).
> >
> >> 	find ??* \( -name Documentation -o -name .\?\* \) -prune -o -name \*.h
> >
> > Heh.  Yeah, that would work. ;-)
> 
> Continuing useless discussion...
> 
> Actually as you are not excluding CVS, RCS, etc., and using ??* as
> the starting point will exclude .git, .hg, etc. at the top, I think
> we can shorten it even further and say
> 
> 	find ??* -name Documentation -prune -o -name \*.h
> 
> or something.

I had originally considered starting with "find *", but I was worried
about shell globbing overflowing command-line limits here. "echo *" on a
built tree is about 12K. That's laughably small for Linux, but would
other systems (which, after all, are the main targets) be more picky?

POSIX lists 4K as the minimum, and that has to fit the environment, too.

I'd also be fine to try it and see if anybody on an antique system
complains.

> Don't we want to exclude contrib/ by the way?

Probably. For calculating dependencies, it is OK to be overly
conservative (the worst case is that we trigger a recompile if somebody
touched contrib/.../foo.h, which is rather unlikely).

For the .pot file, being conservative is a little annoying.  In theory
we might want to translate stuff in contrib/, but it probably is just
extra work for translators for not much benefit (though I have not
really used gettext; I assume it only pulls in strings marked with _()
and friends, so being conservative is maybe not that big a deal...).

In that sense, maybe we should just hit the whole tree to be on the
conservative side. The two reasons I did not in my initial attempt were:

  1. Performance. But with the final form, we only the run the `find` at
     all very rarely, so shaving off a few readdirs() is not that big a
     deal.

  2. There are a few problematic areas. t/perf may contain build trees
     which are copies of git, which I expect would confuse gettext.

So I dunno.

-Peff
