From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] teach git-config to output large integers
Date: Wed, 21 Aug 2013 01:00:53 -0400
Message-ID: <20130821050053.GA875@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <20130820224710.GB24766@sigill.intra.peff.net>
 <20130820225745.GL4110@google.com>
 <20130821030036.GD25296@sigill.intra.peff.net>
 <20130821043841.GA2802@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 07:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC0XY-00019r-2G
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 07:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab3HUFA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 01:00:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:43532 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab3HUFA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 01:00:58 -0400
Received: (qmail 31976 invoked by uid 102); 21 Aug 2013 05:00:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 00:00:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 01:00:53 -0400
Content-Disposition: inline
In-Reply-To: <20130821043841.GA2802@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232687>

On Tue, Aug 20, 2013 at 09:38:41PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > I almost sent it as "--size" with unsigned long internally. But try
> > writing the documentation for it. You want to say something like "it's
> > big enough to handle file sizes". Except that on 32-bit, it's _not_.
> > It's only 4G.
> >
> > You really want something that uses off_t internally, so 32-bit systems
> > with largefile support do the sane thing. But now you have no way of
> > emulating the way that git parses stuff internally.
> 
> Let's take a step back for a moment.  What problem is this patch
> solving?

That you cannot currently ask git-config for a value larger than 2g.

> From the motivating example, I thought it was
> 
> 	When reading or writing an integer config item, git sometimes
> 	encounters integer overflow and doesn't know how to deal with it.
> 	Worse, this means that some meaningful values are unrepresentable
> 	in config files.  Fix it in two steps:
> 
> 	 1. Catch overflow, and error out instead of pretending to be
> 	    able to handle it.

No, this first step is not being added. It is already the case that we
error out for overflow. The first patch is catching a case where we
failed to do that properly, and instead truncated. And it has nothing to
do with git-config itself; it is only that we must use git-config to
test it from the shell. The same problem may happen internally (but
tends not to, because large things tend to use git_config_ulong instead
of git_config_int).

> 	 2. Provide at least an option to use a wider integer type and
> 	    handle larger meaningful values.
> 
> 	This involves a new option --size instead of making --int use
> 	intmax_t for the following compatibility reason: ...
> 
> For example, the compatibility reason could be that some scripts
> calling "git config" were not able to handle large integers and that
> we do not want to expose them to unexpectedly large values.
> 
> But that reason doesn't sound realistic to me.  So what is the actual
> reason not to always use a wider range?

My reason is that it does not represent the same range checks that git
is doing internally (and which vary from platform to platform). So you
might ask git-config "what is the value of pack.deltacachelimit"; I
would expect it to apply the same range checks there that would be used
by git-pack-objects.

> That is what I was trying to get at in discussing the test.  It is not
> "We would like --int to reject values higher than this, but some
> platforms do not allow us to", but "Either rejecting this value, or
> even better, computing the right size and printing it, is an
> acceptable behavior, and this test checks for those."

You are conflating the two patches, I think. The test we were discussing
is for the _first_ patch, which fixes a bug in the range check. It is
not meant to test git-config in particular, but to test that values
higher than INT_MAX and lower than LONG_MAX are properly range-checked.

Forget the second patch for a moment. I believe the first one is a bug
fix that we would want even if we do not take the second patch at all.

-Peff
