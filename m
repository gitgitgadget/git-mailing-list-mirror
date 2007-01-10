From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek() sequence.
Date: Tue, 09 Jan 2007 16:21:24 -0800
Message-ID: <7v7ivvivej.fsf@assigned-by-dhcp.cox.net>
References: <45A40C15.1070200@shadowen.org>
	<20070109232540.GA30023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 10 01:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RDe-00076G-VB
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbXAJAV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbXAJAV2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:21:28 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35258 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578AbXAJAV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:21:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110002125.DWEG19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 19:21:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9CLa1W01u1kojtg0000000; Tue, 09 Jan 2007 19:20:35 -0500
To: git@vger.kernel.org
In-Reply-To: <20070109232540.GA30023@spearce.org> (Shawn O. Pearce's message
	of "Tue, 9 Jan 2007 18:25:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36438>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> With the exception of this style difference, the patch looked
> pretty good.  Nice work Stefan.  Andy's right, we do tend to prefer
> "rc = read_in_full" over "rc=read_in_full".  Quite a bit actually,
> though Junio is the final decider on all such matters as he gets
> to choose to accept or reject the patch.  ;-)

I am a nice guy and do not reject a patch for missing two SP
characters which means I have to --amend it which takes time
away from me.  Maybe I should stop being nice ;-).

>> > +
>> > +        if (current_offset != lseek(fd, current_offset, SEEK_SET))
>> > +                return -1;
>> 
>> How likely are we ever to be in the right place here?  Seems vanishingly
>> small putting us firmly in the four syscalls per call space.  I wonder
>> if git ever actually cares about the seek location.  ie if we could stop
>> reading and resetting it.  Probabally not worth working it out I guess
>> as any _sane_ system has one.
>
> Andy's right actually.  If we are using pread() we aren't relying
> on the current file pointer.  Which means its unnecessary to get
> the current pointer before seeking to the requested offset, and its
> unnecessary to restore it before the git_pread() function returns.

The caller of pread() does not care the current position, but
that is not to mean it does not care the position after pread()
returns.  The current callers do not care, though.
