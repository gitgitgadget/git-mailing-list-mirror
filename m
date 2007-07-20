From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 12:24:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707201210550.27249@woody.linux-foundation.org>
References: <858x9ez1li.fsf@lola.goethe.zz> <vpq4pk1vf7q.fsf@bauges.imag.fr>
 <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com>
 <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com>
 <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
 <85644fvdrn.fsf@lola.goet he.zz> <46A08006.4020500@fs.ei.tum.de>
 <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 21:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBy5i-0000jG-AQ
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 21:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721AbXGTTYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 15:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbXGTTYj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 15:24:39 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33700 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753821AbXGTTYh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 15:24:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KJO9Qj028723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 12:24:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6KJO276012282;
	Fri, 20 Jul 2007 12:24:03 -0700
In-Reply-To: <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.205 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53118>



On Fri, 20 Jul 2007, Junio C Hamano wrote:
> 
> Using attribute that is detached from the content itself allows
> you to hoist that one bit one level up.  By treating
> executable-ness not as part of content, we can compare two blobs
> with different executable bits cheaply.  You can avoid
> descending into such a tree when comparing it with another tree
> that is different only by the "will-stay-when-emptied"-ness the
> same way.

Having thought about it a bit more, I would absolutely *detest* any kind 
of "executable bit" like behaviour.

Why? 

Merging. I think one of the fundamental issues in merging is that you do 
it "in the working tree". This is something that pretty much *everybody* 
else gets wrong, and it's somethign where git absolutely shines.

But git shines here exactly because git never tracks "history" or the 
state in the tree, and only ever tracks things that are indubitably real 
content. Which is why you never *ever* have to tell git about "I moved 
file X to file Y" - because git only tracks things that it can see right 
in front of it, in the tree.

The "sticky directory" bit simply would not be something like that. It 
simply isn't "content", and as such, it should not be tracked. It's as 
easy as that. We don't want a merge of two branches to have to specify any 
extra data "outside" the tree as to how it should be merged.

So the issue about whether a directory *exists* or not can be merged (just 
look at the tree), but the issue about whether the directory is supposed 
to be sticky is something that you'd have to tell git about *outside* of 
the tree, and that violates the whole point of working tree merges.

I do realize that if you use inferior operating systems, we already have 
these kinds of "outside the tree" data entries, thanks to issues like 
symlinks and normal file executable bits that you would have to explicitly 
tell git about when you're working in a broken environment. So in that 
sense, it wouldn't be anything technically new for git. 

But that doesn't change the fundamental issue: the limitation with 
executable bits and symlinks is a limitation of the broken environment, 
not of git. But "directories stay around after the last file is gone" is 
not that, it would simply be a design mistake in git itself.

There are other reasons to not do it. What about file renames? Maybe the 
directory got *renamed*. From a pure content angle, this is "all the files 
in that directory went away". If you have stupid rules like "directories 
stay around even though all the files went away", you would again have 
problems with this common case.

In other words: I don't care one whit about the whiners. What's MUCH more 
important than some random whiny person saying "Daddy, daddy, I want a 
pony" is whether you can afford to maintain that pony in the future. And 
this pony is just stupid.

So here:

	No, you cannot have a pony. NOT YOURS.

but I still think we should support the concept of importing things from 
other systems, and thus eventually support empty directories. Just not any 
crazy semantics with sticky histories.

			Linus

PS. As usual, per-user or per-repository *local* attributes are something 
else. They aren't "sticky history", they are just purely behavioural 
defaults. Those kinds of things may make sense. But that's not a "tracking 
content" issue.
