From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 15:03:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141447290.20368@woody.linux-foundation.org>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com>
 <17875.30687.661794.512124@lisa.zopyra.com>
 <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
 <17875.33204.413186.355557@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 00:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHT9r-0002T8-M2
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 00:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbXBNXDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 18:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbXBNXDY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 18:03:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50224 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964798AbXBNXDX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 18:03:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EN3KhB019642
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 15:03:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EN3Jvf012137;
	Wed, 14 Feb 2007 15:03:19 -0800
In-Reply-To: <17875.33204.413186.355557@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.407 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39771>



On Wed, 14 Feb 2007, Bill Lear wrote:
>
> WAAAAAIAMINIT ... I think I see it:
> 
> % perl -pi -e 's/.*\$Id.*//sx' $(xgrep -l '[$]Id')
> 
> Could I have corrupted the pack file?  I'll bet $50 I did:

Heh.

I'm relieved git is off the hook, although I think we should still look at 
that SIGSEGV. We might well have some situation where we react badly do a 
corrupt pack (most likely, by having one of the object parsing routines 
return NULL, and then we follow that NULL pointer rather than saying "bad 
object").

> % [yet another clone]
> % xgrep -l '[$]Id'
> ./.git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack

This is just one reason I don't ever use 'find' on my source tree. I long 
ago used to do

	find . -name '*.c' | xargs grep ...

etc, but especially with git I have almost totally stopped using "xargs 
grep" entirely - to the point where I actually end up importing tar-files 
into new git archives just because I'm so used to "git grep".

So I would suggest that in order to avoid this in the future, you teach 
your fingers to say "git grep" instead of "xgrep"., which I assume is just 
some local alias of yours for "find .. | xargs grep"?

"git grep" really works wonderfully well, and you could have just done

	perl -pi -e 's/.*\$Id.*//sx' $(git grep -l '[$]Id')

instead.

("git grep" is much nicer than "xargs grep" in many other ways too. You 
can ask it to limit itself to a certain pattern of filenames etc by doing

	git grep -l '[$]Id' -- 'net/*.[ch]'

as long as you realize that the name pattern for git grep considers '*' to 
act like '**' does for some shells - ie it globs against '/'too, so the 
above will find any C and header files under the net/ directory, however 
deep they are.. And you can ask it to grep in just a certain revision etc 
too).

Once you get used to "git grep", I bet you'll forget all about "xgrep", 
and won't have to worry about going into the .git/ directory by mistake 
any more.

There are other tricks you can do, but they are somewhat inconvenient. 
They range from making ".git" a symlink to somewhere else (to stop 
"find" from following it), and in your case, since you apparently already 
have an "xgrep" alias for this, you could just teach your "find" thing to 
do something like what we do in the kernel Makefile:

	RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o

and then we use

	find . $(RCS_FIND_IGNORE) ...

which knows to ignore ".git" directories along with all the other 
SCCS/CVS/SVN/BK/etc directories.

		Linus
