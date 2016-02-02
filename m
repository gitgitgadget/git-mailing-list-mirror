From: Jeff King <peff@peff.net>
Subject: Re: git object-count differs between clones
Date: Tue, 2 Feb 2016 11:52:46 -0500
Message-ID: <20160202165246.GA17822@sigill.intra.peff.net>
References: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com>
 <vpq7finm6v8.fsf@anie.imag.fr>
 <203317792.714602.1454430077194.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Andrew Martin <amartin@xes-inc.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 17:52:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQeCD-0003dH-9S
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756621AbcBBQwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 11:52:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:36258 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754252AbcBBQws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:52:48 -0500
Received: (qmail 30472 invoked by uid 102); 2 Feb 2016 16:52:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 11:52:48 -0500
Received: (qmail 16725 invoked by uid 107); 2 Feb 2016 16:52:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 11:52:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2016 11:52:46 -0500
Content-Disposition: inline
In-Reply-To: <203317792.714602.1454430077194.JavaMail.zimbra@xes-inc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285280>

On Tue, Feb 02, 2016 at 10:21:17AM -0600, Andrew Martin wrote:

> > You may try expiring your reflog and "git gc" again.
> 
> Thanks, I found some commits that are not referenced in any branch. How can I
> remove these from the reflog? I tried running
> "git reflog expire --expire=now --expire-unreachable=now --all" followed by
> "git gc" but still the same number of objects remain.

Are the objects now loose, or still in packs? Git has a grace period for
pruning objects, so that we do not delete objects for an in-progress
operation. The life cycle of an unreferenced object should be something
like:

  - reachable by reflogs, which are pruned after 30 days (or
    gc.reflogExpireUnreachable config). Objects will be repacked as
    normal during this time. Override with "reflog expire" as you did
    above.

  - after the reflog expires, the objects are now unreachable. During
    the next repack, they'll be ejected from the pack into loose
    objects, and their mtimes set to match the pack they came from
    (which is probably quite recent if you just repacked!).

  - after 2 weeks (or gc.pruneExpire), unreachable loose objects are
    dropped by "git prune", which is called as part of "git gc". This is
    based on the object mtime.

    You can accelerate this with "git gc --prune=now" (or
    "--prune=5.minutes.ago").

-Peff
