From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 6 Sep 2009 12:54:23 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain>
References: <4AA17874.7090905@debian.org> <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com> <7vab191dz1.fsf@alter.siamese.dyndns.org> <7vzl98vrmt.fsf@alter.siamese.dyndns.org> <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain> <7v3a6z3lsg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 21:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkNqq-0005Nu-6X
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 21:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758220AbZIFTy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 15:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758204AbZIFTy2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 15:54:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56956 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758191AbZIFTy2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 15:54:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86JsOE3012638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 12:54:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86JsNQ8023630;
	Sun, 6 Sep 2009 12:54:24 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v3a6z3lsg.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127866>



On Sun, 6 Sep 2009, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > And then fix the fallout from that: callers never get mixed-up tree and 
> > blob entries, and have to do their DF checking themselves.
> 
> There are two levels of internal APIs involved, and I am getting confused
> as to which level of callers you are referrring to in the above.

It could be done at any level, but there's a few places where it's easier 
than others.

> My understanding of the current situation is:
> 
>  * unpack_trees() takes a callback from the caller in o->fn().  It
>    promises (but fails to keep the promise) that the callback is called
>    with entries with matching names, so that it gets to see D/F
>    conflicting entries in one go.

Indeed. I'd _like_ to do it at this level (or even at the o->fn() level), 
but quite frankly, unpack_trees() is so horribly complicated, and you'd 
have to remember state, that doing it at this level is not realy 
maintainable.

>  * traverse_trees() takes a callback from the caller in info->fn().  It
>    feeds the callback the entries with the same name most of the time, but
>    that is not a guarantee, and the bug we are seeing is coming from a
>    caller, unpack_trees_callback(), assuming it.

This is the level I'm looking at. In fact, I'm going to cheat. I'm not 
going to do it when we call info->fn(), I'm going to do it _before_ the 
call, and have a special "find conflicts" phase inside traverse_trees() 
itself.

That way, any traverse_trees() user will see the conflicts exactly like 
they used to, because I'm just going to add a special "find conflicts" 
phase there that does the right thing. It's a hack, but it's a "useful" 
hack, and it at least avoids being the current "it can't work for the 
special case" thing.

> Do you mean we would still keep the promise unpack_trees() makes to its
> callbacks, e.g. threeway_merge(), or do you mean these callbacks are to be
> prepared to get DF-split input themselves and expected to coalesce them
> as necessary?

Either would work, but changing unpack_trees() semantics would just be 
very painful. There are just too many users of it, and they are too 
ingrained in their expectations of getting conflict information in a 
single pass.

I think I have a good solution, give me half an hour to actually get it to 
work.

			Linus
