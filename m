From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 10:01:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
 <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net> <7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.051126085
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 27 19:02:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgQqW-0003Bv-AV
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 19:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVK0SBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 13:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVK0SBt
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 13:01:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751127AbVK0SBs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 13:01:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jARI1cnO025101
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Nov 2005 10:01:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jARI1bFx028948;
	Sun, 27 Nov 2005 10:01:37 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr792fnta.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12815>



On Sun, 27 Nov 2005, Junio C Hamano wrote:
> 
> True; that is more or less deliberate.  The behaviour is
> modelled after what "/bin/ls -a" does.

Yes, I did realize, and maybe it's fine. It's just that right now, 
git-ls-tree doesn't work like git-ls-files, which is kind of sad.

I suspect not a lot of people use git-ls-tree, and that's probably why it 
never was updated to match anything else.

It would be nice (I think) if git-ls-tree matched git-ls-files the same 
way git-diff-tree matches git-diff-files: exact same behaviour, except one 
works on a tree and another on the index. And like the git-diff-*, the 
index would always default to "-r", while for the tree version you would 
have to specify it.

(Yeah, there are differences. git-ls-files has the "--others" etc logic, 
but I think there are more similarities than differences).

> However, this patch changes its behaviour in another way, and
> that could impact Porcelains more than the removal of the "-d"
> option.  Currently, "git-ls-tree <tree> $dir" shows what
> "/bin/ls -a -1 $dir" would show --- the tree for $dir itself and
> its immediate children.  This patch changes it to show the tree
> for $dir and nothing else.  In effect, "-d" becomes the default
> that you cannot turn off, except using "-r" to allow it go all
> the way down.

No, actually, it's even stranger than that.

If you use "-r", it acts the way you'd expect. If you _don't_ use "-r", it 
acts strangely, but very consistently with git-diff-tree: it only ever 
shows the _first_ part of a pathname. So

	git-ls-tree HEAD drivers/char/

should show just one entry: "drivers". While adding a "-r" should show all 
files under drivers (and the trees leading up to it).

And yes, you're right. That's a much bigger change by my suggested diff, 
and more likely to cause confusion.

			Linus
