From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 09:16:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602150904310.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org> <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602141829080.3691@g5.osdl.org> <Pine.LNX.4.64.0602141953081.3691@g5.osdl.org>
 <7vd5hpj6ab.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602150715470.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 15 18:18:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9QH7-0006H4-4E
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 18:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946038AbWBORRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 12:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946041AbWBORRE
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 12:17:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946038AbWBORRC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 12:17:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1FHGQDZ028084
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 15 Feb 2006 09:16:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1FHGMIu003349;
	Wed, 15 Feb 2006 09:16:22 -0800
To: Junio C Hamano <junkio@cox.net>, Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.64.0602150715470.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16248>



Btw, some actual numbers: I did the recent kernel networking merge (which 
is a trivial in-index merge) with the standard three-way

	git-read-tree -m <base> <branch> <branch>

and with the new git-merge-tree to compare performance.

Doing git-read-tree takes ~0.35s, while git-merge-tree took 0.015s.

Now, that's not a really fair comparison, because the end result is very 
different: the git-read-tree has populated the index, ready for a 
git-writet-ree, while the git-merge-tree has not. 

However, the interesting part is that especially for a trivial merge, we 
don't actually _want_ to necessarily populate the index, because doing a 
"git-write-tree" is actually a pretty expensive operation (on the kernel, 
it will try to write 1000+ directory trees, most of which already exist. 
Admittedly we don't actually have to write the objects, since we figure 
out that they already exist, but we have to do the SHA1 calculations to 
do so).

So if we made the git-merge-tree based merge work entirely on trees all 
the way, and never even necessarily populate the index at all (unless it 
has to, due to actual data conflicts that want to be fixed up), that would 
actually be another performance advantage. The only downside there is that 
we would literally have to write the resulting tree objects by hand (ie 
we'd need a new helper for doing that, and another thing to validate).

Anyway, that should almost certainly make it possible to scale up git 
merges to hundreds of thousands of files without huge performance problems 
(still, that depends a bit on layout - again, flat directory structures 
won't scale as well, so it might not be enough for maildir handling).

But just at a guess, I think there's at least an order of magnitude to be 
had there. So if a maildir merge currently takes an hour, at least we 
should be able to get it down to a few minutes.

Ben, are you interested in trying this out in your maildir experiments?

		Linus
