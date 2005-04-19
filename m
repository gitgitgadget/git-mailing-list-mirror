From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 12:03:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org>
 <200504191412.00227.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 20:59:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNxw2-0001jn-F2
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 20:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVDSTC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVDSTC5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 15:02:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:49637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261240AbVDSTBr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 15:01:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JJ1bs4006092
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 12:01:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JJ1aMM025510;
	Tue, 19 Apr 2005 12:01:37 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504191412.00227.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Chris Mason wrote:
> 
> Very true, you can't replace quilt with git without ruining both of them.  But 
> it would be nice to take a quilt tree and turn it into a git tree for merging 
> purposes, or to make use of whatever visualization tools might exist someday.  

Fair enough. The thing is, going from quilt->git really is a pretty "big
decision", since it's the decision that says "I will now really commit all
this quilt changes forever and ever".

Which is also why I think it's actually ok to take a minute to do 100
quilt patches. This is not something you do on a whim. It's something
you'd better think about. It's turning a very fluid environment into a
unchangable, final thing.

That said, I agree that "write-tree" is expensive. It tends to be by far
the most expensive op you normally do. I'll make sure it goes faster.

> We already have a "trust me, it hasn't changed" via update-cache.

Heh. I see "update-cache" not as a "it hasn't changed", but a "it _has_ 
changed, and now I want you to reflect that fact". In other words, 
update-cache is an active statement: it says that you're ready to commit 
your changes.

In contrast, to me your "write-tree" thing in many ways is the reverse of 
that: it's saying "don't look here, there's nothing interesting there".

Which to me smells like trying to hide problems rather than being positive 
about them.

Which it is, of course. It's trying to hide the fact that writing a tree 
is not instantaenous.

> With that said, I hate the patch too.  I didn't see how to compare against the 
> old tree without reading each tree object from the old tree, and that should 
> be slower then what write-tree does now.

Reading a tree is faster, simply because you uncompress instead of
compress. So I can read a tree in 0.28 seconds, but it takes me 0.34
seconds to write one. That said, reading the trees has disk seek issues if
it's not in the cache.

What I'd actually prefer to do is to just handle tree caching the same way
we handle file caching - in the index.

Ie we could have the index file track "what subtree is this directory
associated with", and have a "update-cache --refresh-dir" thing that
updates it (and any entry update in that directory obviously removes the
dir-cache entry).

Normally we'd not bother and it would never trigger, but it would be
useful for your scripted setup it would end up caching all the tree
information in a very efficient manner. Totally transparently, apart from
the one "--refresh-dir" at the beginning. That one would be slightly
expensive (ie would do all the stuff that "write-tree" does, but it would
be done just once).

(We could also just make "write-tree" do it _totally_ transparently, but
then we're back to having write-tree both read _and_ write the index file,
which is a situation that I've been trying to avoid. It's so much easier 
to verify the correctness of an operation if it is purely "one-way").

I'll think about it. I'd love to speed up write-tree, and keeping track of 
it in the index is a nice little trick, but it's not quite high enough up 
on my worries for me to act on it right now.

But if you want to try to see how nasty it would be to add tree index
entries to the index file at "write-tree" time automatically, hey...

		Linus
