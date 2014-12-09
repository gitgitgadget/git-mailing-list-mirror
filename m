From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 15:15:51 -0500
Message-ID: <20141209201551.GA12001@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <20141206053024.GE31301@peff.net>
 <xmqq388omwzr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:16:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRCR-0001gC-3R
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbaLIUPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:15:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:50678 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751587AbaLIUPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:15:54 -0500
Received: (qmail 18630 invoked by uid 102); 9 Dec 2014 20:15:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 14:15:53 -0600
Received: (qmail 3541 invoked by uid 107); 9 Dec 2014 20:15:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 15:15:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 15:15:51 -0500
Content-Disposition: inline
In-Reply-To: <xmqq388omwzr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261153>

On Tue, Dec 09, 2014 at 11:41:44AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Also, I forgot to mention: if we consistently put the API docs into the
> > header files and extracted it automatically into standalone documents,
> > we would not need to have two places.
> >
> > This is something I've been meaning to look at for a long time, but it
> > never quite makes the priority list. And my past experiences with tools
> > like doxygen has been that they are complicated and have a lot of
> > dependencies. It's been a long time since I've tried, though.
> 
> Yeah, that is a thought.
> 
> Some existing documentation pages like allocation-growing may not be
> a good match for this strategy, though; cache.h has a lot more than
> just alloc-grow, and there needs to be a way to generate more than
> one API docs from a single header (and vice versa, taking text from
> more than one source for a single API, I suspect).

I think that would be a matter of tool support for saying "now I am
outputting api-foo" in the inline documentation[1]. It does make writing
Makefiles a lot harder, though, if there isn't a one-to-one
correspondence between targets and their sources. Perhaps it is a sign
that we should split our include files more along functional boundaries.
If we cannot make sane documentation out of the file, then it is
probably confusing for humans to read it.

Opening cache.h shows it starting with git_{in,de}flate_*, and then
DEFAULT_GIT_PORT!? It has long been a dumping ground for random global
functions and definitions. If we are going to document subsystems,
splitting them into their own files seems sensible. Skimming through the
file, some of the splits seem pretty easy and obvious.

-Peff

[1] I do not have a tool in mind, so this is something to think about
    while evaluating them. It seems like just parsing:

    /**
     * All of this will get dumped in a file (sans asterisks),
     * which can then be fed to asciidoc. The "**" marker
     * starts the docstring, which ends at the normal comment
     * boundary.
     */

    would be an easy place to start, and by implementing it ourselves
    with sed we would be free to implement any other rules we wanted.
    That is probably too naive, though. It would be nice if the tool
    actually understood C function declarations, so that we would not
    have to repeat them manually in the comments.

    I guess all tools like doxygen probably started off as "just pull
    out and format the comments", and then grew and grew in complexity. :)
