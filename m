From: David Barr <davidbarr@google.com>
Subject: [RFC/PATCH 2/3] small-alloc: add allocator for small objects
Date: Wed, 22 Jun 2011 00:33:31 -0700
Message-ID: <1308728011-14136-3-git-send-email-davidbarr@google.com>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
Cc: David Barr <davidbarr@google.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 09:34:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZHxe-0005HD-1r
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 09:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab1FVHet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 03:34:49 -0400
Received: from smtp-out.google.com ([216.239.44.51]:5635 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1FVHeo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 03:34:44 -0400
Received: from hpaq13.eem.corp.google.com (hpaq13.eem.corp.google.com [172.25.149.13])
	by smtp-out.google.com with ESMTP id p5M7YhU3017523
	for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:43 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308728084; bh=VhMlZr4D/y5LptZUwhdg5x/YqbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
	b=fjRwq9cpp8R6D3wChB4v4rgVTlLAo1zEkZmNOINNDHWRhyqqIT9p9xB8koGtRAYPq
	 cyGK+7Q2iaiW0NL0vdHrQ==
Received: from pzk26 (pzk26.prod.google.com [10.243.19.154])
	by hpaq13.eem.corp.google.com with ESMTP id p5M7Y7Wo023541
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:42 -0700
Received: by pzk26 with SMTP id 26so367790pzk.38
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=dMi/c0vxSn30cJ8Mf7PPRSLT07oHYlcgPSrRPjmNa0o=;
        b=UypLhOQmk303fJvVmqaYHBurhbID6bemng5WtYztl7GZtfyjgZE5UoUqcB5VkdFNfD
         55Kftvl3zypn4w0wUYGQ==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YzYoLa9uXgoRv/tmaf/sZReo3NONfRkTgs4pJLO7IUmt7fHTUJDXhpyqpbOEPcE4/I
         zSqjtzFguMk18tz82XPg==
Received: by 10.68.9.135 with SMTP id z7mr156483pba.107.1308728081708;
        Wed, 22 Jun 2011 00:34:41 -0700 (PDT)
Received: from localhost.localdomain (173-167-127-66-sfba.hfc.comcastbusiness.net [173.167.127.66])
        by mx.google.com with ESMTPS id p5sm248637pbd.92.2011.06.22.00.34.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 00:34:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308728011-14136-1-git-send-email-davidbarr@google.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176225>

This allocator assigns an integer handle to each allocation which
can be used to retrieve the pointer to the start of the allocation
and its length.
On average, the per-allocation memory overhead is twice the length
of the variable-length-encoding of the allocation size. For objects
less than 128 bytes in size, this equates to 2 bytes of overhead.

Signed-off-by: David Barr <davidbarr@google.com>
---

 This is the second in a series of patches to enable libfastimport.
 The theme of series is memory-effective, fast, scalable data structures.

 small-alloc.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 small-alloc.h |   18 ++++++++++++
 2 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 small-alloc.c
 create mode 100644 small-alloc.h

diff --git a/small-alloc.c b/small-alloc.c
new file mode 100644
index 0000000..936884e
--- /dev/null
+++ b/small-alloc.c
@@ -0,0 +1,82 @@
+#include "git-compat-util.h"
+#include "cache.h"
+#include "varint.h"
+#include "small-alloc.h"
+
+static const size_t chunk_size = 2 * 1024 * 1024;
+
+void *pool_alloc(struct mem_pool *pool, size_t len, size_t *id_out)
+{
+	static size_t id = 1;
+	size_t n;
+	void *r;
+
+	if ((pool->end - pool->next_free >= len) &&
+	    (pool->len_free >= sizeof_varint(len)))
+		n = pool->nr - 1;
+	else {
+		if ((pool->end - pool->next_free < len)) {
+			size_t pool_size = chunk_size;
+			if (len >= (chunk_size/2))
+				pool_size = len;
+			pool->total_allocd += pool_size;
+			pool->next_free = malloc(pool_size);
+			pool->end = pool->next_free + pool_size;
+		}
+		pool->total_allocd += sizeof(*pool->first_id) +
+				sizeof(*pool->space) +
+				sizeof(*pool->len);
+		ALLOC_GROW(pool->first_id, pool->nr + 1, pool->f_alloc);
+		ALLOC_GROW(pool->len, pool->nr + 1, pool->l_alloc);
+		ALLOC_GROW(pool->space, pool->nr + 1, pool->s_alloc);
+		pool->first_id[pool->nr] = id;
+		pool->len_free = sizeof(*pool->len);
+		bzero(pool->len[pool->nr], sizeof(*pool->len));
+		pool->space[pool->nr] = pool->next_free;
+		n = pool->nr++;
+	}
+
+	if (id_out)
+		*id_out = id;
+	id++;
+
+	char *t = &pool->len[n][sizeof(*pool->len) - pool->len_free];
+	if (encode_varint(&t, pool->len[n] + sizeof(*pool->len), len))
+		return NULL;
+	pool->len_free = pool->len[n] + sizeof(*pool->len) - t;
+
+	r = pool->next_free;
+	pool->next_free += len;
+	return r;
+}
+
+void *pool_ptr(struct mem_pool *pool, size_t id, size_t *len_out)
+{
+	char *r;
+	const char *t;
+	uint64_t len = 0, cur;
+
+	if (!id || !pool->nr)
+		return NULL;
+
+	size_t n = pool->nr * id / pool->first_id[pool->nr - 1];
+	if (n >= pool->nr - 1)
+		n = pool->nr - 1;
+	while (n && pool->first_id[n] > id)
+		n--;
+	while (n + 1 < pool->nr && pool->first_id[n + 1] <= id)
+		n++;
+	if (pool->first_id[n] > id)
+		return NULL;
+
+	cur = pool->first_id[n];
+	for (r = pool->space[n], t = (const char*) pool->len[n];
+	     !decode_varint(&t, pool->len[n] + sizeof(*pool->len), &len);
+	     r += len, cur++)
+		if (cur == id) {
+			if (len_out)
+				*len_out = len;
+			return r;
+		}
+	return NULL;
+}
diff --git a/small-alloc.h b/small-alloc.h
new file mode 100644
index 0000000..eb77491
--- /dev/null
+++ b/small-alloc.h
@@ -0,0 +1,18 @@
+#ifndef SMALL_ALLOC_H_
+#define SMALL_ALLOC_H_
+
+struct mem_pool {
+	size_t *first_id;
+	char **space;
+	char (*len)[sizeof(size_t) + sizeof(char*)];
+	size_t f_alloc, s_alloc, l_alloc, nr;
+	char *next_free;
+	char *end;
+	int len_free;
+	size_t total_allocd;
+};
+
+void *pool_alloc(struct mem_pool *pool, size_t len, size_t *id_out);
+void *pool_ptr(struct mem_pool *pool, size_t id, size_t *len_out);
+
+#endif
-- 
1.7.5.1
