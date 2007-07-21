From: Steffen Prohaska <prohaska@zib.de>
Subject: segfault in diff-delta.c on mac os x (commit 8433669)
Date: Sat, 21 Jul 2007 17:15:00 +0200
Message-ID: <C10CCDA5-6D65-445E-92F3-2D3E4DCA4F8B@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICGfM-0004Oj-1e
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 17:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940888AbXGUPOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 11:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940877AbXGUPOI
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 11:14:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:58818 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S940707AbXGUPOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 11:14:05 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6LFE3Xr019364
	for <git@vger.kernel.org>; Sat, 21 Jul 2007 17:14:03 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a005.pool.einsundeins.de [77.177.160.5])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6LFE24Z027896
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 21 Jul 2007 17:14:02 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53169>

843366961cf14aad6490fbeb30f7b98f37f8833a may cause segfaults on
Mac OS X. See backtrace below. I only observed the segfault with
-O2 builds.

I was not yet able to understand the reason causing the segfault.
The situation is kind of strange. The for loop in line 302 shouldn't
allow entry == 0 to ever happen. But maybe some more intricate
corruption is taking place.

Unfortunately I'm no longer able to reproduce the exact call stack
because I wasn't aware of the details of when pruning takes place;
and the repository changed in such a way that the segfault no
longer happens.

However, I experienced suspicious behaviour on other repositories
during packing as well. I can probably create similar call stacks
if needed.

For now, I reverted 843366961cf14aad6490fbeb30f7b98f37f8833a for me.

	Steffen


gcc --version
i686-apple-darwin8-gcc-4.0.1 (GCC) 4.0.1 (Apple Computer, Inc. build  
5250)
Copyright (C) 2005 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There  
is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR  
PURPOSE.


Counting objects: 7530
Done counting 56361 objects.
Deltifying 56361 objects...
   69% (38890/56361) done

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_PROTECTION_FAILURE at address: 0x00000000
0x00048526 in create_delta (index=0x35d5000, trg_buf=0x35a0000,  
trg_size=214109, delta_size=0xbfffe83c, max_size=104893) at diff- 
delta.c:303
303                                     const unsigned char *ref =  
entry->ptr;
(gdb) bt
#0  0x00048526 in create_delta (index=0x35d5000, trg_buf=0x35a0000,  
trg_size=214109, delta_size=0xbfffe83c, max_size=104893) at diff- 
delta.c:303
#1  0x0002beb7 in prepare_pack (window=10, depth=50) at builtin-pack- 
objects.c:1293
#2  0x0002cd6e in cmd_pack_objects (argc=16, argv=0xbfffef78,  
prefix=0x0) at builtin-pack-objects.c:1709
#3  0x000020c9 in handle_internal_command (argc=16, argv=0xbfffef78,  
envp=0x84) at git.c:324
#4  0x00002669 in main (argc=16, argv=0xbfffef78, envp=0xbfffefbc) at  
git.c:393
(gdb) l
298                             struct index_entry *entry;
299                             val ^= U[data[-RABIN_WINDOW]];
300                             val = ((val << 8) | *data) ^ T[val >>  
RABIN_SHIFT];
301                             i = val & index->hash_mask;
302                             for (entry = index->hash[i]; entry;  
entry = entry->next) {
303                                     const unsigned char *ref =  
entry->ptr;
304                                     const unsigned char *src = data;
305                                     unsigned int ref_size =  
ref_top - ref;
306                                     if (entry->val != val)
307                                             continue;
(gdb) p entry
$1 = (struct index_entry *) 0x0
