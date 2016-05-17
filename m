From: Jeff King <peff@peff.net>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Date: Tue, 17 May 2016 17:57:49 -0400
Message-ID: <20160517215749.GB16905@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org>
 <20160517194533.GA11289@sigill.intra.peff.net>
 <573B78CE.1080200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 17 23:57:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2n01-00085g-8o
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 23:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbcEQV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 17:57:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:40984 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbcEQV5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 17:57:52 -0400
Received: (qmail 16667 invoked by uid 102); 17 May 2016 21:57:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 17:57:51 -0400
Received: (qmail 18253 invoked by uid 107); 17 May 2016 21:57:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 17:57:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2016 17:57:49 -0400
Content-Disposition: inline
In-Reply-To: <573B78CE.1080200@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294917>

On Tue, May 17, 2016 at 10:02:22PM +0200, Johannes Sixt wrote:

> > Interesting. It replicates out of the box for me.
> 
> "Out of the box" are the magic words. I usually compile with -O0, which
> doesn't trigger the valgrind report.

Heh, I meant that Noam's test worked out of the box. I also build with
-O0. I was able to replicate with different optimization levels.

I think the interesting thing here is actually the libc (and therefore
possibly your valgrind version). I tried compiling with ASAN and get a
color value of "48830". But no ASAN warning!

I think what is happening is that we over-allocate the new_columns array
based on a power of 2, but only initialize up to num_new_columns. So the
off-by-one accesses heap memory that is allocated but which we have
never written to.

> When I compile with a 3.x based gcc on Windows, I see these warnings:
> 
>     CC color.o
> color.c: In function 'color_parse_mem':
> color.c:203: warning: 'c.value' may be used uninitialized in this function
> color.c:203: warning: 'c.blue' may be used uninitialized in this function
> color.c:203: warning: 'c.green' may be used uninitialized in this function
> color.c:203: warning: 'c.red' may be used uninitialized in this function
> 
> (which triggered my curiosity in this bug report). But they seem to be
> unrelated and are most likely false positives.

Yeah, I think that's unrelated. I'd be highly distrustful of
-Wuninitialized in gcc 3.x. We had to mark quite a few false positives
back then, that were later corrected in the 4.x series.

-Peff
