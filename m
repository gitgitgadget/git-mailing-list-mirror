From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees with various fanout schemes
Date: Fri, 28 Aug 2009 12:40:12 +0200
Message-ID: <200908281240.13311.johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net> <200908280103.06015.johan@herland.net> <alpine.DEB.1.00.0908281048320.7434@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 12:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgyuC-0007ja-04
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 12:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbZH1Klx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 06:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbZH1Klx
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 06:41:53 -0400
Received: from sam.opera.com ([213.236.208.81]:52753 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbZH1Klx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 06:41:53 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n7SAeDod013224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Aug 2009 10:40:19 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0908281048320.7434@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127288>

On Friday 28 August 2009, Johannes Schindelin wrote:
> Hi,
>
> On Fri, 28 Aug 2009, Johan Herland wrote:
> > On Thursday 27 August 2009, Junio C Hamano wrote:
> > > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > > > Yea, it was me.  I still think it might be a useful idea, since
> > > > it allows you better density of loading notes when parsing the
> > > > recent commits.  In theory the last 256 commits can easly be in
> > > > each of the 2/ fanout buckets, making 2/38 pointless for
> > > > reducing the search space.  Commit date on the other hand can
> > > > probably force all of them into the same bucket, making it easy
> > > > to have the last 256 commits in cache, from a single bucket.
> > > >
> > > > But I thought you shot it down, by saying that we also wanted
> > > > to support notes on blobs.  I happen to see no value in a note
> > > > on a blob, a blob alone doesn't make much sense without at
> > > > least an annotated tag or commit to provide it some named
> > > > context, and the latter two have dates.
> > >
> > > Yeah, and in this thread everybody seems to be talking about
> > > commits so I think it is fine to limit notes only to commits.
> >
> > Agreed. I'm starting to come around to the idea of storing them in
> > subtrees based on commit dates. For one, you don't have multiple
> > notes for one commit in the same notes tree. Also, the common-case
> > access pattern seems tempting.
> >
> > Dscho: Were there other problems with the date-based approach other
> > than not supporting notes on trees and blobs?
>
> It emphasized an implementation detail too much for my liking.
>
> And I would rather have some flexibility in the code as to _when_ it
> fans out and when not.
>
> So I can easily imagine a full repository which has only, say, 5
> notes. Why not have a single tree for all of those?

Yes, if you only have a handful of notes, the date-based approach is 
definitely overkill. On the other hand, if you only have a handful of 
notes, performance is not going to be a problem in the first place, no 
matter which notes structure you use...

> And I can easily imagine a repository that has a daily note generated
> by an automatic build, and no other notes.  The date-based fan-out
> just wastes our time here, and even hurts performance.

What about a month-based fanout? Looking at the kernel repo with

  git log --all --date=iso --format="%ad" |
  cut -c1-7 | sort | uniq -c | sort -n

I find that commits are spread across 66 months, and the most active 
month (2008-07) has 5661 commits. If we assume the one-note-per-commit 
worst case, that gives up to 5661 notes per month-based subdir. Is that 
too much?

Doing

  for subdir in $(find . -type d); do
      echo "$(ls -1 $subdir | wc -l) $subdir"
  done | sort -n

shows me that the currently largest tree in the kernel has 985 entries 
(include/linux), so a 5661-entry tree is probably larger than what git 
is used to...

...just thinking that we shold make things as simple as possible (but no 
simpler), and if a month-based fanout works adequately in all practical 
cases, then we should go with that...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
