From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files
Date: Thu, 21 Feb 2013 18:24:48 -0500
Message-ID: <20130221232448.GA23736@sigill.intra.peff.net>
References: <CAMB+bfKYLjmDavcLaO7scBPfTLmzqAmH+k9uBj0WJ+dzj9vuyA@mail.gmail.com>
 <20130221224319.GA19021@sigill.intra.peff.net>
 <CAMB+bf+whVFD03neCh-gBORXOBoNjgaCbfP_mh8HgDy6UqGFZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:25:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8fVr-0005RR-7s
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab3BUXYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:24:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56518 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab3BUXYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:24:50 -0500
Received: (qmail 32169 invoked by uid 107); 21 Feb 2013 23:26:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 18:26:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 18:24:48 -0500
Content-Disposition: inline
In-Reply-To: <CAMB+bf+whVFD03neCh-gBORXOBoNjgaCbfP_mh8HgDy6UqGFZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216806>

On Thu, Feb 21, 2013 at 03:18:40PM -0800, Joshua Clayton wrote:

> > By having the read and flush size be the same, it's much simpler.
> 
> My original bugfix did just read 1024, and write 1024. That works fine
> and, yes, is simpler.
> I changed it to be more similar to the original code in case there
> were performance reasons for doing it that way.
> That was the only reason I could think of for the design, and adding
> the $flushSize variable means that
> some motivated person could easily optimize it.
> 
> So far I have been too lazy to profile the two versions....
> I guess I'll try a trivial git svn init; git svn fetch and check back in.
> Its running now.

I doubt it will make much of a difference; we are already writing to a
perl filehandle, so it will be buffered there (which I assume is 4K, but
I haven't checked). And your version retains the 1024-byte read. I do
think 1024 is quite low for this sort of descriptor-to-descriptor
copying. I'd be tempted to just bump that 1024 to 64K.

> In git svn fetch (which is how I discovered it) the file being passed
> to cat_blob is a temporary file, which is checksummed before putting
> it into place.

Great. There may be other callers outside of our tree, of course, but I
think it's pretty clear that the responsibility is on the caller to make
sure the function succeeded. We are changing what gets put on the output
stream for various error conditions, but ultimately that is an
implementation detail that the caller should not be depending on.

-Peff
