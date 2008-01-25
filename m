From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 14:16:22 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>  <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>  <4797095F.9020602@op5.se>  <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>  <4797518A.3040704@op5.se>
  <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>  <4798B633.8040606@op5.se>  <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>  <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
 <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIWrl-0006f9-8M
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 23:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbYAYWRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 17:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbYAYWRJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 17:17:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39722 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753775AbYAYWRH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 17:17:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PMGNaw014942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2008 14:16:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PMGMXB003303;
	Fri, 25 Jan 2008 14:16:23 -0800
In-Reply-To: <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71745>



On Fri, 25 Jan 2008, Marko Kreen wrote:
> 
> Well, although this is very clever approach, I suggest against it.
> You'll end up with complex code that gives out substandard results.

Actually, *your* operation is the one that gives substandard results.

> I think its better to have separate case-folding function (or several),
> that copies string to temp buffer and then run proper optimized hash
> function on that buffer.

I'm sorry, but you just cannot do that efficiently and portably.

I can write a hash function that reliably does 8 bytes at a time for the 
common case on a 64-bit architecture, exactly because it's easy to do 
"test high bits in parallel" with a simple bitwise 'and', and we can do 
the same with "approximate lower-to-uppercase 8 bytes at a time" for a 
hash by just clearing bit 5.

In contrast, trying to do the same thing in half-way portable C, but being 
limited to having to get the case-folding *exactly* right (which you need 
for the comparison function) is much much harder. It's basically 
impossible in portable C (it's doable with architecture-specific features, 
ie vector extensions that have per-byte compares etc).

And hashing is performance-critical, much more so than the compares (ie 
you're likely to have to hash tens of thousands of files, while you will 
only compare a couple). So it really is worth optimizing for.

And the thing is, "performance" isn't a secondary feature. It's also not 
something you can add later by optimizing. 

It's also a mindset issue. Quite frankly, people who do this by "convert 
to some folded/normalized form, then do the operation" will generally make 
much more fundamental mistakes. Once you get into the mindset of "let's 
pass a corrupted strign around", you are in trouble. You start thinking 
that the corrupted string isn't really "corrupt", it's in an "optimized 
format". 

And it's all downhill from there. Don't do it.

			Linus
