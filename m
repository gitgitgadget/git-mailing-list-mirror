From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 11:29:29 -0500
Message-ID: <1261067369.2868.10.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091215023918.GA14689@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
	 <1260851180.9379.88.camel@localhost>
	 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
	 <1260970885.2788.87.camel@localhost>
	 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
	 <1261003041.2788.142.camel@localhost>
	 <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 17:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLJET-0005WK-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 17:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759458AbZLQQ3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 11:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759261AbZLQQ3e
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 11:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64822 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbZLQQ3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 11:29:34 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBHGTUBi012617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 17 Dec 2009 11:29:30 -0500
Received: from [10.11.235.74] (dhcp235-74.rdu.redhat.com [10.11.235.74])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBHGTTHT022738;
	Thu, 17 Dec 2009 11:29:29 -0500
In-Reply-To: <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135375>

On Thu, 2009-12-17 at 00:38 -0500, Nicolas Pitre wrote:

> Moving the reflog data aside (i.e. mv .git/logs .git/logs.bak) it seems 
> that d936ff8 is not referenced anymore.
> 
> I found the other one as follows:
> 
> First I tried
> 
> $ git rev-list --all --objects
> 
> This resulted in:
> 
> [...]
> 4f7911b0b0dbd187131a109cf00161a0c6a9d727 arch/x86
> ea868257c1eabc31e0ea7941efa42b543978b3fa arch/x86/kvm
> a0c11ead723956c667172a9f3fb6787684fe7ff5 arch/x86/kvm/paging_tmpl.h
> b556b6aad8b1aacfecb1dd4a56dbd389674687b5 arch/x86/kvm/x86.c
> 68a9733ae3315d7e2bfec2037dfeee4db8a6f6a1 drivers
> error: Could not read 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f
> fatal: bad tree object 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f
> 
> Because of the way objects are enumerated, we can be pretty sure that 
> the bad tree object is referenced by the tree object 68a9733a 
> corresponding to drivers/.  Let's verify that:
> 
> $ git ls-tree 68a9733a
> 100644 blob 00cf9553f74065291612b0971337f79995933a06    Kconfig
> 100644 blob c1bf41737936ab00be4a87563a0bb0638074785d    Makefile
> 040000 tree d4e847de9bf2450842936582ea7cc6778413825b    accessibility
> 040000 tree 29b6c2fb1390b4fd350a5ecc78f1156fc5d91e9f    acpi

This alone almost certainly tells me how I broke it.

For quite some time (a period of months) linux-next was broken and I had
to carry a patch to ACPI to make it boot.  I dropped that patch at the
head of my stgit trees in all of my repositories.  So I wouldn't be at
all surprised to learn that eventually kernel-2 found that object in
kernel-1.  Sometime when I dropped that patch from kernel-1 (because it
finally got fixed upstream) I can see how it broke.

But now that patch shouldn't be needed by any tree since I have long
since dropped it from the stgit stack.  So if we cleaned up all of the
useless objects in this tree I bet this object wouldn't be needed.  Not
exactly a situation that I'd expect git to be able to dig out of itself
thought.

I'm creating clean repos and going to do no work in my -alt    :)

Thanks everyone!

-Eric
