From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Teach 'git checkout' to preload the index contents
Date: Sat, 9 May 2009 15:41:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905091517000.3586@localhost.localdomain>
References: <alpine.LFD.2.01.0905091501460.3586@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 10 00:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2vGB-0001bx-Eu
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 00:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbZEIWmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 18:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754678AbZEIWma
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 18:42:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34489 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753984AbZEIWm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2009 18:42:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n49MfHWg023916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 May 2009 15:41:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n49MfH2W027427;
	Sat, 9 May 2009 15:41:17 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905091501460.3586@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-5.462 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118687>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 May 2009 15:11:17 -0700

This makes git checkout know to use the threaded index preloading if it
is enabled in the config file. You need to have

	[core]
		preloadindex = true

in your config file to see it, and for that feature to make sense your
filesystem needs to be able to do concurrent 'lstat()' lookups, but when
that is the case (especially NFS over a high-latency network), this can
be a noticeable performance win.

But with a low-latency network and at least older Linux NFS clients, this 
will clearly potentially cause a lot of lock contention. It may still 
speed up the uncached case, but the threading and locking overhead will 
result in the cached case likely slowing down.

That was almost certainly fixed by Linux commit fc0f684c2 ("NFS: Remove 
BKL from NFS lookup code"), but that one got merged into 2.6.27-rc1, so 
older kernel versions than 2.6.27 will not scale very well.

But regardless, it's the right thing to do. If your filesystem doesn't 
scale, don't enable index preloading. 

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

On local filesystems, I've actually seen signs of tiny speedups (iow, 
0.15s -> 0.14s in the cached case on a much-too-fast-for-this-to-matter 
Nehalem machine) due to SMP scaling.

But it's probably more likely to slow things down, unless you have a disk 
that does TCQ and really gets improved by having multiple outstanding 
requests.

Again, this is not so much a "git checkout" issue, as a generic 
"core.preloadindex" issue.

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
-- 
1.6.3.1.g3f31
