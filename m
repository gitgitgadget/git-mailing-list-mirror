From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Fix possible buffer overflow in remove_subtree()
Date: Thu, 13 Mar 2014 09:44:09 -0400
Message-ID: <20140313134409.GA22046@sigill.intra.peff.net>
References: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+?=@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:44:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO5vl-0006Zr-TN
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 14:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbaCMNoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 09:44:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:38810 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753350AbaCMNoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 09:44:12 -0400
Received: (qmail 22419 invoked by uid 102); 13 Mar 2014 13:44:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 08:44:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2014 09:44:09 -0400
Content-Disposition: inline
In-Reply-To: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244032>

On Thu, Mar 13, 2014 at 10:19:06AM +0100, Michael Haggerty wrote:

> These patches are proposed for maint (but also apply cleanly to
> master).
> 
> I presume that this is exploitable via Git commands, though I haven't
> verified it explicitly [1].

It's possible to overflow this buffer, like:

    git init repo && cd repo &&
    blob=$(git hash-object -w /dev/null) &&
    big=$(perl -e 'print "a" x 250')
    (for i in $(seq 1 17); do mkdir $big && cd $big; done)
    printf "100644 blob $blob\t$big\n" >tree &&
    tree=$(git mktree <tree) &&
    git read-tree $tree &&
    git checkout-index -f --all

but I'm not sure if it is easily exploitable for two reasons:

  1. We never actually return from the function with the smashed stack.
     Immediately after overflowing the buffer, we call lstat(), which
     will fail with ENAMETOOLONG (at least on Linux), causing us to call
     into die_errno and exit.

  2. The overflow relies on us trying to move a very deep hierarchy out
     of the way, but I could not convince git to _create_ such a
     hierarchy in the first place. Here I do it using relative paths and
     recursion, but git generally tries to create paths from the top of
     the repo using full pathnames. So it gets ENAMETOOLONG trying to
     create the paths in the first place.

Of course somebody may be more clever than I am, or perhaps some systems
have a PATH_MAX that is not enforced by the kernel. It's still a
suspicious bit of code, and I think your patches are a strict
improvement. Besides fixing this potential problem, I notice that we
currently put 4096 bytes on the stack for a recursive function. Removing
"a/a/a..." can put up to 8M on the stack, which might be too much on
some systems (besides just being silly and wasteful).

-Peff
