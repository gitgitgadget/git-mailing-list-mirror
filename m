From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 20:08:48 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
 <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 05:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFM4C-000070-Ul
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 05:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbYAQEI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 23:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbYAQEI5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 23:08:57 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41550 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752186AbYAQEI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 23:08:56 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H48n0f010630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 20:08:50 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H48m2a008246;
	Wed, 16 Jan 2008 20:08:49 -0800
In-Reply-To: <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70822>



On Wed, 16 Jan 2008, Kevin Ballard wrote:
> 
> I believe it exists because HFS+ was created at a time when the Mac was moving
> from a multi-encoding world (which was a nightmare) to a Unicode world and
> they wanted to remove ambiguity in filenames. But I wasn't around when they
> made this decision so this is just a guess.

I do agree. And I think starting out case-insensitive (something they must 
really hate by now) also made it less of an issue. When you're 
case-insensitive, the issues with any UTF-8 normalization are simply 
swamped by all the issues of case, so you probably don't even think about 
it very much.

The big problem with any name rewriting is that I can open file 'xyz', and 
I literally have a very hard time knowing whether that file I know I 
opened and created has anything to do with the file 'Xyz' that I see when 
I do a readdir().

Are they the same? Maybe. But it's literally hard to tell on OS X. I can 
do an fstat() on my file descriptor and on the directory entry, and if 
they get the same d_ino they *probably are the same entry, but even then 
it actually could have been a hardlink (and my 'xyz' is really *another* 
name for it entirely, and the filesystem is actually case-sensitive and 
'Xyz' was a *different* name that somebody else did!).

See? If you're creating a content tracker, these kinds of issues are not 
"idle chatter". It's really *really* important. Was that file the one I 
was told to track? Or was it a temporary file that was just hardlinked? 

This is why case-insensitivity is so hard: you have a very real "aliasing" 
on the filesystem level, where all those really *different* pathnames end 
up being the same thing.

And all the same issues show up with utf-8 rewriting, so if you normalize 
utf-8 names, you actually end up having almost all the same problems that 
a case-insensitive filesystem has. They're just much rarer in practice, so 
you just won't hit them as often - but when you do, they are equally 
painful!

(In fact, they can be a whole lot *more* painful, because now they are 
really rare, and really confusing when they happen!)

But if you come from a case-insensitive background, all the UTF-8 
rewriting really looks like such a small problem compared to all the 
horrid problems that you had with different locales and cases, so I 
suspect they didn't even realize what a big mistake they did!

			Linus
