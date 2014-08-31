From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Sun, 31 Aug 2014 11:24:38 -0400
Message-ID: <20140831152437.GB17449@peff.net>
References: <20140829205538.GD29456@peff.net>
 <20140829205809.GB7060@peff.net>
 <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com>
 <20140829220818.GA24834@peff.net>
 <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com>
 <20140830131649.GA26833@peff.net>
 <CAJo=hJu-DCMv=jepMJvcmR9EOedkynCyL0kD_hB+UGWxbErDfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 17:24:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO6zo-0005v5-Np
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 17:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbaHaPYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 11:24:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:41891 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751235AbaHaPYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 11:24:39 -0400
Received: (qmail 16013 invoked by uid 102); 31 Aug 2014 15:24:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Aug 2014 10:24:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:24:38 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJu-DCMv=jepMJvcmR9EOedkynCyL0kD_hB+UGWxbErDfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256289>

On Sat, Aug 30, 2014 at 06:10:33PM -0700, Shawn Pearce wrote:

> > We do detect and complain if --strict is given. Should we make it the
> > default instead? I think it is still worthwhile to have a mode that can
> > handle these packs. It may be the only reasonable way to recover the
> > data from such a broken pack (and that broken pack may be the only copy
> > of the data you have, if you are stuck getting it out of a broken
> > implementation on a remote server).
> 
> Eh, OK, that does make a lot of sense.
> 
> Unfortunately accepting it by default encourages broken
> implementations to stay broken and ship packs with duplicate objects,
> which they shouldn't do since there are readers out there that cannot
> handle it.

I was pretty much convinced by this line of reasoning after you reading
your message. But after discovering some horrible side effects that I
just posted elsewhere, I think it's a no-brainer.

> In my opinion we should make --strict default, but its an excellent
> point made that users should have an escape hatch to disable this
> check, attempt accepting a broken pack and try fixing it locally with
> repack.

I am not sure if you meant it this way, but --strict controls a lot more
than just duplicate objects. It also runs fsck checks against the
incoming objects. Turning all of that on is a much bigger change than I
think we've been talking about.

But it's one I think we should consider. We've had --strict on at GitHub
for a few years, and it has caught many problems. Frequently we get
push-back from users saying "but nowhere else I pushed this to
complains". My opinion is that it is not that we are wrong for being
picky, but that other servers are not being picky enough.

It's also a bit of a hassle, though. E.g., a lot of projects have broken
ident lines deep in their history (from old versions of git, or other
broken implementations) and it is often way too late to fix them. We
usually try to get people to rewrite the history if it's not a problem,
but otherwise will lift the restrictions temporarily to let them push up
old history.

Broken ident lines are annoying, but not _too_ fundamentally bad.
Duplicate tree entries are a lot worse. Fsck even distinguishes between
"error" and "warning", but "index-pack --strict" treats both as a reason
to reject the object. We could perhaps loosen that, and make sure our
error/warning categories are reasonable.

-Peff
