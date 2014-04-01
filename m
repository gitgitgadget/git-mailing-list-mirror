From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/22] lockfile: unlock file if lockfile permissions
 cannot be adjusted
Date: Tue, 1 Apr 2014 16:05:59 -0400
Message-ID: <20140401200559.GA22174@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-6-git-send-email-mhagger@alum.mit.edu>
 <20140401200242.GD21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:06:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4wj-0006kf-Bk
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaDAUGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:06:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:52035 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751354AbaDAUGC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:06:02 -0400
Received: (qmail 21453 invoked by uid 102); 1 Apr 2014 20:06:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 15:06:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 16:05:59 -0400
Content-Disposition: inline
In-Reply-To: <20140401200242.GD21715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245650>

On Tue, Apr 01, 2014 at 04:02:42PM -0400, Jeff King wrote:

> On Tue, Apr 01, 2014 at 05:58:13PM +0200, Michael Haggerty wrote:
> 
> > If the call to adjust_shared_perm() fails, lock_file returns -1, which
> > to the caller looks like any other failure to lock the file.  So in
> > this case, roll back the lockfile before returning so that the lock
> > file is deleted immediately and the lockfile object is left in a
> > predictable state that (namely, unlocked).  Previously, the lockfile
> > was retained until process cleanup in this situation.
> 
> Another nice find. I wondered if we could test this, but I think it
> would be hard to trigger. The obvious reason for adjust_shared_perm to
> fail is that you do not have permissions on the file, but by definition
> you just created it. So I doubt this ever comes up in practice short of
> weird races (somebody dropping the "x" bit from an intermediate
> directory between the open() and chmod() or something).

...and I should have read the final sentence in your message more
carefully. Even if we did trigger it, the problem would only last until
the program exits anyway.

I agree that this is a nice cleanup, though; a caller that wants to
retry the lock before exiting would be much less surprised. And the same
logic applies to 06/22.

-Peff
