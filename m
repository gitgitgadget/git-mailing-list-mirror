From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Sat, 16 Apr 2005 09:36:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504160928250.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz>
 <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz>
 <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org>
 <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org>
 <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
 <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net> <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org> <7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
 <Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org> <7vis2ncf8j.fsf@assigned-by-dhcp.cox.net
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:32:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMqDJ-0001JM-RT
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 18:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVDPQfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVDPQfO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 12:35:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:30699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262698AbVDPQed (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 12:34:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GGYSs4026088
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 09:34:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GGYRck019726;
	Sat, 16 Apr 2005 09:34:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0504160820320.7211@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Linus Torvalds wrote:
> 
> Having slept on it, I think I'll merge all the trivial cases that don't 
> involve a file going away or being added. Ie if the file is in all three 
> trees, but it's the same in two of them, we know what to do.

Junio, I pushed this out, along with the two patches from you. It's still
more anal than my original "tree-diff" algorithm, in that it refuses to
touch anything where the name isn't the same in all three versions
(original, new1 and new2), but now it does the "if two of them match, just
select the result directly" trivial merges.

I really cannot see any sane case where user policy might dictate doing
anything else, but if somebody can come up with an argument for a merge
algorithm that wouldn't do what that trivial merge does, we can make a
flag for "don't merge at all".

The reason I do want to merge at all in "read-tree" is that I want to
avoid having to write out a huge index-file (it's 1.6MB on the kernel, so
if you don't do _any_ trivial merges, it would be 4.8MB after reading
three trees) and then having people read it and parse it just to do stuff
that is obvious. Touching 5MB of data isn't cheap, even if you don't do a 
whole lot to it.

Anyway, with the modified read-tree, as far as I can tell it will now 
merge all the cases where one side has done something to a file, and the 
other side has left it alone (or where both sides have done the exact same 
modification). That should _really_ cut down the cases to just a few files 
for most of the kernel merges I can think of. 

Does it do the right thing for your tests?

		Linus
