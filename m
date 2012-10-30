From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Tue, 30 Oct 2012 09:12:22 -0400
Message-ID: <20121030131221.GA19571@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
 <508D8DF7.7040007@arcor.de>
 <20121029060524.GB4457@sigill.intra.peff.net>
 <508EE4E4.1080407@arcor.de>
 <20121029223521.GJ20513@sigill.intra.peff.net>
 <20121029224705.GA32148@sigill.intra.peff.net>
 <20121030121747.GA4231@sigill.intra.peff.net>
 <da24b6ea-ac9b-46dd-b591-25fd4e8e6504@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 14:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTBcT-0005U2-M0
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 14:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311Ab2J3NMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 09:12:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43781 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab2J3NMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 09:12:24 -0400
Received: (qmail 32319 invoked by uid 107); 30 Oct 2012 13:13:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Oct 2012 09:13:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2012 09:12:22 -0400
Content-Disposition: inline
In-Reply-To: <da24b6ea-ac9b-46dd-b591-25fd4e8e6504@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208701>

On Tue, Oct 30, 2012 at 09:46:01PM +0900, Junio C Hamano wrote:

> (1) sounds attractive for more than one reason. In addition to
> avoidance of this issue, it would bring bug-to-bug compatibility
> across platforms.

Yeah. I mentioned breaking the build for people who would now need to
turn on NO_REGEX. But the only reason to do that is to let people on
glibc systems use the system version of the tools. A much saner approach
would be to just always build with our compat regex, and turn NO_REGEX
into a no-op. We already do the same thing for kwset.

> (4), if we can run grep on streaming data (tweak interface we have for
> checking out a large blob to the working tree), would let us work on
> dataset larger than fit in core. Even though it would be much more
> work, it might turn out to be a better option in the longer run.

Agreed, that would be nice. It's potentially a lot of work, but we could
probably get by with a special streaming version of diff_populate_filespec.

The tricky thing is that we have to run the regex matcher progressively
as we stream data in (since your match might fall in the middle of a
read boundary). Which is certainly going to require switching off of
regular regexec. I don't think glibc regex will handle it either,
though. It looks like pcre can report a partial match at the end of the
string, and you can either continue with the next chunk (if using
pcre_dfa) or append and re-start the pattern match (for regular
pcre_exec).

Which means we'd probably have to make streaming matches an optional
feature, and still do (1) first to fix the correctness issue.

-Peff
