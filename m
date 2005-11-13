From: Junio C Hamano <junkio@cox.net>
Subject: Re: Balanced packing strategy
Date: Sun, 13 Nov 2005 15:13:12 -0800
Message-ID: <7vbr0o87lj.fsf@assigned-by-dhcp.cox.net>
References: <1131800663.29461.11.camel@blade>
	<cae2e895f6598781f4f22b76e781684b@codefountain.com>
	<20051112135947.GC30496@pasky.or.cz>
	<200511132106.29841.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 14 00:14:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbR2O-0003CC-Fw
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 00:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVKMXNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVKMXNP
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 18:13:15 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:29918 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750783AbVKMXNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 18:13:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051113231248.FEPH15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Nov 2005 18:12:48 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <200511132106.29841.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 13 Nov 2005 21:06:29 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11755>

Petr Baudis <pasky@suse.cz> writes:

> This has the property that the second half of given pack is covered by
> objects with precision lower by one. This is a relatively high overload
> (this can be balanced by only keeping the last third or whatever), but
> it designed to reduce the overhead of fetching packs over dumb
> transport.

I have a feeling that you would be better off if instead do the
repacking on the server side to prepare multiple packs, each of
which has all the necessary objects to bring people who was
up-to-date at various timerange ago, to arrange that you would
need only one patch fetch with individual objects near the tip.

This obviously needs smarter client-side support.

Suppose we are somewhere after releasing v1.8 and inching
towards v1.9:

In your proposal, the object ranges each pack contains would
look like this:

 v1.0..v1.5 --------
 v1.5..v1.6        -----
 v1.6..v1.7            -------
 v1.7..v1.8                  -----
 individual objects               ....

That is, there are slight overlaps but you would do multiple
packs if you are really behind.

Instead, you could do this:

 v1.0..v1.8 ----------------------
 v1.5..v1.8         --------------
 v1.6..v1.8             ----------
 v1.7..v1.8                   ----
 individual objects               ....

Everybody starts from the tip, fetching individual objects, and
when the last repack boundary (the time we released 1.8) is
reached, the dumb protocol downloader now faces a choice.  The
indices are fairly small, so you fetch all of them and see how
many objects you are lacking from each pack.  If you were
up-to-date very long time ago, say at v1.2, you would obviously
need to fetch the longest pack.  If you were up-to-date
recently, say after v1.6 was released, you need to fetch smaller
pack.

Given the self containedness requirements, any path that is
touched once in a period needs at least one full copy of it in
each pack (all other revisions could be deltified), and I
suspect in practice the oldest pack (v1.0..v1.5 pack in your
scheme) would not save much space by not having v1.5..v1.8
history.  We could tweak things further to do something like
this:

 v1.0..v1.8 ------------------
 v1.5..v1.8         ----------
 v1.6..v1.8             ------
 v1.7..v1.8                   ----
 individual objects               ....

to also account for a fact that the recent ones cover shorter
time range and not many paths are touched.
