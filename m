From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with a push
Date: Tue, 12 Jun 2007 08:07:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706120800430.14121@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
 <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
 <200706121007.17044.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, plexq@plexq.com
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 17:08:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy7yn-0008Qy-S1
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 17:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbXFLPIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 11:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXFLPIO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 11:08:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35697 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777AbXFLPIO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 11:08:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CF85D1031089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2007 08:08:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CF7xes014352;
	Tue, 12 Jun 2007 08:07:59 -0700
In-Reply-To: <200706121007.17044.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.69 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49966>



On Tue, 12 Jun 2007, Andy Parkins wrote:
> 
> I agree its odd, but is it really true that one (I) shouldn't be doing it?

No, it's definitely not a hard rule, and it's perfectly fine to push any 
refs at all, including remotes.

It's just that we probably shouldn't do it by *default*.

There's another slight detail to this story, which is what caused Alex to 
notice in the first place: we tried to push to something that was a 
symref, which actually caused *another* ref to update. Again, there's 
nothing wrong about that theoretically (it's what symrefs are there for!), 
but again, it's probably something we shouldn't do by default.

So there's a big difference between:

 - git _can_ do it, and it's perfectly sane to do when you know what you 
   are doing and have a very specific issue.

and

 - git not only _can_ do it, but will do it even when you didn't 
   explicitly tell it to do that..

> Can I tell you what I'm doing, and check that it's not crazy...
> 
> I have my laptop and my desktop computer; I use both for development.  
> I've set them so that they are symmetric...
> 
> laptop:.git/config
>  [remote "desktop"]
>    url = ssh://blah blah blah
>    fetch = refs/heads/*:refs/remotes/desktop/*
>    push = refs/heads/*:refs/remotes/laptop/*
> 
> desktop:.git/config
>  [remote "laptop"]
>    url = ssh://blah blah blah
>    fetch = refs/heads/*:refs/remotes/laptop/*
>    push = refs/heads/*:refs/remotes/desktop/*
> 
> This is very handy, as git-push on one does the same as git-fetch on the 
> other.  Have I made a glaring mistake by pushing to a remote ref?

I think this is perfectly sane, exactly because you did it explicitly, and 
partly exactly *because* you explicitly don't do what git push does by 
default (which is to update the "remote" refs remotely with what are the 
remote refs locally!).

IOW, the notion of "remote" refs really logically implies a mirror image, 
exactly like you have it set up in your config: what is a local ref in one 
repository is a remote ref in another. But that's not what the default 
"git push" semantics are: it just matches refs directly, without that 
mirroring.

And the _reason_ for it doing that are obviously historical: we didn't use 
to have the notion of "remotes", so back when I did that, it made sense. 
It just doesn't make sense any more.

Junio: I suspect this is really an area worth changing semantics in, the 
same way we changed the semantics for the defaults for "git pull". And I 
suspect it will confuse a lot fewer people, because fewer people depend on 
the default behaviour of "git push".

		Linus
