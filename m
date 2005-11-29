From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 16:43:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 01:45:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egtb8-0000kj-Ff
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 01:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVK2Ana (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 19:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVK2Ana
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 19:43:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932277AbVK2An3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 19:43:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAT0hEnO004220
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Nov 2005 16:43:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAT0hDp1031463;
	Mon, 28 Nov 2005 16:43:13 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12912>



On Mon, 28 Nov 2005, Daniel Barkalow wrote:
> 
> We really ought to keep track of what the current checked out tree is, 
> independant of the head that it's supposed to match. Then it would be safe 
> to push to a head that's checked out (it wouldn't update it, but the 
> system would understand what's going on).

Well, that's what branches are all about. 

You really have two choices:
 - do it all yourself
 - use git branches

but if you use a special git branch for the checked-out state, then you 
have to realize that nobody can push directly to it.

You'd have a trigger that triggers on a push to _another_ branch, and then 
the trigger basically does an automatic "git pull" from that branch (and 
updates the checked-out state as part of that).

But you _still_ need to do the locking. That's very fundamental. There is 
no locking in a "git push", exactly because it can push in parallel, by 
design. And you _cannot_ check out a tree in parallel, so you have to do 
locking for that.

There's no way you can avoid the locking. You can do shortcuts: for 
example, you could avoid any explicit locking by having the "checkout" 
just happen once an hour, with an automatic "pull" from the changed 
branch. Again, that means that the branch that is checked out can NOT be 
one of the branches that people push to.

		Linus
