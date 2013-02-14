From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Thu, 14 Feb 2013 01:48:20 +0100
Message-ID: <511C3454.6080204@gmail.com>
References: <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com> <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com> <511AAA92.4030508@gmail.com> <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com> <20130213181851.GA5603@sigill.intra.peff.net> <511BF6D7.3030404@gmail.com> <20130213225529.GA25353@sigill.intra.peff.net>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 01:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5n0I-0001fE-Io
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 01:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761356Ab3BNAsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 19:48:22 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:56882 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab3BNAsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 19:48:21 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so954430eei.3
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Bcn2gCBRCqhGspsukarigjApYz+a2cAvxqVQdgemeAQ=;
        b=qIb6q9pKxfrsxtv9PLPo9pSLXWgJRDWGsZowIlDVbsJHT9qNx0n7mJ0oLE9c3AZiRo
         vr21CxzfMH0ptHEZJv6kJmEaPD3CcDO+ST4lqcPdMgtPWrXHKcOPNja5I0u7yfoHZlV1
         m7QIAixiImh8+xK6kbcJdAVzxdRYzyig9P4Jlo+IwrhYx+HMhcHqqnWdk2cX6wGI8rwX
         3220tQOkZD4t9GMpFSoI4nG3UOG4rlPjnnpHJZ8Ybs0ATS9CPCh+vgqQAJP0O/sEXN1S
         WQUeXZSmzEb9GUK5hXY22ZixpSW7e75UMmtzr7AujaGqZjdX/hl4n4SigPYCI/cVXohc
         T/9A==
X-Received: by 10.14.0.73 with SMTP id 49mr11531023eea.21.1360802899990;
        Wed, 13 Feb 2013 16:48:19 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id 46sm6684790eea.3.2013.02.13.16.48.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 16:48:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130213225529.GA25353@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216295>

Am 13.02.2013 23:55, schrieb Jeff King:
> On Wed, Feb 13, 2013 at 09:25:59PM +0100, Karsten Blees wrote:
> 
>> Alternatively, we could simply create normal cache_entries for the
>> directories that are linked via ce->next, but have a trailing '/' in
>> their name?
>>
>> Reference counting sounds good to me, at least better than allocating
>> directory entries per cache entry * parent dirs.
> 
> I think that is more or less what my patch does, but it splits the
> ref-counted fake cache_entries out into a separate hash of "struct
> dir_hash_entry" rather than storing it in the regular hash. Which IMHO
> is a bit cleaner for two reasons:
> 
>   1. You do not have to pay the memory price of storing fake
>      cache_entries (the name+refcount struct for each directory is much
>      smaller than a real cache_entry).
> 

Yes, but considering the small number of directories compared to files, I think this is a relatively small price to pay.

>   2. It makes the code a bit simpler, as you do not have to do any
>      "check for trailing /" magic on the result of index_name_exists to
>      determine if it is a "real" name or just a fake dir entry.
> 

True for dir.c. On the other hand, you need a lot of new find / find_or_create logic in name-hash.c.

Just to illustrate what I mean, here's a quick sketch (there's still a segfault somewhere, but I don't have time to debug right now...).

Note that hash_index_entry_directories works from right to left - if the immediate parent directory is there, there's no need to check the parent's parent.

cache_entry.dir points to the parent directory so that we don't need to lookup all path components for reference counting when adding / removing entries.

As directory entries are 'real' cache_entries, we can reuse the existing index_name_exists and hash_index_entry code.

I feel slightly guilty for abusing ce_size as reference counter...well :-)

---
 cache.h     |  4 +++-
 name-hash.c | 80 ++++++++++++++++++++++++++++---------------------------------
 2 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/cache.h b/cache.h
index 665b512..2bc1372 100644
--- a/cache.h
+++ b/cache.h
@@ -131,7 +131,7 @@ struct cache_entry {
 	unsigned int ce_namelen;
 	unsigned char sha1[20];
 	struct cache_entry *next;
-	struct cache_entry *dir_next;
+	struct cache_entry *dir;
 	char name[FLEX_ARRAY]; /* more */
 };
 
@@ -285,6 +285,8 @@ extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 static inline void remove_name_hash(struct cache_entry *ce)
 {
 	ce->ce_flags |= CE_UNHASHED;
+	if (ce->dir && !(--ce->dir->ce_size))
+		remove_name_hash(ce->dir);
 }
 
 
