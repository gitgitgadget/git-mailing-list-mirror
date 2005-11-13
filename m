From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Balanced packing strategy
Date: Sun, 13 Nov 2005 21:06:29 +0100
Message-ID: <200511132106.29841.Josef.Weidendorfer@gmx.de>
References: <1131800663.29461.11.camel@blade> <cae2e895f6598781f4f22b76e781684b@codefountain.com> <20051112135947.GC30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Craig Schlenter <craig@codefountain.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 21:33:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbOVX-0002BH-8v
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 21:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVKMUay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 15:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVKMUax
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 15:30:53 -0500
Received: from mail.gmx.de ([213.165.64.20]:10159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750741AbVKMUax (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 15:30:53 -0500
Received: (qmail invoked by alias); 13 Nov 2005 20:30:51 -0000
Received: from p5496AB49.dip0.t-ipconnect.de (EHLO linux) [84.150.171.73]
  by mail.gmx.net (mp014) with SMTP; 13 Nov 2005 21:30:51 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051112135947.GC30496@pasky.or.cz>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11748>

On Saturday 12 November 2005 14:59, Petr Baudis wrote:
> The repacking should be done in such a way to minimize the overhead for
> the dumb transport users. Ideal for this is some structure like (at the
> end of october):
> 
> 	year2003.pack
> 	year2004.pack
> ...
> 	week42.pack
> 	week43.pack
> 	<individual objects for weeks 43, 44>

I am not sure if it is really beneficial, as packs have the requirement
to be self contained, so you get a lot of objects undeltified which could
be deltified in a better scheme (as eg. in git native protocol).

AFAICS, the git native protocol (which is nothing more than a pack itself
for each transfer) even has this problem, too: If you are updating every
day via git native, the sum of transfered bytes in a month will be a
multiple of one git transfer for all the month's changes.

To keep the pack self-containment property, but work better with dumb
transfers, we could introduce incremental packs:

Instead of fully repacking, create a new pack by only appendending new
objects at the end of the pack. Thus, most objects will be appended in
deltified form, making the incremental addition quite small. The outcome
would be a totally new package.

Unfortunately, I do not know the package format in detail, and hope that
this is possible at all.

For dumb protocols to take advantage of this, the information that the
first part of a package is actually the same as another package has to
be stored somewhere visible.
If a client detects that it has the first part of a pack already locally,
it would be enough to fetch only some the second part. 

This is more or less the same as Pasky's solution, but by using incremental
packs instead. I think that such incremental packing will not even take
much more space that fully repacking.

Josef
