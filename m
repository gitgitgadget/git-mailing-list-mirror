From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] Accept object data in the fsck_object() function
Date: Fri, 29 Aug 2014 19:10:34 -0400
Message-ID: <20140829231034.GD24834@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646400.990@s15462909.onlinehome-server.info>
 <xmqqvbpc8hon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 01:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNVJX-0008SV-Lt
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 01:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbaH2XKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 19:10:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:33485 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaH2XKf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 19:10:35 -0400
Received: (qmail 11731 invoked by uid 102); 29 Aug 2014 23:10:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 18:10:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 19:10:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbpc8hon.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256202>

On Thu, Aug 28, 2014 at 01:47:52PM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When fsck'ing an incoming pack, we need to fsck objects that cannot be
> > read via read_sha1_file() because they are not local yet (and might even
> > be rejected if transfer.fsckobjects is set to 'true').
> >
> > For commits, there is a hack in place: we basically cache commit
> > objects' buffers anyway, but the same is not true, say, for tag objects.
> >
> > By refactoring fsck_object() to take the object buffer and size as
> > optional arguments -- optional, because we still fall back to the
> > previous method to look at the cached commit objects if the caller
> > passes NULL -- we prepare the machinery for the upcoming handling of tag
> > objects.
> >
> > The assumption that such buffers are inherently NUL terminated is now
> > wrong, of course, hence we pass the size of the buffer so that we can
> > add a sanity check later, to prevent running past the end of the buffer.
> 
> A nice side effect may be that we can now check (and perhaps warn) a
> commit buffer with a NUL inside, perhaps?   I am not suggesting to
> add such a check to this series, but mentioning the possibilty here
> may have a merit.

I think that is a good check to add at some point. I demonstrated quite
a while ago that you can get up to some mischief by "hiding" bytes after
a NUL in the commit message. If we ever see feasible collision attacks
against sha1, this is going to be an obvious vector for hiding random
bytes to achieve the collisions.

The downside is that git's data model in theory promises to store
arbitrary bytes in people's commit messages. IMHO we have gotten far
enough from that in practice that I do not think anybody is seriously
doing it (you could not really use most of the history inspection tools
in a reasonable way; you would have to write a parallel set of tools
that never shows log messages, and then extracts and does something
separate with the commit content).

-Peff
