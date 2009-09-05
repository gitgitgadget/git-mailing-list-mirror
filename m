From: Jeff King <peff@peff.net>
Subject: Re: Hosting Git repositories: how useful will git-gc be?
Date: Sat, 5 Sep 2009 02:24:24 -0400
Message-ID: <20090905062424.GC29863@coredump.intra.peff.net>
References: <vpq1vmo9xai.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjojd-0000ln-J3
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbZIEGY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 02:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbZIEGY0
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:24:26 -0400
Received: from peff.net ([208.65.91.99]:51132 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbZIEGY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:24:26 -0400
Received: (qmail 25237 invoked by uid 107); 5 Sep 2009 06:24:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 02:24:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 02:24:24 -0400
Content-Disposition: inline
In-Reply-To: <vpq1vmo9xai.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127781>

On Thu, Sep 03, 2009 at 11:45:25AM +0200, Matthieu Moy wrote:

> A question: is it necessary/recommanded/useless to set up a cron job
> doing a "git gc" in each repository? My understanding is that a push
> through ssh will do some packing, is it correct? Does receiving a pack
> trigger a "git gc --auto"?

The objects are transferred as a pack. If the number of objects is less
than receive.unpackLimit (default 100), then they are unpacked to loose
objects. If more, we keep the pack, after completing any missing deltas
used by a thin pack.

So if you tend to push frequently, you will end up with a lot of loose
objects. Even if you have packs, they will be larger than necessary
because you will be missing deltas between objects across packs. And of
course you will eventually end up with a large number of packs, which is
less efficient (each pack has an index, but I believe we search the
indices linearly).

Receiving a pack does not (AFAICT looking at the code) trigger a "gc
--auto".  Running it has other benefits, too, like pruning cruft and
packing refs. So I think it is probably a good idea to run it
periodically.

Running it daily or weekly is probably reasonable. You could run it on
every push using the post-update hook, but that may cause excessive I/O
for very little benefit.

-Peff
