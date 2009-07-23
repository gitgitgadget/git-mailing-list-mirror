From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 21:10:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907222050500.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <20090723031843.GA9152@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907222041341.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 06:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTpgS-0007T7-II
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 06:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbZGWELW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 00:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbZGWELV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 00:11:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56512 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754AbZGWELV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 00:11:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N4Ao2c006736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 21:10:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N4AnAP015963;
	Wed, 22 Jul 2009 21:10:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907222041341.21520@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123832>



On Wed, 22 Jul 2009, Linus Torvalds wrote:
> 
> But I'll see if I can dig up my non-binary-search patch and see if I can 
> make it go faster. My machine is fast, but not so fast that I can't 
> measure it ;)

Oh. We actually merged a fixed version of it. I'd completely forgotten.
 
Enabled with 'GIT_USE_LOOKUP'. But it seems to give worse performance, 
despite giving me fewer searches: I get 2121 probes with binary searching, 
but only 1325 with the newton-raphson method (for the non-fixed 'git 
branch' case).

Using GIT_USE_LOOKUP actually results in fewer pagefaults (1391 vs 1473), 
but it's still slower. Interesting. Carlos, try it on your machine (just 
do

	export GIT_USE_LOOKUP=1
	time git branch

to try it, and 'unset GIT_USE_LOOKUP' to disable it.

(And note that the "=1" part isn't important - the only thing that matters 
is whether the environment variable is set or not - setting it to '0' will 
_not_ disable it, you need to 'unset' it).

With my fix to 'git branch', it doesn't matter. I get the same 
performance, and same number of page faults (676) regardless. So my patch 
makes the GIT_USE_LOOKUP=1 thing irrelevant.

		Linus
