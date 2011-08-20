From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v2 4/5] Use kwset in pickaxe
Date: Sun, 21 Aug 2011 00:41:57 +0200
Message-ID: <20110820224157.GE2199@fredrik-Q430-Q530>
References: <20110820223032.12380.72469.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, dpotapov@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 00:42:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuuEw-0008FS-Ul
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 00:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1HTWmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 18:42:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35673 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab1HTWmA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 18:42:00 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2936995bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ngBfRpACA+c19CBniatzL109Cd5SwegxXkHAfRdYGWs=;
        b=RlaEmxUQj3chAsP2FCavOTO1GqpN8sYYs5NFqtAZqOW8piWRmZR2HVLv5u+wukpunR
         tzwC7FHvxi5osyx45LzrJsGlulCAjM+2AkYXcx9h9hifyNZcPc0U6KUZ/6ujCUlCb3cB
         wbajDZWLowZ53kkD4xaaauW16mov2J9BXm39c=
Received: by 10.204.152.152 with SMTP id g24mr318946bkw.345.1313880119802;
        Sat, 20 Aug 2011 15:41:59 -0700 (PDT)
Received: from fredrik-Q430-Q530 (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id a22sm1442308bke.20.2011.08.20.15.41.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 15:41:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110820223032.12380.72469.stgit@localhost6.localdomain6>
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179790>

Benchmarks in the hot cache case:

before:
$ perf stat --repeat=5 git log -Sqwerty

Performance counter stats for 'git log -Sqwerty' (5 runs):

       47,092,744 cache-misses             #      2.825 M/sec   ( +-   1.607% )
      123,368,389 cache-references         #      7.400 M/sec   ( +-   0.812% )
      330,040,998 branch-misses            #      3.134 %       ( +-   0.257% )
   10,530,896,750 branches                 #    631.663 M/sec   ( +-   0.121% )
   62,037,201,030 instructions             #      1.399 IPC     ( +-   0.142% )
   44,331,294,321 cycles                   #   2659.073 M/sec   ( +-   0.326% )
           96,794 page-faults              #      0.006 M/sec   ( +-  11.952% )
               25 CPU-migrations           #      0.000 M/sec   ( +-  25.266% )
            1,424 context-switches         #      0.000 M/sec   ( +-   0.540% )
     16671.708650 task-clock-msecs         #      0.997 CPUs    ( +-   0.343% )

      16.728692052  seconds time elapsed   ( +-   0.344% )

after:
$ perf stat --repeat=5 git log -Sqwerty

Performance counter stats for 'git log -Sqwerty' (5 runs):

       51,385,522 cache-misses             #      4.619 M/sec   ( +-   0.565% )
      129,177,880 cache-references         #     11.611 M/sec   ( +-   0.219% )
      319,222,775 branch-misses            #      6.946 %       ( +-   0.134% )
    4,595,913,233 branches                 #    413.086 M/sec   ( +-   0.112% )
   31,395,042,533 instructions             #      1.062 IPC     ( +-   0.129% )
   29,558,348,598 cycles                   #   2656.740 M/sec   ( +-   0.204% )
           93,224 page-faults              #      0.008 M/sec   ( +-   4.487% )
               19 CPU-migrations           #      0.000 M/sec   ( +-  10.425% )
              950 context-switches         #      0.000 M/sec   ( +-   0.360% )
     11125.796039 task-clock-msecs         #      0.997 CPUs    ( +-   0.239% )

      11.164216599  seconds time elapsed   ( +-   0.240% )

So the kwset code is about 33% faster.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---
 Makefile           |    2 ++
 diffcore-pickaxe.c |   34 +++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 4cd061f..45ef51f 100644
--- a/Makefile
+++ b/Makefile
@@ -533,6 +533,7 @@ LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += help.h
+LIB_H += kwset.h
 LIB_H += levenshtein.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
@@ -624,6 +625,7 @@ LIB_OBJS += hash.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
+LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index ea03b91..c3760cf 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
+#include "kwset.h"
 
 struct diffgrep_cb {
 	regex_t *regexp;
@@ -146,7 +147,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 
 static unsigned int contains(struct diff_filespec *one,
 			     const char *needle, unsigned long len,
-			     regex_t *regexp)
+			     regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
 	unsigned long sz;
@@ -175,9 +176,12 @@ static unsigned int contains(struct diff_filespec *one,
 
 	} else { /* Classic exact string match */
 		while (sz) {
-			const char *found = memmem(data, sz, needle, len);
-			if (!found)
+			size_t offset = kwsexec(kws, data, sz, NULL);
+			const char *found;
+			if (offset == -1)
 				break;
+			else
+				found = data + offset;
 			sz -= found - data + len;
 			data = found + len;
 			cnt++;
@@ -195,6 +199,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 	unsigned long len = strlen(needle);
 	int i, has_changes;
 	regex_t regex, *regexp = NULL;
+	kwset_t kws = NULL;
 	struct diff_queue_struct outq;
 	DIFF_QUEUE_CLEAR(&outq);
 
@@ -209,6 +214,10 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 			die("invalid pickaxe regex: %s", errbuf);
 		}
 		regexp = &regex;
+	} else {
+		kws = kwsalloc(NULL);
+		kwsincr(kws, needle, len);
+		kwsprep(kws);
 	}
 
 	if (opts & DIFF_PICKAXE_ALL) {
@@ -219,16 +228,16 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 				if (!DIFF_FILE_VALID(p->two))
 					continue; /* ignore unmerged */
 				/* created */
-				if (contains(p->two, needle, len, regexp))
+				if (contains(p->two, needle, len, regexp, kws))
 					has_changes++;
 			}
 			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len, regexp))
+				if (contains(p->one, needle, len, regexp, kws))
 					has_changes++;
 			}
 			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len, regexp) !=
-				 contains(p->two, needle, len, regexp))
+				 contains(p->one, needle, len, regexp, kws) !=
+				 contains(p->two, needle, len, regexp, kws))
 				has_changes++;
 		}
 		if (has_changes)
@@ -251,16 +260,17 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 				if (!DIFF_FILE_VALID(p->two))
 					; /* ignore unmerged */
 				/* created */
-				else if (contains(p->two, needle, len, regexp))
+				else if (contains(p->two, needle, len, regexp,
+						  kws))
 					has_changes = 1;
 			}
 			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len, regexp))
+				if (contains(p->one, needle, len, regexp, kws))
 					has_changes = 1;
 			}
 			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len, regexp) !=
-				 contains(p->two, needle, len, regexp))
+				 contains(p->one, needle, len, regexp, kws) !=
+				 contains(p->two, needle, len, regexp, kws))
 				has_changes = 1;
 
 			if (has_changes)
@@ -271,6 +281,8 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 
 	if (opts & DIFF_PICKAXE_REGEX)
 		regfree(&regex);
+	else
+		kwsfree(kws);
 
 	free(q->queue);
 	*q = outq;
