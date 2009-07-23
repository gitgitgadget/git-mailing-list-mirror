From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 20:08:57 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 05:09:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTogB-0001rF-ET
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 05:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbZGWDJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 23:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbZGWDJB
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 23:09:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36374 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376AbZGWDJB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 23:09:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N38vXD001918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 20:08:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N38vH4016169;
	Wed, 22 Jul 2009 20:08:57 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123825>



On Wed, 22 Jul 2009, Linus Torvalds wrote:
> 
> It uses the "raw" version of 'for_each_ref()' (which doesn't verify that 
> the ref is valid), and then does the "type verification" before it starts 
> doing any gentle commit lookup.
> 
> That should hopefully mean that it no longer does tons of object lookups 
> on refs that it's not actually interested in. 

Hmm. On my kernel repo, doing

	GIT_DEBUG_LOOKUP=1 git branch | wc -l

I get
 - before: 2121
 - after: 39

(where two of the lines are the actual 'git branch' output). So yeah, this 
should make a big difference. It now looks up just two objects (one of 
them duplicated because it checks "HEAD" - but the duplicate lookup won't 
result in any extra IO, so it's only two _uncached_ accesses).

The GIT_DEBUG_LOOKUP debug output probably does match the number of 
cold-cache IO's fairly well for something like this (at least to a first 
approximation), so I really hope my patch will fix your problem.

			Linus
