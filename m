From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 13:11:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> 
 <446FA262.7080900@gentoo.org>  <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
  <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>  <44713BE4.9040505@gentoo.org>
  <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> 
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> 
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> 
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> 
 <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 22:11:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiGkm-0003ue-4D
	for gcvg-git@gmane.org; Mon, 22 May 2006 22:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWEVULp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWEVULp
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 16:11:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751161AbWEVULo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 16:11:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MKBKtH026629
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 13:11:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MKBIXD011910;
	Mon, 22 May 2006 13:11:19 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20529>



On Tue, 23 May 2006, Martin Langhoff wrote:
> 
> The dev machine where I am running the import is a slug! It's still
> working on it, only gotten to 7700 commits, with the cvsimport process
> stable at 28MB RAM and cvs stable at 4MB.

I have to say, that cvsimport script really does do horrible things. It's 
basically a fork/exec/exit benchmark, as far as I can tell. Running 
oprofile on the thing, the top offenders are (ignore the 45% idle thing: 
it's just because this was run on a dual-cpu system, so since it's almost 
completely single-threaded you get ~50% idle by default).

	3117654  45.8708  vmlinux                  vmlinux                  .power4_idle
	802313   11.8046  vmlinux                  vmlinux                  .unmap_vmas
	632913    9.3122  vmlinux                  vmlinux                  .copy_page_range
	150359    2.2123  vmlinux                  vmlinux                  .release_pages
	131330    1.9323  vmlinux                  vmlinux                  .vm_normal_page
	117836    1.7337  libperl.so               libperl.so               (no symbols)
	74098     1.0902  libgklayout.so           libgklayout.so           (no symbols)
	54680     0.8045  vmlinux                  vmlinux                  .free_pages_and_swap_cache
	54300     0.7989  libfb.so                 libfb.so                 (no symbols)
	49052     0.7217  vmlinux                  vmlinux                  .copy_4K_page
	46559     0.6850  libc-2.4.so              libc-2.4.so              getc
	42677     0.6279  vmlinux                  vmlinux                  .page_remove_rmap
	41133     0.6052  libc-2.4.so              libc-2.4.so              ferror
	..

those kernel functions are all about process create/exit, and COW faulting 
after the fork.

Now, this is on ppc, so process creation is likely slower (idiotic PPC VM 
page table hashes), but Linux is actually very good at doing this, and the 
fact that process create/exit is so high is a very big sign that the 
script just ends up executing a _ton_ of small simple processes that do 
almost nothing.

I wonder why those "git-update-index" calls seem to be (assuming I read 
the perl correctly) done only a few files at a time. We can do a hundreds 
in one go, but it seems to want to do just ten files or something at the 
same time. Although since most commits should hopefully just modify a 
couple of files, that probably isn't a big deal.

That thing would probably be an order of magnitude faster if written to 
use the git library interfaces directly. Of course, the CVS part is 
probably a big overhead, so it might not help much (I would not be 
surprised at all if a number of the fork/exec/exit things are due to the 
CVS server starting RCS or something, not due to git-cvsimport itself)

		Linus
