From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Build configuration to skip ctime for modification
 test
Date: Thu, 24 Jul 2008 19:00:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local>
 <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 04:04:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMCfa-0003PM-8e
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 04:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbYGYCDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 22:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbYGYCDe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 22:03:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37360 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755343AbYGYCDd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 22:03:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6P23Rfn009109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2008 19:03:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6P23PUS017783;
	Thu, 24 Jul 2008 19:03:26 -0700
In-Reply-To: <20080723191647.GF5283@blimp.local>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.408 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89993>



On Wed, 23 Jul 2008, Alex Riesen wrote:
> 
> It is not that it is broken. We just don't need it, because the st_mode
> is not used, and the rest of inode information is not used anyway.

That is NOT why git checks the ctime.

Git checks the ctime not because it cares about the inode state being 
modified per se: since it can see that _directly_ - so why should it care 
about inode state like st_mode?

No, git checks ctime because it in general tries to make it VERY VERY hard 
for people to try to "fake out" git and replace files from underneath it 
without git noticing.

It's much easier and much more common for tools to restore 'mtime' when 
they do some operation on a file than it is for them to restore 'ctime'.

For example, if you rsync files between two hosts, the '-t' flag will make 
rsync try to keep the mtimes in sync (and it's part of '-a', which is the 
common form that you'd use for rsync). So if you only look at mtime and 
size, you often miss the fact that the file has actually been messed with!

Looking at ctime gets around a number of those things. Of course, it can 
cause git to be _too_ eager in thinking that a file is modified, and an 
example of that is the insane indexing that 'beagle' does, which actually 
modifies the files by adding inode extended attributes to them and thus 
changes ctime due to the indexing. But in general it's a lot better to be 
too careful than to miss the fact that somebody changed the file.

		Linus
