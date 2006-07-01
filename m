From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 15:57:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607011552170.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
 <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org> <Pine.LNX.4.64.0607011754370.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 00:57:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwoPW-0004e6-8O
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 00:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWGAW5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 18:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWGAW5z
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 18:57:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751452AbWGAW5y (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 18:57:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k61MvhnW021158
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Jul 2006 15:57:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k61Mvgaw014413;
	Sat, 1 Jul 2006 15:57:43 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0607011754370.9789@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23072>



On Sat, 1 Jul 2006, Daniel Barkalow wrote:
> 
> I think a...b can be computed by (in pseudocode, obviously):

Nope.

> It's basically the original merge-bases code, from way back;

And it has basically the same bug.

It is possible to have

		a
	       / \
	      b   c
	      |\ /|
	      d e f
	       \|/
		g

and clearly "e" is the only valid merge-base of b and c.

HOWEVER. It's actually possible that we traverse d, f and g before we even 
look at 'e' (because somebody had a bogus date, and 'e' _looks_ old).

Remember: in a distributed system we have no global clock, so any graph 
traversal ordering we choose is by definition always arbitrary, even 
though we can obviously _try_ to choose one that is efficient in practice 
(ie the "sort the heap by date).

So that's why git-merge-base has all that extra "unnecessary" complexity. 
You cannot output anything at all until you've guaranteed that all pending 
objects are uninteresting.

				Linus
