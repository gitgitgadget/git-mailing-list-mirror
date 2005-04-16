From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 09:26:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org>
References: <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
 <1113559330.12012.292.camel@baythorne.infradead.org>
 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org>
 <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz> <20050416155536.GX4488@himi.org>
 <20050416160333.GF19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMq3S-0000Yk-WC
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 18:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVDPQZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 12:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVDPQZX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 12:25:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:41449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262693AbVDPQZM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 12:25:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GGOxs4025556
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 09:25:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GGOwGL019421;
	Sat, 16 Apr 2005 09:24:59 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416160333.GF19099@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sat, Apr 16, 2005 at 05:55:37PM CEST, I got a letter
> where Simon Fowler <simon@himi.org> told me that...
>
> > The id is a sha1 hash of the current time and the full path of the
> > file being added - the chances of that being replicated without
> > malicious intent is extremely small. There are other things that
> > could be used, like the hostname, username of the person running the
> > program, etc, but I don't really see them being necessary.
> 
> Why not just use UUID?

Note that using anything that isn't data-related totally destroys the 
whole point of the object database. Remember: any time we don't uniquely 
generate the same name for the same object, we'll waste disk-space.

So adding in user/machine/uuid's to the thing is always a mistake. The 
whole thing depends on the hash being as close to 1:1 with the contents as 
humanly possible. 

There's also the issue of size. Yes, I could have chosen sha256 instead of
sha1. But the keys would be almost twice as big, which in turn means that 
the "tree" objects would be bigger, and that the "index" file would be 
bigger.

Is that a huge problem? No. We can certainly move to it if sha1 ever shows
itself to be weak. But I really think we are much better off just
re-generating the whole tree and history at that point, rather than try to 
predict the future.

The fact is, with current knowledge, sha1 _is_ safe for what git uses it 
for, for the forseeable future. And we have a migration strategy if I'm 
wrong. Don't worry about it.

Almost all attacks on sha1 will depend on _replacing_ a file with a bogus
new one. So guys, instead of using sha256 or going overboard, just make 
sure that when you synchronize, you NEVER import a file you already have.

It's really that simple. Add "--ignore-existing" to your rsync scripts,
and you're pretty much done. That guarantees that a new evil blob by the
next mad scientist out to take over the world will never touch your
repository, and if we make this part of the _standard_ scripts, then
dammit, security is in good _practices_ rather than just relying blindly
on the hash being secure.

In other words, I think we could have used md5's as the hash, if we just
make sure we have good practices. And it wouldn't have been "insecure".

The fact is, you don't merge with people you don't trust. If you don't
trust them, they have a much easier time corrupting your repository by
just creating bugs in the code and checking that thing in. Who cares about
hash collisions, when you can generate a kernel root vulnerability by just
adding a single line of code and use the _correct_ hash for it.

So the sha1 hash does not replace _trust_. That comes from something else 
altogether.

			Linus
