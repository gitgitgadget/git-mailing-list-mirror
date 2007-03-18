From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sun, 18 Mar 2007 10:23:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703181012520.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
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
 <alpine.LFD.0.83.0703172228220.18328@xanadu.home>
 <Pine.LNX.4.64.0703172013340.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703180517360.24626@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Mar 18 18:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSz73-0007OG-Au
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 18:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbXCRRXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 13:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbXCRRXw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 13:23:52 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46081 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbXCRRXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 13:23:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2IHNScD022984
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Mar 2007 10:23:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2IHNRSe026996;
	Sun, 18 Mar 2007 09:23:28 -0800
In-Reply-To: <Pine.LNX.4.64.0703180517360.24626@beast.quantumfyre.co.uk>
X-Spam-Status: No, hits=-0.98 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42505>



On Sun, 18 Mar 2007, Julian Phillips wrote:
> 
> (This is a rather unrealistic repository consisting of a long series of
> commits of new binary files, but I don't have access to the repository that is
> being approximated until I get back to work on Monday ...)

This is a *horrible* test repo.

Is this actually really trying to approximate anything you work with? If 
so, please check whether you have cyanide or some other effective poison 
to kill all your cow-orkers - it's really doing them a favor - and then do 
the honorable thing yourself? Use something especially painful on whoever 
came up with the idea to track 25000 files in a single directory.

I'll see what the profile is, but even without the repo full generated 
yet, I can already tell you that you should *not* put tens of thousands of 
files in a single directory like this.

It's not only usually horribly bad quite independently of any SCM issues 
(ie most filesystems will have some bad performance behaviour with things 
like this - if only because "readdir()" will inevitably be slow).

And for git it means that you lose all ability to efficiently prune away 
the parts of the tree that you don't care about. git will always end up 
working with a full linear filemanifest instead of a nice collection of 
recursive trees, and a lot of the nice tree-walking optimizations that git 
has will just end up being no-ops: each tree is always one *huge* 
manifest.

So it's not that git cannot handle it, it's that a lot of the nice things 
that make git really efficient simply won't trigger for your repository.

In short: avoiding tens of thousands of files in a single directory is 
*always* a good idea. With or without git.

(Again, SCM's that are really just "one file at a time" like CVS, 
won't care as much. They never really track all files anyway, so while 
they are limited by potential filesystem performance bottlenecks, they 
won't have the fundamental issue of tracking 25,000 files..)

		Linus
