From: Junio C Hamano <junkio@cox.net>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 11:11:40 -0700
Message-ID: <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
	<7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171251210.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:12:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZtPl-0000kn-Op
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWJQSLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWJQSLm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:11:42 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:47527 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750736AbWJQSLl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:11:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017181141.BECI12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 14:11:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bWBU1V0091kojtg0000000
	Tue, 17 Oct 2006 14:11:28 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610171251210.1971@xanadu.home> (Nicolas Pitre's
	message of "Tue, 17 Oct 2006 13:00:09 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29098>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 17 Oct 2006, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > On Mon, 16 Oct 2006, Junio C Hamano wrote:
>> >
>> >> I'm still a bit under the weather and do not have enough
>> >> concentration to dig into the problem tonight, but I noticed
>> >> that something in "next", most likely the delta-base-offset
>> >> patchset, broke git-index-pack:
>> >> 
>> >> $ X=ec0c3491753e115e1775256f6b7bd1bce4dea7cd
>> >> $ wget http://www.kernel.org/pub/scm/git/git.git/objects/pack/pack-$X.pack
>> >> $ ~/git-master/bin/git-index-pack pack-$X.pack
>> >> ec0c3491753e115e1775256f6b7bd1bce4dea7cd
>> >> $ git-index-pack pack-$X.pack
>> >> fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has unresolved deltas
>> >
>> > Using the tip of the "next" branch (git version 1.4.2.4.gf9fe) I just 
>> > cannot reproduce this problem at all.  I always get a good index and 
>> > ec0c3491753e115e1775256f6b7bd1bce4dea7cd back.
>> 
>> Hmph.  I just got exactly the same breakage; could this be
>> another 64-bit breakage?  My breakage was on x86-64.
>
> I've been suspecting that since then as well.  I indeed tested on i386.
> But reviewing the code I just can't find any obvious spot where 64-bit 
> would be an issue, especially since your pack does not have any 
> OFS_DELTA objects.
>
> Could you instrument the code at the end of 
> index-pack.c:parse_pack_objects() to display how many deltas were 
> actually resolved and how many were not?  IOW is it a case of all or 
> nothing, or is there an isolated case of corruption lurking somewhere?

fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has
18915 unresolved ref-deltas and 0 ofs-deltas among 21205

By the way, "Gaaaah".  Is this find_delta() called from
find_delta_children() doing the right thing?  I wonder if this
is open to accidental collisions?. If you have an object name
whose last 12-bytes are all NUL and you have a pack offset whose
bytes happens to be a good prefix for an object, what happens?
