From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Hmm.. Try harder to find the common commits in git protocol?
Date: Mon, 28 Apr 2008 13:15:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804281310320.3119@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0804280936080.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:17:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZmf-0001dr-2n
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 22:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbYD1UQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 16:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbYD1UQU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 16:16:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55073 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964841AbYD1UQT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 16:16:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SKFrLg030623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2008 13:15:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3SKFpqO013377;
	Mon, 28 Apr 2008 13:15:51 -0700
In-Reply-To: <alpine.LFD.1.10.0804280936080.3119@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.477 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80605>



Hmm. Trying to debug this, I find the behavior hard to reproduce. But I 
*also* find that there seems to be something wrong in builtin-fetch-pack.

Look at commit f3ec549481827b10609a43bf504517a0e8063a12 ("fetch-pack: 
check parse_commit/object results"), and tell me that the "parents" 
handling isn't totally broken. In particular, get_rev() does:

	struct commit_list *parents = NULL;
	..
	commit = rev_list->item;
	if (!(commit->object.parsed))
		if (!parse_commit(commit))
			parents = commit->parents;
	..

which means that "parents" will never even get set if the commit was 
already parsed!

And whether it got parsed or not depends on how we got there etc, so this 
may explain the occasionally odd behaviour I saw.

Basically, I don't think that code can be right, and with a cut-down repo, 
I get "no commits in common" due to this, because the whole "get_rev()" 
thing doesn't work.

This patch should fix that problem, but I wonder why it got rewritten that 
way in the first place?

			Linus

---
 builtin-fetch-pack.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 65350ca..c97a427 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -117,15 +117,15 @@ static const unsigned char* get_rev(void)
 
 	while (commit == NULL) {
 		unsigned int mark;
-		struct commit_list *parents = NULL;
+		struct commit_list *parents;
 
 		if (rev_list == NULL || non_common_revs == 0)
 			return NULL;
 
 		commit = rev_list->item;
-		if (!(commit->object.parsed))
-			if (!parse_commit(commit))
-				parents = commit->parents;
+		if (!commit->object.parsed)
+			parse_commit(commit);
+		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
 		if (!(commit->object.flags & COMMON))
