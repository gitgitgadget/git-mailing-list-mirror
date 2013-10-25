From: Jeff King <peff@peff.net>
Subject: Re: [BUG] "git --literal-pathspecs blame" broken in master
Date: Fri, 25 Oct 2013 00:18:37 -0400
Message-ID: <20131025041837.GA17266@sigill.intra.peff.net>
References: <20131025034947.GA4959@sigill.intra.peff.net>
 <20131025040436.GA11810@sigill.intra.peff.net>
 <CACsJy8Aw9KyeWqgC5KQmqPrzD7J4Gga1ibDTvfNQFaVN303U9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZYrD-0006s6-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3JYESk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:18:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:55228 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751192Ab3JYESj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:18:39 -0400
Received: (qmail 30801 invoked by uid 102); 25 Oct 2013 04:18:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 23:18:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 00:18:37 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Aw9KyeWqgC5KQmqPrzD7J4Gga1ibDTvfNQFaVN303U9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236655>

On Fri, Oct 25, 2013 at 11:16:08AM +0700, Nguyen Thai Ngoc Duy wrote:

> > All of the GUARD_PATHSPEC calls indicate that everybody understands
> > PATHSPEC_LITERAL. It is not technically true that git-blame understands
> > the literal pathspec magic:
> >
> >   $ git blame -- ':(literal)revision.c'
> >   fatal: no such path ':(literal)revision.c' in HEAD
> >
> > but that is a separate bug (that blame considers the argument as a path
> > first before feeding it to the pathspec machinery). The patch above does
> > not fix that, but AFAICT it does not make anything worse.
> 
> I did consider this change but dropped it because there are more
> parse_pathspec() calls with PATHSPEC_ALL_MAGIC as mask. Thanks for
> bringing up ":(literal)".  I guess we need to change prefix_pathspec()
> to set PATHSPEC_LITERAL only when :(literal) is present, not when
> --literal-pathspecs is used.

I considered suggesting that, too, but it means that everywhere that
checks for PATHSPEC_LITERAL must _also_ check for literal_global (e.g.,
if they were deciding to feed the result to fnmatch). Whereas if we
catch it at the parse_pathspec layer, then the consumers of the pathspec
just need to check the one flag.

I dunno. I haven't kept up very well with your work in this area, so you
probably have a better sense than I do of what would be the most
elegant.

-Peff
