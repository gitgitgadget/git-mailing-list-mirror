From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Sat, 26 Jan 2008 22:51:18 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801262247140.3222@www.l.google.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>  <4797095F.9020602@op5.se>  <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>  <4797518A.3040704@op5.se>  <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com> 
 <4798B633.8040606@op5.se>  <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>  <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>  <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>  <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
 <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 07:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ1NH-0003g0-9U
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 07:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbYA0Gvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 01:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYA0Gvc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 01:51:32 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44509 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750882AbYA0Gvb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2008 01:51:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0R6pLIn001891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Jan 2008 22:51:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0R6pInq001767;
	Sat, 26 Jan 2008 22:51:19 -0800
X-X-Sender: torvalds@www.l.google.com
In-Reply-To: <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71806>



On Sat, 26 Jan 2008, Marko Kreen wrote:
> 
> Here you misunderstood me, I was proposing following:
> 
> int hash_folded(const char *str, int len)
> {
>    char buf[512];
>    do_folding(buf, str, len);
>    return do_hash(buf, len);
> }
> 
> That is - the folded string should stay internal to hash function.

If it's internal, it's much better, but you still missed the performance 
angle.

The fact is, hashing can take shortcuts that folding cannot do!

Case folding, by definition, has to be "exact" (since the whole point is 
what you're going to use the same folding function to do the compare, so 
if you play games with folding, the compares will be wrong).

But hashing doesn't have to be exact. It's ok to hash '{' and '[' as if 
they were different cases of the same character, if that gives you a 
faster hash function. Especially as those charactes are rather rare in 
filenames.

So if you do hashing as a function of its own, you can simply do a better 
job at it.

I do agree that the functions that create a folded set of characters from 
a _complex_ UTF-8 character should be shared between folding and hashing, 
since that code is too complex and there are no simple shortcuts for doing 
a faster hash that still retains all the properties we want. 

			Linus
