From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 01:03:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603250025550.1704@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 10:04:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN4gu-0007Cn-Mi
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 10:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWCYJD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 04:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWCYJDz
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 04:03:55 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:39561 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750735AbWCYJDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 04:03:54 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C6923> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 25 Mar 2006 01:03:43 -0800
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17964>

On Fri, 24 Mar 2006, Linus Torvalds wrote:

> - the libxdiff algorithm is different, and I bet GNU diff has gotten a
>   lot more testing. And the thing is, generating a diff is not an exact
>   science - you can get two different diffs (and you will), and they can
>   both be perfectly valid. So it's not possible to "validate" the
>   libxdiff output by just comparing it against GNU diff.

Correct, the diff(A, B) is not unique. If you look inside the test 
directory, there's an xregression binary that does:

1) Random generate A
2) Create B by random changing A
3) Create D=A-B
4) Verify that B+D==A and A-D==B (using the library patch function)

It does and repeat this operation continuosly, for both text (using text 
diff/patch) and binary (using binary diff/patch). It ran several days 
w/out finding errors, so I've a good confidence about it.



> - GNU diff does some nice eye-candy, like trying to figure out what the
>   last function was, and adding that information to the "@@ .." line.
>   libxdiff doesn't do that.

This, I don't think is a natural part of a generic text/binary diff/patch 
library. If you feel it is important, you could post-process the diff, but 
IMO is kinda bogus.



> - The libxdiff thing has some known deficiencies. In particular, it gets
>   the "\No newline at end of file" case wrong. So this is currently for
>   the experimental branch only. I hope Davide will help fix it.

This, need fix. At the moment, in my projects I enforce the final EOL if 
missing (look inside the file-load function inside the test directory).



> Technical note: this is based on libxdiff-0.17, but I did some surgery to
> get rid of the extraneous fat - stuff that git doesn't need, and seriously
> cutting down on mmfile_t, which had much more capabilities than the diff
> algorithm either needed or used. In this version, "mmfile_t" is just a
> trivial <pointer,length> tuple.
>
> That said, I tried to keep the differences to simple removals, so that you
> can do a diff between this and the libxdiff origin, and you'll basically
> see just things getting deleted. Even the mmfile_t simplifications are
> left in a state where the diffs should be readable.

Here you have two options. Either you suck in the libxdiff code and change 
it to drop/change the stuff you don't want (the whole libxdiff library 
compiled with -O2 is 33KB though). Or you use the library as is, like 
you'd use libz & co. Once you have your own load-mmfile, you can pretty 
much feed libxdiff as is. Not my choice though, so pick the one you think 
best for your project.
I see you use XDF_NEED_MINIMAL. You might want to do some experiments with 
and without, to see how diff size changes, versus time.



> Apologies to Davide, whom I'd love to get feedback on this all from (I
> wrote my own "fill_mmfile()" for the new simpler mmfile_t format: the old

If you look inside the test directory, I use a similar function. The 
reason of the mmfile born for a use I made of the library inside an 
embedded device where there was no guarantee of contiguos memory, and dat 
could have been generated in chunks. OTOH an mmfile with a single block is 
a perfectly valid mmfile ;)



PS: Another solution you have is to libify GNU diff by creating a
     diff_main() & co., usual libification wrapping. You'd need to change
     the exit() that diff throws with a setjmp/longjmp, and make it call
     you own mem alloc/free functions, in order to free up memory diff does
     not clear on return. I did it once, not many changes. This solution
     will give you all the GNU diff crud, like function names, etc...



- Davide
