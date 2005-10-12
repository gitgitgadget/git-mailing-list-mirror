From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 12:52:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510121220230.15297@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
 <Pine.LNX.4.63.0510121452030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Eggert <eggert@CS.UCLA.EDU>, Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:55:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPmf7-0004iG-4F
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 21:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVJLTxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 15:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVJLTxO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 15:53:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751511AbVJLTxN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 15:53:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9CJqh4s024930
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Oct 2005 12:52:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9CJqfiw013324;
	Wed, 12 Oct 2005 12:52:42 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510121452030.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10045>



On Wed, 12 Oct 2005, Daniel Barkalow wrote:
> 
> I think it's actually sufficient to escape 0x00-0x1f and 0x7f; those 
> ranges are both easy

They are indeed easy.

>		 and, as far as I can tell, include all of the control 
> characters that do annoying things.

Nope. The traditional vt100 escape sequence is "ESC" followed by a 
character to indicate the type of sequence (the most common one is '['). 
That's all 7-bit and fine.

HOWEVER, they made the 8-bit extension be such that any of these vt100 
begin sequences where the second character is in the appropriate range can 
be instead shortened by one character, by instead using a single 8-bit 
character of "0x80+(char-0x40)". Ie the traditional "ESC + '['" (\x1b\x5b) 
can also be written as a single '\x9b' character, aka CSI.

In other words, 0x80-0x9f are _all_ just vt100 shorthand for ESC+'@' 
through ESC+'_'.

(I guess it's not strictly "vt100" any more - it's the extended vt220 
format).

> I think escape, backspace, delete, and 
> bell are the only ones we'd rather the terminal not get; beyond that, 
> patches with screwy filenames look screwy, but don't screw up anything 
> outside of the filename.

Try this on a (non-UTF-8) xterm:

	echo -en '\x9b5B---\x9b1A---\x9b4A\r'

and it should do:
 - move cursor 5 lines down
 - print "---"
 - move cursor 1 line up
 - print "---"
 - move cursor 4 lines up
 - return carriage to beginning.

In other words, your screen should end up looking something like this:

	[torvalds@g5 ~]$ echo -en '\x9b5B---\x9b1A---\x9b4A\r'
	[torvalds@g5 ~]$
	
	
	
	   ---
	---

where that "staircase" of two "---" things was done with cursor movements.

And that's a _benign_ sequence. You can do all kinds of funky stuff that 
really screws up the user experience. Including have the thing echo keys 
to you that you didn't type:

	echo -en '\x9b5n'

or lock the keyboard (I don't think any of the terminal emulators 
implement the latter, or some of the other stranger sequences - things to 
do double-wide characters etc).

			Linus

PS. You can do all the same in UTF-8 one, but then you'll have to add a 
\xc2 before the \x9b:

	echo -en '\xc2\x9b5B---\xc2\x9b1A---\xc2\x9b4A\r'

etc..
