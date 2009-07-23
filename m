From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 20:47:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907222041341.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <20090723031843.GA9152@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 05:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTpH9-0001qF-EF
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 05:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZGWDrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 23:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbZGWDrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 23:47:16 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35055 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753291AbZGWDrP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 23:47:15 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N3lBHB004878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 20:47:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N3lApv011380;
	Wed, 22 Jul 2009 20:47:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090723031843.GA9152@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123831>



On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
> 
> PS: Out of curiosity, how many femtoseconds does it take in your 
> state-of-the-art machine? :-)

Cold cache? 0.15s before the patch. 0.03s after.

So we're not talking femto-seconds, but I've got Intel SSD's that do 
random reads in well under a millisecond. Your pitiful 4200rpm drive 
probably takes 20ms for each seek. You don't really need that many IO's 
for it to take a second or two. Or four.

The kernel will do IO in bigger chunks than a single page, and there is 
_some_ locality to it all, so you won't see IO for each lookup. But with 
2000+ lines of GIT_DEBUG_LOOKUP, you probably do end up having a 
noticeable fraction of them being IO-causing, and another fraction causing 
seeks.

But I'll see if I can dig up my non-binary-search patch and see if I can 
make it go faster. My machine is fast, but not so fast that I can't 
measure it ;)

		Linus
