From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Build configuration to skip ctime for modification test
Date: Fri, 25 Jul 2008 07:55:47 +0200
Message-ID: <20080725055547.GA3699@blimp.local>
References: <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local> <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:21:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSqe-0004HR-6E
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbYGYTTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbYGYTTf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:19:35 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:59688 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754AbYGYTTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:19:34 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44h+5V
Received: from tigra.home (Fa915.f.strato-dslnet.de [195.4.169.21])
	by post.webmailer.de (mrclete mo18) (RZmta 16.47)
	with ESMTP id 506786k6PGcaoS ; Fri, 25 Jul 2008 21:19:30 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 6F957277BD;
	Fri, 25 Jul 2008 21:19:30 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 1907A36D19; Fri, 25 Jul 2008 07:55:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90092>

Linus Torvalds, Fri, Jul 25, 2008 04:00:29 +0200:
> On Wed, 23 Jul 2008, Alex Riesen wrote:
> > 
> > It is not that it is broken. We just don't need it, because the st_mode
> > is not used, and the rest of inode information is not used anyway.
> 
> That is NOT why git checks the ctime.
> 
> Git checks the ctime not because it cares about the inode state being 
> modified per se: since it can see that _directly_ - so why should it care 
> about inode state like st_mode?
> 
> No, git checks ctime because it in general tries to make it VERY VERY hard 
> for people to try to "fake out" git and replace files from underneath it 
> without git noticing.
> 
> It's much easier and much more common for tools to restore 'mtime' when 
> they do some operation on a file than it is for them to restore 'ctime'.
> 
> For example, if you rsync files between two hosts, the '-t' flag will make 
> rsync try to keep the mtimes in sync (and it's part of '-a', which is the 
> common form that you'd use for rsync). So if you only look at mtime and 
> size, you often miss the fact that the file has actually been messed with!
> 
> Looking at ctime gets around a number of those things. Of course, it can 
> cause git to be _too_ eager in thinking that a file is modified, and an 
> example of that is the insane indexing that 'beagle' does, which actually 
> modifies the files by adding inode extended attributes to them and thus 
> changes ctime due to the indexing. But in general it's a lot better to be 
> too careful than to miss the fact that somebody changed the file.
> 

But, given the fact, that somewhere sometimes its very-very annoying
to have even one (un)changed file, something must be done about it.
Maybe just direct

    # my .gitconfig for Windows machines with GDS
    [core]
	filemode = false
	trustctime = false
	logallrefupdates = false
    [pack]
	threads = 1

    etc...
