From: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Fri, 19 Feb 2010 10:26:09 -0500
Message-ID: <20100219152609.GC11733@gibbs.hungrycats.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> <201002181114.19984.trast@student.ethz.ch> <7vtytee7ff.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002181456230.1946@xanadu.home> <7v635ub8oa.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002181604310.1946@xanadu.home> <20100219010456.GA1789@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 16:26:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiUkY-0006FN-2j
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 16:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab0BSP0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 10:26:14 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:40628 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754469Ab0BSP0L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 10:26:11 -0500
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 8488D8013;
	Fri, 19 Feb 2010 10:26:09 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@gibbs.hungrycats.org>)
	id 1NiUk5-0003SY-BI; Fri, 19 Feb 2010 10:26:09 -0500
Content-Disposition: inline
In-Reply-To: <20100219010456.GA1789@progeny.tock>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140457>

On Thu, Feb 18, 2010 at 07:04:56PM -0600, Jonathan Nieder wrote:
> Nicolas Pitre wrote:
> > On Thu, 18 Feb 2010, Junio C Hamano wrote:
> >> I suspect that opening to mmap(2), hashing once to compute the object
> >> name, and deflating it to write it out, will all happen within the same
> >> second, unless you are talking about a really huge file, or you started at
> >> very near a second boundary.
> >
> > How is the index dealing with this?  Surely if a file is added to the 
> > index and modified within the same second then 'git status' will fail to 
> > notice the changes.  I'm not familiar enough with that part of Git.
> 
> See Documentation/technical/racy-git.txt and t/t0010-racy-git.sh.
> 
> Short version: in the awful case, the timestamp of the index is the
> same as (or before) the timestamp of the file.  Git will notice this
> and re-hash the tracked file.

As far as I can tell, the index doesn't handle this case at all.

Suppose the file is modified during git add near the beginning of the
file, after git add has read that part of the file, but the modifications
finish before git add does.  Now the mtime of the file is earlier
than the index timestamp, but the file contents don't match the index.
This holds even if the objects git adds to the index aren't corrupted.
Actually right now you can have all four combinations:  index up to date
or not, and object matching its sha1 hash or not, depending on where and
when you modify data during an index update.

racy-git.txt doesn't discuss concurrent modification of files with the
index.  It only discusses low-resolution file timestamps and modifications
at times that are close to, but not concurrent with, index modifications.

Git probably also doesn't handle things like NTP time corrections
(especially those where time moves backward by sub-second intervals) and
mismatched server/client clocks on remote filesystems either (mind you,
I know of no SCM that currently handles that case, and CVS in particular
is unusually bad at it).

Personally, I find the combination of nanosecond-precision timestamps
and network file systems amusing.  At nanosecond precision, relativistic
effects start to matter across a volume of space the size of my laptop.
I'm not sure how timestamps at any resolution could be a reliable metric
for detecting changes to file contents in the general case.  A valuable
hint in many cases, but not authoritative (unless they all come from a
single monotonic high-resolution clock guaranteed to increment faster than
git--but they don't).

rsync solves this sort of problem with a 'modification window' parameter,
which is a time interval that is "close enough" to consider two timestamps
to be equal.  Some of rsync's use cases set that window to six months.
Git would use a modification window for the opposite reason rsync
does--rsync uses the window to avoid unnecessarily examining files that
have different timestamps, while git would use it to re-examine files
even when it appears to be unnecessary.

Git probably wants the modification window to be the maximum clock
offset between a network filesystem client and server plus the minimum
representable interval in the filesystem's timestamp data type--which
is a value git couldn't possibly know for some cases, so it needs input
from the user.
