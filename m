From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-merge fails when trying to merge from a tag
Date: Tue, 13 Dec 2005 11:21:19 -0800
Message-ID: <7vy82o951s.fsf@assigned-by-dhcp.cox.net>
References: <20051213175516.GA3695@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 20:24:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmFiI-0005zN-TV
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 20:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVLMTVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 14:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVLMTVY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 14:21:24 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36029 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932526AbVLMTVX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 14:21:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213192030.LPEF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 14:20:30 -0500
To: Carl Baldwin <cnb@fc.hp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13585>

Carl Baldwin <cnb@fc.hp.com> writes:

> I just tried to merge using a tag object.

Thanks for the report.

> % git merge "Merging release-0.3.1" HEAD refs/tags/release-0.3.1

Once I considered changing commit-tree to take any committish
after -p, but thought the command is a low level primitive and
the user should know what he is doing, but apparently, git-merge
does not know what it is doing ;-).

In fact, I never use "merge" myself, and haven't noticed this
breakage until now (you would notice that the Everyday document
never talks about "git merge").  Instead, I always do this:

	$ git pull . tag release-0.3.1

But you are right.  It is advertised as the end-user
command and demonstrated in the tutorial.

How about this patch?  I haven't looked at what (old)
git-resolve and git-octopus commands do --- they may need
similar parameter massaging.

-- >8 --
[PATCH] allow merging any committish

Although "git-merge" is advertised as the end-user level command
(instead of being a "git-pull" backend), it was not prepared to
take tag objects that point at commits and barfed when fed one.
Sanitize the input while we validate them, for which we already
have a loop.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-merge.sh b/git-merge.sh
index a221daa..d25ae4b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -97,11 +97,14 @@ head=$(git-rev-parse --verify "$1"^0) ||
 shift
 
 # All the rest are remote heads
+remoteheads=
 for remote
 do
-	git-rev-parse --verify "$remote"^0 >/dev/null ||
+	remotehead=$(git-rev-parse --verify "$remote"^0) ||
 	    die "$remote - not something we can merge"
+	remoteheads="${remoteheads}$remotehead "
 done
+set x $remoteheads ; shift
 
 case "$#" in
 1)
