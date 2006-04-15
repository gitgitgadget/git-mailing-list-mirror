From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tentative built-in "git show"
Date: Sat, 15 Apr 2006 13:57:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604151345050.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604151203060.3701@g5.osdl.org>
 <7v3bgefxkp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 22:57:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUrpZ-00079M-Rl
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 22:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWDOU5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 16:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWDOU5T
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 16:57:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751456AbWDOU5T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 16:57:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3FKvFtH019698
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Apr 2006 13:57:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3FKvEDv014731;
	Sat, 15 Apr 2006 13:57:15 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bgefxkp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18764>



On Sat, 15 Apr 2006, Junio C Hamano wrote:
> 
> I sometimes do "git show -4" myself, and wondered why defaulting
> to "-n 1"is insufficient

I detest -n1 for a variety of reasons, and giving multiple refs is just 
one of them.

The reason I like "--no-walk" is that it's conceptually much stronger, and 
more efficient. Remember how we tried to optimize "-1" (as used by gitweb) 
by adding magic special cases to get_revision()? And how they always ended
up being problematic because of how they interact with all the other 
options?

So we don't do it any more, and as a result, "git-rev-list -1 HEAD" will 
actually walk all the parents too.

In contrast, "--no-walk" just does exactly what you tell it: don't start 
walking the parents. It's kind of equivalent to -1 with one argument, but 
in the presense of path limiting it actually does the RightThing(tm), 
unlike -1.

Try this as a replacement for "git show":

	git log -1 kernel/
	git log --no-walk kernel/

on the current kernel source tree to see the difference. "--no-walk" gives 
the right answer (for some definition of "right"). While -1 gives a 
totally random answer that has nothing to do with the current HEAD (except 
that it's _reachable_ from the current HEAD).

So I think "-n 1" is fundamentally incompatible with "git show". Git 
"show" is "show _this_ commit". While "-1" fundamentally means "show the 
_first_ commit when you walk the tree". Which is really really 
fundamentally different.

In contrast "--no-walk" tells you exactly what it is about. Don't walk the 
tree. Show _this_ commit.

(Now, the reason I said 'for _some_ definition of "right"' is that the 
question about path limiting in the absense of commit walking is somewhat 
ambiguous. The current "git show" shows the commit regardless. My 
suggested patch will potentially prune the commit away, and if the 
specified commit does not touch the path, no commit is shown at all. 
Both make sense. While "git-rev-list -1" does _not_ make sense)

			Linus
