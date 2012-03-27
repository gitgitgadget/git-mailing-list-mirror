From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] run-command: propagate EACCES errors to parent
Date: Tue, 27 Mar 2012 14:33:22 -0400
Message-ID: <20120327183322.GA8460@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180425.GA4659@sigill.intra.peff.net>
 <7vhax9j41p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCbD0-0002h8-CE
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab2C0SdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:33:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34416
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880Ab2C0SdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:33:24 -0400
Received: (qmail 5977 invoked by uid 107); 27 Mar 2012 18:33:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 14:33:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 14:33:22 -0400
Content-Disposition: inline
In-Reply-To: <7vhax9j41p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194071>

On Tue, Mar 27, 2012 at 11:24:02AM -0700, Junio C Hamano wrote:

> > Actually, there is a slight bending of the truth in the commit message.
> > bash implements its own execvp, and it will only return 126/EACCES if a
> > file is found via stat(), but is not executable. If there is an
> > inaccessible directory in the PATH (meaning that stat() will fail), it
> > will silently convert that to 127/ENOENT.
> 
> I am wondering what would happen if we treated EACCESS and ENOENT exactly
> the same way.  Wouldn't the four breakage scenarios in the cover letter
> end up being even better?  Case (3) will still say does-not-exist is not a
> git command (instead of "permission denied", which this patch gives), but
> your case (2) will see a much better diagnosis.

Yes, after writing my last message detailing all of the cases, I am
tempted to go that way. The downside is that it is more confusing if you
have a file in your PATH without the execute bit. IOW, we do not
differentiate the common mistake of "directory in PATH is not
accessible" from the uncommon "we found /usr/bin/foo, but it is not
executable by you". While the latter case is much less common, it would
be nice to continue to report EACCES.

Which leads us to either implementing our own execvp, or tracing through
the PATH after execvp fails (which amounts to basically the same thing).

-Peff
