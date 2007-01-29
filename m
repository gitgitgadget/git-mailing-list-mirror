From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 08:24:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
 <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 17:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBZJl-00067C-3p
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 17:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXA2QZA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 11:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbXA2QZA
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 11:25:00 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42095 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbXA2QZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 11:25:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0TGOr1m002329
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Jan 2007 08:24:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0TGOqWB023288;
	Mon, 29 Jan 2007 08:24:53 -0800
In-Reply-To: <20070129061807.GA4634@spearce.org>
X-Spam-Status: No, hits=-0.418 required=5 tests=AWL,OSDL_NIGERIAN_ESTATE
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38082>



On Mon, 29 Jan 2007, Shawn O. Pearce wrote:
> 
> I just implemented the blame --incremental thing in git-gui.

That's a real technicolor interface ;)

It's prettier, but it highlights an issue I had with the perl-gtk blame 
viewer too (but there it was overshadowed by all the other aesthetic 
issues)..

One thing I never really enjoyed about the normal "git blame" either, and 
that the git-gui interface makes even worse, is that it uses a *lot* of 
real-estate for the blaming. I've got a big screen, and usually run with 
100+ character wide terminals, but for git blame, I think the canvas is 
120+ characters, and despite that over half of it is just the blame 
output.

That's actually distracting for several reasons:

 - it may be interesting when the primary interest is the shiny new output 
   from "git blame --incremental", but at least the way I have ever used 
   annotations, I'm not actually *interested* in the annotations until I 
   find the code I'm looking for.

   In other words, the actual file data is really the *primary* thing. 
   It's the stuff you need to look at first, and it's the thing that ends 
   up making all the rest relevant. The current "git blame" and "git-gui" 
   interfaces just seem to give too much importance to the annotation data 
   itself.

   Now, in a plain-text pager thign (aka the traditional "git blame"), you 
   don't have much choice. The blame data needs to be there, and you can't 
   hide it, because if you do, there's no way to get at it. But things are 
   different with an interactive graphical environment (or a textual one, 
   for that matter: using some curses interface wouldn't change this 
   argument).

   You _could_ just make the primary thing be the actual file data, and 
   the blame be "incidental". Which it really is.

 - As Ted already pointed out, you actually want to search for the point 
   you're interested in, but when you start out and see the top of the 
   file that generally gets annotated last, a natural reaction with the 
   current interface is to wait for the annotations to happen rather than 
   actually start looking at the code.

   Which is silly. You end up waiting for somethign that you don't even 
   really care about..

   Again, I think the basic issue is the same: by making the annotation 
   data *so* prominent, the lack of it just forces you mentally to think 
   that something important is missing.

 - Finally, the purely practical issue of "on a small screen, this would 
   be almost impossible to use".

   Optimally, you should be able to see the whole (or at least the bulk) 
   of the actual file content even if you only had 80-character lines in 
   the blame viewer. And I just tested: if I make the blame viewer 80 
   characters wide when I look at a random kernel file annotation, I don't 
   even see the "current line number", much less the actual file data. And 
   remember: the file data was supposed to be the *primary* thing.

   If I make it 110 characters wide, I can see ~20 characters of the file 
   data, which means that I can't actually make sense out of anything that 
   is indented by more than two indents, and I usually can't even see the 
   full function names - much less arguments - in declarations..

Anyway, all of these issues makes me suspect that the proper blame 
interface is to basically *hide* the blame almost entirely, in order to 
make the important parts much more visible, and in order to encourage 
people to start looking for the piece of code that they are actually 
interested in.

Then, some *small* part of the annotation window (preferably on the 
right-hand side) should have some very basic blame info - possibly even 
just a "grouping hint" to see where the blame boundaries are. And only 
when you mouse over it or something, do you get the full data.

I dunno. I'm horrible at actually doing GUI's, so you should take anything 
I say with a grain of salt. At the same time, I do know what *I* consider 
to be important (which tends to be unusual in a user), and I'd like to 
think that I have a clue about how people work. And I've always hated 
"annotate" in CVS, but git made it even worse by making the annotation 
data much bigger.

(Yes, from a technical standpoint making the annotation data bigger is a 
good thign: git simply has more useful information than CVS does. But the 
lack of information in CVS actually makes the "stupid interface" better, 
if only because you don't waste as much space on it).

But I'm not going to be able to actually do what I describe above. I can 
only hope to inspire somebody else..

			Linus
