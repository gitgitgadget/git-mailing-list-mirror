From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix extraneous lstat's in 'git checkout -f'
Date: Mon, 13 Jul 2009 21:01:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907132040530.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 06:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQZDY-0003JT-JF
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 06:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbZGNECF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 00:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbZGNECF
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 00:02:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40524 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699AbZGNECD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 00:02:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6E4209h019253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Jul 2009 21:02:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6E41xk4022742;
	Mon, 13 Jul 2009 21:01:59 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123218>


In our 'oneway_merge()' we always do an 'lstat()' to see if we might need 
to mark the entry for updating. 

We really shouldn't need to do that when the cache entry is already marked 
as being ce_uptodate(). However, since this function will actually match 
the lstat() information with the CE_MATCH_IGNORE_VALID, we need to be a 
bit more careful: it's not sufficient to check ce_uptodate(), we need to 
also double-check that the ce_uptodate() isn't because of CE_VALID (which 
will be "uptodate" regardless of whether the lstat() matches or not).

This explains why it's not sufficient to check _just_ the CE_UPTODATE bit.

But if both CE_UPTODATE is set, and CE_VALID is clear, then we know that 
the lstat() will always match the cache entry information, and there's no 
point in doing another one.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Quite frankly, I'd like for us to at least think about removing CE_VALID. 

Does anybody use it (and "core.ignorestat" that turns it on, along with 
the "--assume-unchanged" flag to update-index)

I wonder if we have other places where we have optimized away the lstat() 
just because we decided that it was already up-to-date - without 
realizing that something could have been marked up-to-date just because 
it was marked CE_VALID.

The original reasoning behind CE_VALID was to avoid the cost of lstat's on 
operating systems where it is slow, but we are now so good at optimizing 
them away (thanks to CE_UPTODATE) that I wonder whether it's not better to 
just always rely on CE_UPTODATE.

In fact, a quick grep made me just look at "verify_uptodate()", and how it 
does ie_match_stat(CE_MATCH_IGNORE_VALID). But look at how we've already 
short-circuited this if ce_uptodate() is true, and we never get there if 
we've preloaded the index or done any other operation that might have 
already validated the entry?

I dunno. This at least doesn't make things worse, since I started thinking 
about this _after_ having first done a patch that just did the 
"ce_uptodate()" test.

 unpack-trees.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f9d12aa..9920a6f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -985,6 +985,18 @@ int bind_merge(struct cache_entry **src,
 }
 
 /*
+ * Do we _know_ the stat information will match?
+ *
+ * Note that if CE_VALID is set, then we might have a
+ * uptodate cache entry even if the stat info might not
+ * match.
+ */
+static inline int known_uptodate(struct cache_entry *ce)
+{
+	return ce_uptodate(ce) && !(ce->ce_flags & CE_VALID);
+}
+
+/*
  * One-way merge.
  *
  * The rule is:
@@ -1004,7 +1016,7 @@ int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset) {
+		if (o->reset && !known_uptodate(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
