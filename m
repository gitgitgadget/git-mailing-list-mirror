From: Junio C Hamano <junkio@cox.net>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Wed, 16 Nov 2005 12:13:42 -0800
Message-ID: <7vlkzo73m1.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
	<20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se>
	<20051115223340.GA3951@steel.home>
	<Pine.LNX.4.64.0511151552400.11232@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 16 21:14:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTf9-0000Ee-F7
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVKPUNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKPUNo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:13:44 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45507 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932334AbVKPUNo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 15:13:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116201250.LJCK17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 15:12:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511151552400.11232@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 15 Nov 2005 15:58:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12048>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 15 Nov 2005, Alex Riesen wrote:
>> 
>> Sorry, it doesn't. The code loops here:
>> 
>> 401             /* find the permutations which contain all missing objects */
>> 402             perm_all = perm = get_all_permutations(non_unique);
>
> Looks like the whole thing is exponential.

This reminds me of one thing I have been meaning to remove.

The $GIT_OBJECT_DIRECTORY/info/pack file produced by
update-server-info records not just the packs (P lines), but its
dependencies (D lines) and top objects (T lines).  If there are
more than one packs, D lines are meant to help the downloader to
figure out what other packs are needed to complete.

"meant to" is the keyword here.  The original heuristics was
very bad (still correct but way suboptimal) and it has never
been updated.  I do not use that information myself in http
fetch, and I do not think any Porcelain uses it.

Top objects are tags and commits in the pack that are not
reachable from any other object in the same pack.  This can be
useful if you obtain just a packfile -- you can run server-info
to produce info/pack file, and resurrect the branch heads and
tags by using them --- you would not know what they are called,
though.  I have been thinking it may be worthwhile to also
record bottom objects (B lines, naturally) --- tags and commits
in the pack that refer to tags or commits not present in the
same pack.  This would help commit walkers to decide which pack
is more efficient to slurp when faced with multiple choices.  If
you see a pack all whose bottom objects you have in your
repository, fetching that would complete the commit walking, so
the choice would become the matter of choosing such a pack among
multiple that has smallest number of objects you do not have
locally -- you would have the index file for each pack at that
point.
