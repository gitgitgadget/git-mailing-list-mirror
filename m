From: Jeff King <peff@peff.net>
Subject: Re: [PATCH jk/pkt-line-cleanup] t5700-clone-reference: send trace to
 fd 2, not 3, to please Windows git
Date: Wed, 20 Mar 2013 13:06:07 -0400
Message-ID: <20130320170607.GB10752@sigill.intra.peff.net>
References: <5149724C.3060105@viscovery.net>
 <20130320093313.GA9482@sigill.intra.peff.net>
 <51499DE7.2030404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMTJ-0005fP-Oo
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab3CTRGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:06:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60244 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab3CTRGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:06:13 -0400
Received: (qmail 9478 invoked by uid 107); 20 Mar 2013 17:07:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 13:07:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 13:06:07 -0400
Content-Disposition: inline
In-Reply-To: <51499DE7.2030404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218619>

On Wed, Mar 20, 2013 at 12:30:47PM +0100, Johannes Sixt wrote:

> > I think that is OK, but I'm curious why this is a problem _now_, and not
> > with the code prior to 97a83fa8. The old GIT_DEBUG_SEND_PACK was also
> > just calling write() to descriptor 3.
> 
> Before this change, both affected commands completed and the trace file
> was empty. Notice that in both test cases we only check for the absence of
> certain lines, which is naturally true for an empty file, so that the
> tests pass.

Hmm. The code in t5503 is similar, but before my patch used to actually
use "test -s" to make sure that some trace output was written. Did it
fail before 97a83fa8 (and does it pass now)?

We should probably be adjusting t5503, too. And possibly adding back in
the "test -s" checks (which I removed as redundant, but I guess the
double-checking might have caught a platform error in this case).

Also, though I think your use of stderr is probably OK, might it be a
little more robust against future output changes to use:

  GIT_TRACE_PACKET=$PWD/$U.D git clone ...

to write directly to the file. The original GIT_DEBUG_SEND_PACK did not
support such niceties, but GIT_TRACE gives them to us for free.

> With the updated code, 'git fetch' hung, which is how I noticed the
> problem. As I said, I didn't investigate where and why this happens.

Thinking on it more, almost certainly what is happening is that fd 3 is
being used for the actual protocol, and we are jamming random bytes over
it. Since we have changed the bytes, the code is reacting in a different
way (but the actual reaction doesn't matter; we should stop the cause,
not worry about the symptom).

-Peff
