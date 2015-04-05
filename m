From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] strbuf_getwholeline: use getc_unlocked
Date: Sun, 5 Apr 2015 14:24:02 -0400
Message-ID: <20150405182401.GA13096@peff.net>
References: <20150405010611.GA15901@peff.net>
 <20150405011110.GC30127@peff.net>
 <20150405045614.GA12053@peff.net>
 <CACsJy8Biv6D2foDxpn-CZhEsjn3WsPV=_A3UOnT4+1LVrpRnTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 20:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YepDT-0005N7-27
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 20:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbbDESYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 14:24:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:42661 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752528AbbDESYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 14:24:05 -0400
Received: (qmail 23252 invoked by uid 102); 5 Apr 2015 18:24:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 13:24:05 -0500
Received: (qmail 6278 invoked by uid 107); 5 Apr 2015 18:24:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 14:24:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2015 14:24:02 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Biv6D2foDxpn-CZhEsjn3WsPV=_A3UOnT4+1LVrpRnTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266811>

On Sun, Apr 05, 2015 at 09:36:04PM +0700, Duy Nguyen wrote:

> On Sun, Apr 5, 2015 at 11:56 AM, Jeff King <peff@peff.net> wrote:
> > So we'd have to either:
> >
> >   1. Decide that doesn't matter.
> >
> >   2. Have callers specify a "damn the NULs, I want it fast" flag.
> 
> 2+. Avoid FILE* interface and go with syscalls for reading
> packed-refs? If mmaping the entire file could be a problem for some
> platform because it's too large, we have code for reading (with
> bufferring) from fd somewhere, e.g. index-pack.

There's strbuf_getwholeline_fd, but it's horrifically inefficient (one
syscall per character). But the other option is to implement your own
buffering, and we're generally better off letting stdio do that for us
(the exception here is that stdio does not have a good NUL-safe "read
until X" function).

-Peff
