From: Zygo Blaxell <zblaxell@esightcorp.com>
Subject: Re: 'git add' corrupts repository if the working directory is
	modified as it runs
Date: Sat, 13 Feb 2010 17:37:33 -0500
Message-ID: <20100213223733.GP24809@gibbs.hungrycats.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix> <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 23:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgQjv-0003tk-DG
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 23:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab0BMWpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 17:45:22 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:45562 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751543Ab0BMWpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 17:45:21 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2010 17:45:21 EST
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 1DBCE770130;
	Sat, 13 Feb 2010 17:37:34 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@esightcorp.com>)
	id 1NgQcH-0008PH-Vk; Sat, 13 Feb 2010 17:37:33 -0500
Content-Disposition: inline
In-Reply-To: <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139867>

On Sun, Feb 14, 2010 at 01:09:23AM +0300, Dmitry Potapov wrote:
> On Sat, Feb 13, 2010 at 7:29 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> > Hmm... One needs to copy the data block at time into temporary buffer
> > and use that for feeding zlib and SHA-1. That ensures that whatever
> > SHA-1 hashes and zlib compresses are consistent.
> 
> If you want this then just compile Git with NO_MMAP = YesPlease
> It should solve the described problem.

Doesn't that also turn off mmap in other places where it's harmless or
even beneficial?  Otherwise, why use mmap in Git at all?  It also doesn't
solve the problem in cases when mmap support is compiled in.

There is a performance-robustness trade-off here.  If we do an extra
copy of the file data, we get always consistent repo contents but lose
speed (not very much speed, since sha1 and zlib are much slower than
a memory copy).  If we don't, we still get consistent repo contents
if--and only if--the files never happen to be modified during a git add.
I can live with that, as long as the limitation is documented and there's
a config switch somewhere that I can turn on for cases when I can't make
such assurances.

I imagine similar reasoning led to the existence of the
receive.fsckObjects option.  Personally, checking all objects fetched
from remote repos is not a feature I'd ever want to be able to turn off;
however, it's easy to think of cases where integrity matters less than
speed (e.g. build systems doing clone-build-destroy cycles from a trusted,
reliable server over a similarly trusted network).
