From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: cg-commit problems with path_xargs
Date: Fri, 6 Jan 2006 16:51:42 -0600
Message-ID: <3FACF001-CB7F-43FE-B095-A1296F6565F0@freescale.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 06 23:53:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Qx-0001xW-3H
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWAFWvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWAFWvf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:51:35 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:43986 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S964891AbWAFWve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:51:34 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k06N384I011293
	for <git@vger.kernel.org>; Fri, 6 Jan 2006 16:03:08 -0700 (MST)
Received: from [192.168.1.101] (mvp-10-214-72-24.am.freescale.net [10.214.72.24])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k06MxO2x002235
	for <git@vger.kernel.org>; Fri, 6 Jan 2006 16:59:25 -0600 (CST)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14226>

So,

I'm having an issue with cg-commit, where it only commits the first  
[modified,added,deleted] file listed by cg-status (example below).  I  
tracked this down to these lines in cg-commit:

         [ "$queueA" ] && { ( echo "${queueA[*]}" | path_xargs git- 
update-index --add ${infoonly} -- ) ||
return 1; }
         [ "$queueD" ] && { ( echo "${queueD[*]}" | path_xargs git- 
update-index --force-remove -- ) || re
turn 1;  }
         [ "$queueM" ] && { ( echo "${queueM[*]}" | path_xargs git- 
update-index ${infoonly} -- ) || retur
n 1; }

If I revert these lines to their form in cogito 0.13, the problem  
resolves itself:

         [ "$queueA" ] && { ( echo "${queueA[*]}" | tr \\n \\0 |  
xargs -0 git-update-index --add ${infoon
ly} -- ) || return 1; }
         [ "$queueD" ] && { ( echo "${queueD[*]}" | tr \\n \\0 |  
xargs -0 git-update-index --force-remove
-- ) || return 1;  }
         [ "$queueM" ] && { ( echo "${queueM[*]}" | tr \\n \\0 |  
xargs -0 git-update-index ${infoonly} --
) || return 1; }

I've seen the threads about problems with newer bash versions, but  
this is happening to me with bash 2.05b (/usr/bin/env bash --version  
reports GNU bash, version 2.05b.0(1)-release (i386-redhat-linux- 
gnu)).  This is occuring with the latest git repository for cogito  
(cogito-0.17pre.GIT)

Should I be running a different bash?

Thanks,
Becky

Here's the cg-commands that show the problem.....

 > cg-status
Heads:
    >master      4c1697d8a481086ea58307f88e7bb251a92e1d9b
   R origin      88202a0c84e1951d6630d1d557d4801a8cc5b5ef

M arch/powerpc/Kconfig
M arch/powerpc/kernel/pci_64.c
M arch/powerpc/kernel/prom.c
M arch/powerpc/kernel/udbg.c
M arch/powerpc/platforms/maple/setup.c
M arch/powerpc/platforms/powermac/feature.c
M arch/powerpc/platforms/powermac/pci.c
M arch/powerpc/platforms/powermac/pic.c
M arch/powerpc/platforms/powermac/setup.c
M arch/powerpc/platforms/powermac/smp.c
M arch/powerpc/sysdev/Makefile
M arch/powerpc/sysdev/dart.h
M arch/powerpc/sysdev/mpic.c
M drivers/ide/ppc/pmac.c
M drivers/macintosh/smu.c
M include/asm-powerpc/hardirq.h
M include/asm-powerpc/iommu.h
M include/asm-powerpc/mpic.h
M include/asm-powerpc/pmac_feature.h
M include/linux/pci_regs.h

  > cg --version
cogito-0.17pre.GIT (6d0b0790e812618e694798f741f76ccb202c9cab)

 > cg-commit -m "test"
M       arch/powerpc/Kconfig
M       arch/powerpc/kernel/pci_64.c
M       arch/powerpc/kernel/prom.c
M       arch/powerpc/kernel/udbg.c
M       arch/powerpc/platforms/maple/setup.c
M       arch/powerpc/platforms/powermac/feature.c
M       arch/powerpc/platforms/powermac/pci.c
M       arch/powerpc/platforms/powermac/pic.c
M       arch/powerpc/platforms/powermac/setup.c
M       arch/powerpc/platforms/powermac/smp.c
M       arch/powerpc/sysdev/Makefile
M       arch/powerpc/sysdev/dart.h
M       arch/powerpc/sysdev/mpic.c
M       drivers/ide/ppc/pmac.c
M       drivers/macintosh/smu.c
M       include/asm-powerpc/hardirq.h
M       include/asm-powerpc/iommu.h
M       include/asm-powerpc/mpic.h
M       include/asm-powerpc/pmac_feature.h
M       include/linux/pci_regs.h
Committed as 33f25d02e785e549be195a2c34dcee659ece185f.

cde-tx32-ldt329:~/merge/becky/test.linus.newgit > cg-status
Heads:
    >master      33f25d02e785e549be195a2c34dcee659ece185f
   R origin      88202a0c84e1951d6630d1d557d4801a8cc5b5ef

M arch/powerpc/kernel/pci_64.c
M arch/powerpc/kernel/prom.c
M arch/powerpc/kernel/udbg.c
M arch/powerpc/platforms/maple/setup.c
M arch/powerpc/platforms/powermac/feature.c
M arch/powerpc/platforms/powermac/pci.c
M arch/powerpc/platforms/powermac/pic.c
M arch/powerpc/platforms/powermac/setup.c
M arch/powerpc/platforms/powermac/smp.c
M arch/powerpc/sysdev/Makefile
M arch/powerpc/sysdev/dart.h
M arch/powerpc/sysdev/mpic.c
M drivers/ide/ppc/pmac.c
M drivers/macintosh/smu.c
M include/asm-powerpc/hardirq.h
M include/asm-powerpc/iommu.h
M include/asm-powerpc/mpic.h
M include/asm-powerpc/pmac_feature.h
M include/linux/pci_regs.h
