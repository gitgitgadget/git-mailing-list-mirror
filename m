From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Mon, 08 Aug 2005 14:23:27 -0700
Message-ID: <7voe882kds.fsf@assigned-by-dhcp.cox.net>
References: <20050808.103304.55507512.davem@davemloft.net>
	<Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
	<20050808160846.GA7710@kroah.com>
	<20050808.123209.59463259.davem@davemloft.net>
	<20050808194249.GA6729@kroah.com>
	<Pine.LNX.4.58.0508081249110.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
	<7vd5oo40mq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 23:24:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2F5q-0003NP-28
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 23:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVHHVXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 17:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVHHVXb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 17:23:31 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17565 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932264AbVHHVXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 17:23:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808212328.HYWN19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 17:23:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508081357020.3258@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 8 Aug 2005 13:59:18 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 8 Aug 2005, Junio C Hamano wrote:
>> 
>> Totally untested.  I acquired your habit of coding in my e-mail
>> client ;-).
>
> Looks good. Although I also have this advanced testing habit of just 
> reading the email and if it looks sane it tested out ok ;)

Heh, I immediately spotted two bugs after I sent it out, one
mine, another yours.

 * dereferencing potential tag to get to the underlying commit
   was a good idea of mine, poorly executed.  It should
   rev-parse $rev^0, not $commit^0.

 * git commit does not take commit message from stdin.  I think
   we should do something like this:

diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -92,11 +92,13 @@ then
 	rm .editmsg
 	exit 1
 fi
-case "$use_commit" in
-'')
+if test -t 0 && "$use_commit" = ""
+then
 	${VISUAL:-${EDITOR:-vi}} .editmsg
-	;;
-esac
+else
+	echo >&2 "(reading commit message from standard input)"
+	cat >.editmsg
+fi
 grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
 [ -s .cmitmsg ] && 
 	tree=$(git-write-tree) &&
