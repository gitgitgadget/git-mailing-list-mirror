X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: handling symlinks proposal
Date: Sun, 26 Nov 2006 10:46:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611261034100.3483@woody.osdl.org>
References: <4569C7F8.4030303@pipapo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 26 Nov 2006 18:46:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4569C7F8.4030303@pipapo.org>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32363>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoP1N-0002fT-AB for gcvg-git@gmane.org; Sun, 26 Nov
 2006 19:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935534AbWKZSqa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 13:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935531AbWKZSqa
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 13:46:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:62188 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S935534AbWKZSq3 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 13:46:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAQIkGix004862
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 26
 Nov 2006 10:46:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAQIkFRR005915; Sun, 26 Nov
 2006 10:46:15 -0800
To: Christian Thaeter <ct@pipapo.org>
Sender: git-owner@vger.kernel.org



On Sun, 26 Nov 2006, Christian Thaeter wrote:
>
> Git currently keep symlinks always as symlink, I would like to see some
> optional functionality when handling symlinks.

I can pretty much guarantee that you really don't want to do this, and 
that you'd be _much_ happier using some explicit wrappers around git to 
handle your special needs, than try to teach the SCM to handle symlinks 
specially.

The issues become all the same as with some of the idiotic things that 
other SCM's do - like $Id keyword substitution - but _much_ worse.

A simple example: what is "git diff HEAD" supposed to say, once you've 
committed the symlink as something else than a symlink? It's obviously 
still a symlink in your source tree.. Or what about "git reset --hard", or 
"git checkout other-branch-that-also-had-a-symlink"?

In other words, trivial and simple operations that have clear and 
well-defined semantics suddenly become totally insane, with no semantics 
that make sense what-so-ever. 

By not "keeping" symlinks as symlinks, what you actually did was to 
totally destroy the ability to handle symlinks AT ALL. The simplest core 
operations suddenly cannot work, because you've broken the 1:1 link 
between "original source tree" and "tree that actually got committed".

> how can we handle symlinks:
>  - 'keep' what git currently does, store the symlink as it is

Right. This is the only sane thing, if you want to support symlinks at 
all.

>  - 'file' store it as file (dereference it), information that it was a
>     symlink gets lost, checkouts will produce a file.

This is what some other systems do, by just not knowing anything about 
symlinks at all. It's certainly self-consistent - you can just drop all 
"lstat()" calls, and replace them with regular "stat()" calls. 

It causes:

 - (obviously) inability to handle symlinks correctly

 - security problems and serious confusion when you _do_ have a symlink
   (what happens when you check out another branch, and the symlink points 
   to outside the tree? A system that is truly unaware of symlinks will 
   generally just overwrite the file OUTSIDE the tree, which is clearly 
   bogus, but equally bogus is to just do an "unlink + create" which will 
   break the symlink.

so it's generally MUCH worse than any alternative.

>  - 'relative' store it as a relative symlink
>  - 'absolute' store it as a absolute symlink

Neither of these make any real sense. You can really only store it in the 
form it is now, because you simply _cannot_ make it a "relative" or 
"absolute" symlink (the transformation depends on how things are mounted).

Not to mention that you get all the problems with "what does 'git diff' 
mean?" that I already alluded to above..

>  - 'error' refuse to checkin and abort commit

Sure, we can just say "don't allow symlinks". This is probably what we'd 
have to do for a native Windows client, for example, or for anything else 
that simply doesn't support the concept (VMS port of git, anyone?).

>  - 'warn' display a warning

Again, there's nothing wrong with this, but what's the point, really? 
Especially a big enough point to merit a per-branch config option?

