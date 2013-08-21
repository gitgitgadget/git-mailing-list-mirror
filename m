From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] teach git-config to output large integers
Date: Tue, 20 Aug 2013 23:00:36 -0400
Message-ID: <20130821030036.GD25296@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <20130820224710.GB24766@sigill.intra.peff.net>
 <20130820225745.GL4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 05:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VByf7-0004VA-9z
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 05:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab3HUDAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 23:00:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:42751 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab3HUDAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 23:00:41 -0400
Received: (qmail 26044 invoked by uid 102); 21 Aug 2013 03:00:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 22:00:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 23:00:36 -0400
Content-Disposition: inline
In-Reply-To: <20130820225745.GL4110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232680>

On Tue, Aug 20, 2013 at 03:57:45PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I kind of hate the name "--ulong". I wanted to call it "--size" or
> > something and abstract away the actual platform representation, and just
> > make it "big enough for file sizes".
> 
> Yes, something like --size would be more pleasant.
> 
> It could still use unsigned long internally.  My only worry about
> --size is that it does not make it clear we are talking about file
> sizes and not in-memory sizes (size_t), and I'm not too worried about
> that.

I almost sent it as "--size" with unsigned long internally. But try
writing the documentation for it. You want to say something like "it's
big enough to handle file sizes". Except that on 32-bit, it's _not_.
It's only 4G.

You really want something that uses off_t internally, so 32-bit systems
with largefile support do the sane thing. But now you have no way of
emulating the way that git parses stuff internally. You cannot say "git
config --size core.bigFileThreshold" and get the same results that git
will have internally when it looks at that file (because it uses
"unsigned long" internally").

I think there is an argument to be made that git should be using off_t
internally for such things. But it is a lot of code to change and check,
and I'm not sure that anybody even really cares that much.

> Style: uncuddled "else", stray blank line.  (The former was already
> there, but it still stands out.)  I think

Yes, I was trying to follow the existing style (but obviously the extra
line was just a typo).

> 		if (types == TYPE_INT) {
> 			...
> 		} else if (types == TYPE_ULONG) {
> 			...
> 		} else if (types == TYPE_BOOL) {
> 			...
> 		} else if (types == TYPE_BOOL_OR_INT) {
> 			...
> 		} else {
> 			...
> 		}
> 
> would be easiest to read.

But that is adding brackets for one-liner conditional bodies that do not
need it. Which is more evil?

My usual method is to do what looks the most readable to me, but I admit
I have a hard time using my intuition with the cuddled-elses, as I think
they look terrible (yes, I'm aware they are in our style guide and I am
not arguing to take them out, only that my personal sense of "looks
good" is helpless with them).

-Peff
