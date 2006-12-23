From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sat, 23 Dec 2006 11:45:44 -0800
Message-ID: <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
	<20061223073428.GL9837@spearce.org>
	<Pine.LNX.4.64.0612231038410.3671@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 23 20:46:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyCpB-0005PO-HA
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 20:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbWLWTpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 14:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbWLWTpq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 14:45:46 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53086 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbWLWTpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 14:45:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223194544.WOEV25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 14:45:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2Kl11W00R1kojtg0000000; Sat, 23 Dec 2006 14:45:02 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org> (Linus
	Torvalds's message of "Sat, 23 Dec 2006 10:44:51 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35327>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 23 Dec 2006, Shawn O. Pearce wrote:
>>
>> This finally turns on the sliding window behavior for packfile data
>> access by mapping limited size windows and chaining them under the
>> packed_git->windows list.
>
> Hmm. You seem to default the window size to 32MB.
>
> Maybe I'm reading that code wrong, but I think that's a bit sad.
>
> In particular, in any setup that doesn't like mmap() at all (eg Cygwin), 
> and uses the "malloc+read" emulation, 32MB is actually likely much too 
> big. It's probably better to use something like a 1MB slice instead, since 
> otherwise you'll often be reading much too much.
>
> So I'd argue that if you fall back to read() (or pread) instead of mmap, 
> the 32MB thing is way too big.
>
> So maybe you should make the default depend on NO_MMAP (although it would 
> seem that the default Makefile makes Cygwin actually default to using mmap 
> these days, so maybe it's not a big deal).

I have been thinking that we should perhaps change Cygwin
default to NO_MMAP.  Safer but slower would be better than not
working correctly for people on FAT32.

I agree that 32MB is too big for emulated mmap().  We might want
to further enhance the new use_pack() API so that the caller can
say how much it expects to consume, to help pread() based
emulation avoid reading unnecessary data.

Also the patch makes the maximum mapped from (1<<26) bytes to
256MB which is four-fold; I think tweaking such settings should
be done as a separate step.
