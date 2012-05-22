From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 13:33:55 -0400
Message-ID: <20120522173355.GC11600@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521235219.GA5589@sigill.intra.peff.net>
 <4FBB0F21.5080608@alum.mit.edu>
 <20120522041123.GA9972@sigill.intra.peff.net>
 <4FBB3D2B.4010300@alum.mit.edu>
 <20120522073740.GA10093@sigill.intra.peff.net>
 <4FBB9480.4010407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 22 19:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsyD-0004Si-Ls
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759946Ab2EVRd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:33:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51835
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab2EVRd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:33:58 -0400
Received: (qmail 20309 invoked by uid 107); 22 May 2012 17:34:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 13:34:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 13:33:55 -0400
Content-Disposition: inline
In-Reply-To: <4FBB9480.4010407@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198210>

On Tue, May 22, 2012 at 03:28:32PM +0200, Michael Haggerty wrote:

> >When I try it with both 'next' and v1.7.10, I see that the latter is
> >much faster.  I did my tests with a warm cache, but the interesting
> >number is the CPU time, which is quite different.
> 
> I cannot reproduce anything as big as the performance regression that
> you see.  I did find a regression 9.5 s -> 10.1 s caused by
> 
> 5fa044184 find_containing_dir(): use strbuf in implementation of this
> function
> 
> It is fixed by the patch that I just sent to the mailing list [1],
> which sizes the strbuf in that function to strlen(refname) instead of
> PATH_MAX.  Since your experiments suggest that the performance
> regression is related to the size of the repository contents, it
> could be that the same test produces more memory pressure on your
> system and therefore a larger effect.  Please try the patch and tell
> me if it fixes the problem for you.

That patch drops about a second off of the slow case, but the main
problem still remains. Just to be sure we are both doing the exact same
thing, here is a complete reproduction recipe:

  GIT=/path/to/your/git/checkout
  RAILS=/path/to/unpacked/rails.git

  cd $GIT &&
  git checkout 432ad41e60cedb87ceec446ab034d46a53f5f9d8^ &&
  make &&

  cd $RAILS &&
  time $GIT/bin-wrappers/git fetch . refs/*:refs/* &&

  cd $GIT &&
  git checkout 432ad41e60cedb87ceec446ab034d46a53f5f9d8 &&
  make &&

  cd $RAILS &&
  time $GIT/bin-wrappers/git fetch . refs/*:refs/*

produces:

  [before]
  real    0m9.128s
  user    0m9.369s
  sys     0m0.976s

  [after]
  real    0m15.926s
  user    0m16.181s
  sys     0m0.984s

I don't think memory pressure is involved. The git process maxes out at
~300M, and this machine has 7.5G available.

I wonder why we are getting different results. Could it be compilation
options? As I mentioned, I compile with -O0, but I got similar results
with -O3.

-Peff
