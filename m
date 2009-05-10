From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid unnecessary 'lstat()' calls in 'get_stat_data()'
Date: Sun, 10 May 2009 11:40:53 -0700
Message-ID: <7v7i0oztqi.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0905091501460.3586@localhost.localdomain>
	<7v8wl5613c.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0905100943370.3586@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 10 20:41:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3DxP-0001Vs-AN
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbZEJSkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755075AbZEJSky
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:40:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:32868 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbZEJSkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:40:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510184054.URIJ17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 May 2009 14:40:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id pugu1b0024aMwMQ04uguuy; Sun, 10 May 2009 14:40:54 -0400
X-Authority-Analysis: v=1.0 c=1 a=FBa1IiYnV70A:10 a=_rGolq_aGIsA:10
 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=i7_erqn0K4wXRTdKx20A:9
 a=jRKbG0R9RUeJBZH2OfoA:7 a=ZblIstSz65YyIqJSscRUIgNAFHAA:4 a=U62fhAwekXMA:10
 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118732>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I've found that "make -j64 test" does fairly well, bringing the cost down 
> to something reasonable. Some of the SVN tests seem to sometimes randomly 
> fail when done in parallel (I've not tried to debug it, I assume it's 
> either some SVN bug, or just the test infrastructure having some shared 
> SVN central repo thing), but it happens rarely enough that even if you 
> have to run it twice, it's still worth it. 
>
> [ Side note: the success output of "make test" makes it almost impossible 
>   to debug the error cases when you do that "make -j64" thing. Sad. It 
>   would be good to have the tests that fail clearly say exactly what test 
>   failed, because when you run 64 tests at the same time, having "case 9" 
>   fail is almost totally useless information - test 9 of _which_ 
>   testsuite? ]
>
> I don't generally build docs, but they should run in parallel too, and at 
> least your fedora build on kernel.org has a nice quad-core machine with 
> lots of memory, so "-j8" or something is reasonable.

Thanks; unfortunately I already do all the tricks known to me, including
running make in parallel (I happen to use -j4) and maintaining a separate
build farm for each of the branches to avoid recompilation of programs and
reformatting docs.  However, on a

    model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
    stepping        : 1
    cpu MHz         : 2004.185
    cache size      : 512 KB

with slow IDE disks, optimizing and cheating at the software level goes
only so far...  For example, a typical cycle I just did looks like this:

$ /usr/bin/time Meta/Dothem --pedantic >:all.log 2>&1; tail -n 2 :all.log
2089.15user 1610.16system 45:56.91elapsed 134%CPU (0avgtext+0avgdata 0maxresident)k
220088inputs+3723296outputs (696major+305868883minor)pagefaults 0swaps

You have to remember that people use boxes that are a bit slower compared
to the boxes you are used to ;-)
