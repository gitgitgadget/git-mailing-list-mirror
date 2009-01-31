From: Jeff King <peff@peff.net>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 16:55:14 -0500
Message-ID: <20090131215514.GB9415@coredump.intra.peff.net>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com> <20090131071238.GC3033@coredump.intra.peff.net> <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNpl-0002ZX-L7
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbZAaVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbZAaVzS
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:55:18 -0500
Received: from peff.net ([208.65.91.99]:34016 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbZAaVzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:55:17 -0500
Received: (qmail 14178 invoked by uid 107); 31 Jan 2009 21:55:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 16:55:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 16:55:14 -0500
Content-Disposition: inline
In-Reply-To: <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107950>

On Sat, Jan 31, 2009 at 01:08:16PM -0700, James Pickens wrote:

> Well, the clone gets the alternates either way.  It just doesn't
> use them to avoid copying the data unless I give -s.  More

The other key change is that you don't depend on the origin in your
alternates when you don't use "-s".

> So, is there any reason 'git clone' shouldn't automatically use
> the alternates that it copied into the new repository?  I might
> look into writing a patch if nobody objects.

I think the reason "-s" isn't the default is that alternates are fragile
(as Jakub mentioned), and we don't want ot set them up without the user
asking to do so.

So from what you've posted (but I haven't double checked or looked at
the code), it sounds like the current behavior is:

  - with "-s", add the origin as an alternate, and use alternates while
    cloning

  - "with --reference", add some other repo as an alternate, and use
    alternates while cloning

  - without either, copy alternates from origin, but _don't_ use
    alternates while cloning

The last one seems a little silly. Why bother setting up the alternates
if you're not going to use them? I guess because we might not be able to
get the objects at all, otherwise, and we need to know where to copy
them from. But either:

  - that is an implementation-specific detail of clone, and those
    alternates should go away after we clone

      or

  - we should fully respect those alternates

The only downside to the latter is that now somebody who has cloned a
repository with alternates now has an alternates-based repository and
might not know it (i.e., they might have been the one who set up
alternates in the origin).

-Peff
