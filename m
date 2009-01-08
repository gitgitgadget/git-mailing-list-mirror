From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
 that are corrupted in a pack file
Date: Wed, 7 Jan 2009 16:48:42 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>  <1231314099.8870.415.camel@starfruit>
  <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>  <1231368935.8870.584.camel@starfruit>  <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKj6l-0000us-KR
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbZAHAtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755636AbZAHAtW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:49:22 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57664 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755437AbZAHAtV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 19:49:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n080mgi7018477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 16:48:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n080mgMi011644;
	Wed, 7 Jan 2009 16:48:42 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231374514.8870.621.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104860>



On Wed, 7 Jan 2009, R. Tyler Ballance wrote:
>
> My most esteemed colleague (Ken aka kb) who pointed out the memory issue
> was on the right path (I think), and I have a reproduction case you can
> try with your very own Linux kernel tree!
> 
> WOO!
> 
> I set ulimit -v really low (150M), and the operations I made got an
> mmap(2) fatal error, but there is a sweet spot that I found, see the
> transcript below.

This is indeed the packfile mapping. The sweet spot you found depends on 
how big the biggest two pack-files are, I do believe.

And if you do that

	[core]
		packedgitwindowsize = 64M

I think you'll find that it works. Of course, with a _really_ low ulimit, 
you'd need to make it even smaller, but at some point you start hitting 
other problems than the pack-file limits, ie just the simple fact that git 
wants and expects you to have a certain amount of memory available ;)

Can you cnfirm that your "reproducible" case starts working with that 
addition to your ~/.gitconfig? If so, the solution is pretty simple: we 
should just lower the default pack windowsize.

		Linus
