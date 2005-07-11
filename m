From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 09:38:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507110928070.17536@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
 <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
 <m1irzh74m0.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 19:06:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds1ig-0001Tp-1I
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 19:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVGKQxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGKQkL
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 12:40:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7365 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261982AbVGKQjE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 12:39:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BGcojA031956
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 09:38:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BGcngw016255;
	Mon, 11 Jul 2005 09:38:50 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1irzh74m0.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> 
> I guess I was expecting to pull from one tree into another unrelated
> tree.  Getting a tree with two heads and then be able to merge them
> together.

You can do it, but you have to do it by hand. It's a valid operation, but 
it's not an operation I want people to do by mistake, so it's not 
something the trivial helper scripts help with.

The way to do it by hand is to just use something stupid that doesn't
understand what it's doing anyway, and just copy the files over. "cp -a" 
or "rsync" works fine. Then just do "git resolve" by hand. It's not very 
hard at all, but it's definitely something that should be a special case.

> A couple of questions.
> 
> 1) Does git-clone-script when packed copy the entire repository
>    or just take a couple of slices of the tree where you have
>    references?

It only gets the objects needed for the references, nothing more.

So if you only get one branch, it will leave the objects that are specific 
to other branches alone.

> 2) Is there a way for a pack to create deltas against objects
>    that are not in the tree?  For a dumb repository making incremental
>    changes this is ideal.

A pack can only have deltas against objects in that pack. It caan't even 
have deltas to other objects in the same tree, it literally is only 
_within_ a pack. This is so that each pack is totally independent: you can 
always unpack (and verify) the objects in a pack _without_ having anything 
else (of course, the end result is often not a full project, and you won't 
have any references, but at least the _objects_ are valid).

I don't want to have deltas to outside the pack, because while it's 
obviously very nice from a size packing standpoint, it's totally horrid 
from an infrastructure standpoint. It would make it possible to have 
circular dependencies (ie deltas against each other) that could only be 
resolved by having a third pack (or the unpacked object).

It would also means that you may have to have two packs mapped at the same
time to unpack them, which was very much against what I was aiming for: I
think that in the long run, for truly huge projects, you'd want to have a
history of packs, each maybe a gigabyte in size, and you may be in the 
situation that you simply cannot have two packs mapped at the same time 
because you don't have enough virtual memory for it.

So then inter-pack deltas would mean that you'd have to have "partial pack 
mapping" etc horrid special case logic. Right now, because a pack is 
always self-sufficient, you know that in order to unpack an object, if you 
find it in the index file, you will be able to unpack it by just mapping 
that pack and going off..

So the rule is: don't pack too often. The unpacked objects are actually 
working really really well as long as you don't have tens of thousands of 
them. Having a few hundred (or even a few thousand) unpacked objects is 
not a problem at all. Then you do a "git repack" when it starts getting 
uncomfortable, and you you continue.

			Linus
