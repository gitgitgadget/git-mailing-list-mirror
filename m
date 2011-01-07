From: Jeff King <peff@peff.net>
Subject: Re: clone breaks replace
Date: Fri, 7 Jan 2011 17:09:42 -0500
Message-ID: <20110107220942.GB10343@sigill.intra.peff.net>
References: <4D262D68.2050804@cfl.rr.com>
 <20110106213338.GA15325@burratino>
 <4D276CD2.60607@cfl.rr.com>
 <20110107205103.GC4629@burratino>
 <4D278930.7010100@cfl.rr.com>
 <20110107214907.GA9194@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phillip Susi <psusi@cfl.rr.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:09:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKVN-0006OE-NR
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab1AGWJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:09:47 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35353 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695Ab1AGWJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:09:46 -0500
Received: (qmail 18956 invoked by uid 111); 7 Jan 2011 22:09:45 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Jan 2011 22:09:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jan 2011 17:09:42 -0500
Content-Disposition: inline
In-Reply-To: <20110107214907.GA9194@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164773>

On Fri, Jan 07, 2011 at 03:49:07PM -0600, Jonathan Nieder wrote:

> Phillip Susi wrote:
> 
> > Take the kernel history as an example, only imagine that Linus did not
> > originally make that first commit leaving out the prior history, but
> > wants to go back and fix it now.  He can do it with a replace, but then
> > if he runs filter-branch as you suggest to make the change 'real', then
> > everyone tracking his tree will fail the next time they try to pull.
> > You could get the same result without replace, so why bother?
> >
> > If the replace was fetched by default, the people already tracking would
> > get it the next time they pull and would not have a problem.
> 
> Interesting.  I hadn't thought about this detail before.

I think there are two separate issues here:

  1. Should transport protocols respect replacements (i.e., if you
     truncate history with a replacement object and I fetch from you,
     should you get the full history or the truncated one)?

  2. Should clone fetch refs from refs/replace (either by default, or
     with an option)?

Based on previous discussions, I think the answer to the first is no.
The resulting repo violates a fundamental assumption of git. Yes,
because of the replacement object, many things will still work. But many
parts of git intentionally do not respect replacement, and they will be
broken.

Instead, I think of replacements as a specific view into history, not a
fundamental history-changing operation itself. Which means you can never
save bandwidth or space by truncating history with replacements. You can
only give somebody the full history, and share with them your view. If
you want to truncate, you must rewrite history[1].

Which leads to the second question. It is basically a matter of saying
"do you want to fetch the view that upstream has"? I can definitely see
that being useful, and meriting an option. However, it may or may not be
worth turning on by default, as upstream's view may be confusing.

-Peff

[1] Actually, what we are talking about it basically shallow clone.
    Which does do exactly this truncation, but does not use the replace
    mechanism. So it _is_ possible, but lots of things need to be
    tweaked to understand the shallow-ness. Perhaps in the long run
    making git understand replacement-truncated repos with missing
    objects would be a good thing, and shallow clones can be implemented
    simply as a special case of that. It would probably make the code a
    bit cleaner.
