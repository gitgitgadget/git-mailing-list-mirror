From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Mon, 13 Feb 2006 08:19:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602130806070.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <43F01F5A.5020808@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Clifford <benc@hawaga.org.uk>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 17:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8gRE-0001mS-UQ
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 17:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWBMQU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 11:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWBMQU1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 11:20:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbWBMQU0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 11:20:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1DGJCDZ008157
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 08:19:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1DGJAA5024677;
	Mon, 13 Feb 2006 08:19:10 -0800
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <43F01F5A.5020808@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16073>



On Mon, 13 Feb 2006, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > I've never used maildir layout, but if it is a couple of large _flat_
> > subdirectories,
> 
> That's what it is :/   One directory per mail folder, with each email an
> individual file in that dir.

Ok.

Anyway, I double-checked, and I'm wrong anyway. While the "static 
directories" thing is a huge performance optimization for doing many 
things (diffing trees, file history in git-rev-list, etc etc), for merging 
it doesn't help. We always end up expanding the whole tree.

Which is kind of sad.

It's inevitable in one sense: we do the merge in the index, after all, and 
the index - unlike the tree structures - is a flat file (like the 
"manifest" in mercurial or monotone). It's also represented that way in 
memory. 

However, it is a total and complete waste in other cases.

Thinking more about it, this is also why merging causes all the horrible 
index performance: not only do we (unnecessarily) read the same trees over 
and over again only to collapse them back to stage0 later when they are 
the same, but because we keep the index in a linear format, when we read 
the other trees, we'll have to move things around with memmove() (just the 
pointers, but still).

We'd actually be a _lot_ better off if we split "git-read-tree" up into 
two phases: one that did the recursive tree operation (which can optimize 
the "same tree everywhere" case), and the second stage that actually 
populated the index.

I'll have to think about this. It would be an absolutely _huge_ 
optimization for merging in certain patterns, it just doesn't matter for 
something like the kernel with "just" 18,000 files and not a lot of 
strange merging going on.

In contrast, I can see a mail archive easily having hundreds of thousands 
of individual emails. At which time it's horribly stupid to read them all 
in three times (for a merge - base, origin, new) and do so in a pretty 
inefficient manner.

Ho humm. It doesn't look _hard_ per se, and I think the two-stage 
git-read-tree is actually also what the recursive merge strategy wants 
anyway (it can't use the index - it really just wants to get a list of 
conflict information). So this definitely sounds like the RightThing(tm) 
to do anyway, and it fits the git data structures really well.

So no downsides. Except that this is some rather core code, and you can't 
afford to get it wrong. And the fact that I'm a lazy bastard, of course.

			Linus
