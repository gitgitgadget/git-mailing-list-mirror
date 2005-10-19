From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree rename detection for single file
Date: Tue, 18 Oct 2005 20:12:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510182004100.3369@g5.osdl.org>
References: <4dd15d180510181256i1c5a82d9ld62acaedb493cf71@mail.gmail.com>
 <7vu0fepn0x.fsf@assigned-by-dhcp.cox.net> <7virvujkcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Ho <davidkwho@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 05:13:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES4O3-0008MX-2w
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 05:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVJSDMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 23:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbVJSDMw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 23:12:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751469AbVJSDMv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 23:12:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9J3CjFC025677
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 20:12:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9J3ChC8014064;
	Tue, 18 Oct 2005 20:12:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virvujkcw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10261>



On Tue, 18 Oct 2005, Junio C Hamano wrote:
> 
> Having said that, I think we *could* introduce a new flag to
> git-diff-* brothers, --late-pathspec

Gaah. Why? It's really not possible to do it efficiently inside 
git-diff-xyz, so whatever implementation would basically boil down to 
something you can already do with some trivial scripting, basically 
boiling down to:

	git-diff-tree -r -M | grep pathnamelist | git-diff-helper

Now, several reasons why it's much better to do this kind of 
"--late-pathspec" at a higher level (instead of inside the git-diff-xyz 
family):

 (a) git-diff-xyz is already some of the more complex core parts. It's not 
     likely a good idea to make them any more complex, unless there's some 
     very fundamental reason for it.

 (b) without pathname limits, git-diff-tree is very slow. Well, it's 
     actually very fast compared to something braindead like CVS, but if 
     you want to track a single file over a thousand releases, it's MUCH 
     MUCH faster to do the pathname limit at the beginning. Otherwise 
     you'll spend all your time reading and comparing big trees with tens 
     of thousands of entries.

 (c) with a higher-level thing, what you can do is have a TWO-phase thing: 
     use the fast pathname limiter in git-diff-tree to figure out when 
     that file changes in history, and then _only_ for those commits do 
     you go back and then do the much more expensive "git-diff-tree -r -M" 
     followed by the pathname-limiting post-processing.

See what I'm saying? You really can do the post-processing outside of 
git-diff-tree, and you will in fact be much better off if you do so.

The performance impact of pruning the pathnames _before_ diffing them was 
absolutely staggering. You couldn't reasonably do a "git-whatchanged -p" 
on the kernel for a single file if you didn't do it the way we do it now.

			Linus
