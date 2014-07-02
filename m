From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 4/4] hashmap: add string interning API
Date: Thu, 03 Jul 2014 00:22:54 +0200
Message-ID: <53B4863E.1020701@gmail.com>
References: <53B48540.5070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:23:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Svh-0002zf-0p
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 00:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073AbaGBWW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 18:22:56 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:46932 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbaGBWWy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 18:22:54 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so11981917wes.4
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5PKMvnw7Lg4w19kvpasCkj5OWYc7bM14Nt61uvt/ofE=;
        b=YWdebQWK806JuXieOxvrxkEZCeH4L+djFyfvh/ma88mThGtPQS5Ek0sF7Pk+1HWAu5
         PSM33qKk9W5LpMJcZqtbE9XgzW8Tnlc8QB4dX4CrNP0NGfmoXlHsJXLr7QA/1bqawWim
         K3zZb41eVw1vElA3qPu97uouZQWVb4dDjqS+BSPE742ZAp5t8DsKw9BDO8HQC7masAfG
         wDVLE/DZGd3Ph85DVJ41Bn/tw24uivB9VBKKXcUlP2rMFlw2HQTCgT/JfNIolDn+KgHz
         1Ka/gMO1xZ3joW3jRSfZlkUdDQS+p82vpDumupg1HmqUXlCVDfEDC683nbJOWusyAFfe
         KBCA==
X-Received: by 10.194.120.129 with SMTP id lc1mr747459wjb.16.1404339773192;
        Wed, 02 Jul 2014 15:22:53 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o3sm59724193wiz.24.2014.07.02.15.22.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 15:22:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B48540.5070600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252849>

Interning short strings with high probability of duplicates can reduce the
memory footprint and speed up comparisons.

Add strintern() and memintern() APIs that use a hashmap to manage the pool
of unique, interned strings.

Note: strintern(getenv()) could be used to sanitize git's use of getenv(),
in case we ever encounter a platform where a call to getenv() invalidates
previous getenv() results (which is allowed by POSIX).

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-hashmap.txt | 15 +++++++++++++
 hashmap.c                               | 38 +++++++++++++++++++++++++++++++++
 hashmap.h                               |  8 +++++++
 t/t0011-hashmap.sh                      | 13 +++++++++++
 test-hashmap.c                          | 14 ++++++++++++
 5 files changed, 88 insertions(+)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index f9215d6..00c4c29 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -193,6 +193,21 @@ more entries.
 `hashmap_iter_first` is a combination of both (i.e. initializes the iterator
 and returns the first entry, if any).
 
+`const char *strintern(const char *string)`::
+`const void *memintern(const void *data, size_t len)`::
+
+	Returns the unique, interned version of the specified string or data,
+	similar to the `String.intern` API in Java and .NET, respectively.
+	Interned strings remain valid for the entire lifetime of the process.
++
+Can be used as `[x]strdup()` or `xmemdupz` replacement, except that interned
+strings / data must not be modified or freed.
++
+Interned strings are best used for short strings with high probability of
+duplicates.
++
+Uses a hashmap to store the pool of interned strings.
+
 Usage example
 -------------
 
diff --git a/hashmap.c b/hashmap.c
index d1b8056..f693839 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -226,3 +226,41 @@ void *hashmap_iter_next(struct hashmap_iter *iter)
 		current = iter->map->table[iter->tablepos++];
 	}
 }
+
+struct pool_entry {
+	struct hashmap_entry ent;
+	size_t len;
+	unsigned char data[FLEX_ARRAY];
+};
+
+static int pool_entry_cmp(const struct pool_entry *e1,
+			  const struct pool_entry *e2,
+			  const unsigned char *keydata)
+{
+	return e1->data != keydata &&
+	       (e1->len != e2->len || memcmp(e1->data, keydata, e1->len));
+}
+
+const void *memintern(const void *data, size_t len)
+{
+	static struct hashmap map;
+	struct pool_entry key, *e;
+
+	/* initialize string pool hashmap */
+	if (!map.tablesize)
+		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, 0);
+
+	/* lookup interned string in pool */
+	hashmap_entry_init(&key, memhash(data, len));
+	key.len = len;
+	e = hashmap_get(&map, &key, data);
+	if (!e) {
+		/* not found: create it */
+		e = xmallocz(sizeof(struct pool_entry) + len);
+		hashmap_entry_init(e, key.ent.hash);
+		e->len = len;
+		memcpy(e->data, data, len);
+		hashmap_add(&map, e);
+	}
+	return e->data;
+}
diff --git a/hashmap.h b/hashmap.h
index 12f0668..507884b 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -87,4 +87,12 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
+/* string interning */
+
+extern const void *memintern(const void *data, size_t len);
+static inline const char *strintern(const char *string)
+{
+	return memintern(string, strlen(string));
+}
+
 #endif
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 391e2b6..f97c805 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -237,4 +237,17 @@ test_expect_success 'grow / shrink' '
 
 '
 
+test_expect_success 'string interning' '
+
+test_hashmap "intern value1
+intern Value1
+intern value2
+intern value2
+" "value1
+Value1
+value2
+value2"
+
+'
+
 test_done
diff --git a/test-hashmap.c b/test-hashmap.c
index 3c9f67b..07aa7ec 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -234,6 +234,20 @@ int main(int argc, char *argv[])
 			/* print table sizes */
 			printf("%u %u\n", map.tablesize, map.size);
 
+		} else if (!strcmp("intern", cmd) && l1) {
+
+			/* test that strintern works */
+			const char *i1 = strintern(p1);
+			const char *i2 = strintern(p1);
+			if (strcmp(i1, p1))
+				printf("strintern(%s) returns %s\n", p1, i1);
+			else if (i1 == p1)
+				printf("strintern(%s) returns input pointer\n", p1);
+			else if (i1 != i2)
+				printf("strintern(%s) != strintern(%s)", i1, i2);
+			else
+				printf("%s\n", i1);
+
 		} else if (!strcmp("perfhashmap", cmd) && l1 && l2) {
 
 			perf_hashmap(atoi(p1), atoi(p2));
-- 
1.9.4.msysgit.0.dirty
