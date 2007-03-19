From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 13:22:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191308130.6730@woody.linux-foundation.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com> <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
 <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
 <45FEEB0C.3080602@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, John Goerzen <jgoerzen@complete.org>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:23:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTONk-0003vb-GN
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbXCSUW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbXCSUW7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:22:59 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54122 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbXCSUW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:22:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JKMRcD006361
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 13:22:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JKMQfs016244;
	Mon, 19 Mar 2007 12:22:27 -0800
In-Reply-To: <45FEEB0C.3080602@midwinter.com>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42666>



On Mon, 19 Mar 2007, Steven Grimm wrote:
> 
> Until someone comes up with a way to make content-based rename detection 100%
> foolproof in the face of things like frequent self-references in Java or C++
> classes, it may be a necessary evil (or at least a worthwhile one.)

Try to implement it. Trust me, it will suck so badly that you'll realize 
that I am right.

File identities have *huge* problems. They are a total nightmare to 
implement well, and you'd lose a lot of the really good features that git 
has. But I suspect it's not worth trying to convince you. You really need 
to just try to do it.

I can name some of the problems:

 - you get a whole new source of really fundamentally nasty merge 
   conflicts that are really fundmanentally hard to handle.

   I have first-hand experience, and I realize that lots of people simply 
   don't even *understand* the problems. But take it from me - having two 
   different repositories create the same file independently (which is not 
   at all uncommon - patches flying around make it really easy) - is the 
   tip of a very nasty iceberg.

   Git makes merges easy in comparison. Trying to track file ID's is a 
   huge gaping hole, leading to hell. I doubt you'll find an SCM that does 
   it, and does it well.

   (Side note: in a *centralized* setup, with no branches, this isn't a 
   problem. But with branches it already becomes a nastier issue, and when 
   decentralized you simply cannot avoid it at all).

   End result: merges suck. Unless you're smart, and use git.

 - The end result depends on the path you took to get there. You're going 
   to have a really hard time re-creating things exactly, and doing so 
   from patches (which is *the* most common way actual real development 
   gets done) is basically impossible. So you end up with the meaning 
   getting lost along the way (or being added), and now where is your 
   "trustworthy" file movement logic?

I've seen both problems with BK. Bitkeeper had a nice patch application 
graphical toolkit to help some of these issues. It was really nice, but it 
was still *painful*. Not having it would be a total disaster. Except if 
you simply don't need it - like git.

The merges in particular is something that git just DOES BETTER than 
anybody else. The lack of explicit file ID information means that you can 
just fix up the conflicts in the working tree using perfectly normal 
tools, and never have to do anything special with special "merge tools". 

You may still want to use nice graphical tools to help you, of course, but 
they aren't even git-specific any more. See the whole discussion about 
visual merge tools recently, and "git mergetool", and using a random tool 
to do the merge. Realize that IF FILE IDENTITIES MATTER, none of this 
works. Suddenly, you need to have special tools that resolve the file 
identity problem (never mind the fact that quite often there *is* no 
ideal resolution and "resolving" it ends up being "pick one of the other, 
and live with it forever").

In other words, you live in a dream-world where you know you'd like to 
tell the SCM what the rename is, but at the same time you don't really 
realize what the problems with that is downstream. You think it's a great 
thing, because you've not thought the consequences through (which is 
understandable - they are subtle, and the main reason I know them is (a) 
I'm just special. My mother told me so! and (b) I've used SCM's that do 
it about as well as you can, and I've hit the problems).

		Linus
