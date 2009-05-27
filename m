From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 09:59:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 18:59:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9MTc-00007E-Cr
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 18:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbZE0Q7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 12:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbZE0Q7c
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 12:59:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59459 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751516AbZE0Q7b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 12:59:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4RGxMEb019372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2009 09:59:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4RGxLAt022033;
	Wed, 27 May 2009 09:59:21 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120078>



On Wed, 27 May 2009, Linus Torvalds wrote:
> 
> I'll see if I can make us handle the "big file without diff" case better 
> by chunking.

Hmm. No. Looking at it some more, we could add some nasty code to do 
_some_ things chunked (like adding a new file as a single object), but it 
doesn't really help. For any kind of useful thing, we'd need to handle the 
"read from pack" case in multiple chunks too, and that gets really nasty 
really quickly.

The whole "each object as one allocation" design is pretty core, and it 
looks pointless to have a few special cases, when any actual relevant use 
would need a whole lot more than the few simple ones.

Git really doesn't like big individual objects.

I've occasionally thought about handling big files as multiple big 
objects: we'd split them into a "pseudo-directory" (it would have some new 
object ID), and then treat them as a magical special kind of directory 
that just happens to be represented as one large file on the filesystem.

That would mean that if you have a huge file, git internally would never 
think of it as one big file, but as a collection of many smaller objects. 
By just making the point where you break up files be a consistent rule 
("always break into 256MB pieces"), it would be a well-behaved design (ie 
things like behaviour convergence wrt the same big file being created 
different ways).

HOWEVER.

While that would fit in the git design (ie it would be just a fairly 
straightforward extension - another level of indirection, kind of the way 
we added subprojects), it would still be a rewrite of some core stuff. The 
actual number of lines might not be too horrid, but quite frankly, I 
wouldn't want to do it personally. It would be a lot of work with lots of 
careful special case handling - and no real upside for normal use.

So I'm kind of down on it. I would suggest just admitting that git isn't 
very good at big individual files - especially not if you have a limited 
address space.

So "don't do it then" or "make sure you are 64-bit and have lots of 
memory if you do it" may well be the right solution.

[ And it's really really sad how Apple migrated to x86-32. It was totally 
  unforgivably stupid, and I said so at the time. When Apple did the 
  PowerPC -> x86 transition, they should have just transitioned to x86-64, 
  and never had a 32-bit space.

  But Apple does stupid things, that seem to be driven by marketing rather 
  than thinking deeply about the technology, and now they basically _have_ 
  to default to that 32-bit environment. ]

Oh well. 

			Linus
