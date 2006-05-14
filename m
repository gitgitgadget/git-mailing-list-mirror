From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Ensure author & committer before asking for commit message.
Date: Sat, 13 May 2006 23:09:32 -0400
Message-ID: <BAYC1-PASMTP06C5870DB0764F7F3284A3AEA20@CEZ.ICE>
References: <BAYC1-PASMTP10DC791E7560155D9E71F4AEA20@CEZ.ICE>
	<7vlkt5s4yw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 05:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff74R-0004Ki-Q9
	for gcvg-git@gmane.org; Sun, 14 May 2006 05:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWENDO7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 23:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWENDO7
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 23:14:59 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:41222 "EHLO
	BAYC1-PASMTP06.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932363AbWENDO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 23:14:58 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP06.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 13 May 2006 20:16:43 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 9A556644C17;
	Sat, 13 May 2006 23:14:56 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060513230932.41ef4982.seanlkml@sympatico.ca>
In-Reply-To: <7vlkt5s4yw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 May 2006 03:16:44.0078 (UTC) FILETIME=[D3A15CE0:01C67704]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


It's better to find out you need to fix your author and
committer information before you enter a long commit message.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

On Sat, 13 May 2006 19:41:27 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Makes sense but I suspect you would want COMMITTER not AUTHOR.
> Imagine you pulled from somewhere else and it conflicted,
> requiring you to hand resolve and then run git-commit.

Hmm.. It seems that both sets of environment variables must be 
properly set before commit will succeed?  For some reason I thought 
that if AUTHOR was properly set it would be used as the committer too
when the GIT_COMMITTER_* environment variables weren't set.  All I
ever use are the config user.email/name variables which do work for
both author and committer.

But it looks like we have to test both variables before proceeding.

 git-commit.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


801ac3c2e4ec7fd0dd91975800897f30938b4e68
diff --git a/git-commit.sh b/git-commit.sh
index 26cd7ca..6ef1a9d 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -640,6 +640,8 @@ case "$no_edit" in
 		exit 1
 		;;
 	esac
+	git-var GIT_AUTHOR_IDENT > /dev/null  || die
+	git-var GIT_COMMITTER_IDENT > /dev/null  || die
 	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
-- 
1.3.2.gd9a4
