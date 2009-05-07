From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE:
Date: Thu, 7 May 2009 14:55:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Bevan Watkiss <bevan.watkiss@cloakware.com>
X-From: git-owner@vger.kernel.org Thu May 07 23:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Bbk-0000Ke-1e
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 23:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592AbZEGV6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 17:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbZEGV6A
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 17:58:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44544 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188AbZEGV6A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 17:58:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47LtjDB001135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 14:56:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47LtjWM024299;
	Thu, 7 May 2009 14:55:45 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118528>



On Thu, 7 May 2009, Linus Torvalds wrote:
> 
> Hmm. The second pass comes from 
> 
> 	show_local_changes(&new->commit->object);
> 
> (this is the "git checkout" without actual filenames), and is suppressed 
> if we ask for a quiet checkout. But it's sad how it re-loads the index. I 
> wonder where the CE_VALID bit got dropped.

Ahh. It's not actually dropped, it's still there.

It's just that 'get_stat_data()' doesn't check it, when asking for 
noncached data.

The logic of 'get_stat_data()' is that it will return the stat data from 
the filesystem (unless we explicitly ask for just the cached case, in 
which case it will take it from the cache entry directly).

However, the code doesn't realize that if ce_uptodate() is true, then we 
already know the stat data, so no need to do the lstat() again, and we 
can take it all from the cache entry regardless of whether we asked for 
filesystem data or cached data.

So here's a better patch. It should cut down the 'lstat()' calls from "git 
checkout" a lot.

It looks obvious enough, and it passes testing (and now "git checkout" 
only does about as many lstat's as there are files in the repository, and 
they seem to all be properly asynchronous if 'core.preloadindex' is set.

Somebody should check. It would be interesting to hear about whether this 
makes a performance impact, especially with slow filesystems and/or other 
operating systems that have a relatively higher cost for 'lstat()'.

		Linus

---
 builtin-checkout.c |    4 ++--
 diff-lib.c         |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/diff-lib.c b/diff-lib.c
index a310fb2..0aba6cd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -214,7 +214,7 @@ static int get_stat_data(struct cache_entry *ce,
 	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
 
-	if (!cached) {
+	if (!cached && !ce_uptodate(ce)) {
 		int changed;
 		struct stat st;
 		changed = check_removed(ce, &st);
