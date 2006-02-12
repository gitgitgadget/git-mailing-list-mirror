From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 11:13:59 -0800
Message-ID: <7vpsls9yq0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602121006360.3691@g5.osdl.org>
	<7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602121037460.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 20:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Mfe-0006Wa-2d
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 20:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWBLTOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 14:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBLTOD
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 14:14:03 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49819 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751359AbWBLTOB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 14:14:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212191136.RZYZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 14:11:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121037460.3691@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Feb 2006 10:53:18 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16013>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 12 Feb 2006, Junio C Hamano wrote:
>> 
>> This "fix" makes the symptom that me fire two (maybe three)
>> Grrrrr messages earlier this morning disappear.
>
> Goodie. I assume that was the fixed fix, not my original "edit out the 
> useless optimization and then break it totally" fix ;)
>
>> I haven't had my caffeine nor nicotine yet after my short sleep, so I 
>> need to take some time understanding your explanation first, but I am 
>> reasonably sure this must be it (not that I do not trust you, not at all 
>> -- it is that I do not trust *me* applying a patch without understanding 
>> when I have a bug reproducible).

Your explanation finally made sense to me, without caffeine nor
nicotine yet, but when I tried to do an illustration.

If the initial obj_allocs were 4 instead of 32, we may have
something lie this before rehashing.

slot    value
 0        3
 1        -
 2        -
 3        7

Rehash to double the hash goes like this:

        step1    step2    step3         fixup rehash
       enlarge  rehash   rehash         missing from
        array    "3%8"    "7%8"         the original
 0        3        -        -                -
 1        -        -        -                -
 2        -        -        -                -
 3        7        7        -                3
 4        -        3        3                -
 5        -        -        -                -
 6        -        -        -                -
 7        -        -        7                7

We cannot find "3%8" without the fix.

Thanks for the fix.  Will do an updated "master" soon.
