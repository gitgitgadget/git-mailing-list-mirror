From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Sun, 18 Mar 2007 08:54:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
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
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 16:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSxiF-0001Zh-6P
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 16:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbXCRPyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 11:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752157AbXCRPyX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 11:54:23 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43897 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbXCRPyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 11:54:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2IFs4cD020501
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Mar 2007 08:54:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2IFs3NT025642;
	Sun, 18 Mar 2007 07:54:03 -0800
In-Reply-To: <7v8xdunavr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.509 required=5 tests=AWL,DRASTIC_REDUCED,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42499>



On Sun, 18 Mar 2007, Junio C Hamano wrote:
> 
> 	git blame -C block/ll_rw_blk.c
> 
> Just for fun, these are the same for the kernel history with tglx-history 
> repository's history grafted behind it, i.e. with this grafts file:
> 
> $ cat .git/info/grafts
> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 e7e173af42dbf37b1d946f9ee00219cb3b2bea6a
> 
> (v1.5.0)
> 73.80user 2.57system 1:16.40elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+773077minor)pagefaults 0swaps
> 
> (master + three patches)
> 65.14user 0.40system 1:05.55elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+125052minor)pagefaults 0swaps
> 
> In either case, it is showing drastic reduction of minor faults.

That's an interesting test-case (and I get 53 seconds, nyaah, nyaah ;)

However, it's almost totally *not* about object access any more with my 
patches. All the top profiling hits are about generating the patches and 
assigning blame:

	samples  %        image name               app name                 symbol name
	470352   15.5813  git                      git                      xdl_hash_record
	298683    9.8944  git                      git                      cmp_suspect
	225156    7.4587  git                      git                      assign_blame
	221308    7.3312  libc-2.5.so              libc-2.5.so              memcpy
	177621    5.8840  libc-2.5.so              libc-2.5.so              memchr
	163571    5.4186  vmlinux                  vmlinux                  __copy_user_nocache
	129301    4.2833  git                      git                      xdl_prepare_ctx
	99009     3.2799  libc-2.5.so              libc-2.5.so              _int_malloc
	83899     2.7793  git                      git                      xdiff_outf
	80588     2.6696  libz.so.1.2.3            libz.so.1.2.3            (no symbols)
	..

so as you can see, libz is down in the 2.5% range, and strlen and the tree 
accessor functions are totally un the noise. 

So it looks like it *used* to be somewhat of a problem (the object access 
itself must have been about 10 seconds, since that got shaved off the 
time), but realistically, if you want to speed up "git blame", we can 
totally ignore the git object data structures, an dconcentrate on xdiff 
and on blame itself (cmp_suspect and assign_blame probably have some nasty 
O(n^2) behaviour or something like that, that could hopefully be fixed 
fairly easily. The xdl hashing is a different thing, and I don't think 
it's necessarily easy to fix that one..)

			Linus
