From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git reset" and newly created files.
Date: Mon, 22 Aug 2005 01:17:26 -0700
Message-ID: <7vslx29yi1.fsf@assigned-by-dhcp.cox.net>
References: <7vbr3rccjc.fsf@assigned-by-dhcp.cox.net>
	<20050821214605.GA4134@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 00:30:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7KmD-0000Se-K5
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVHVW0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 18:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbVHVW0q
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 18:26:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:29577 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751445AbVHVW0Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2005 18:26:24 -0400
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M8HvGL029882
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 01:17:57 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050822081727.XMKG19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 Aug 2005 04:17:27 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050821214605.GA4134@mars.ravnborg.org> (Sam Ravnborg's message
	of "Sun, 21 Aug 2005 23:46:05 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

>> So you would naturally be tempted to do this:
>> 
>>     ... Re-edit, compile, and test.  This time it is perfect.
>>     $ git commit -a -C ORIG_HEAD
>> 
>> Well, not really.  You can lose any file newly created in
>> ORIG_HEAD this way.  Instead, you need to do this:
>> 
>>     ... Re-edit, compile, and test.  This time it is perfect.
>>     $ git add <whatever file you have changed>
>>     $ git commit -a -C ORIG_HEAD
>> 
>> Do people find this a big problem?
>
> I often do some maybe not that brilliant changes in my tree,
> and when I then ask git to reset these I expect git to reset
> everything.
>
> After a git-reset HEAD^ I really expect git to have rewinded back till
> where I started with no files added whatsoever.

That is another thing I initially expected from the "git reset"
command, but I do not think that is what this command is about.
It is about reverting your working tree and index file to the
state just before you make your commit to create the botched
commit, so that you can make minor fixes and recommit.

Viewing it that way, it might even be a good idea to "git add"
the files that are in ORIG_HEAD but not in the head you are
"resetting" to.

> From the matter of least suprise git should not remember files added,
> one have to do that by themself again if needed.

What I was getting at was that doing things that way means new
files and modified files are handled inconsistently.  With the
current implementation, git "remembers" the files modified, but
not files added.  And if the purpose of "reset" is to eventually
re-commit, it would be useful if git remembers both, not just
modified files.

One way to achieve that would be "git-update-cache --add-maybe"
I talked about in the original message, but at least something
like the following would still be an improvement.  Instead of
echoing the output from diff-tree, we might even be better off
if we just feed it to "xargs git-update-cache --add".

------------
[PATCH] Remind the user of "about to be lost" files. 

Files that are in the current HEAD but not in the head we are
resetting to can easily be lost when "git reset HEAD^" is
followed by re-edit and "git commit".

This patch reminds the user about those files.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/git-reset-script b/git-reset-script
--- a/git-reset-script
+++ b/git-reset-script
@@ -6,6 +6,16 @@ git-read-tree --reset "$rev" && {
 	if orig=$(git-rev-parse --verify HEAD 2>/dev/null)
 	then
 		echo "$orig" >"$GIT_DIR/ORIG_HEAD"
+
+		# Remind the user about files that are in ORIG_HEAD
+		# but not in $rev.  We would really want to do
+		# "git-update-cache --add-maybe" on these paths, but
+		# that is not available (yet).
+		git-diff-tree -r --diff-filter=D $rev ORIG_HEAD |
+		while path
+		do
+			echo "$path: needs add"
+		done
 	fi
 	echo "$rev" > "$GIT_DIR/HEAD"
 }
