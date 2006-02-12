From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary-tree-based objects.
Date: Sat, 11 Feb 2006 22:07:04 -0800
Message-ID: <7vaccxdsaf.fsf@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
	<7vslqpi9mg.fsf@assigned-by-dhcp.cox.net>
	<7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602112045340.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602112117560.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602112122400.3691@g5.osdl.org>
	<7v1wy9f7q4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 12 07:07:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8AO7-0008VY-Ko
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 07:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWBLGHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 01:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWBLGHI
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 01:07:08 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32216 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964817AbWBLGHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 01:07:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212060411.VVTW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 01:04:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15985>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Sat, 11 Feb 2006, Linus Torvalds wrote:
>>> 
>>> If somebody shows that the other approaches are faster, then I guess I'll 
>>> just have to sulk in a corner and grown quietly at people.
>>
>> growl. growL. With an 'L'!
>
> I do not get it.
> ...

I first suspected you just meant the typo (s/grown/growl/) but
it probably is that you really meant GROWL (and sulk).

It turns out that Johannes (with my patch to fix possible
unsigned int alignment issue and the initial call to
find_object()) is the clear winner.

        base   - tip of "master"
        lt-obj - the binary tree without balancing
        aj-obj - Alexandre's 256-way buckets
        js-obj - Johannes' circular hash

Although I have _not_ double checked the correctness of them, I
did not see major flaw in any of them.

base/git-rev-list --objects v2.6.14..linus
real	2m32.088s	user	2m2.830s	sys	0m0.890s
real	2m6.614s	user	2m1.860s	sys	0m0.660s
real	2m13.776s	user	2m2.450s	sys	0m0.590s
real	2m6.062s	user	2m2.420s	sys	0m0.690s
real	2m15.567s	user	2m3.170s	sys	0m0.900s

lt-obj/git-rev-list --objects v2.6.14..linus
real	0m42.889s	user	0m40.170s	sys	0m0.570s
real	0m44.247s	user	0m40.320s	sys	0m0.530s
real	0m40.891s	user	0m40.110s	sys	0m0.500s
real	0m41.874s	user	0m40.090s	sys	0m0.530s
real	0m41.596s	user	0m40.050s	sys	0m0.600s

aj-obj/git-rev-list --objects v2.6.14..linus
real	0m36.842s	user	0m36.200s	sys	0m0.490s
real	0m37.178s	user	0m36.740s	sys	0m0.390s
real	0m37.222s	user	0m36.540s	sys	0m0.610s
real	0m36.924s	user	0m36.410s	sys	0m0.360s
real	0m37.341s	user	0m36.150s	sys	0m0.620s

js-obj/git-rev-list --objects v2.6.14..linus
real	0m24.689s	user	0m24.120s	sys	0m0.390s
real	0m24.753s	user	0m24.020s	sys	0m0.360s
real	0m27.650s	user	0m24.470s	sys	0m0.440s
real	0m33.480s	user	0m24.030s	sys	0m0.460s
real	0m25.329s	user	0m24.490s	sys	0m0.390s


base/git-name-rev --all
real	0m4.193s	user	0m4.060s	sys	0m0.130s
real	0m4.179s	user	0m4.100s	sys	0m0.080s
real	0m4.210s	user	0m4.040s	sys	0m0.150s
real	0m4.162s	user	0m4.100s	sys	0m0.060s
real	0m4.697s	user	0m4.100s	sys	0m0.120s

lt-obj/git-name-rev --all
real	0m2.199s	user	0m2.120s	sys	0m0.080s
real	0m2.186s	user	0m2.110s	sys	0m0.080s
real	0m2.187s	user	0m2.150s	sys	0m0.040s
real	0m2.817s	user	0m2.150s	sys	0m0.070s
real	0m2.323s	user	0m2.170s	sys	0m0.050s

aj-obj/git-name-rev --all
real	0m2.136s	user	0m2.050s	sys	0m0.080s
real	0m2.164s	user	0m2.080s	sys	0m0.060s
real	0m2.143s	user	0m2.070s	sys	0m0.070s
real	0m2.141s	user	0m2.080s	sys	0m0.060s
real	0m2.154s	user	0m2.070s	sys	0m0.090s

js-obj/git-name-rev --all
real	0m2.047s	user	0m2.010s	sys	0m0.040s
real	0m2.040s	user	0m1.970s	sys	0m0.070s
real	0m2.025s	user	0m1.970s	sys	0m0.060s
real	0m2.170s	user	0m2.020s	sys	0m0.030s
real	0m2.046s	user	0m2.010s	sys	0m0.030s
