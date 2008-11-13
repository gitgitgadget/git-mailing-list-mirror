From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 13:05:04 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org>
 <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0jP9-0007xF-Kz
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 22:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYKMVFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 16:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYKMVFw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 16:05:52 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60926 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869AbYKMVFu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 16:05:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADL55cM012983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 13:05:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADL54eQ016745;
	Thu, 13 Nov 2008 13:05:05 -0800
In-Reply-To: <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.433 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100915>



On Thu, 13 Nov 2008, Linus Torvalds wrote:
> 
> If I were still using NFS (I gave up on it years ago exactly because it 
> was so painful for software development - and that was when I was using 
> CVS) I'd surely have done it long since.
> 
> Bit I'll think about it again. 

THIS IS TOTALLY UNTESTED! It's trivial, it's hacky, and it would need to 
be cleaned up before being merged, but I'm not even going to bother 
_trying_ to make it anything cleaner unless somebody can test it on a nice 
NFS setup.

Because it's entirely possible that there are various directory inode 
locks etc that means that doing parallel lookups in the same directory 
won't actually be doing a whole lot. Whatever. It's kind of cute, and it 
really isn't all that many lines of code, and even if it doesn't work due 
to some locking reason, maybe it's worth looking at.

It arbitrarily caps the number of threads to 10, and it has no way to turn 
it on or off. It actually _does_ seem to work in the sense than when 
cached, it can take advantage of the fact that I have a nice multi-core 
thing, but let's face it, it's not really worth it for that reason only. 

Before:

	[torvalds@nehalem linux]$ /usr/bin/time git diff > /dev/null 
	0.03user 0.04system 0:00.07elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k

After:

	0.02user 0.07system 0:00.04elapsed 243%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+2241minor)pagefaults 0swaps

ie it actually did cut elapsed time from 7 hundredths of a second to just 
4. And the CPU usage went from 100% to 243%. Ooooh. Magic.

But it's still hacky as hell. Who has NFS? Can you do the same thing over 
NFS and test it? I'm not going to set up NFS to test this, and as I 
suspected, on a local disk, the cold-cache case makes no difference 
what-so-ever, because whatever seek optimizations can be done are still 
totally irrelevant.

And if there are per-directory locking etc that screws this up, we can 
look at using different heuristics for the lstat() patterns. Right now I 
divvy it up so that thread 0 gets entries 0, 10, 20, 30.. and thread 1 
does entries 1, 11, 21, 31.., but we could easily split it up differently, 
and do 0,1,2,3.. and 1000,1001,1002,1003.. instead. That migth avoid some 
per-directory locks. Dunno.

Anyway, it was kind of fun writing this. The reason it threads so well is 
that all the lstat() code really works on private data already, so there 
are no global data structures that change that need to be worried about. 

So no locking necessary - just fire it up in parallel, and wait for the 
results. We already had everything else in place (ie the per-cache_entry 
flag to say "I've checked this entry on disk").

Of course, if a lot of entries do _not_ match, then this will actually 
generate more work (because we'll do the parallel thing to verify that 
the on-disk version matches, and if it doesn't match, then we'll end up 
re-doing it linearly later more carefully).

			Linus

---
 diff-lib.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index ae96c64..7d972c9 100644
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
@@ -54,6 +55,70 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
+/* Hacky hack-hack start */
+#define MAX_PARALLEL (10)
+static int parallel_lstats = 1;
+
+struct thread_data {
+	pthread_t pthread;
+	struct index_state *index;
+	struct rev_info *revs;
+	int i, step;
+};
+
+static void *preload_thread(void *_data)
+{
+	int i;
+	struct thread_data *p = _data;
+	struct index_state *index = p->index;
+	struct rev_info *revs = p->revs;
+
+	for (i = p->i; i < index->cache_nr; i += p->step) {
+		struct cache_entry *ce = index->cache[i];
+		struct stat st;
+
+		if (ce_stage(ce))
+			continue;
+		if (ce_uptodate(ce))
+			continue;
+		if (!ce_path_match(ce, revs->prune_data))
+			continue;
+		if (lstat(ce->name, &st))
+			continue;
+		if (ie_match_stat(index, ce, &st, 0))
+			continue;
+		ce_mark_uptodate(ce);
+	}
+	return NULL;
+}
+
+static void preload_uptodate(struct rev_info *revs, struct index_state *index)
+{
+	int i;
+	int threads = index->cache_nr / 100;
+	struct thread_data data[MAX_PARALLEL];
+
+	if (threads < 2)
+		return;
+	if (threads > MAX_PARALLEL)
+		threads = MAX_PARALLEL;
+	for (i = 0; i < threads; i++) {
+		struct thread_data *p = data+i;
+		p->index = index;
+		p->revs = revs;
+		p->i = i;
+		p->step = threads;
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
@@ -68,6 +133,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
+	if (parallel_lstats)
+		preload_uptodate(revs, &the_index);
 	symcache[0] = '\0';
 	for (i = 0; i < entries; i++) {
 		struct stat st;
