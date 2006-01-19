From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 11:10:00 -0500
Message-ID: <20060119161000.GA27888@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <7vlkxciodu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 17:11:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzcMb-0005VK-Gz
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 17:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWASQKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 11:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWASQKF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 11:10:05 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:3988 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161283AbWASQKB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 11:10:01 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 9CE845A8006; Thu, 19 Jan 2006 11:10:00 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkxciodu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14913>

On Thu, Jan 19, 2006 at 12:59:57AM -0800, Junio C Hamano wrote:
>Christopher Faylor <me@cgf.cx> writes:
>>"They" probably would like to hear about any irregularities that are
>>found.  "They" probably don't like it when people treat an open source
>>project as if it was some unresponsive proprietary enterprise which
>>does not listen to or accept patches.
>
>First of all, thanks for joining our discussion.

You're welcome.  I use git on linux and cygwin so I'm happy to try to help.

>Being able to hear from somebody from other project firsthand (not just
>listen to somebody talking in his own changelogs and code comments, but
>in actual e-mail exchange discussion) lets us put faces and names to
>the entity "so far just one of the external projects to us".

I only read this list sporadically but I have chimed in from time to time
when people were talking about cygwin.  For the most part, it seems like
my input hasn't been needed all that much.

>>>For reasons unknown, cygwin decided to use our sockaddr_storage.
>
>I haven't looked at the proposed patch by Alex, so would not comment on
>this part, but I'd appreciate your input.
>
>>>For the other, probably unrelated, reasons, they decided to leave
>>>declarations of DT_* macros in dirent.h without providing
>>>dirent->d_type.
>
>I was wondering what the justification for keeping DT_* without d_type
>myself.  What is the preferred resolution on this one from your point
>of view?  I suspect removing d_type while leaving DT_* was just a
>transient error and you would want to remove DT_* as well, in which
>case the patch on this issue by Alex would become unnecessary.

Actually, I started adding DT_* macros at one point, in preparation for
adding d_type, and then got sidetracked.  Their existence is a real bug
so, I have ifdef'ed out the DT macros in current CVS.

>>>And on top of that, they removed dirent->d_ino (or probably replaced it
>>>by __ino32, if at all).  BTW, can we somehow avoid using d_ino?  It is
>>>referenced only in fsck-objects.c Anyway, to workaround this I put
>>>
>>>COMPAT_CFLAGS += -Dd_ino=__ino32
>>>
>>>It helps, but surely is not the solution.
>>
>> I don't see how it could help since __ino32 is not actually filled in
>> with anything.  In fact, I'll rename the field to __invalid_ino32 to
>> make that clear.
>
>I think renaming __invalid_* makes sense.  I'll see how we would
>work this around on the git side to make things more portable.

There were two fields in the dirent struct.  One was the "real" d_ino
which was a 64-bit ino_t, __ino32 was a legacy field from a time when
inodes were 32 bits.  I had already renamed the d_ino to __invalid_d_ino
but I didn't think I had to rename __ino32, too, since it wasn't a
standard field and didn't think that anyone would be using it.  However,
it is now __invalid_ino32 (and will probably disappear entirely) in CVS.

I knew that there would be fallout from getting rid of d_ino but this
change has been a long time coming.  Previously, the inodes reported in
d_ino were different from the (correct) ones in st_ino and some
applications were understandbly confused by that fact.  Making d_ino
accurate would have meant that we'd have to open every file in readdir
to get the windows equivalent of inode information and, since we get
enough "cygwin is slow" complaints, that wasn't a cost we were willing
to pay.

cgf
