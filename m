From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Sat, 28 Jun 2014 07:20:41 +0200
Message-ID: <53AE50A9.6010707@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>	<1403520105-23250-6-git-send-email-tanayabh@gmail.com>	<CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>	<53AC6A7B.3040602@gmail.com> <vpqr42afty5.fsf@anie.imag.fr>	<53ADA26E.8030801@gmail.com> <vpqmwcyw47q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 28 07:20:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0l49-0004sG-A0
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 07:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbaF1FUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 01:20:39 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52699 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbaF1FUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 01:20:38 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so6108297wes.19
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=O4q5crjVbjXy4PD1ieRj72caeKgPm0ji1/mC2yg0MfU=;
        b=0X1hfpNSKum7IlZQAUveNjp4eOjKzs08xJCQUqZ2lSxcZuh4RQ0wQBU3Urn11PPpS8
         o39Tz083Dk6NWRMiQMq/5R1OaJnmTSKrTvefBb18SX6mByEty2n+r16qzZ1xrtkdoHjj
         YYJ5K9Orcx4NmB3V20Fz3uqgnF29igaQ4HEjOok0VaTYgH4CVMcTp0IAf+VP1sPzLylv
         zUQEKh5CL227OgFcACxKoGGE7PRB4do8p0t7GizoJkgEnQHxjArPb/pcGW0thZDPNrJj
         g7cJ/voPOK3mFzMFMS7qTEa9Pcd9Rzttr641+Q0IQqXybM2FqML2/oRaE/uYnHoklP8+
         XX4w==
X-Received: by 10.194.2.72 with SMTP id 8mr30840740wjs.85.1403932837268;
        Fri, 27 Jun 2014 22:20:37 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gc5sm4219994wic.6.2014.06.27.22.20.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Jun 2014 22:20:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqmwcyw47q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252595>

Am 27.06.2014 21:19, schrieb Matthieu Moy:
> 
> The reason for which setting any config value invalidates the cache is
> that it is _much_ simpler to implement. Less complexity, less
> corner-cases, less bugs.
> 

I think I see what you mean. E.g. in cmd_clone we have:

  write_config(&option_config);
  git_config(git_default_config, NULL);
  ...
  git_config_set("remote.Foo.url", repo);
  ...
  remote = remote_get(option_origin); /* which does 'git_config(handle_config)' */

So if we load the config cache at 'git_config(git_default_config)', then
'remote_get' won't see "remote.Foo.url" unless we invalidate the cache first.


I still don't like that the invalidation is done in git_config_set, though, as
this is also used to write completely unrelated files. Wouldn't it be better to
have a 'git_config_refresh()' that could be used in place of (or before) current
'git_config(callback)' calls? The initial implementation could just invalidate
the config cache. If there's time and energy to spare, a more advanced version
could first check if any of the involved config files has changed.


The xstrdup() problem could be solved by interning strings (see the
attached patch for a trivial implementation). I.e. allocate each distinct
string only once (and keep it allocated).

So if there are 100 instances of "true" in the config file, the interned string
pool would contain only one instance (i.e. 5 bytes + hashmap_entry + malloc
overhead, vs. 100 * (5 bytes + malloc overhead) in case of xstrdup()). If the
config cache is cleared, the interned string in the pool would still remain
valid. If the config cache is reloaded, unmodified values would reuse the
existing strings from the pool.

Side note: interning getenv() results would fix the non-POSIX-compliant
getenv()-usage in git [1].

[1] https://groups.google.com/d/msg/msysgit/4cVWWJkN4to/DR8FGTQ09Q0J

---- 8< ----
Subject: [PATCH] hashmap: add string interning API

Interning short strings that are likely to have multiple copies may reduce
memory footprint and speed up string comparisons.

Add a strintern() API that uses a hashmap to manage the pool of interned
strings.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-hashmap.txt | 11 +++++++++++
 hashmap.c                               | 34 +++++++++++++++++++++++++++++++++
 hashmap.h                               |  4 ++++
 t/t0011-hashmap.sh                      | 13 +++++++++++++
 test-hashmap.c                          | 14 ++++++++++++++
 5 files changed, 76 insertions(+)

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
index b977ae8..db7c955 100644
--- a/Documentation/technical/api-hashmap.txt
+++ b/Documentation/technical/api-hashmap.txt
@@ -162,6 +162,17 @@ more entries.
 `hashmap_iter_first` is a combination of both (i.e. initializes the iterator
 and returns the first entry, if any).
 
+`const char *strintern(const char *string)`::
+
+	Returns the unique, interned version of the specified string, similar
+	to the `String.intern` API in Java and .NET. Interned strings remain
+	valid for the entire lifetime of the process.
++
+Can be used as `[x]strdup()` replacement, except that the interned string must
+not be modified or freed.
++
+Uses a hashmap to store the pool of interned strings.
+
 Usage example
 -------------
 
diff --git a/hashmap.c b/hashmap.c
index d1b8056..03cd8f3 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -226,3 +226,37 @@ void *hashmap_iter_next(struct hashmap_iter *iter)
 		current = iter->map->table[iter->tablepos++];
 	}
 }
+
+struct string_pool_entry {
+	struct hashmap_entry ent;
+	char key[FLEX_ARRAY];
+};
+
+static int string_pool_cmp(const struct string_pool_entry *e1,
+			   const struct string_pool_entry *e2,
+			   const char *key)
+{
+	return strcmp(e1->key, key ? key : e2->key);
+}
+
+const char *strintern(const char *string)
+{
+	static struct hashmap map;
+	struct string_pool_entry key, *e;
+	/* initialize string pool hashmap */
+	if (!map.tablesize)
+		hashmap_init(&map, (hashmap_cmp_fn) string_pool_cmp, 0);
+
+	/* lookup interned string in pool */
+	hashmap_entry_init(&key, strhash(string));
+	e = hashmap_get(&map, &key, string);
+	if (!e) {
+		/* not found: create it */
+		int len = strlen(string);
+		e = xmalloc(sizeof(struct string_pool_entry) + len + 1);
+		hashmap_entry_init(e, key.ent.hash);
+		memcpy(e->key, string, len + 1);
+		hashmap_add(&map, e);
+	}
+	return e->key;
+}
diff --git a/hashmap.h b/hashmap.h
index a816ad4..b428677 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -68,4 +68,8 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
+/* string interning */
+
+extern const char *strintern(const char *string);
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
index f5183fb..116cbb5 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -239,6 +239,20 @@ int main(int argc, char *argv[])
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
2.0.0.9649.g1eafa1f.dirty
