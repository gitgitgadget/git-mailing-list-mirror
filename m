From: Gerrit Pape <pape@smarden.org>
Subject: git-http-fetch segfault, curl 7.18.0
Date: Sun, 2 Mar 2008 19:08:57 +0000
Message-ID: <20080302190857.11027.qmail@28c5bbafb32cb2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 20:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVtYj-0000eK-6s
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 20:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbYCBTIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 14:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbYCBTIj
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 14:08:39 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:38696 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754563AbYCBTIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 14:08:38 -0500
Received: (qmail 11028 invoked by uid 1000); 2 Mar 2008 19:08:57 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75829>

Hi, as reported through http://bugs.debian.org/468836, I can reproduce
with current maint branch on Debian/unstable, but I don't know whether
it's a problem in curl, or in git.  Maybe anyone with some experience
in curl can help on this?

 $ make
 [...]
 $ mkdir repo && cd repo && git init
 Initialized empty Git repository in .git/
 $ ../git-http-fetch -v -a -w remotes/origin/master ef227a3da916f53f5a9ef4266c27c283c1ab607b http://git.debian.org/git/users/eddyp-guest/test-segfault.git/
 got ef227a3da916f53f5a9ef4266c27c283c1ab607b
 walk ef227a3da916f53f5a9ef4266c27c283c1ab607b
 got 12d086d13b3e69b26389282fe031b1a15153d84c
 Getting alternates list for
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Getting pack list for
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 got e25c7e03ea0c0d4d9bea5552ee629a25196ff43f
 got a8d762c979ac21da092732eafb6ded8751c3f63d
 Getting index for pack 06eec8e3e8f770e471d5f3f19c3b8ffa9159fd97
 got 31cdb53945ddfa3b7bc15e12fdf900024eec1a56
 Getting pack 06eec8e3e8f770e471d5f3f19c3b8ffa9159fd97
  which contains 64580202061d4d8f449e09107ac6e60706142202
 walk 64580202061d4d8f449e09107ac6e60706142202
 error: Unable to find 30e8500073c101f656311906f5a00f0ccc0e8546 under http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Cannot obtain needed commit 30e8500073c101f656311906f5a00f0ccc0e8546
 while processing commit 64580202061d4d8f449e09107ac6e60706142202.
 $ echo $?
 255
 $ ../git-http-fetch -v -a -w remotes/origin/master ef227a3da916f53f5a9ef4266c27c283c1ab607b http://git.debian.org/git/users/eddyp-guest/test-segfault.git/
 walk ef227a3da916f53f5a9ef4266c27c283c1ab607b
 walk 64580202061d4d8f449e09107ac6e60706142202
 Getting alternates list for
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Getting pack list for
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 error: Unable to find 30e8500073c101f656311906f5a00f0ccc0e8546 under
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Cannot obtain needed commit 30e8500073c101f656311906f5a00f0ccc0e8546
 while processing commit 64580202061d4d8f449e09107ac6e60706142202.
 Waiting for
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git/objects/8b/d9d5f451cb08435cdcb773dc8cdddf9f61d553
 Waiting for
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git/objects/ef/b3c1b344b887ffdb5d917eca2a28e5f176613c
 Segmentation fault

