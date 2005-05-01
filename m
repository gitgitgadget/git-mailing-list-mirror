From: Junio C Hamano <junkio@cox.net>
Subject: Re: Should git-prune-script warn about dircache?
Date: Sun, 01 May 2005 13:41:40 -0700
Message-ID: <7vwtqismpn.fsf@assigned-by-dhcp.cox.net>
References: <7vwtqjxlrv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505010916510.2296@ppc970.osdl.org>
	<7vll6yyiax.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 22:36:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSLAL-0000ov-HK
	for gcvg-git@gmane.org; Sun, 01 May 2005 22:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVEAUlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 16:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVEAUlq
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 16:41:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:24299 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262669AbVEAUlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 16:41:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501204141.UFIT22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 16:41:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll6yyiax.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 01 May 2005 10:20:22 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
LT> How about making git-prune-script first run "git-update-cache --refresh",
LT> and checking the return value of it (this, of course, assumes that
LT> git-update-cache --refresh would return non-zero if it can't refresh a
LT> file, which is currently not true, but should be easily fixable).

JCH> Or just check if it sees anything in the output, especially
JCH> "needs update" line.

Well, we were both wrong.  The problem is not about the work
tree changes since the last git-update-cache, but about the
blobs recorded in the cache but still not committed.

I think we should do something like this.

    git-ls-files --cached | "sed to SHA1 only" | sort >,,1
    git-fsck-cache --unreachable | "sed to SHA1 only" | sort >,,2
    comm -13 ,,1 ,,2 | "sed to .git/object/ path" | xargs -r rm -f

