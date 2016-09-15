Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB91E1FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 02:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756775AbcIOCBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 22:01:48 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36139 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756404AbcIOCBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 22:01:47 -0400
Received: by mail-pa0-f44.google.com with SMTP id id6so10820216pad.3
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 19:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=b75daTApO+PxmJNRbkkrrWjAXgFYdQtFTGA77/Yjg+o=;
        b=NWF1ar9hwhL7J10uvzMHdTH2cKK9iP7TuCfKudN4WLdYXdF+JIbHRgBsMYsCDnpB74
         zY7Gr2m4/pOB3RamRjO0xbJpzeljMKwJ1sxZAJ2WiEpwdzuKTezilZVSmaFFd2sh0jma
         C8Xiwv4xVBPRtbmFZyyU53cXGD1EakrYUOtIdQqMI9bcrQ2J6Besj/VahMAYS4gwU53G
         D6CClHrolH0YKYKai1/snRnG2nxK9LioUS+6vBoo+BP/VRs3y9n96Na84OH3jypfTcxx
         CFDnCAM5GY4l7/ikyjRqYpX27a4pznojKEfI7Q1SgZKHa11ARwQPd7gXHmuBdRJWNvHA
         s26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b75daTApO+PxmJNRbkkrrWjAXgFYdQtFTGA77/Yjg+o=;
        b=B6sgeS5cGYniVwIICokswOaefZFc2wgk2bNnAX/+9JfjeYFqQiIIxsW/1VDXvnKuZI
         OLyPXnG3TY34QYXODTvPTAyihePydC0poy7yeRK28qen/BZoOOnu3xLJoxaxzY9ifIut
         XzsQ5cgklViwFbuTG0OY1yXdPrjJVS4w4qlCYUaANK0LpoWbpqXdJIyCEiF15HFPoun9
         AKaQpd4MjxBPqCA94/XnPIRlkXuKOwPmWGGx9DU/ATsoXR0cl/dLCAWwlFd1z2GXFWbh
         Z+1EzN/B0KODF5bZ8V94+0FbdF5IfbXHcvmX8XfbTX1XipIAZyHFcDV8kMj9gD75cMHu
         SwlQ==
X-Gm-Message-State: AE9vXwOljwk0i514+Ihc9VdPpFpDuBAxr9b6M1GvNuzZabqoPaHyuIY9aFCgfbR8j6kvkJb4
X-Received: by 10.66.156.72 with SMTP id wc8mr10171768pab.53.1473904906222;
        Wed, 14 Sep 2016 19:01:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a826:8aac:4af5:7046])
        by smtp.gmail.com with ESMTPSA id bx9sm689296pab.17.2016.09.14.19.01.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Sep 2016 19:01:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] object: measure time needed for resolving hash collisions
Date:   Wed, 14 Sep 2016 19:01:41 -0700
Message-Id: <20160915020141.32000-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.130.gef2bcd7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ time ./git rev-list HEAD --count
44271
print_time_spent_object: measure time needed for resolving hash collisions

This shows that we roughly spent a third of the time in resolving
hash collisions:

I am using linux.git to measure:

$ time git rev-list --objects --count HEAD >/dev/null
print_time_spent_resolving_hash_collisions 9:445591664

real	0m31.733s
user	0m31.220s
sys	0m0.463s

For fun I reverted 9a414486d9f0:

$ time git rev-list --objects --count HEAD >/dev/null
print_time_spent_resolving_hash_collisions 14:338605504

real	0m37.008s
user	0m36.524s
sys	0m0.423s

The 17% that Jeff measured in there, equals to 1-31.733/37.008 = 0.14
in these measurements.
The time spent in collision resolving went down by 1/3 on itself
(14.33s to 9.44s), so there is still room for improvement.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 According to Jeff, sending patches that don't get accepted is the new hype!

 builtin/rev-list.c |  2 ++
 object.c           | 36 ++++++++++++++++++++++++++++++++++++
 object.h           |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8479f6e..d0e5922 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -412,5 +412,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			printf("%d\n", revs.count_left + revs.count_right);
 	}
 
+	print_time_spent_resolving_hash_collisions();
+
 	return 0;
 }
diff --git a/object.c b/object.c
index 67d9a9e..e9e73e0 100644
--- a/object.c
+++ b/object.c
@@ -5,9 +5,40 @@
 #include "commit.h"
 #include "tag.h"
 
+#include <time.h>
+
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
 
+struct timespec caching = {0, 0};
+
+void diff(struct timespec *start, struct timespec *end, struct timespec *dst)
+{
+	if ((end->tv_nsec-start->tv_nsec)<0) {
+		dst->tv_sec = end->tv_sec-start->tv_sec-1;
+		dst->tv_nsec = 1000000000+end->tv_nsec-start->tv_nsec;
+	} else {
+		dst->tv_sec = end->tv_sec-start->tv_sec;
+		dst->tv_nsec = end->tv_nsec-start->tv_nsec;
+	}
+}
+
+void add_time_to(struct timespec *dst, struct timespec *addend)
+{
+	dst->tv_sec += addend->tv_sec;
+	dst->tv_nsec += addend->tv_nsec;
+	while (dst->tv_nsec > 1000000000) {
+		dst->tv_nsec -= 1000000000;
+		dst->tv_sec ++;
+	}
+}
+
+void print_time_spent_resolving_hash_collisions(void)
+{
+	fprintf(stderr, "print_time_spent_resolving_hash_collisions %ld:%9ld\n",
+		(long)caching.tv_sec, (long)caching.tv_nsec);
+}
+
 unsigned int get_max_object_index(void)
 {
 	return obj_hash_size;
@@ -86,11 +117,13 @@ struct object *lookup_object(const unsigned char *sha1)
 {
 	unsigned int i, first;
 	struct object *obj;
+	struct timespec time1, time2, t_diff;
 
 	if (!obj_hash)
 		return NULL;
 
 	first = i = hash_obj(sha1, obj_hash_size);
+	clock_gettime(CLOCK_MONOTONIC, &time1);
 	while ((obj = obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->oid.hash))
 			break;
@@ -98,6 +131,9 @@ struct object *lookup_object(const unsigned char *sha1)
 		if (i == obj_hash_size)
 			i = 0;
 	}
+	clock_gettime(CLOCK_MONOTONIC, &time2);
+	diff(&time1, &time2, &t_diff);
+	add_time_to(&caching, &t_diff);
 	if (obj && i != first) {
 		/*
 		 * Move object to where we started to look for it so
diff --git a/object.h b/object.h
index f8b6442..ee6ab3a 100644
--- a/object.h
+++ b/object.h
@@ -56,6 +56,8 @@ extern const char *typename(unsigned int type);
 extern int type_from_string_gently(const char *str, ssize_t, int gentle);
 #define type_from_string(str) type_from_string_gently(str, -1, 0)
 
+void print_time_spent_resolving_hash_collisions(void);
+
 /*
  * Return the current number of buckets in the object hashmap.
  */
-- 
2.10.0.130.gef2bcd7.dirty

