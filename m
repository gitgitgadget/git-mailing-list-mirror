From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 15:42:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 00:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lqy-00062s-1V
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYKMXmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbYKMXmp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:42:45 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50897 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715AbYKMXmo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 18:42:44 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADNgTgp023299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 15:42:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADNgTc6030697;
	Thu, 13 Nov 2008 15:42:29 -0800
In-Reply-To: <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.433 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100929>



On Thu, 13 Nov 2008, Linus Torvalds wrote:
>
> And if there are per-directory locking etc that screws this up, we can 
> look at using different heuristics for the lstat() patterns. Right now I 
> divvy it up so that thread 0 gets entries 0, 10, 20, 30.. and thread 1 
> does entries 1, 11, 21, 31.., but we could easily split it up differently, 
> and do 0,1,2,3.. and 1000,1001,1002,1003.. instead. That migth avoid some 
> per-directory locks. Dunno.

Yeah, I just checked. We really should to the lookups in clusters, because 
yes, we do have directory locks that limit parallel lookups in the same 
directory, so to get good parallelism you want to look up in different 
places.

Admittedly that's really a Linux kernel deficiency, and I'd love to fix it 
(in the long run), but we optimize file lookup for the common (cached) 
case, and the uncommon case of parallel misses in the same directory has 
been written for simplicity and robustness.

So don't even bother trying the previous patch, even if it might work. At 
least not on Linux. Try this one instead, which does the parallel things 
in batches, so that we hopefully hit different directories.

Parallelism is hard. 

The good news is that I seem to actualluy see a bit of a win from this 
even on a disk, now that the kernel doesn't serialize things. So it may 
be worth it. So I have some hope that it actually helps on NFS too. 
The numbers for five runs (with clearing of the caches in between, of 
course) are:

Before:

	0.01user 0.23system 0:10.87elapsed 2%CPU
	0.04user 0.19system 0:10.86elapsed 2%CPU
	0.03user 0.26system 0:10.82elapsed 2%CPU
	0.02user 0.27system 0:12.67elapsed 2%CPU
	0.01user 0.22system 0:10.86elapsed 2%CPU

After:

	0.03user 0.26system 0:07.88elapsed 3%CPU
	0.02user 0.25system 0:07.63elapsed 3%CPU
	0.01user 0.26system 0:08.62elapsed 3%CPU
	0.01user 0.26system 0:07.27elapsed 3%CPU
	0.05user 0.28system 0:08.61elapsed 3%CPU

so it really does seem like it has possibly given a 30% improvement in 
cold-cache performance even on a disk. 

NOTE NOTE NOTE! This is still a total hack. If this was done properly, we 
would do the "preload_uptodate()" thing when we load the cache for all the 
different programs where it can matter, not just the one special case 
place. So see this as a proof-of-concept, nothing more.

		Linus

---
 diff-lib.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae96c64..83c180d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+#include <pthread.h>
 #include "cache.h"
 #include "quote.h"
 #include "commit.h"
@@ -54,6 +55,77 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
+/* Hacky hack-hack start */
+#define MAX_PARALLEL (10)
+static int parallel_lstats = 1;
+
+struct thread_data {
+	pthread_t pthread;
+	struct index_state *index;
+	const char **pathspec;
+	int offset, nr;
+};
+
+static void *preload_thread(void *_data)
+{
+	int nr;
+	struct thread_data *p = _data;
+	struct index_state *index = p->index;
+	struct cache_entry **cep = index->cache + p->offset;
+
+	nr = p->nr;
+	if (nr + p->offset > index->cache_nr)
+		nr = index->cache_nr - p->offset;
+
+	do {
+		struct cache_entry *ce = *cep++;
+		struct stat st;
+
+		if (ce_stage(ce))
+			continue;
+		if (ce_uptodate(ce))
+			continue;
+		if (!ce_path_match(ce, p->pathspec))
+			continue;
+		if (lstat(ce->name, &st))
+			continue;
+		if (ie_match_stat(index, ce, &st, 0))
+			continue;
+		ce_mark_uptodate(ce);
+	} while (--nr > 0);
+	return NULL;
+}
+
+static void preload_uptodate(const char **pathspec, struct index_state *index)
+{
+	int i, work, offset;
+	int threads = index->cache_nr / 100;
+	struct thread_data data[MAX_PARALLEL];
+
+	if (threads < 2)
+		return;
+	if (threads > MAX_PARALLEL)
+		threads = MAX_PARALLEL;
+	offset = 0;
+	work = (index->cache_nr + threads - 1) / threads;
+	for (i = 0; i < threads; i++) {
+		struct thread_data *p = data+i;
+		p->index = index;
+		p->pathspec = pathspec;
+		p->offset = offset;
+		p->nr = work;
+		offset += work;
+		if (pthread_create(&p->pthread, NULL, preload_thread, p))
+			die("unable to create threaded lstat");
+	}
+	for (i = 0; i < threads; i++) {
+		struct thread_data *p = data+i;
+		if (pthread_join(p->pthread, NULL))
+			die("unable to join threaded lstat");
+	}
+}
+/* Hacky hack-hack mostly ends */
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
@@ -68,6 +140,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
+	if (parallel_lstats)
+		preload_uptodate(revs->prune_data, &the_index);
 	symcache[0] = '\0';
 	for (i = 0; i < entries; i++) {
 		struct stat st;
