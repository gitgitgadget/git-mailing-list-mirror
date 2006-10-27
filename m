X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 11:56:14 -0700
Message-ID: <7vy7r1egfl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610261105200.12418@xanadu.home>
	<45413209.2000905@tromer.org>
	<Pine.LNX.4.64.0610262038320.11384@xanadu.home>
	<20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org>
	<20061027030054.GB28407@spearce.org>
	<Pine.LNX.4.64.0610271022240.11384@xanadu.home>
	<20061027143854.GC20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 19:03:51 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Eran Tromer <git2eran@tromer.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061027143854.GC20017@pasky.or.cz> (Petr Baudis's message of
	"Fri, 27 Oct 2006 16:38:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30340>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdWsd-0004ei-03 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 20:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752421AbWJ0S4U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 14:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbWJ0S4T
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 14:56:19 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40687 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1752410AbWJ0S4Q
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 14:56:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027185615.UGBO18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Fri, 27
 Oct 2006 14:56:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fWvx1V00V1kojtg0000000 Fri, 27 Oct 2006
 14:55:58 -0400
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Oct 27, 2006 at 04:27:05PM CEST, I got a letter
> where Nicolas Pitre <nico@cam.org> said that...
>> On Thu, 26 Oct 2006, Shawn Pearce wrote:
>> > OK so the repository won't get corrupted but the repack would be
>> > forced to abort.
>> 
>> Maybe this is the best way out?  Abort git-repack with "a fetch is in 
>> progress -- retry later".  No one will really suffer if the repack has 
>> to wait for the next scheduled cron job, especially if the fetch doesn't 
>> explode packs into loose objects anymore.
>
> I don't really like this that much. Big projects can have 10 commits per
> hour on average, and they also take potentially long time to repack, so
> you might get to never really repack them.

One question about that statistics is if the frequency of 10
commits per hour is 10 pushes into the central repository per
hour or 10 commits distributed all over the world in dozens of
developers' repositories.

Even if the number is 10 pushes into the central repository per
hour, I do not see it as a big problem in practice from the
workflow point of view.  Even people sticking to their CVS
workflow to have a central repository model are gaining big time
from being able to keep working disconnected by switching to git
using the shared repository mode, and it should not be a big
deal if the central repository master shuts down pushes into the
repository for N minutes a day for scheduled repacking.  So it
could be that a more practical way out is to say "'repack -a -d'
and 'prune' are to be run when things are quiescent".

A cron job for the scheduled repack/prune can set a flag
(repository wide lockfile or something) to ask new push/fetch to
wait and come back later, and we could set up a pre-* hooks for
push/fetch to notice it.  While push/fetch processes that have
already been started can still interfere, as long as they cause
repack/prune to fail the "deletion" part, eventually outstanding
push/fetch will die out and the cron job will have that
quiescent window.

