From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 11:13:30 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain>
References: <200901111602.53082.borntraeger@de.ibm.com> <200901111607.59054.borntraeger@de.ibm.com> <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de> <200901111620.03345.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 20:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM5ma-0000GP-4f
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 20:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbZAKTOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbZAKTOJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:14:09 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41628 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751738AbZAKTOG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jan 2009 14:14:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0BJDVSR012841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jan 2009 11:13:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0BJDU1i021356;
	Sun, 11 Jan 2009 11:13:30 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <200901111620.03345.borntraeger@de.ibm.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105199>


On Sun, 11 Jan 2009, Christian Borntraeger wrote:
> 
> I think we should really avoid merging subtrees to the linux kernel. It 
> makes bisecting a real PITA. Furthermore, It is unlikely, but what if 
> the problem is part of the 581 changesets from btrfs?

Umm, yes? 

The thing is, btrfs was developed as an outside module. There are two 
choices: import it with history, or import it without history. The history 
is interesting, so importing _with_ it is a much nicer one. But that does 
mean that btrfs introduces into the kernel tree the same behaviour we've 
had in the git development tree for a long time - multiple root commits, 
and "independent" branches that get merged.

It's actually very natural for git, and the btrfs tree actually was 
re-done with "git filter-branch" to move all the history so that it is in 
fs/btrfs, rather than moving around from the root like the _original_ 
development was done. So it's not technically a subtree merge, it's a 
regular merge with just two different root commits - one for the original 
base kernel development, one for the original btrfs kernel development.

For bisect, it's indeed somewhat annoying, and we could have perhaps done 
some things a bit differently, but it's about the closest you can get to 
"real history" without making the first btrfs merge-point a _total_ 
disaster.

For bisect purposes, if you know you're not chasing down a btrfs issue, 
you can do

	git bisect good 34353029534a08e41cfb8be647d734b9ce9ebff8

where that commit 34353029 is the last one which has _just_ the btrfs 
files. The next commit is when it does "Merge Btrfs into fs/btrfs", and 
that one has the whole kernel tree again.

			Linus
