From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] preload-index: optimize for sequential IO
Date: Wed, 25 Jun 2014 00:53:31 +0200
Message-ID: <53AA016B.6050900@gmail.com>
References: <53AA0129.1080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzZat-0001PS-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 00:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaFXWxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 18:53:34 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:43730 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbaFXWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 18:53:32 -0400
Received: by mail-wi0-f175.google.com with SMTP id r20so6947515wiv.14
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=O/alRPwy9dLH9lSfqvmNq8uN6t9hzW5tDkiA7iIJmu4=;
        b=MI8B8Wtvf3NGu5H5OPKMOLdJJrXrYxRtPtqfs/KvHVoGY9e1AjGzZU+Zu7koauzSef
         TK/4WjoqOAlF/algdL5+m6a8Z1ylWrDWVoMDrk3kTEvs6VubJwxvLbj6auPiourIwgLZ
         rnjKFN0UCu5llV6LvyOXPW2qlJ4GLyE/w2sXw6DdrcOpWzma726yDdr8Hb/k9i3NthYZ
         zd0tgUbR9ffZJwJYZv4whFWRCAVcWgDQraJbSm2Cdr0tKYJjxJ469WN73FP7/Ut393Gz
         6UvUgd9JiA2ou8vv7GpR1QKvrVjFoDxZw1dI7O2UF9msAol87GPjnEyNwIHGgENLCWKz
         gJkA==
X-Received: by 10.194.24.36 with SMTP id r4mr4918527wjf.35.1403650411225;
        Tue, 24 Jun 2014 15:53:31 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id f6sm47216570wiy.19.2014.06.24.15.53.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 15:53:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53AA0129.1080109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252422>

Enabling core.preloadIndex on a real HD reduces cold cache performance by
~5%. This is because the threads read from up to 20 different locations on
disk.

Additionally, some threads finish early (each thread is assigned a fixed
number of cache entries to process in advance), i.e. preloading is not as
parallel as we would like. With hot cache, threads finish so quickly that
most run in sequence rather than in parallel.

Change background threads so that they run until all work is done. Use a
central mutex-protected counter to iterate over available cache entries. As
cache entries are sorted by path, this implicitly increases IO locality.

This improves cold cache performance of preload_index() by ~20% and
hot cache performance by ~15%. Total improvement of e.g. 'git status -uno'
on WebKit is ~15% (cold cache) and ~5% (hot cache).

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 preload-index.c | 76 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 968ee25..6ac368d 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -28,50 +28,65 @@ struct thread_data {
 	pthread_t pthread;
 	struct index_state *index;
 	struct pathspec pathspec;
-	int offset, nr;
+	pthread_mutex_t *pmutex;
+	int *pnr;
 };
 
 static void *preload_thread(void *_data)
 {
-	int nr;
+	int nr, max_nr;
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
-	struct cache_entry **cep = index->cache + p->offset;
 	struct cache_def cache;
 
 	memset(&cache, 0, sizeof(cache));
-	nr = p->nr;
-	if (nr + p->offset > index->cache_nr)
-		nr = index->cache_nr - p->offset;
+	for (;;) {
+		/* get next batch of entries to check */
+		pthread_mutex_lock(p->pmutex);
+		nr = *p->pnr;
+		*p->pnr += THREAD_COST;
+		pthread_mutex_unlock(p->pmutex);
 
-	do {
-		struct cache_entry *ce = *cep++;
-		struct stat st;
+		max_nr = nr + THREAD_COST;
+		if (max_nr > index->cache_nr)
+			max_nr = index->cache_nr;
 
-		if (ce_stage(ce))
-			continue;
-		if (S_ISGITLINK(ce->ce_mode))
-			continue;
-		if (ce_uptodate(ce))
-			continue;
-		if (!ce_path_match(ce, &p->pathspec, NULL))
-			continue;
-		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
-			continue;
-		if (lstat(ce->name, &st))
-			continue;
-		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
-			continue;
-		ce_mark_uptodate(ce);
-	} while (--nr > 0);
+		/* break loop if no more work to do */
+		if (nr >= max_nr)
+			break;
+
+		for (; nr < max_nr; nr++) {
+			struct cache_entry *ce = index->cache[nr];
+			struct stat st;
+
+			if (ce_stage(ce))
+				continue;
+			if (S_ISGITLINK(ce->ce_mode))
+				continue;
+			if (ce_uptodate(ce))
+				continue;
+			if (!ce_path_match(ce, &p->pathspec, NULL))
+				continue;
+			if (threaded_has_symlink_leading_path(&cache, ce->name,
+							      ce_namelen(ce)))
+				continue;
+			if (lstat(ce->name, &st))
+				continue;
+			if (ie_match_stat(index, ce, &st,
+					  CE_MATCH_RACY_IS_DIRTY))
+				continue;
+			ce_mark_uptodate(ce);
+		}
+	}
 	return NULL;
 }
 
 static void preload_index(struct index_state *index,
 			  const struct pathspec *pathspec)
 {
-	int threads, i, work, offset;
+	int threads, i, nr = 0;
 	struct thread_data data[MAX_PARALLEL];
+	pthread_mutex_t mutex;
 
 	if (!core_preload_index)
 		return;
@@ -81,17 +96,15 @@ static void preload_index(struct index_state *index,
 		return;
 	if (threads > MAX_PARALLEL)
 		threads = MAX_PARALLEL;
-	offset = 0;
-	work = DIV_ROUND_UP(index->cache_nr, threads);
 	memset(&data, 0, sizeof(data));
+	pthread_mutex_init(&mutex, NULL);
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
 		p->index = index;
 		if (pathspec)
 			copy_pathspec(&p->pathspec, pathspec);
-		p->offset = offset;
-		p->nr = work;
-		offset += work;
+		p->pnr = &nr;
+		p->pmutex = &mutex;
 		if (pthread_create(&p->pthread, NULL, preload_thread, p))
 			die("unable to create threaded lstat");
 	}
@@ -100,6 +113,7 @@ static void preload_index(struct index_state *index,
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
 	}
+	pthread_mutex_destroy(&mutex);
 }
 #endif
 
-- 
1.9.4.msysgit.0.1.gc8a51b4
