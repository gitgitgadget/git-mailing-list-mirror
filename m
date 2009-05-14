From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] read_directory(): infrastructure for pathname 
 character set conversion
Date: Thu, 14 May 2009 15:51:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905141547480.3343@localhost.localdomain>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain>  <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain>  <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>  <alpine.DEB.1.00.0905150018070.26154@pacific.mpi-cbg.de>
 <727e50150905141536r5f3c4c1ap615166ba71018bf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: aaron@assonance.org
X-From: git-owner@vger.kernel.org Fri May 15 00:55:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jpp-0004RW-CP
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761448AbZENWwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759624AbZENWwc
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:52:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58334 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761448AbZENWwb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 18:52:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EMpkN9009367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 15:51:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EMpk0c016429;
	Thu, 14 May 2009 15:51:46 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <727e50150905141536r5f3c4c1ap615166ba71018bf3@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.962 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119237>



On Thu, 14 May 2009, Aaron Cohen wrote:
> 
> Does this possibly allow using the magic "\\?\" prefix on windows to
> avoid file name length restrictions?

That would be the intention - eventually. The point being exactly that the 
'path' side can be done differently from the 'basename' part that git then 
uses internally.

However, the thing is not complete. As shown from the strace, almost all 
filesystem operations then end up using the 'git internal' name anyway. 
It's currently literally just the filesystem traversal itself that knows 
to separate the notion of 'internal pathname representation' from the 
filesystem accesses.

So right now, the only thing that uses the filesystem-specific stuff is 
the "opendir()" (and the lstat() in case the filesystem doesn't support 
d_type in the dirent).

		Kubys
