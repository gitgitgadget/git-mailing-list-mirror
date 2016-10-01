Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C93A207EC
	for <e@80x24.org>; Sat,  1 Oct 2016 00:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbcJAATv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 20:19:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52172 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752720AbcJAATt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 20:19:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86E68420EA;
        Fri, 30 Sep 2016 20:19:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=D9N7
        1amLPaqlhVoENMUJuRGqOyU=; b=qKF1L5dKIQx4DntzwwnYOID+qaNHvxCG39P/
        u92c/HuQljNWAcsMkqwAm0BgggG6VpesIZGF/mxpRLuSY9S4C/viuyjmDhGX8QyP
        rMry+DJh9fAFP9/koNXdCxKeGRK5Ga06isbElpSaUVw6ogLZDWCd6hkxg85Cxhhw
        EshbcLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        q+1txvkyr9ST2n4gpyGPLZh6FdAIJXfxleGgLhjOuqwvAbE9nAiySbqIJcg8OxCR
        D1MR62xSJaaTwVz1NlRWbyIYNDRpEY4CL458ScpalFrHU9yFSzHjVofNGE3U519J
        BTiF4G9JmGHXZemQ4Bi8QqyngLqL//QSkuJGpTEbJlk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F24C420E9;
        Fri, 30 Sep 2016 20:19:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 009D2420E8;
        Fri, 30 Sep 2016 20:19:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] abbrev: auto size the default abbreviation
Date:   Fri, 30 Sep 2016 17:19:37 -0700
Message-Id: <20161001001937.10884-4-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-622-g05f606bbb0
In-Reply-To: <20161001001937.10884-1-gitster@pobox.com>
References: <20161001001937.10884-1-gitster@pobox.com>
X-Pobox-Relay-ID: C276B846-876C-11E6-ABE7-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

In fairly early days we somehow decided to abbreviate object names
down to 7-hexdigits, but as projects grow, it is becoming more and
more likely to see such a short object names made in earlier days
and recorded in the log messages no longer unique.

Currently the Linux kernel project needs 11 to 12 hexdigits, while
Git itself needs 10 hexdigits to uniquely identify the objects they
have, while many smaller projects may still be fine with the
original 7-hexdigit default.  One-size does not fit all projects.

Introduce a mechanism, where we estimate the number of objects in
the repository upon the first request to abbreviate an object name
with the default setting and come up with a sane default for the
repository.  Based on the expectation that we would see collision in
a repository with 2^(2N) objects when using object names shortened
to first N bits, use sufficient number of hexdigits to cover the
number of objects in the repository.  Each hexdigit (4-bits) we add
to the shortened name allows us to have four times (2-bits) as many
objects in the repository.

---
 cache.h       |  1 +
 environment.c |  2 +-
 sha1_name.c   | 28 +++++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 5a651b8435..0e2a0595e5 100644
--- a/cache.h
+++ b/cache.h
@@ -1204,6 +1204,7 @@ struct object_context {
 #define GET_SHA1_TREEISH          020
 #define GET_SHA1_BLOB             040
 #define GET_SHA1_FOLLOW_SYMLINKS 0100
+#define GET_SHA1_AUTOMATIC	 0200
 #define GET_SHA1_ONLY_TO_DIE    04000
 
 #define GET_SHA1_DISAMBIGUATORS \
diff --git a/environment.c b/environment.c
index 44fb107b8a..6f9d290563 100644
--- a/environment.c
+++ b/environment.c
@@ -16,7 +16,7 @@ int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
-int minimum_abbrev = 4, default_abbrev = FALLBACK_DEFAULT_ABBREV;
+int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/sha1_name.c b/sha1_name.c
index 3b647fd7cf..beb7ab588b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -15,6 +15,7 @@ typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
+	unsigned int nrobjects;
 	char hex_pfx[GIT_SHA1_HEXSZ + 1];
 	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
 
@@ -118,6 +119,14 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 
 			if (strlen(de->d_name) != 38)
 				continue;
+
+			/*
+			 * We only look at the one subdirectory, and we assume
+			 * each subdirectory is roughly similar, so each
+			 * object we find probably has 255 other objects in
+			 * the other fan-out directories.
+			 */
+			ds->nrobjects += 256;
 			if (memcmp(de->d_name, ds->hex_pfx + 2, ds->len - 2))
 				continue;
 			memcpy(hex + 2, de->d_name, 38);
@@ -151,6 +160,7 @@ static void unique_in_pack(struct packed_git *p,
 
 	open_pack_index(p);
 	num = p->num_objects;
+	ds->nrobjects += num;
 	last = num;
 	while (first < last) {
 		uint32_t mid = (first + last) / 2;
@@ -380,6 +390,9 @@ static int show_ambiguous_object(const unsigned char *sha1, void *data)
 	return 0;
 }
 
+/* start from our historical default before the automatic abbreviation */
+static int default_automatic_abbrev = FALLBACK_DEFAULT_ABBREV;
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -426,6 +439,14 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
 	}
 
+	if (len < 16 && !status && (flags & GET_SHA1_AUTOMATIC)) {
+		unsigned int expect_collision = 1 << (len * 2);
+		if (ds.nrobjects > expect_collision) {
+			default_automatic_abbrev = len+1;
+			return SHORT_NAME_AMBIGUOUS;
+		}
+	}
+
 	return status;
 }
 
@@ -458,14 +479,19 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 {
 	int status, exists;
+	int flags = GET_SHA1_QUIETLY;
 
+	if (len < 0) {
+		flags |= GET_SHA1_AUTOMATIC;
+		len = default_automatic_abbrev;
+	}
 	sha1_to_hex_r(hex, sha1);
 	if (len == 40 || !len)
 		return 40;
 	exists = has_sha1_file(sha1);
 	while (len < 40) {
 		unsigned char sha1_ret[20];
-		status = get_short_sha1(hex, len, sha1_ret, GET_SHA1_QUIETLY);
+		status = get_short_sha1(hex, len, sha1_ret, flags);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
-- 
2.10.0-622-g05f606bbb0

