From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Sat, 20 Apr 2013 23:37:10 -0400
Message-ID: <20130421033710.GA18890@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net>
 <20130420040643.GB24970@sigill.intra.peff.net>
 <51729A6D.3030501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Apr 21 05:37:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTl5f-00025G-TG
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 05:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab3DUDhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 23:37:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:45260 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab3DUDhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 23:37:18 -0400
Received: (qmail 6264 invoked by uid 102); 21 Apr 2013 03:37:21 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 20 Apr 2013 22:37:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 23:37:10 -0400
Content-Disposition: inline
In-Reply-To: <51729A6D.3030501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221887>

On Sat, Apr 20, 2013 at 03:38:53PM +0200, Michael J Gruber wrote:

> > Wait, this does the opposite of the last patch. If we do want to do
> > this, shouldn't the last one have been an "expect_failure"?
> 
> The last patch just documents the status quo, which is not a bug per se.
> Therefore, no failure, but change in the definition of "success".

IMHO, the series is easier to review if you it does not go back and
forth. If you have one patch that says "X is the right behavior", and
then another patch that flips it to say "Y is the right behavior", the
reviewer would read each in sequence and want to be convinced by your
arguments for X and Y. But you probably cannot make a good argument for
X if you are trying to end up at Y. :)

So I'd much rather see the test introduced with the desired end
behavior, marked as expect_failure, and the commit message contain an
argument about why Y is a good thing (and squashing the tests in with
the actual fix is often even better, because the fix itself would want
to contain the same argument).

Just my two cents as a reviewer.

> My reasoning is twofold:
> 
> - consistency between "git show commit" and "git show blob"

I'm not sure I agree with this line of reasoning. "git show commit" is
showing a diff, not the file contents; textconv has always been about
munging the contents to produce a textual diff. It may be reasonable to
extend its definition to "this is the preferred human view of this
content, and that happens to be what you would want to produce a diff".
But I do not think it is necessarily inconsistent not to apply it for
the blob case.

> - "git show" is a user facing command, and as such should produce output
> consumable by humans; whereas "git cat-file" is plumbing and should
> produce raw data unless told otherwise (-p, --textconv).

That holds if the textconv is the only (or best) human-readable version
of the file. And maybe that is reasonable. But is it possible that
somebody uses "textconv" to produce a better diff of some already
human-readable format? For example, imagine I define a textconv for XML
files that normalizes the formatting to make diffs less noisy. When I am
not looking at a diff, what is the best human-readable version? The
original, or the normalized one? I'm not sure.

Note that I'm somewhat playing devil's advocate here. For the cases
where I have used textconv in the real world, I think I would probably
prefer seeing the converted contents, and I am happy to call it user
error if I use "git show HEAD:foo.jpg >bar.jpg" accidentally. But I also
want to make sure we are not regressing somebody else unnecessarily.

-Peff