diff --git a/name-hash.c b/name-hash.c
index d8d25c2..01e8320 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -32,6 +32,9 @@ static unsigned int hash_name(const char *name, int namelen)
 	return hash;
 }
 
+static struct cache_entry *lookup_index_entry(struct index_state *istate, const char *name, int namelen, int icase);
+static void hash_index_entry(struct index_state *istate, struct cache_entry *ce);
+
 static void hash_index_entry_directories(struct index_state *istate, struct cache_entry *ce)
 {
 	/*
@@ -40,30 +43,25 @@ static void hash_index_entry_directories(struct index_state *istate, struct cach
 	 * closing slash.  Despite submodules being a directory, they never
 	 * reach this point, because they are stored without a closing slash
 	 * in the cache.
-	 *
-	 * Note that the cache_entry stored with the directory does not
-	 * represent the directory itself.  It is a pointer to an existing
-	 * filename, and its only purpose is to represent existence of the
-	 * directory in the cache.  It is very possible multiple directory
-	 * hash entries may point to the same cache_entry.
 	 */
-	unsigned int hash;
-	void **pos;
+	int len = ce_namelen(ce);
+	if (len && ce->name[len - 1] == '/')
+		len--;
+	while (len && ce->name[len - 1] != '/')
+		len--;
+	if (!len)
+		return;
 
-	const char *ptr = ce->name;
-	while (*ptr) {
-		while (*ptr && *ptr != '/')
-			++ptr;
-		if (*ptr == '/') {
-			++ptr;
-			hash = hash_name(ce->name, ptr - ce->name);
-			pos = insert_hash(hash, ce, &istate->name_hash);
-			if (pos) {
-				ce->dir_next = *pos;
-				*pos = ce;
-			}
-		}
+	ce->dir = lookup_index_entry(istate, ce->name, len, ignore_case);
+	if (!ce->dir) {
+		ce->dir = xcalloc(1, cache_entry_size(len));
+		memcpy(ce->dir->name, ce->name, len);
+		ce->dir->ce_namelen = len;
+		ce->dir->name[len] = 0;
+		hash_index_entry(istate, ce->dir);
 	}
+	ce->dir->ce_flags &= ~CE_UNHASHED;
+	ce->dir->ce_size++;
 }
 
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
@@ -74,7 +72,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	ce->next = ce->dir_next = NULL;
+	ce->next = ce->dir = NULL;
 	hash = hash_name(ce->name, ce_namelen(ce));
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
@@ -137,38 +135,32 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	if (!icase)
 		return 0;
 
-	/*
-	 * If the entry we're comparing is a filename (no trailing slash), then compare
-	 * the lengths exactly.
-	 */
-	if (name[namelen - 1] != '/')
-		return slow_same_name(name, namelen, ce->name, len);
-
-	/*
-	 * For a directory, we point to an arbitrary cache_entry filename.  Just
-	 * make sure the directory portion matches.
-	 */
-	return slow_same_name(name, namelen, ce->name, namelen < len ? namelen : len);
+	return slow_same_name(name, namelen, ce->name, len);
 }
 
-struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
+static struct cache_entry *lookup_index_entry(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	unsigned int hash = hash_name(name, namelen);
-	struct cache_entry *ce;
-
-	lazy_init_name_hash(istate);
-	ce = lookup_hash(hash, &istate->name_hash);
+	struct cache_entry *ce = lookup_hash(hash, &istate->name_hash);
 
 	while (ce) {
 		if (!(ce->ce_flags & CE_UNHASHED)) {
 			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
-		if (icase && name[namelen - 1] == '/')
-			ce = ce->dir_next;
-		else
-			ce = ce->next;
+		ce = ce->next;
 	}
+	return NULL;
+}
+
+struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
+{
+	struct cache_entry *ce;
+
+	lazy_init_name_hash(istate);
+	ce = lookup_index_entry(istate, name, namelen, icase);
+	if (ce)
+		return ce;
 
 	/*
 	 * Might be a submodule.  Despite submodules being directories,
@@ -182,7 +174,7 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 	 * true.
 	 */
 	if (icase && name[namelen - 1] == '/') {
-		ce = index_name_exists(istate, name, namelen - 1, icase);
+		ce = lookup_index_entry(istate, name, namelen - 1, icase);
 		if (ce && S_ISGITLINK(ce->ce_mode))
 			return ce;
 	}
