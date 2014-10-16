From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] fsck: do not canonicalize modes in trees we are
 checking
Date: Wed, 15 Oct 2014 20:20:21 -0400
Message-ID: <20141016002021.GA27509@peff.net>
References: <20140923154751.GA19319@peff.net>
 <20140923162343.GA20379@debian>
 <20140923163008.GA21591@peff.net>
 <543B02A7.9040807@optusnet.com.au>
 <20141014082120.GA16686@peff.net>
 <543F074B.2050907@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Ben Aveling <bena.001@optusnet.com.au>
X-From: git-owner@vger.kernel.org Thu Oct 16 02:20:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeYnw-0007UZ-0k
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 02:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbaJPAUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 20:20:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59073 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751251AbaJPAUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 20:20:23 -0400
Received: (qmail 6714 invoked by uid 102); 16 Oct 2014 00:20:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 19:20:23 -0500
Received: (qmail 28849 invoked by uid 107); 16 Oct 2014 00:20:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 20:20:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 20:20:21 -0400
Content-Disposition: inline
In-Reply-To: <543F074B.2050907@optusnet.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 10:46:19AM +1100, Ben Aveling wrote:

> On 14/10/2014 19:21, Jeff King wrote:
> >On Mon, Oct 13, 2014 at 09:37:27AM +1100, Ben Aveling wrote:
> >>A question about fsck - is there a reason it doesn't have an option to
> >>delete bad objects?
> >If the objects are reachable, then deleting them would create other big
> >problems (i.e., we would be breaking the object graph!).
> 
> The man page for fsck advises:
> 
>    "Any corrupt objects you will have to find in backups or other
>    archives (i.e., you can just remove them and do an /rsync/ with some
>    other site in the hopes that somebody else has the object you have
>    corrupted)."

I think there are really two different types of corruption worth
considering here.

One is where the data bytes of the object were correct at one point, but
now aren't anymore. The sha1 does not check out, and the object is
broken. You need to go find another copy of the object somewhere else.

The other is where the object was malformed in the first place,
generally due to a software bug (e.g., syntactically bogus email
addresses on committer lines, trees that are not sorted properly, etc).
There is no point in finding another object, as any you find will be
byte-for-byte identical.

For this second type (which is what I thought we were talking about in
this thread), deleting the object would be Very Bad.

For the first type, deleting the object _could_ be a path forward. But
it's not the usual method for fixing corruption. If you copy a good
version of the object into the repository, then a subsequent repack
should throw away the broken copy in favor of the good one. Note that
you need to copy the objects in manually; you can't use the git protocol
to do so. But that is true whether you have the broken object or not
(because git does not communicate with the other side about _every_
object you have; it talks about commits, and assumes that you have the
rest of the object graph that a commit refers to).

So I don't think deleting really helps in that case. And it may hurt if
it later turns out you don't have another copy of the object and need to
recover what you can from the corrupted pieces (which has actually
happened before).

> I ask because I have a corrupt repository, and every time I run fsck, it
> reports one corrupt object, then stops.

Corrupt how? Bit-corruption, or a malformed object?

> I could write a script to repeatedly call fsck and then remove the
> next corrupt object, but it raises the question for me; could it make
> sense to extend fsck with the option to do to the removes? Or even
> better, do the removes and then do the necessary [r]sync, assuming the
> user has another repository that has a good copy of the bad objects,
> which in this case I do.

If you have a non-corrupted version of the repository, the simplest
thing is to just pack it, copy the resulting packfile to the broken
repository (again, using "cp" or "rsync" and not git), and then repack
there. That won't transfer the minimum amount of data, but it's simple
and only requires one round-trip (bearing in mind that git doesn't know
what out-of-band method you're using, nor whether we can even initiate a
request from the broken repo to the good one, so each round trip
generally does need to be done by hand).

-Peff
