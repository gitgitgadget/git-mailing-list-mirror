From: Junio C Hamano <junkio@cox.net>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Mon, 17 Oct 2005 01:21:14 -0700
Message-ID: <7voe5o366d.fsf@assigned-by-dhcp.cox.net>
References: <434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com>
	<Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
	<435264B1.2010204@de.bosch.com>
	<Pine.LNX.4.63.0510161122570.23242@iabervon.org>
	<20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
	<7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net>
	<20051016213341.GF5509@reactrix.com>
	<7vwtkd6rik.fsf@assigned-by-dhcp.cox.net>
	<20051017060659.GH5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 10:21:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERQFF-0006GI-4M
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 10:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVJQIVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 04:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVJQIVS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 04:21:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36531 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932197AbVJQIVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 04:21:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051017082045.PFKA2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Oct 2005 04:20:45 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051017060659.GH5509@reactrix.com> (Nick Hengeveld's message of
	"Sun, 16 Oct 2005 23:06:59 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10180>

Nick Hengeveld <nickh@reactrix.com> writes:

> To get a complete list of objects we do not have yet, fetch will need
> to walk all the trees first and then make another pass to process
> all the missing objects.

Notice I did not say "we do not have yet but we will need" -- I
just said "we do not have yet".

The assumption, which is the property the suggested packing
strategy has, is that older objects that are needed to complete
the history leading to the current tip are packed in those
n-month/n-week packs, so if we do not have them we would likely
be needing them, although we might not have walked that far back
in history yet.

The previous "packing strategy" picture was certainly too
simplified.  Obviously we would not want to repack everything
every week for different periods all the way back -- we would
want to leave old huge pack untouched to help server side (and
mirroring), so instead of having a single "pack optimization
boundary", we would probably need some staggering as well for
archived material.

This is a revised example.

1yr -----
9mo      --------
6mo              ----------
3mo                        ------------------
1mo                              ------------  
2wk                                  --------
1wk                                      ----

We keep track of "the current heads and tags" for each week.
Every week, we can do something like this:

 - rotate the record, and create a new one:
   mv .save/wk11 .save/wk12
   mv .save/wk10 .save/wk11
   mv .save/wk9 .save/wk10
   ...
   mv .save/wk0 .save/wk1
   find .git/refs -type f -print | xargs cat >.save/wk0
 
 - prepare a pack to allow a single pack fetch to bring a
   repository that had everything reachable from wk$N refs
   up-to-date to the current, for selected recent weeks (say N=1,
   2, 4, 12):

   for N in 1 2 4 12
   do
       name=$(git-rev-list --objects \
                 $(sed -e 's/^/^/' .save/wk$N) \
                 $(cat .save/wk0) |
              git-pack-object pack-) &&
       mv pack-$name.* .git/objects/pack/.
   done

   remove the pack files that we created this way last week from
   the repository (if the repository did not have any activity
   during the last week we would have created the same set of
   packs.  make sure we do not remove them).

 - except that, we keep the longest period (i.e. N=12 in this
   example) one every N weeks (that's how 1yr, 9mo, 6mo packs in
   the picture are kept).

This way, really old stuff (say, older than 3mo) will stay
intact and will not be repacked, so people reasonably up-to-date
(within 12 weeks in the example) need to fetch only one pack
(and unpacked objects since the last pack optimization), but
people without the ancient history need to go further back.
