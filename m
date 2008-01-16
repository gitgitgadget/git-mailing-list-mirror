From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 14:52:32 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161433380.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
 <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFH8E-00046g-I5
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYAPWwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYAPWwq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:52:46 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46164 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751310AbYAPWwp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 17:52:45 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GMqX6l029287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 14:52:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GMqWuV028699;
	Wed, 16 Jan 2008 14:52:32 -0800
In-Reply-To: <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70760>



On Wed, 16 Jan 2008, Linus Torvalds wrote:
> 
> Does it always matter? Hell no. But the problem with a filesystem that 
> thinks it knows better is that when it *sometimes* matters, the filesystem 
> simply DOES THE WRONG THING.
> 
> Can't you understand that?

Side note: there are ways to do it right.

You can:

 - not do conversion at all (which is always right). Not corrupting the 
   user data means that the user never gets something back that he didn't 
   put in

   (And, btw, the "security" argument is total BS. The fact that two 
   characters look the same does not mean that they should act the same, 
   and it is *not* a security feature. Quite the reverse. Having programs 
   that get different results back from what they actually wrote, *that* 
   tends to be a security issue, because now you have a confused program, 
   and I guarantee that there are more bugs in unexpected cases than in 
   the expected ones)

 - Not accept data in formats that you don't like. This is also always 
   right, but can be rather impolite.

 - Not accept data in formats that you don't like, and give people 
   explicit conversion and comparison routines so that they can then make 
   their own decisions and they are *aware* of the conversion (so that 
   they don't come back to the problem of being confused)

So there are certainly many ways to handle things like this.

The one thing you shouldn't do is to silently convert data behind the 
programs back, without even giving any way to disable it (and that disable 
has to be on a use-by-use casis, not some "disable/enable for all users of 
this filesystem", because you can - and do - have different programs that 
have different expectations).

And finally: all of the above is true at *all* levels. It doesn't matter 
one whit whether the automatic conversion conversion is in the kernel or 
in a library. Doing it on a library level has advantages (namely the whole 
"disable/enable" thing tends to get *much* easier to do, and applications 
can decide to link against a particular version to get the behaviour 
*they* want, for example).

So doing it inside the kernel is just about the worst possible case, 
exactly because it makes it really hard to do a "on a case-by-case" basis. 

Yes, Linux does it too, but it does it only for filesystems that are 
*defined* to be insane. OS X really should have known better. Especially 
since they already fixed the applications (ie they do allow for 
case-sensitive filesystems).

I can understand normalization when it's about case-insensitivity (there 
are lots of _technical_ reasons to do it there), but once you let the 
case-insensitivity go, there just isn't any excuse any more.

			Linus
