From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-update-ref (reflog) uses bogus author ident information
Date: Mon, 10 Jul 2006 20:27:54 -0400
Message-ID: <20060711002754.GB10700@spearce.org>
References: <e8uele$o7t$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 02:28:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G066h-0000oc-4a
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 02:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWGKA2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWGKA2D
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 20:28:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:28832 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751346AbWGKA2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 20:28:02 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G066P-0006HD-Az; Mon, 10 Jul 2006 20:27:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 426AE20E43C; Mon, 10 Jul 2006 20:27:55 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <e8uele$o7t$2@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23674>

Jakub Narebski <jnareb@gmail.com> wrote:
> git-log reports 
> 
>   commit 059111c9381ce1444d17c8fc35606b0aa417ca42
>   Author: Jakub Narebski <jnareb@gmail.com>
>   Date:   Sat Jul 8 18:52:35 2006 +0200
>   
>       configure.ac vertical whitespace usage cleanup
>  
> git-var -l shows:
> 
>  GIT_COMMITTER_IDENT=Jakub Narebski <jnareb@gmail.com> 1152564452 +0200
>  GIT_AUTHOR_IDENT=Jakub Narebski <jnareb@gmail.com> 1152564452 +0200
> 
> BUT in git/.git/logs/refs/heads/autoconf I have (broken into lines):
>   fe7b45a419ae62ed96148d98f6aba8710a6f6245
>   059111c9381ce1444d17c8fc35606b0aa417ca42 
>   Jakub Narebski <jnareb@roke.D-201> 1152377555 +0200   
>   commit: configure.ac vertical whitespace usage cleanu
> 
> where "roke.D-201" are results of "hostname -f" on my computer, and are
> suitable _only_ for my small private local network.
> 
> Bug or a feature?

This is definately a bug.  The reflog uses the same ident code
that commit-tree uses, with the idea that GIT_COMMITTER_IDENT would
drive the entry in the reflog, as you expected it to.

Looking in refs.c at log_ref_write its invoking setup_ident()
then git_committer_info(1).  git_committer_info should be using
the environment variables (GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
GIT_COMMITTER_DATE) with defaults back to the gecos values.  Based
on that it would seem that the user data in .git/config is being
ignored...  Hm.

So you must be expecting .git/config to be supplying your data but
its getting overrwritten by setup_ident() in log_ref_write.

Here's the bug fix.  Sorry about that one.  That bug has been in
there since the reflog code was first put into GIT.  :-)

-->--
Allow user.name and user.email to drive reflog entry.

Apparently calling setup_ident() after git_config causes the
user.name and user.email values read from the config file to be
replaced with the data obtained from the host.  This means that
users who have setup their email address in user.email will instead
be writing reflog entries with their hostname.

Moving setup_ident() to before git_config in update-ref resolves
this ordering problem.
---
 builtin-update-ref.c |    1 +
 refs.c               |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 00333c7..83094ab 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -12,6 +12,7 @@ int cmd_update_ref(int argc, const char 
 	unsigned char sha1[20], oldsha1[20];
 	int i;
 
+	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/refs.c b/refs.c
index 2d9c1dc..56db394 100644
--- a/refs.c
+++ b/refs.c
@@ -379,7 +379,6 @@ static int log_ref_write(struct ref_lock
 			lock->log_file, strerror(errno));
 	}
 
-	setup_ident();
 	committer = git_committer_info(1);
 	if (msg) {
 		maxlen = strlen(committer) + strlen(msg) + 2*40 + 5;
-- 
1.4.1.gc48f
