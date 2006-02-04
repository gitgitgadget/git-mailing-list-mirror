From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Sat, 4 Feb 2006 12:59:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602041239471.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net> <17380.34301.584514.520465@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0602041125440.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:00:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5UW3-0007D7-Jx
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 22:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946080AbWBDVAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 16:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946144AbWBDVAO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 16:00:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946080AbWBDVAN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 16:00:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k14L01DZ001416
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Feb 2006 13:00:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k14KxxOd006962;
	Sat, 4 Feb 2006 13:00:00 -0800
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0602041125440.3854@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15600>



On Sat, 4 Feb 2006, Linus Torvalds wrote:
> 
> Doing a 
> 
> 	git-rev-list --parents HEAD |
> 		egrep '^.{90}' |
> 		cut -d' ' -f1 | 
> 		git-diff-tree --pretty --cc --stdin
> 		| less -S
> 
> on the kernel is actually interesting. It's interesting because it shows 
> that out of 1391 merges, in the kernel, only _19_ actually had these close 
> calls. Some - but certainly not all - of them actually did need manual 
> fixup.

There are some doubly interesting lessons when I looked closer.

In particular, some merges that needed manual fixups do _not_ show up. I 
found that surprising, at first. I expected that if I had to fix something 
manually, it would obviously show up in the "--cc" output.

Not so.  In fact, the one I looked closer at didn't show up even in the 
"long" version, aka "-c".

The reason? A lot of the manual fixups end up selecting one version or the 
other - the clash is because two people fixes the same bug slightly 
differently, and the manual merge will end up just selecting one of them. 
So then even "-c" won't show it, because it will notice that the whole 
file was actually the same as one of the branches merged.

That may be a bit non-intuitive (maybe it shouldn't be, and it was just me 
who didn't think about it the right way when I was initially surprised), 
but it was definitely the right thing (both from a merge standpoint _and_ 
from a "what happened" standpoint) in the cases I looked at. The merge may 
have been manual, but the end _result_ was trivial, and thus isn't shown.

So even after looking at it more, and searching for "interesting" cases 
from the other side, I really like the current git-diff-tree --cc output. 
It sometimes shows you things you wouldn't expect, and it sometimes 
doesn't show you things you'd expect to show up, but in both cases it 
shows/avoids the _right_ things.

However, the point that a "diff" itself isn't totally unambigious is well 
taken. You're right that the very first hunk of the 12-way merge is really 
not interesting.

However, looking at the other cases, it seems to not really be a huge 
problem - that seems to be the only case in the whole kernel - and the 
git-diff-tree algorithm may show an unnecessary hunk once in a blue moon, 
but that's better than having the heuristics fail the other way around (ie 
not showing a hunk).

That's what the gitk problem was, btw (showing too little, not too much). 
Current gitk fails on this trivial case:

	mkdir test-merge
	cd test-merge/
	git-init-db 

	#
	# Initial silly contents
	#
	echo "Hello" > hello
	echo "Hi" > hi
	git add hello hi
	git commit -m "Initial"

	#
	# Create another branch
	#
	git branch other

	#
	# Edit the contents on the master branch,
	# commit it.
	#
	echo "Hello there" > hello
	git commit -m "first change" hello

	#
	# Edit/commit the other differently
	#
	git checkout other
	echo "Hello differently" > hello
	git commit -m "second change" hello

	#
	# Try to merge - this will fail
	#
	git checkout master
	git merge "Clashing merge" HEAD other

	#
	# Do an evil merge conflict that also edits a 
	# nonconflicting file
	#
	echo "Hello third version" > hello
	echo "Hidden hi change" > hi 
	git commit -m "Evil merge conflict" hello hi

At this point, "git-diff-tree --cc HEAD" shows exactly the right thing, 
but "gitk" doesn't show anything at all for that merge (it shows the 
"hello" file in the file pane, but no diff at all, and certainly not the 
"hi" file which it _should_ show).

		Linus
