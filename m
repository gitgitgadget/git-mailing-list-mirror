From: Petr Baudis <pasky@suse.cz>
Subject: Balanced packing strategy
Date: Sat, 12 Nov 2005 14:59:47 +0100
Message-ID: <20051112135947.GC30496@pasky.or.cz>
References: <1131800663.29461.11.camel@blade> <cae2e895f6598781f4f22b76e781684b@codefountain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 15:01:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eavv7-0001Wt-MN
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 14:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVKLN7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 08:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKLN7u
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 08:59:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16852 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932374AbVKLN7t (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 08:59:49 -0500
Received: (qmail 17158 invoked by uid 2001); 12 Nov 2005 14:59:47 +0100
To: Craig Schlenter <craig@codefountain.com>
Content-Disposition: inline
In-Reply-To: <cae2e895f6598781f4f22b76e781684b@codefountain.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11688>

Dear diary, on Sat, Nov 12, 2005 at 02:40:50PM CET, I got a letter
where Craig Schlenter <craig@codefountain.com> said that...
> On 12 Nov 2005, at 3:04 PM, Marcel Holtmann wrote:
> 
> >every time Linus re-creates the pack for his linux-2.6 tree, I end up
> >with another pack. I use HTTP as transport and thus the new pack will 
> >be
> >download (which is almost 100 MB), but that is fine.
> >[snip]
> 
> The 100MB situation is not cool for those of us on a tight bandwidth
> budget or slow links. Can anyone tell me if the native git protocol is
> any better at this stuff please?

Yes, the native GIT protocol transfers only the objects you need.

But the 100MB situation is still bad. FWIW, this is my proposal I sent
about a month ago to some packs-related discussion at the kernel.org
mailing list (ok, I updated it a little):


The repacking should be done in such a way to minimize the overhead for
the dumb transport users. Ideal for this is some structure like (at the
end of october):

	year2003.pack
	year2004.pack
	halfyear2004-2.pack
	halfyear2005-1.pack
	month4.pack
	month5.pack
	month6.pack
	month7.pack
	month8.pack
	month9.pack
	week37.pack
	week38.pack
	week39.pack
	week40.pack
	week41.pack
	week42.pack
	week43.pack
	<individual objects for weeks 43, 44>


This has the property that the second half of given pack is covered by
objects with precision lower by one. This is a relatively high overload
(this can be balanced by only keeping the last third or whatever), but
it designed to reduce the overhead of fetching packs over dumb
transport. E.g. if it's almost the end of July and you last fetched at
the start of June, you will not have to get the whole halfyear2005-1
pack, but be able to catch up by just fetching month6 pack, and then few
week-packs.

For the autopacker (which should be ideally ran by some cronjob), this
means packing new week each week and getting rid of a week worth of
objects, packing new month each month and getting rid of a month worth
of objects, etc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
