From: Jeff King <peff@peff.net>
Subject: Re: Zero padded file modes...
Date: Thu, 5 Sep 2013 11:36:46 -0400
Message-ID: <20130905153646.GA12372@sigill.intra.peff.net>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 17:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHbc6-0003pL-GL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 17:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab3IEPgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 11:36:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:46746 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705Ab3IEPgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 11:36:49 -0400
Received: (qmail 19594 invoked by uid 102); 5 Sep 2013 15:36:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Sep 2013 10:36:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Sep 2013 11:36:46 -0400
Content-Disposition: inline
In-Reply-To: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233963>

On Thu, Sep 05, 2013 at 10:00:39AM -0400, John Szakmeister wrote:

> I went to clone a repository from GitHub today and discovered
> something interesting:
> 
>     :: git clone https://github.com/liebke/incanter.git
>     Cloning into 'incanter'...
>     remote: Counting objects: 10457, done.
>     remote: Compressing objects: 100% (3018/3018), done.
>     error: object 4946e1ba09ba5655202a7a5d81ae106b08411061:contains
> zero-padded file modes
>     fatal: Error in object
>     fatal: index-pack failed

Yep. These were mostly caused by a bug in Grit that is long-fixed.  But
the objects remain in many histories. It would have painful to rewrite
them back then, and it would be even more painful now.

> > This is going to screw up pack v4 (yes, someday I'll have the
> > time to make it real).
> 
> I don't know if this is still true, but given that patches are
> being sent out about it, I thought it relevant.

I haven't looked carefully at the pack v4 patches yet, but I suspect
that yes, it's still a problem. The premise of pack v4 is that we can do
better by not storing the raw git object bytes, but rather storing
specialized representations of the various components. For example, by
using an integer to store the mode rather than the ascii representation.
But that representation does not represent the "oops, I have a 0-padded
mode" quirk. And we have to be able to recover the original object, byte
for byte, from the v4 representation (to verify sha1, or to generate a
loose object or v2 pack).

There are basically two solutions:

  1. Add a single-bit flag for "I am 0-padded in the real data". We
     could probably even squeeze it into the same integer.

  2. Have a "classic" section of the pack that stores the raw object
     bytes. For objects which do not match our expectations, store them
     raw instead of in v4 format. They will not get the benefit of v4
     optimizations, but if they are the minority of objects, that will
     only end up with a slight slow-down.

As I said, I have not looked carefully at the v4 patches, so maybe they
handle this case already. But of the two solutions, I prefer (2). Doing
(1) can solve _this_ problem, but it complicates the format, and does
nothing for any future compatibility issues. Whereas (2) is easy to
implement, since it is basically just pack v2 (and implementations would
need a pack v2 reader anyway).

-Peff
