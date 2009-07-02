From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Thu, 2 Jul 2009 13:58:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 22:58:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMTMY-0003LV-S5
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 22:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbZGBU6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZGBU6Y
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 16:58:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60731 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752912AbZGBU6X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 16:58:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n62KwPEb031643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2009 13:58:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n62KwPr6021111;
	Thu, 2 Jul 2009 13:58:25 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122670>



On Thu, 2 Jul 2009, Sitaram Chamarty wrote:
> 
> A couple of us were beating each other senseless on this
> issue over on #git, so I thought I'd ask: is it OK to do
> this?  Or would there potential be race conditions due to
> the lack of proper locking?

It should all work fine.

We've had a few NFS issues due to oddities with renaming across 
directories, but modern git avoids the cross-directory renames, and that 
whole issue only hit some very specific cases anyway.

And git doesn't have "proper locking", because it doesn't need it for 
database ops: git objects are stable. For refs, git should be using the 
proper NFS-safe "create and atomic rename" ops.

You do need to be a bit careful if you do maintenance operations 
concurrently (I would suggest avoiding doing concurrent "git gc --prune", 
for example), but any normal git workflow should be fine.

There is one big thing to look out for: performance. You may want to add

	[core]
		PreloadIndex = true

in your .git/config file, especially if you have a high-latency NFS server 
(but if you have a fast network and a high-end NFS server, you might be 
better off without it, so do your own testing).

Btw, I think we fixed the problem we had with CIFS. That one was a cifs 
filesystem problem on Linux, but it should be fixed in 2.6.30+ (commit 
0f4d634c: "cifs: flush data on any setattr"). If you have an older kernel 
(or are just uncertain), you can also work around it with

	[core]
		fsyncobjectfiles = true

which may be a good thing in general (regardless of any cifs issues), but 
in most cases the performance loss isn't worth it if your filesystem is 
stable and sane.

			Linus
