From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config: properly range-check integer values
Date: Tue, 20 Aug 2013 22:55:04 -0400
Message-ID: <20130821025503.GC25296@sigill.intra.peff.net>
References: <20130820223953.GA3429@sigill.intra.peff.net>
 <20130820224256.GA24766@sigill.intra.peff.net>
 <20130820230749.GM4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 04:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VByZo-0000gt-8X
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 04:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab3HUCzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 22:55:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:42714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab3HUCzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 22:55:08 -0400
Received: (qmail 25821 invoked by uid 102); 21 Aug 2013 02:55:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 21:55:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 22:55:04 -0400
Content-Disposition: inline
In-Reply-To: <20130820230749.GM4110@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232679>

On Tue, Aug 20, 2013 at 04:07:49PM -0700, Jonathan Nieder wrote:

> > I added a test. It would not fail on existing 32-bit systems, but would
> > on existing LP64 systems. It will pass with the new code on both.
> > However, it will fail on ILP64 systems (because their int is large, and
> > can represent 3GB). I'm not sure if any such systems are in wide use
> > (SPARC64?), but we would want a prereq in that case, I guess. I'm
> > inclined to wait to see if it actually fails for anybody.
> 
> Yuck.
> 
> What will go wrong if "git config --int" starts returning numbers too
> large to fit in an 'int'?  That can already happen if "git" and a
> command that uses it are built for different ABIs (e.g., ILP64 git,
> 32-bit custom tool that calls git).

I'm not sure I understand your question. "git config --int" cannot
return numbers that do not fit in an "int", since we use an int as an
intermediate representation type. The intent of the code is to
range-check the input and complain. But the code gets it wrong, and
sometimes truncates the value instead. So we continue to never show
anything that would not fit in an "int", but now our range-check
correctly complains rather than truncating in some cases.

If you are worried about a 32-bit command calling an ILP64 git, then
nothing is made worse by this patch. We return the same range of values
as before.

Short of adding "--int32", etc to git-config, I don't think git can be
responsible for this situation. It can only say "This does not fit in my
internal representation, and I would barf on it". If you do not tell it
that your int is smaller, then it cannot say "you would barf on it".

> It's possible that what the test should be checking for is "either
> returns a sane answer or fails" (which would pass regardless of ABI).
> Something like:
> 
> 	test_expect_success 'large integers do not confuse config --int' '
> 		git config giga.crash 3g &&
> 		test_might_fail git config --int giga.crash >actual &&
> 		echo 3221225472 >expect &&
> 		{
> 			test_cmp expect actual ||
> 			test_must_fail git config --int giga.crash
> 		}
> 	'
> 
> Sensible?

Yes, that would cover an ILP64 system, though it very much muddies the
point of the test (which is to find a value that is represented by a
long, but not an int; such a value does not exist at all on ILP64).

Which is why I wondered about avoiding it with a prerequisite.

-Peff
