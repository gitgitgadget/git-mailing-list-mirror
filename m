From: David Kastrup <dak@gnu.org>
Subject: Benchmarking git-add vs git-ls-files+update-index (was: way to automatically add untracked files?)
Date: Sun, 05 Aug 2007 12:33:38 +0200
Message-ID: <85vebu9sot.fsf_-_@lola.goethe.zz>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org>
	<7vr6mih8a8.fsf@assigned-by-dhcp.cox.net>
	<85fy2ycu7n.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 12:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHdQp-0007mY-JE
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbXHEKdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXHEKdv
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:33:51 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:53042 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754217AbXHEKdu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 06:33:50 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 9A0E525D332;
	Sun,  5 Aug 2007 12:33:48 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 7C17F5BF46;
	Sun,  5 Aug 2007 12:33:48 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id C58C5135FC;
	Sun,  5 Aug 2007 12:33:46 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7FF731C3D500; Sun,  5 Aug 2007 12:33:38 +0200 (CEST)
In-Reply-To: <85fy2ycu7n.fsf@lola.goethe.zz> (David Kastrup's message of "Sun\, 05 Aug 2007 09\:32\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3858/Sun Aug  5 09:40:13 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54988>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> ... (except, as we found out last week, we've had a huge 
>>> performance regression, so that's actually a really slow way to do it, and 
>>> so it's actually faster to do
>>>
>>> 	git ls-files -o | git update-index --add --stdin
>>> 	git commit -a
>>>
>>> instead...
>>
>> Is it still the case after the fix in rc4?  Other than the
>> theoretical "on multi-core, ls-files and update-index can run in
>> parallel" performance boost potential,

dak@lola:/home/tmp/texlive$ git-init
Initialized empty Git repository in .git/
dak@lola:/home/tmp/texlive$ time git --work-tree=/usr/local/texlive/2007/texmf-dist add .

real    9m36.256s
user    2m2.408s
sys     0m25.874s
dak@lola:/home/tmp/texlive$ time git --work-tree=/usr/local/texlive/2007/texmf-dist add .

real    0m34.161s
user    0m0.448s
sys     0m2.212s

[So the rc4 fix seems to have made it.]

dak@lola:/home/tmp/texlive$ rm -rf .git;git-init
Initialized empty Git repository in .git/

dak@lola:/home/tmp/texlive$ time git --work-tree=/usr/local/texlive/2007/texmf-dist ls-files -z -m -o .|(cd /usr/local/texlive/2007/texmf-dist;git --git-dir=/home/tmp/texlive/.git update-index --add -z --stdin)

real    8m9.370s
user    2m1.172s
sys     0m25.138s
dak@lola:/home/tmp/texlive$ time git --work-tree=/usr/local/texlive/2007/texmf-dist ls-files -z -m -o .|(cd /usr/local/texlive/2007/texmf-dist;git --git-dir=/home/tmp/texlive/.git update-index --add -z --stdin)

real    6m4.447s
user    0m16.801s
sys     0m12.333s
dak@lola:/home/tmp/texlive$ 

[Hm.  Maybe "modified" files are not what I think they are?]

dak@lola:/home/tmp/texlive$ time git --work-tree=/usr/local/texlive/2007/texmf-dist ls-files -z -o .|(cd /usr/local/texlive/2007/texmf-dist;git --git-dir=/home/tmp/texlive/.git update-index --add -z --stdin)

real    6m0.120s
user    0m16.977s
sys     0m12.653s

[No, doesn't help.]

[Just for kicks, let's try getting the Linux scheduler out of our hair
in the initial case.]

dak@lola:/home/tmp/texlive$ time git --work-tree=/usr/local/texlive/2007/texmf-dist ls-files -z -m -o .|dd bs=8k|(cd /usr/local/texlive/2007/texmf-dist;git --git-dir=/home/tmp/texlive/.git update-index --add -z --stdin)
201+1 records in
201+1 records out
1650230 bytes (1.7 MB) copied, 513.125 seconds, 3.2 kB/s

real    8m45.088s
user    2m2.052s
sys     0m25.870s

[Hm, does more damage than it helps.]

So in summary: git-ls-files -m is apparently lacking the optimization
of git-add for unchanged inodes.  Bad.  Using it together with
git-update-index in the initial case saves some time over git-add, but
not breathtakingly so.  This is on a single core.

Most of the time is spent waiting for I/O.  Threaded execution should
supposedly help in having less waiting time, but at least in this
combination, the payoff does not seem overwhelming.

One should mention that the stuff I tested it on is actually sitting
on a reiserfs file system (though the repository is on ext3).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
