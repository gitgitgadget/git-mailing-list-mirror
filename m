From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Fri, 07 Dec 2007 04:53:29 -0800 (PST)
Message-ID: <20071207.045329.204650714.davem@davemloft.net>
References: <20071206.193121.40404287.davem@davemloft.net>
	<20071207063848.GA13101@coredump.intra.peff.net>
	<9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, nico@cam.org, dberlin@dberlin.org,
	harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: jonsmirl@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 07 13:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ciF-00074u-VG
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 13:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbXLGMxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 07:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXLGMxb
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 07:53:31 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56213
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751307AbXLGMxa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 07:53:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id A7F00C8C17F;
	Fri,  7 Dec 2007 04:53:29 -0800 (PST)
In-Reply-To: <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67421>

From: "Jon Smirl" <jonsmirl@gmail.com>
Date: Fri, 7 Dec 2007 02:10:49 -0500

> On 12/7/07, Jeff King <peff@peff.net> wrote:
> > On Thu, Dec 06, 2007 at 07:31:21PM -0800, David Miller wrote:
> >
> > # and test multithreaded large depth/window repacking
> > cd test
> > git config pack.threads 4
> 
> 64 threads with 64 CPUs, if they are multicore you want even more.
> you need to adjust chunk_size as mentioned in the other mail.

It's an 8 core system with 64 cpu threads.

> > time git repack -a -d -f --window=250 --depth=250

Didn't work very well, even with the one-liner patch for
chunk_size it died.  I think I need to build 64-bit
binaries.

davem@huronp11:~/src/GCC/git/test$ time git repack -a -d -f --window=250 --depth=250
Counting objects: 1190671, done.
fatal: Out of memory? mmap failed: Cannot allocate memory

real    58m36.447s
user    289m8.270s
sys     4m40.680s
davem@huronp11:~/src/GCC/git/test$ 

While it did run the load was anywhere between 5 and 9, although it
did create 64 threads, and the size of the process was about 3.2GB
This may be in part why it wasn't able to use all 64 thread
effectively.  Like I said it seemed to have 9 active at best, at any
one time, most of the time only 4 or 5 were busy doing anything.

Also I could end up being performance limited by SHA, it's not very
well tuned on Sparc.  It's been on my TODO list to code up the crypto
unit support for Niagara-2 in the kernel, then work with Herbert Xu on
the userland interfaces to take advantage of that in things like
libssl.  Even a better C/asm version would probably improve GIT
performance a bit.

Is SHA a significant portion of the compute during these repacks?
I should run oprofile...
