From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Sun, 18 Mar 2007 02:45:12 -0700
Message-ID: <7v8xdunavr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703162257560.18328@xanadu.home>
	<Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
	<118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
	<Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703172136440.18328@xanadu.home>
	<Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703172200060.18328@xanadu.home>
	<Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 10:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSrwz-0005Ib-E2
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 10:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbXCRJpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 05:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbXCRJpP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 05:45:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46662 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbXCRJpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 05:45:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318094513.UOPR24587.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 18 Mar 2007 05:45:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c9lC1W0041kojtg0000000; Sun, 18 Mar 2007 05:45:12 -0400
In-Reply-To: <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 17 Mar 2007 20:06:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42484>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This shaves off another ~5-10% from some loads that are very tree 
> intensive (notably doing commit filtering by a pathspec).
>
> Signed-off-by: Linus Torvalds  <torvalds@linux-foundation.org>"

With your 256-entry cache, Nico's reusing objects out of delta
base cache, and this strlen() patch

	git blame -C block/ll_rw_blk.c

gets these numbers:

(v1.5.0)
14.71user 0.26system 0:15.07elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+93622minor)pagefaults 0swaps

(master + three patches)
8.94user 0.14system 0:09.10elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+40075minor)pagefaults 0swaps

Just for fun, these are the same for the kernel history with tglx-history 
repository's history grafted behind it, i.e. with this grafts file:

$ cat .git/info/grafts
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 e7e173af42dbf37b1d946f9ee00219cb3b2bea6a

(v1.5.0)
73.80user 2.57system 1:16.40elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+773077minor)pagefaults 0swaps

(master + three patches)
65.14user 0.40system 1:05.55elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+125052minor)pagefaults 0swaps

In either case, it is showing drastic reduction of minor faults.