gdb gives this

 (gdb) r -v -a -w remotes/origin/master ef227a3da916f53f5a9ef4266c27c283c1ab607b http://git.debian.org/git/users/eddyp-guest/test-segfault.git/
 Starting program: /usr/local/src/Debian/GIT/git/git-http-fetch -v -a -w
 remotes/origin/master  ef227a3da916f53f5a9ef4266c27c283c1ab607b
 http://git.debian.org/git/users/eddyp-guest/test-segfault.git/
 [Thread debugging using libthread_db enabled]
 walk ef227a3da916f53f5a9ef4266c27c283c1ab607b
 [New Thread 0x3002c220 (LWP 19305)]
 walk 64580202061d4d8f449e09107ac6e60706142202
 Getting alternates list for http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Getting pack list for http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 error: Unable to find 30e8500073c101f656311906f5a00f0ccc0e8546 under http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Cannot obtain needed commit 30e8500073c101f656311906f5a00f0ccc0e8546
 while processing commit 64580202061d4d8f449e09107ac6e60706142202.
 Waiting for http://git.debian.org/git/users/eddyp-guest/test-segfault.git/objects/8b/d9d5f451cb08435cdcb773dc8cdddf9f61d553
 Waiting for http://git.debian.org/git/users/eddyp-guest/test-segfault.git/objects/3a/36bcfe419fe97021a330516c25e8c8d6a61b23
 Waiting for http://git.debian.org/git/users/eddyp-guest/test-segfault.git/objects/f9/1f9480407a3786f0a66855af7c64da9360c214

 Program received signal SIGSEGV, Segmentation fault.
 [Switching to Thread 0x3002c220 (LWP 19305)]
 0x0ffbaddc in ?? () from /usr/lib/libcurl-gnutls.so.4
 (gdb) bt
 #0  0x0ffbaddc in ?? () from /usr/lib/libcurl-gnutls.so.4
 #1  0x0ffbadc4 in ?? () from /usr/lib/libcurl-gnutls.so.4
 #2  0x0ffc3f0c in curl_easy_cleanup () from /usr/lib/libcurl-gnutls.so.4
 #3  0x100a4e8c in fill_active_slots () at http.c:442
 #4  0x100a5100 in step_active_slots () at http.c:459
 #5  0x100a519c in run_active_slot (slot=0x10169f08) at http.c:479
 #6  0x100a5478 in http_cleanup () at http.c:296
 #7  0x100a6514 in cleanup (walker=<value optimized out>) at http-walker.c:900
 #8  0x100a2550 in walker_free (walker=<value optimized out>) at walker.c:315
 #9  0x1004df68 in cmd_http_fetch (argc=<value optimized out>, argv=0x7fbfe784, 
     prefix=<value optimized out>) at builtin-http-fetch.c:81
 #10 0x100045e8 in handle_internal_command (argc=7, argv=0x7fbfe784) at git.c:259
 #11 0x10004f88 in main (argc=7, argv=0x7fbfe784) at git.c:420
 (gdb) 

and sometimes

 (gdb) r -v -a -w remotes/origin/master ef227a3da916f53f5a9ef4266c27c283c1ab607b http://git.debian.org/git/users/eddyp-guest/test-segfault.git/
 Starting program: /usr/local/src/Debian/GIT/git/git-http-fetch -v -a -w remotes/origin/master  ef227a3da916f53f5a9ef4266c27c283c1ab607b http://git.debian.org/git/users/eddyp-guest/test-segfault.git/
 [Thread debugging using libthread_db enabled]
 walk ef227a3da916f53f5a9ef4266c27c283c1ab607b
 [New Thread 0x3002c220 (LWP 20097)]
 walk 64580202061d4d8f449e09107ac6e60706142202
 Getting alternates list for http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Getting pack list for http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 error: Unable to find 30e8500073c101f656311906f5a00f0ccc0e8546 under http://git.debian.org/git/users/eddyp-guest/test-segfault.git
 Cannot obtain needed commit 30e8500073c101f656311906f5a00f0ccc0e8546
 while processing commit 64580202061d4d8f449e09107ac6e60706142202.
 Waiting for http://git.debian.org/git/users/eddyp-guest/test-segfault.git/objects/61/6e4145cf75c474bafa94f1dd917ed0a6f421fc
 Waiting for http://git.debian.org/git/users/eddyp-guest/test-segfault.git/objects/ef/b3c1b344b887ffdb5d917eca2a28e5f176613c

 Program received signal SIGSEGV, Segmentation fault.
 [Switching to Thread 0x3002c220 (LWP 20097)]
 fill_active_slots () at http.c:441
 441                     if (!slot->in_use && slot->curl != NULL) {
 (gdb) 

Thanks, Gerrit.
