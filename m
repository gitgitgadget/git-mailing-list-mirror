From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/67] add reentrant variants of sha1_to_hex and
 find_unique_abbrev
Date: Tue, 15 Sep 2015 13:50:27 -0400
Message-ID: <20150915175027.GA31091@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152629.GH29753@sigill.intra.peff.net>
 <55F84D9B.90004@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 19:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbuNG-0001Yp-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 19:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbbIORub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 13:50:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59521 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751601AbbIORua (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 13:50:30 -0400
Received: (qmail 20002 invoked by uid 102); 15 Sep 2015 17:50:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:50:29 -0500
Received: (qmail 8529 invoked by uid 107); 15 Sep 2015 17:50:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 13:50:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 13:50:27 -0400
Content-Disposition: inline
In-Reply-To: <55F84D9B.90004@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277974>

On Tue, Sep 15, 2015 at 05:55:55PM +0100, Ramsay Jones wrote:

> On 15/09/15 16:26, Jeff King wrote:
> > The sha1_to_hex and find_unique_abbrev functions always
> > write into reusable static buffers. There are a few problems
> > with this:
> >
> >   - future calls overwrite our result. This is especially
> >     annoying with find_unique_abbrev, which does not have a
> >     ring of buffers, so you cannot even printf() a result
> >     that has two abbreviated sha1s.
> >
> >   - if you want to put the result into another buffer, we
> >     often strcpy, which looks suspicious when auditing for
> >     overflows.
> >
> > This patch introduces sha1_to_hex_to and find_unique_abbrev_to,
> > which write into a user-provided buffer. Of course this is
> > just punting on the overflow-auditing, as the buffer
> > obviously needs to be GIT_SHA1_HEXSZ + 1 bytes. But it is
> > much easier to audit, since that is a well-known size.
> 
> Hmm, I haven't read any other patches yet (including those which use these
> new '_to' functions), but I can't help feeling they should be named something
> like 'sha1_to_hex_str()' and 'find_unique_abbrev_str()' instead.  i.e. I don't get
> the '_to' thing - not that I'm any good at naming things ...

I meant it as a contrast with their original. sha1_to_hex() formats into
an internal buffer and returns it. But sha1_to_hex_to() formats "to" a
buffer of your choice.

I'm happy to switch the names to something else, but I don't think
_str() conveys the difference. If I were starting from scratch, I would
probably have just called my variant sha1_to_hex(), and called the
original sha1_to_hex_unsafe(). :)

-Peff
