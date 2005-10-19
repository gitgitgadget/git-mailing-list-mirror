From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 17:41:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181728490.3369@g5.osdl.org>
References: <435560F7.4080006@zytor.com> <Pine.LNX.4.64.0510181517280.3369@g5.osdl.org>
 <435591A3.7030708@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 02:42:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES21G-0006mH-HA
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 02:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVJSAlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 20:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJSAlP
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 20:41:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932373AbVJSAlO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 20:41:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9J0fDFC019654
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 17:41:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9J0fCTW008498;
	Tue, 18 Oct 2005 17:41:13 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <435591A3.7030708@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10247>



On Tue, 18 Oct 2005, H. Peter Anvin wrote:
> 
> This is also exactly the kind of DWIM that tends to result in the kind of
> security holes I described earlier.

I don't agree. 

DWIM isn't automatically a security hole. DWIM _can_ be a security hole, 
but so can anything else that is badly designed or specified.

And just appending ".git" is _not_ badly designed/specified. I did think 
about the boundary cases, and it's entirely safe:

 - it can't result in "surprises": if the original pathname doesn't exist, 
   then even if there is a race and it got created in between the two 
   chdir's as a directory and the name had a slash at the end, adding 
   ".git" is actually safe even if it succeeds: it won't take us anywhere 
   surprising. At worst it will take us to the ".git" directory of a newly 
   added git archive, but that's what we wanted anyway, so..

 - you can't create ".." with it - even if the passed-in filename ended 
   with "xyz/.", you'll end up with a perfectly safe "xyz/..git", so any 
   safety checks that were done on the original pathname are still valid 
   when appending ".git" to it.

 - and exactly because we don't append slashes or anything like that, the 
   end result won't even have anything ambiguous like "//" in it.

So it really doesn't have any downsides that I can see.

> The DWIM aspect is fine, of course, but it has to be done up front: instead of
> doing just chdir(), each path should be validated through path_ok() before
> even being considered for chdir().  Perhaps the right thing to do is to
> combine the two functions.

Sure, you could do that, and just replace path_ok + chdir with a 
"safe_chdir()". I don't really see the point, unless you want to walk the 
path one component at a time, though (which is really quite expensive).

If you want to verify that it's still on the same filesystem and didn't 
traverse any dubious symlinks (the only reason to do the component walking 
afaik), it's actually much cheaper to just do the chdir() and then do a 
"getcwd()" to verify that the result matches. At least under Linux.

(That, btw, is likely the right way to do "valid directory checking" 
anyway: if you have a white-list of acceptable directories, just do a 
chdir() blindly without any checking, then do "getcwd()" and check the 
result of that against the whitelist - then you can even allow ".." etc, 
and never even care)

			Linus
