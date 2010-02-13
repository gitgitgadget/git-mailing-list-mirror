From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 4/5] Use kwset in pickaxe
Date: Sat, 13 Feb 2010 15:21:00 +0100
Message-ID: <20100213142100.GE9543@fredrik-laptop>
References: <20100213141558.22851.13660.stgit@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:21:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgIrw-0006FP-1s
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 15:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab0BMOVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 09:21:05 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:53809 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab0BMOVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 09:21:04 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2560766ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=i2yY2vNHgDeJzLBHEqdm8naRvSe3IVgri568+5AHOQc=;
        b=eulWjOCXGJC3gOV4R3JWXtqsNVEtV1ZOJVXFsmcLSfRwFkpGe6pF+ad7QNsgymEN4/
         e332nXAGfKl41lQvQkklE5vTKOihorD1viFU782izYLVSwuNYuLuid/CYqPdnRPBVh9a
         Cvf+d6LJO0n5KZ7QhS08LZ4naJhQ1KDd5LnR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cpYSi+QP17eEhhAcOvK1Jb6zt2S1DNaHQWtRpkQkg0ysbY9NpmjQUil5srKQv4SLtG
         1WsPxMg9vaEdvP+2zQFa6RWqCBjWBiD8kbFccCvr61/aMKkm/R22qcGKfMw6nFhJ51e3
         pvKSK0u1TKdVyWhkslN8mdZeal7w7MQv5feow=
Received: by 10.213.100.229 with SMTP id z37mr1043924ebn.28.1266070863082;
        Sat, 13 Feb 2010 06:21:03 -0800 (PST)
Received: from fredrik-laptop (c83-250-157-96.bredband.comhem.se [83.250.157.96])
        by mx.google.com with ESMTPS id 24sm10642131eyx.38.2010.02.13.06.21.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 06:21:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100213141558.22851.13660.stgit@fredrik-laptop>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139801>

Best of five runs in the git repository:

before:

$ time git log -Sqwerty

real	0m32.517s
user	0m32.134s
sys	0m0.388s

after:

$ time git log -Sqwerty

real	0m24.299s
user	0m23.645s
sys	0m0.652s

So the kwset code is about 25% faster.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---

 Makefile           |    2 ++
 diffcore-pickaxe.c |   34 +++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 7bf2fca..5687b99 100644
--- a/Makefile
+++ b/Makefile
@@ -479,6 +479,7 @@ LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
+LIB_H += kwset.h
 
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
@@ -591,6 +592,7 @@ LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+LIB_OBJS += kwset.o
 
 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index d0ef839..6563a4e 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -4,10 +4,11 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "kwset.h"
 
 static unsigned int contains(struct diff_filespec *one,
 			     const char *needle, unsigned long len,
-			     regex_t *regexp)
+			     regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
 	unsigned long sz;
@@ -36,9 +37,12 @@ static unsigned int contains(struct diff_filespec *one,
 
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
@@ -54,6 +58,7 @@ void diffcore_pickaxe(const char *needle, int opts)
 	unsigned long len = strlen(needle);
 	int i, has_changes;
 	regex_t regex, *regexp = NULL;
+	kwset_t kws = NULL;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
@@ -69,6 +74,10 @@ void diffcore_pickaxe(const char *needle, int opts)
 			die("invalid pickaxe regex: %s", errbuf);
 		}
 		regexp = &regex;
+	} else {
+		kws = kwsalloc(NULL);
+		kwsincr(kws, needle, len);
+		kwsprep(kws);
 	}
 
 	if (opts & DIFF_PICKAXE_ALL) {
@@ -79,16 +88,16 @@ void diffcore_pickaxe(const char *needle, int opts)
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
+				contains(p->one, needle, len, regexp, kws) !=
+				contains(p->two, needle, len, regexp, kws))
 				has_changes++;
 		}
 		if (has_changes)
@@ -111,16 +120,17 @@ void diffcore_pickaxe(const char *needle, int opts)
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
+				contains(p->one, needle, len, regexp, kws) !=
+				contains(p->two, needle, len, regexp, kws))
 				has_changes = 1;
 
 			if (has_changes)
@@ -131,6 +141,8 @@ void diffcore_pickaxe(const char *needle, int opts)
 
 	if (opts & DIFF_PICKAXE_REGEX) {
 		regfree(&regex);
+	} else {
+		kwsfree(kws);
 	}
 
 	free(q->queue);
