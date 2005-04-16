From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 11:44:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504161135480.7211@ppc970.osdl.org>
References: <20050416131528.GB19908@elte.hu>  <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
 <1113679421.28612.16.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:39:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsC9-0003Rg-NT
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVDPSmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVDPSmq
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:42:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:51612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262726AbVDPSmn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 14:42:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GIgbs4002389
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 11:42:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GIgaVS023414;
	Sat, 16 Apr 2005 11:42:36 -0700
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1113679421.28612.16.camel@tglx.tec.linutronix.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Thomas Gleixner wrote:
> 
> One remark on the tree blob storage format. 
> The binary storage of the sha1sum of the refered object is a PITA for
> scripting. 
> Converting the ASCII -> binary for the sha1sum comparision should not
> take much longer than the binary -> ASCII conversion for the file
> reference. Can this be changed ?

I'd really rather not. Why don't you just use "ls-tree" for scripting? 
That's why it exists in the first place. 

It might make sense to have some simple selection capabilities built into 
ls-tree (ie "ls-tree --match drivers/char/ -z <treesha1>" to get just a 
subtree out), but that depends entirely on how you end up using it.

The fact is, there should _never_ any reason to look at the objects
themselves directly. "cat-file" is a debugging aid, it shouldn't be
scripted (with the possible exception of "cat-file blob xxxx" to just
extract the blob contents, since that object doesn't have any internal
structure).

That level of abstraction ("we never look directly at the objects") is 
what allows us to change the object structure later. For example, we 
already changed the "commit" date thing once, and the tree object has 
obviously evolved a bit, and if we ever change the hash, the objects will 
change too, but if you always just script them using nice helper tools, 
you won't ever need to _care_. And that's how it should be.

If there's a tool missing, holler. THAT is the part I've been trying to
write: all the plumbing so that you _can_ script the thing sanely, and not
worry about how objects are created and worked with. 

For example, that "index" file format likely _will_ change. I ended up
doing the new "stage" flags in a way that kept the index file compatible
with old ones, but I did that mainly because it also happened to be the
easiest way to enforce the rule I wanted to enforce (ie the "stage" really
_is_ a part of the filename from a "compare filenames" standpoint, in
order to make sure that the stages are always ordered).

So if the index file change hadn't had that property, I'd have just said
"I'll change the format", and anybody who tried to parse the index file
would have been _broken_.

		Linus
