From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 10 Sep 2006 12:10:07 -0400
Message-ID: <20060910161007.8846.qmail@science.horizon.com>
References: <9e4733910609100756r1ece1e22m38054536a2909dd4@mail.gmail.com>
Cc: git@vger.kernel.org, linux@horizon.com, paulus@samba.org,
	torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Sep 10 18:10:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMRt1-0002cA-H9
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 18:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWIJQKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIJQKM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 12:10:12 -0400
Received: from science.horizon.com ([192.35.100.1]:24371 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932278AbWIJQKK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 12:10:10 -0400
Received: (qmail 8847 invoked by uid 1000); 10 Sep 2006 12:10:07 -0400
To: jonsmirl@gmail.com
In-Reply-To: <9e4733910609100756r1ece1e22m38054536a2909dd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26799>

> You noticed too that forks of small apps are relatively slow. The
> first pass of the import tools used fork for everything and took a
> week to run with 60% of the time spent in the kernel. There may be
> some work to do on fork in the kernel. Does mapping the kernel into
> the top 1G slow down fork of these small apps? Or are they dynamically
> linked to something that is bringing in millions of pages? When I was
> doing oprofile all of the time was in the actual fork call and page
> table copying.

Actually, Linux has one of the fastest forks around, 100-200 us on
modern x86.  For large executables, the shared page tables patch (is it
merged yet?) might help.

No, mapping the kernel does NOT slow anything down.  Those page tables are
shared between all processes, and use the x86's global bit to avoid being
forced out of the TLB during context switch.  Attempting to make the
kernel mapping vary between processes would slow things down enormously!

I'm not finding reasonably recent Linux/FreeBSD comparisons.  There are
plenty of Max OS X comparisons, but it appears to particularly suck,
so that's a bit of a straw man.  See, e.g.
http://www.anandtech.com/mac/showdoc.aspx?i=2520&p=7
or some figures from 2002:
http://lists.apple.com/archives/darwin-kernel/2002/Oct/msg00009.html
----------------------------------------------------------------
Host      OS            Mhz  null null      open selct sig  sig  fork exec sh
                             call I/O  stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
g4           Darwin 1.4  799 2.21 3.19 12.6 16.4 30.4  3.78 9.88 1576 4095 13.K
g4           Darwin 5.5  797 2.26 3.15 14.5 17.8 30.4  3.82 10.2 5685 12.K 40.K
g4.local.    Darwin 6.0  797 1.47 2.73 17.2 20.7 27.2  3.00 10.5 7517 17.K 41.K
g4.local.    Darwin 6.0  (after misconfiguration fixed)          1575
g4        Linux 2.4.18-  799 0.42 0.69 2.52 3.79 33.6  1.23 3.08 659. 2642 12.K
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
jim          Darwin 1.4  448 2.85 4.23 9.53   17       4.83   14 2402 6817  19K
jim.local    Darwin 6.1  448 1.89 3.71   21   29    43 3.85   15 2832 8955  19K

For small processes such as lmbench uses, you can see from the above that
exec is much more expensive than fork.  Also
http://www.opersys.com/lrtbf/index.html
http://marc.theaimsgroup.com/?l=linux-kernel&m=112086443319815
http://www.opensourcetutorials.com/tutorials/Server-Side-Coding/Administration/hyper-threading-linux/page4.html

As for small apps and dynamic linking, glibc isn't tiny (prelink can
help), but that's post-exec.  If it's in the fork() call, then it's just
a case that your app's memory space is big and even copying all of its
page tables is expensive.

If you're invoking one of the git programs that's a shell script, that
adds its own startup overhead, of course.
