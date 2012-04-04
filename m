From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Wed, 04 Apr 2012 09:57:00 -0700
Message-ID: <7vy5qba10j.fsf@alter.siamese.dyndns.org>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <CAFfmPPOqb8Kn-LERyiLKL838DKw=X6=CTV1x0s8coPgAvNLUdw@mail.gmail.com>
 <7v7gxvbjfy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 18:57:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFTWA-0005Rt-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 18:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359Ab2DDQ5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 12:57:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab2DDQ5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 12:57:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CA897C86;
	Wed,  4 Apr 2012 12:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5KefvA3kRI9R9muWxvEW3Hooh6w=; b=pz5Gik
	Xr4WpJ6R5Oagl+pRS+XzK94wl60iEXej1JPP00+hJ7WQuym1qrb9mi2RzyfcqeJ4
	FtL5b/hbZLbg2SMxQmFqn2Io+3nyMxlEA4giHlS7kdlS6r9liHpg4GLJBIrBA0Uv
	hhrNqaBHpfPsJbcuOloTpevn6nLOtXSLr2hJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bX4T09dnZ/v5ecWzSGqy3+VKIg8ncCi9
	ouyTLsm4DIAa2YjM8+bG/QdBquAcbLMUhmZO6jmy65ckcnp9x8oSd0w4jOMqBfFn
	iojQivq+OcwC2789FpdWQz4XezBFXkNkQ1SJaRRv2wX9TfZCSwSsMJrrysOlnCuX
	JtVeVhS8moE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2334F7C85;
	Wed,  4 Apr 2012 12:57:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CABD7C83; Wed,  4 Apr 2012
 12:57:01 -0400 (EDT)
In-Reply-To: <7v7gxvbjfy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Apr 2012 08:33:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32B1F962-7E77-11E1-8B5E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194707>

Junio C Hamano <gitster@pobox.com> writes:

> David Barr <davidbarr@google.com> writes:
>
>> As I am hacking on WebKit daily, I'll try out this series and give feedback.
>
> Thanks; the write-out codepath needs to learn to keep the format of the
> index it originally read from when there is no preferred format defined, I
> think, as I do not think core.indexformat configuration is particularly a
> good idea, by the way.

Here is the first of two patches that should replace 9/9 (write index v4 format)
of the yesterday's 9-patch series.

-- >8 --
Subject: [PATCH 1/2] read-cache.c: write prefix-compressed names in the index

Teach the code to write the index in the v4 on-disk format.

Record the format version of the on-disk index we read from in the
index_state, and use the format when writing the new index out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      |    4 ++++
 read-cache.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 65a7aba..a3f1279 100644
--- a/cache.h
+++ b/cache.h
@@ -105,6 +105,9 @@ struct cache_header {
 	unsigned int hdr_entries;
 };
 
+#define INDEX_FORMAT_LB 2
+#define INDEX_FORMAT_UB 4
+
 /*
  * The "cache_time" is just the low 32 bits of the
  * time. It doesn't matter if it overflows - we only
@@ -265,6 +268,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 
 struct index_state {
 	struct cache_entry **cache;
+	unsigned int version;
 	unsigned int cache_nr, cache_alloc, cache_changed;
 	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
diff --git a/read-cache.c b/read-cache.c
index 1c173f7..adda1da 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1196,6 +1196,8 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
  * Index File I/O
  *****************************************************************/
 
+#define INDEX_FORMAT_DEFAULT 3
+
 /*
  * dev/ino/uid/gid/size are also just tracked to the low 32 bits
  * Again - this is just a (very strong in practice) heuristic that
@@ -1443,12 +1445,13 @@ int read_index_from(struct index_state *istate, const char *path)
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
+	istate->version = ntohl(hdr->hdr_version);
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
 	istate->initialized = 1;
 
-	if (hdr->hdr_version == htonl(4))
+	if (istate->version == 4)
 		previous_name = &previous_name_buf;
 	else
 		previous_name = NULL;
@@ -1676,15 +1679,45 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce)
+static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
+			  struct strbuf *previous_name)
 {
-	int size = ondisk_ce_size(ce);
-	struct ondisk_cache_entry *ondisk = xcalloc(1, size);
+	int size;
+	struct ondisk_cache_entry *ondisk;
 	char *name;
 	int result;
 
-	name = copy_cache_entry_to_ondisk(ondisk, ce);
-	memcpy(name, ce->name, ce_namelen(ce));
+	if (!previous_name) {
+		size = ondisk_ce_size(ce);
+		ondisk = xcalloc(1, size);
+		name = copy_cache_entry_to_ondisk(ondisk, ce);
+		memcpy(name, ce->name, ce_namelen(ce));
+	} else {
+		int common, to_remove, prefix_size;
+		unsigned char to_remove_vi[16];
+		for (common = 0;
+		     (ce->name[common] &&
+		      common < previous_name->len &&
+		      ce->name[common] == previous_name->buf[common]);
+		     common++)
+			; /* still matching */
+		to_remove = previous_name->len - common;
+		prefix_size = encode_varint(to_remove, to_remove_vi);
+
+		if (ce->ce_flags & CE_EXTENDED)
+			size = offsetof(struct ondisk_cache_entry_extended, name);
+		else
+			size = offsetof(struct ondisk_cache_entry, name);
+		size += prefix_size + (ce_namelen(ce) - common + 1);
+
+		ondisk = xcalloc(1, size);
+		name = copy_cache_entry_to_ondisk(ondisk, ce);
+		memcpy(name, to_remove_vi, prefix_size);
+		memcpy(name + prefix_size, ce->name + common, ce_namelen(ce) - common);
+
+		strbuf_splice(previous_name, common, to_remove,
+			      ce->name + common, ce_namelen(ce) - common);
+	}
 
 	result = ce_write(c, fd, ondisk, size);
 	free(ondisk);
@@ -1720,10 +1753,11 @@ int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended;
+	int i, err, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1737,24 +1771,34 @@ int write_index(struct index_state *istate, int newfd)
 		}
 	}
 
+	if (!istate->version)
+		istate->version = INDEX_FORMAT_DEFAULT;
+
+	/* demote version 3 to version 2 when the latter suffices */
+	if (istate->version == 3 || istate->version == 2)
+		istate->version = extended ? 3 : 2;
+
+	hdr_version = istate->version;
+
 	hdr.hdr_signature = htonl(CACHE_SIGNATURE);
-	/* for extended format, increase version so older git won't try to read it */
-	hdr.hdr_version = htonl(extended ? 3 : 2);
+	hdr.hdr_version = htonl(hdr_version);
 	hdr.hdr_entries = htonl(entries - removed);
 
 	git_SHA1_Init(&c);
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
+	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
-		if (ce_write_entry(&c, newfd, ce) < 0)
+		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
 			return -1;
 	}
+	strbuf_release(&previous_name_buf);
 
 	/* Write extension data here */
 	if (istate->cache_tree) {
-- 
1.7.10.rc4.54.g1d5dd3

 
