From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE:
Date: Thu, 7 May 2009 13:07:40 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>
 <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "'Alex Riesen'" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bevan Watkiss <bevan.watkiss@cloakware.com>
X-From: git-owner@vger.kernel.org Thu May 07 22:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29vH-00061C-2e
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 22:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbZEGUKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 16:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbZEGUKR
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 16:10:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53324 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837AbZEGUKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 16:10:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47K7eWI020783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 13:08:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47K7ehA020420;
	Thu, 7 May 2009 13:07:40 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118519>



On Thu, 7 May 2009, Bevan Watkiss wrote:
>
> Looking at the trace it does appear that most of this is the lstat.  It's
> the problem of having many tiny files on a network drive, and trying to use
> git for something it's not meant.
> 
> The log has 265430 lines of lstat and 10887 other lines.  If you still want
> the log file I'll strip out the directory names and send it off.

Actually, if it's just the lstat's, then it's not all that interesting any 
more, it's a known problem with at least a known _partial_ solution.

However, I think it turns out that we've only enabled the index preloading 
with "git diff" and "git commit". Not on "git checkout".

So start off doing that

> 	[core]
> 		preloadindex = true

AND apply the following patch to git, and see how much (if any) that 
helps. It sounds like you have a pretty damn large repository, together 
with a slow filesystem. It really could be a big improvement.

The patch is TOTALLY UNTESTED. It also worries me that 'git checkout' 
seems to do _two_ 'lstat()' calls per file. I didn't look any more 
closely, but there may be other issues here.

		Linus

---
 builtin-checkout.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 15f0c32..3100ccd 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -216,7 +216,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	newfd = hold_locked_index(lock_file, 1);
-	if (read_cache() < 0)
+	if (read_cache_preload(pathspec) < 0)
 		return error("corrupt index file");
 
 	if (source_tree)
@@ -367,7 +367,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 	int newfd = hold_locked_index(lock_file, 1);
 	int reprime_cache_tree = 0;
 
-	if (read_cache() < 0)
+	if (read_cache_preload(NULL) < 0)
 		return error("corrupt index file");
 
 	cache_tree_free(&active_cache_tree);
