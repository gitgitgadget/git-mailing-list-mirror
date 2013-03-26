From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Tue, 26 Mar 2013 17:29:48 -0400
Message-ID: <20130326212948.GA1340@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-3-git-send-email-gitster@pobox.com>
 <20130326185559.GB26462@sigill.intra.peff.net>
 <20130326203914.GA29167@sigill.intra.peff.net>
 <7v7gktubsp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbRl-0002yU-Po
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab3CZV3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:29:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40722 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab3CZV3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:29:53 -0400
Received: (qmail 8142 invoked by uid 107); 26 Mar 2013 21:31:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 17:31:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 17:29:48 -0400
Content-Disposition: inline
In-Reply-To: <7v7gktubsp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219211>

On Tue, Mar 26, 2013 at 01:49:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I timed this doing "git archive HEAD" on webkit.git before and after. It
> > actually ended up not mattering much (I think because it is only the
> > directories which are affected, not each individually path, so it's a
> > much smaller number than you'd think). The best-of-five timing was
> > slightly slower, but was within the noise.
> 
> Interesting.  Because "archive" has to incur a large I/O cost
> anyway, I expected extra allocation for correctness for only the
> directory paths would be dwarfed in the noise.
> 
> I actually care more about cases other than "archive", though.  Do
> we even feed directory paths to the machinery?

In general, no, I don't think so. That's why I tested "archive", since I
knew it did. In the normal case, we should just feed file paths, meaning
we only run into this code path when somebody has "foo/" in their
pattern. Testing like:

  git ls-files -z >files
  time git check-attr --stdin -z -a <files >/dev/null

showed a difference well within the noise.

> > So I do still think it would make sense to go to a byte-limited version
> > of fnmatch eventually, just for code cleanliness and predictability of
> > performance, but this is really not a bad solution in the interim.
> 
> Yes, what we do with wildmatch is a separate issue for 'master' and
> upwards.

Oh, agreed. I just wanted to see how much performance would be impacted
for the interim. But it seems that it's not.

So I think your series is the right direction, but we would want to
factor out the allocation code and use it from match_pathname, as well.

-Peff
