From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 08:28:38 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, ae@op5.se,
	Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWjD-000778-BE
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXKIQ2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbXKIQ2w
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:28:52 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43875 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751233AbXKIQ2v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 11:28:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9GSdK1012183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 08:28:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9GScZ2022137;
	Fri, 9 Nov 2007 08:28:38 -0800
In-Reply-To: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64213>



On Fri, 9 Nov 2007, Yossi Leybovich wrote:
> 
> Did not help still the repository look for this object?
> Any one know how can I track this object and understand which file is it

So exactly *becuse* the SHA1 hash is cryptographically secure, the hash 
itself doesn't actually tell you anything, in order to fix a corrupt 
object you basically have to find the "original source" for it. 

The easiest way to do that is almost always to have backups, and find the 
same object somewhere else. Backups really are a good idea, and git makes 
it pretty easy (if nothing else, just clone the repository somewhere else, 
and make sure that you do *not* use a hard-linked clone, and preferably 
not the same disk/machine).

But since you don't seem to have backups right now, the good news is that 
especially with a single blob being corrupt, these things *are* somewhat 
debuggable.

First off, move the corrupt object away, and *save* it. The most common 
cause of corruption so far has been memory corruption, but even so, there 
are people who would be interested in seeing the corruption - but it's 
basically impossible to judge the corruption until we can also see the 
original object, so right now the corrupt object is useless, but it's very 
interesting for the future, in the hope that you can re-create a 
non-corrupt version.

So:

> ib]$ mv .git/objects/4b/9458b3786228369c63936db65827de3cc06200 ../

This is the right thing to do, although it's usually best to save it under 
it's full SHA1 name (you just dropped the "4b" from the result ;).

Let's see what that tells us:

> ib]$ git-fsck --full
> broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
>              to    blob 4b9458b3786228369c63936db65827de3cc06200
> missing blob 4b9458b3786228369c63936db65827de3cc06200

Ok, I removed the "dangling commit" messages, because they are just 
messages about the fact that you probably have rebased etc, so they're not 
at all interesting. But what remains is still very useful. In particular, 
we now know which tree points to it!

Now you can do

	git ls-tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8

which will show something like

	100644 blob 8d14531846b95bfa3564b58ccfb7913a034323b8    .gitignore
	100644 blob ebf9bf84da0aab5ed944264a5db2a65fe3a3e883    .mailmap
	100644 blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c    COPYING
	100644 blob ee909f2cc49e54f0799a4739d24c4cb9151ae453    CREDITS
	040000 tree 0f5f709c17ad89e72bdbbef6ea221c69807009f6    Documentation
	100644 blob 1570d248ad9237e4fa6e4d079336b9da62d9ba32    Kbuild
	100644 blob 1c7c229a092665b11cd46a25dbd40feeb31661d9    MAINTAINERS
	...

and you should now have a line that looks like

	10064 blob 4b9458b3786228369c63936db65827de3cc06200	my-magic-file

in the output. This already tells you a *lot* it tells you what file the 
corrupt blob came from!

Now, it doesn't tell you quite enough, though: it doesn't tell what 
*version* of the file didn't get correctly written! You might be really 
lucky, and it may be the version that you already have checked out in your 
working tree, in which case fixing this problem is really simple, just do

	git hash-object -w my-magic-file

again, and if it outputs the missing SHA1 (4b945..) you're now all done!

But that's the really lucky case, so let's assume that it was some older 
version that was broken. How do you tell which version it was?

The easiest way to do it is to do

	git log --raw --all --full-history -- subdirectory/my-magic-file 

and that will show you the whole log for that file (please realize that 
the tree you had may not be the top-level tree, so you need to figure out 
which subdirectory it was in on your own), and because you're asking for 
raw output, you'll now get something like

	commit abc
	Author:
	Date:
	  ..
	:100644 100644 4b9458b... newsha... M  somedirectory/my-magic-file


	commit xyz
	Author:
	Date:
	
	  ..
	:100644 100644 oldsha... 4b9458b... M	somedirectory/my-magic-file

and this actually tells you what the *previous* and *subsequent* versions 
of that file were! So now you can look at those ("oldsha" and "newsha" 
respectively), and hopefully you have done commits often, and can 
re-create the missing my-magic-file version by looking at those older and 
newer versions!

If you can do that, you can now recreate the missing object with

	git hash-object -w <recreated-file>

and your repository is good again!

(Btw, you could have ignored the fsck, and started with doing a 

	git log --raw --all

and just looked for the sha of the missing object (4b9458b..) in that 
whole thing. It's up to you - git does *have* a lot of information, it is 
just missing one particular blob version.

Trying to recreate trees and especially commits is *much* harder. So you 
were lucky that it's a blob. It's quite possible that you can recreate the 
thing.

			Linus
