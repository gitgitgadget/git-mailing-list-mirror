From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree
 performance problems)
Date: Wed, 20 Apr 2005 07:59:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200731590.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com>  <200504191708.23536.mason@suse.com>
  <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>  <200504192049.21947.mason@suse.com>
  <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>  <42660708.60109@zytor.com>
  <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
 <1114006429.5877.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:55:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOGaa-0002dc-Or
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 16:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVDTO6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVDTO6P
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 10:58:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:8595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261664AbVDTO6F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 10:58:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KEvqs4001146
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 07:57:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KEvoOV007751;
	Wed, 20 Apr 2005 07:57:51 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114006429.5877.42.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, David Woodhouse wrote:
> 
> The reason for doing this is that without it, we can't ever have a full
> history actually connected to the current trees. There'd always be a
> break at 2.6.12-rc2, at which point you'd have to switch to an entirely
> different git repository.

Quite frankly, I'd _much_ rather have a notion of "external references" 
than start depending on external hashes.

IOW, I'd be happier with a new line in the header (after the normal
"author"/"committer" lines) that just pointed to an external tree, aka

	external linux-2.6.12-rc2-tree

and then people could literally use this to link whatever they wanted, and 
it would not force one particular version of an external tree on you.

Why? Because we can't keep re-generating trees.

However, the second part of that plan is that once you do that, you might 
as well make the "external" linkages be external to the repository itself. 
IOW, you could just make a file that the git tools can parse that say

	external-parent <root-hash> <external-parent-ID>
		comment for this parent

	external-parent <commit-hash> <external-parent-ID>
		comment for this parent

and the nice thing about that is that now that information allows you to 
add external parents at any point. 

Why do it like this? First off, I think that the "initial import" ends up
being just one special case of the much more _generic_ issue of having
patches come in from other source control systems (ie the above would
actually work with the darcs issues too, and allow people to track the
dependencies between a tree maintained in git and maintained elsewhere).

Secondly, we do need something like this for pruning off history anyway, 
so that the tools have a better way of saying "history has been pruned 
off" than just hitting a missing commit. That's not a big deal right now, 
since I'm not planning on letting people prune their history (or at least 
I'm planning on having tools complain loudly), but it _will_ be an issue. 
I think history pruning is wonderful, but I do want to have some mechanism 
to say "it was pruned" as opposed to "it was lost".

Thirdly, I don't actually want my new tree to depend on a conversion of
the old BK tree.

Two reasons: if it's a really full conversion, there are definitely going
to be issues with BitMover. They do not want people to try to reverse
engineer how they do namespace merges, which is why they have the "don't
look at git and do another SCM at the same time" clause in the first
place. Namespace merges (and probably other things too, for that matter)
tend to be the thing they tend to do better than anybody else. The kernel
probably does not actually have a lot of those so it might be ok by them,
but the keyword is _might_, and I don't want to cloud git by another
flamewar.

The other reason is just the really obvious one: in the last week, I've
already changed the format _twice_ in ways that change the hash. As long
as it's 119MB of data, it's not going to be too nasty to do again. If it's
3+GB of data, I'm going to feel really constrained about the kind of
conversions I can do. It's one thing to have something that takes a few
minutes and that anybody can do. It's another thing entirely to do
something that requires the convertee to dedicate tons of diskspace and
hours of work on it.

Let's face it, I doubt we did our last conversion ever. I still think that
the git data model is the best model _ever_ for an SCM, but it's not all
the minute details I'm proud over, it's the general big things. For
example, let's see how the "blobs are sequences of smaller hashes" thing
works out. I was doubtful, but Scott's first chunking code doesn't make me
hurl chunks, and I've been wrong before.

And the thing is, I'm ok with being wrong. Especially if I can fix things 
up later.

So I've got tons of reasons (that you may not agree with, obviously) for
why I don't think it's a good idea to base the kernel on a large
conversion. Some (or all) of those reasons may become moot in another week
or month, but I'd definitely _not_ that interested in doing it now. If it
turns out later that we do want to re-base the kernel, we can do any
conversion we want at a later time - it's not that it's necessarily the
wrong thing to do, but I think it is the wrogn thing to do _now_.

		Linus
