From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH (experimental)] preload-index: make parallel IO configurable
Date: Wed, 25 Jun 2014 00:54:38 +0200
Message-ID: <53AA01AE.8010707@gmail.com>
References: <53AA0129.1080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzZbv-000206-GW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 00:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbaFXWyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 18:54:40 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:48208 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbaFXWyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 18:54:39 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so1115537wgg.8
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 15:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Eptdry5kAzX9UghWwYpiKhJoFzlOyV/JoDEceK0xyIY=;
        b=Qjonn1rG7jJmzU3tLD3CU2ZBut5v1kF1gietSizPWWPwFNN0uiocvnwWZWRfh4+Qs3
         54xKW9HOU7nM7OizGf3EHTCzaJCKeI28Tq28zqmXgaSx/Q0d7VpnP4/v1z2ozGMhwG+k
         qUonEHobdEw50sBtjLZ1jwvuFHTLKGZsBKmhA0rXk8NWz34ClOs2tbb3/veAzNrtBtkE
         yMONmaK2R3Fm7FFCopLB9koUdsCIJg38Z+3FgbttQGFPQFZgFsxVMAtTnEPEE61K8DNX
         kUaoMgwaHSoczYIoDdZkx5wbD8xVNqP6cMvnmnfPGSPGCs5pDeQB46lortKjhx+/gs4K
         8OGA==
X-Received: by 10.194.7.167 with SMTP id k7mr4773546wja.11.1403650478083;
        Tue, 24 Jun 2014 15:54:38 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hs8sm47243410wib.10.2014.06.24.15.54.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 15:54:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53AA0129.1080109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252423>

Make the amount of IO parallelism configurable (i.e. number of separate
index sections to be processed in parallel).

Defining PARALLEL_IO = 20 restores approximately the IO pattern of the
original preload_index() implementation. Best performance is achieved with
PARALLEL_IO = 1 (i.e. sequential IO).

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Applies on top of "preload-index: optimize for sequential IO".

 preload-index.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 6ac368d..5fe5521 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -23,6 +23,7 @@ static void preload_index(struct index_state *index,
  */
 #define MAX_PARALLEL (20)
 #define THREAD_COST (500)
+#define PARALLEL_IO (1)
 
 struct thread_data {
 	pthread_t pthread;
@@ -38,23 +39,34 @@ static void *preload_thread(void *_data)
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
 	struct cache_def cache;
+	int blocks = DIV_ROUND_UP(index->cache_nr, THREAD_COST);
+	int step = DIV_ROUND_UP(blocks, PARALLEL_IO);
 
 	memset(&cache, 0, sizeof(cache));
 	for (;;) {
 		/* get next batch of entries to check */
 		pthread_mutex_lock(p->pmutex);
 		nr = *p->pnr;
-		*p->pnr += THREAD_COST;
+		(*p->pnr)++;
 		pthread_mutex_unlock(p->pmutex);
 
+		/* break loop if no more work to do */
+		if (nr >= blocks + PARALLEL_IO - 1)
+			break;
+
+		/*
+		 * rearrange iteration order, i.e. with PARALLEL_IO = 2,
+		 * [0, 1, 2, 3, 4, 5, 6, 7] becomes [0, 4, 1, 5, 2, 6, 3, 7]
+		 */
+		nr = (nr / PARALLEL_IO) + (nr % PARALLEL_IO) * step;
+		if (nr >= blocks)
+			continue;
+		nr *= THREAD_COST;
+
 		max_nr = nr + THREAD_COST;
 		if (max_nr > index->cache_nr)
 			max_nr = index->cache_nr;
 
-		/* break loop if no more work to do */
-		if (nr >= max_nr)
-			break;
-
 		for (; nr < max_nr; nr++) {
 			struct cache_entry *ce = index->cache[nr];
 			struct stat st;
-- 
1.9.4.msysgit.0.1.gc8a51b4
