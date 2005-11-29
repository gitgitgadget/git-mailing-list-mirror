From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 23:52:16 -0800
Message-ID: <7v8xv7lwlr.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
	<20051128105736.GO22159@pasky.or.cz>
	<7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
	<20051128212804.GV22159@pasky.or.cz>
	<Pine.LNX.4.64.0511281420390.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511281845280.25300@iabervon.org>
	<Pine.LNX.4.64.0511281637480.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282027360.25300@iabervon.org>
	<Pine.LNX.4.64.0511281837040.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282208050.25300@iabervon.org>
	<Pine.LNX.4.64.0511282029290.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282337170.25300@iabervon.org>
	<7vmzjom00m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511290141220.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 09:38:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh0Hl-000804-VP
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 08:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVK2HwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 02:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVK2HwT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 02:52:19 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43433 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750856AbVK2HwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 02:52:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129075112.YOXA17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 02:51:12 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511290141220.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 29 Nov 2005 01:57:09 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12929>

Daniel Barkalow <barkalow@iabervon.org> writes:

>>     server$ git checkout production
>>     work$ git checkout master
>>     work$ git pull server production ;# merge into work's master
>>     work$ git push server master:receive_from_work
>>     server$ git pull . receive_from_work ;# merge into server's production
>> 
>> and you make sure receive_from_work is not checked out on server
>> (or production is never pushed into) and always do fast forward
>> and nothing else.
>
> That's what I'm doing currently, actually (with work pushing to 
> "production", but server having checked out "deploy"), and I find it 
> annoying to have to do the pull each time and have a separate head. It 
> also means that, if the stuff on the server is set up as a hook, it'll 
> have to do the locking against concurrent changes to the working tree in 
> pull, which is much more complicated than checkout.

This depends on what is on the checked-out working tree and how
it is used, but one use pattern I was imagining was actually
much more elaborate.  I would set up two non-naked repositories
on the server; let's call them treeR and treeP (reception and
publish).

Each work machine push into its own reception branch of treeR
repository (so you have N reception branches for N workers).  On
the server machine, a daemon monitors the reception branch heads
(inotify or idle poll loop looking at mtime; the details do not
matter), and run the git pull into "master" of treeR.  My daemon
might want to forbid anything but fast forward for this pull, or
might allow any clean merge.  It compiles and runs testsuites
next.  If anything fails during the above process, the owner of
the reception branch is notified about the failure; I might even
want to forcibly rewind her reception branch in this case to
"master" when this happens.

When everything goes well, the daemon goes to treeP and pulls
from treeR's master into "deploy", which is checked out.  This
procedure is the only thing that touches treeP, so this pull is
guaranteed to be a fast forward.

The serialization happens by having a single such daemon
running; no need to worry about locking anymore.
