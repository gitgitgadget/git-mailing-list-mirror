From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Wed, 27 Jun 2007 09:06:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706270849230.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net> <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
 <87tzstpyck.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 18:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3a2w-00023F-0c
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 18:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758428AbXF0QHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 12:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757623AbXF0QHH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 12:07:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38293 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755406AbXF0QHF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2007 12:07:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5RG71B9001536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2007 09:07:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5RG6tMi021438;
	Wed, 27 Jun 2007 09:06:55 -0700
In-Reply-To: <87tzstpyck.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.62 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51054>



On Wed, 27 Jun 2007, Jim Meyering wrote:
> 
> If someone pointed out a bug in coreutils whereby a tool failed
> to give an accurate diagnostic

The thing is, I don't think stdio output is "important" enough.

In fact, by definition, if the data was really important, it had better 
not use stdio.

So look at where git uses "real" IO, and where it uses stdio, and you'll 
see where the "diagnostics" matter.

In other words, the diagnostics matter for:
 - the actual git database (including refs).
 - doing things like "git checkout" that writes the working tree

Those are the ones where we want to *guarantee* correctness. And that 
means that they don't use stdio (and if any of them do, then that really 
*is* a bug, and should be fixed asap)

In contrast, if you redirect stdout, that's a totally different level of 
correctness, and all bets are off. Exactly because we use stdio. If we 
really cared, we shouldn't use stdio. 

> Be careful when throwing stones...
> I mentioned (without making a fuss) a regression you introduced,
>   http://thread.gmane.org/gmane.comp.version-control.git/50742/focus=50917
> and you included similar code in a snippet in the very message to which
> I'm replying now.  I do see that you omitted the troublesome ferror call
> from your eventual patch.

Right. There's a difference between an email saying "ok, this is how you 
might want to do it" and then actually sitting down and thinking about it 
and coding it.

If you look closer, you'll notice that my initial suggestion wouldn't even 
*compile*. 

By the time I sent out a patch, I had actually thought it through.

And no, I don't guarantee that I do that all the time. I try to, but hey, 
mistakes happen. It's when the mistake is repeated over and over after 
being pointed out that I get irritated.

> You and I have a difference of opinion.  I firmly believe that it is
> unnecessary and counterproductive (it is prohibited by POSIX for many
> of the tools I maintain) to suppress an EPIPE diagnostic and to exit
> successfully in spite of a write error.

Quite frankly, the tools you maintain are mostly filters in the first 
place! In other words, for you, stdout *matters*. That's the real data!

But look at something like "cp" one of these days, and ask yourself: 

 - do you check error returns for the IO operations that actually do the 
   copy (I hope yes). 

   I also hope to high heaven that you would never use stdio for that IO. 
   Because you *will* lose error information!

 - do you check the error returns of informational messages like the ones 
   from the verbose output switch (cp -v).

If you answered "no" to the second question, you should really think about 
that fact. Please realize that there's a *huge* difference in error 
checking between "core data" and "random information".

For something like "cat", the core data is the actual stream. You care a 
lot more about that. For git, the core data is the working tree and the 
database. I care about _that_. That's the stuff that should be protected 
and must never _ever_ fail silently.

The rest is really "statistics".

Let's get it right, but unlike core data, that's mostly a politeness 
issue, much less important than "oops, we just corrupted your archive".

And when we talk about politeness, avoiding the _idiotic_ error messages 
like "Broken pipe" is a big part of it! The "Broken pipe" message means 
either:
 - the receiver already got everything he wanted (and you should damn well 
   shut up about it)
 - the receiver had some problem (and it's damn well *that* which matters, 
   since the sender was fine, and you shouldn't confuse the issue by 
   writing bogus error messages)

The fact that you have some broken POSIX spec to worry about is not git's 
problem. I hold git to higher standards.

		Linus
