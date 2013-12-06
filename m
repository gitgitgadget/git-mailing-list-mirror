From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] rev-parse and "--"
Date: Fri, 6 Dec 2013 17:05:20 -0500
Message-ID: <20131206220520.GA30652@sigill.intra.peff.net>
References: <20131206211222.GB20482@sigill.intra.peff.net>
 <20131206211509.GB20536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 23:05:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp3Wa-0004xf-IA
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 23:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432Ab3LFWFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 17:05:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:51849 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161428Ab3LFWFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 17:05:22 -0500
Received: (qmail 10952 invoked by uid 102); 6 Dec 2013 22:05:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 16:05:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 17:05:20 -0500
Content-Disposition: inline
In-Reply-To: <20131206211509.GB20536@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238955>

On Fri, Dec 06, 2013 at 04:15:09PM -0500, Jeff King wrote:

> If you have both a file and a branch named "foo", running:
> 
>   git log foo
> 
> will complain. We should do the same in rev-parse, and
> demand that it be disambiguated with:
> 
>   git rev-parse foo --
> 
> or
> 
>   git rev-parse -- foo
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Hmm, looking at this again, I guess we need to give the same treatment
> to the try_difference code path above, as "foo..bar" can be ambiguous
> with a filename (and "git log" seems to diagnose that).

Here's a revised series which handles that:

  [1/3]: rev-parse: correctly diagnose revision errors before "--"
  [2/3]: rev-parse: be more careful with munging arguments
  [3/3]: rev-parse: diagnose ambiguous revision/filename arguments

While fixing this commit, I noticed another bug whose fix is a
prerequisite. That's now patch 2 in the series. I think the first two
patches are correct and should be applied.

Patch 3 is the revised version of this patch which notices ambiguity.
However, I'm having second thoughts on it. I think it's the right thing
to do if you want to help people build something like "git log"
themselves. But it does mean that we are breaking somebody who does:

  echo foo >HEAD
  commit=$(git rev-parse HEAD)

I'm tempted to say that people who did that are stupid and wrong (and
ugly, too). They should probably be using "--verify" in this case. But
it has been that way for a long time, and there are two instances in our
test scripts that are broken by the patch.

Is it better for "rev-parse" to be more careful, and to behave more like
the rest of git? Or is better to be historically compatible?

One thing to note is that "git rev-parse HEAD" is slightly broken there
already. Because "git rev-parse $some_branch" may do very different
things than what the caller expects if $some_branch does not exist (but
there is a file with the same name). So maybe we are doing a favor by
calling out the problem; if they want a rev, they should be using
"--verify" (or "--").

-Peff
