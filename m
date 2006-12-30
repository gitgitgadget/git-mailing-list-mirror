From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Sat, 30 Dec 2006 11:27:26 -0800
Message-ID: <7vhcvdjiap.fsf@assigned-by-dhcp.cox.net>
References: <20061228073441.GB17304@spearce.org>
	<7vmz58whnx.fsf@assigned-by-dhcp.cox.net>
	<20061228084245.GA18150@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 20:27:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0jrk-0000TG-KO
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 20:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWL3T1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWL3T1d
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 14:27:33 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:47622 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030306AbWL3T1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 14:27:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061230192727.HAYB7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 14:27:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 57Sg1W00p1kojtg0000000; Sat, 30 Dec 2006 14:26:41 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061228084245.GA18150@spearce.org> (Shawn Pearce's message of
	"Thu, 28 Dec 2006 03:42:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35629>

Shawn Pearce <spearce@spearce.org> writes:

>> I am very tempted to have sliding window mmap() if it helps
>> people on cygwin, for example.
>
> Especially now that NO_MMAP is the default on that platform.
> At this point it may be ready to graduate to next to try and get a
> wider audience.  Since fixing that segfault in pack-objects I can't
> break it.  Of course I couldn't break it before you found that error,
> so take my words with a grain of salt... ;-)

After I fixed a few problems in sp/mmap topic (one was a bug
that screwed up OBJ_OFS_DELTA codepath in pack-objects, another
was an unrelated bug in send-pack that merging this series
revealed), I've tried to redo _all_ merges leading to the tip of
'pu' in git.git history, with small and default mmap window
sizes on my primary machine.

With the default setting, the whole experiment to redo 1561
merges took this much:

193.54user 131.17system 5:23.48elapsed 100%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+35700235minor)pagefaults 0swaps

While with smaller window size i.e. with

        [core]
                packedgitwindowsize = 20
                packedgitlimit = 4194304

the numbers are almost the same:

195.90user 134.40system 5:29.14elapsed 100%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+35862520minor)pagefaults 0swaps

A more important thing is that the merge results exactly match
what I get without sp/mmap (i.e. 'next').  Interestingly, with
either configurations, sp/mmap is slightly faster than 'next'
but I haven't done repeated tests so it may not be statistically
significant.

This is by no means a proof of correctness, but is a good way to
gain more confidence in the code.
