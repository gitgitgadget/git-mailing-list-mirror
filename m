From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 25/25] rev-parse --disambiguate=<prefix>
Date: Tue,  3 Jul 2012 14:37:15 -0700
Message-ID: <1341351435-31011-26-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:39:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAp5-0007vc-5s
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab2GCVjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:39:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756586Ab2GCViG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:38:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 394BC86AB
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xSFE
	DueQKCIOK9CiDPvtNLSU6vw=; b=KcS3Ky5l65tsO/JnNue77vhqmna8TrLTsvHt
	GlvMTwyqPmeq0dF9uFfhlcfS1gZr0K2q03l/NOmOOLR4PZlxlUKoP3HzeK6RRig/
	/Fk5hO3vVhJ37ois28wRBK754IwDL6lnyTU/GuKXmCZ12HY2j/aGrZLBrcvg3czK
	nkHywDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Urjet/
	FTiLIUoQyDb68dyFY3tpM/2hYbzhX+ev7mon5fkXuGFQM87m3IJDjSj4JugmowZB
	T2siOxpniJAA7M4yKx8fcbTL+eZQoi+8Bsi2LscX8ivFDld+4ru6853ouHeT/e21
	n1BZ4jFv2sYRk3WTHKV0iK9kvE8S7p1m3RnEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 303F086AA
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75CA886A7 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5F9F351C-C557-11E1-86E2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200972>

The new option allows you to feed an ambiguous prefix and enumerate
all the objects that share it as a prefix of their object names.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rev-parse.txt     |  6 ++++
 builtin/rev-parse.c                 | 10 +++++++
 cache.h                             |  3 ++
 sha1_name.c                         | 59 +++++++++++++++++++++++++++++++------
 t/t1512-rev-parse-disambiguation.sh |  9 ++++++
 5 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8023dc0..8d90863 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -101,6 +101,12 @@ OPTIONS
 	The option core.warnAmbiguousRefs is used to select the strict
 	abbreviation mode.
 
+--disambiguate=<prefix>::
+	Show every object whose name begins with the given prefix.
+	The <prefix> must be at least 4 hexadecimal digits long to
+	avoid listing each and every object in the repository by
+	mistake.
+
 --all::
 	Show all refs found in `refs/`.
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 16b98b5..d85b8a6 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -195,6 +195,12 @@ static int anti_reference(const char *refname, const unsigned char *sha1, int fl
 	return 0;
 }
 
+static int show_abbrev(const unsigned char *sha1, void *cb_data)
+{
+	show_rev(NORMAL, sha1, NULL);
+	return 0;
+}
+
 static void show_datestring(const char *flag, const char *datestr)
 {
 	static char buffer[100];
@@ -589,6 +595,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref(show_reference, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--disambiguate=")) {
+				for_each_abbrev(arg + 15, show_abbrev, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--bisect")) {
 				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
diff --git a/cache.h b/cache.h
index c8d6406..6338878 100644
--- a/cache.h
+++ b/cache.h
@@ -828,6 +828,9 @@ extern int get_sha1_blob(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc);
 
+typedef int each_abbrev_fn(const unsigned char *sha1, void *);
+extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
+
 /*
  * Try to read a SHA1 in hexadecimal format from the 40 characters
  * starting at hex.  Write the 20-byte result to sha1 in binary form.
diff --git a/sha1_name.c b/sha1_name.c
index 18fac92..8bc20c5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -20,10 +20,15 @@ struct disambiguate_state {
 	unsigned candidate_ok:1;
 	unsigned disambiguate_fn_used:1;
 	unsigned ambiguous:1;
+	unsigned always_call_fn:1;
 };
 
 static void update_candidates(struct disambiguate_state *ds, const unsigned char *current)
 {
+	if (ds->always_call_fn) {
+		ds->ambiguous = ds->fn(current, ds->cb_data) ? 1 : 0;
+		return;
+	}
 	if (!ds->candidate_exists) {
 		/* this is the first candidate */
 		hashcpy(ds->candidate, current);
@@ -272,17 +277,12 @@ static int disambiguate_blob_only(const unsigned char *sha1, void *cb_data_unuse
 	return kind == OBJ_BLOB;
 }
 
-static int get_short_sha1(const char *name, int len, unsigned char *sha1,
-			  unsigned flags)
+static int prepare_prefixes(const char *name, int len,
+			    unsigned char *bin_pfx,
+			    char *hex_pfx)
 {
-	int i, status;
-	char hex_pfx[40];
-	unsigned char bin_pfx[20];
-	struct disambiguate_state ds;
-	int quietly = !!(flags & GET_SHA1_QUIETLY);
+	int i;
 
-	if (len < MINIMUM_ABBREV || len > 40)
-		return -1;
 	hashclr(bin_pfx);
 	memset(hex_pfx, 'x', 40);
 	for (i = 0; i < len ;i++) {
@@ -303,6 +303,22 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			val <<= 4;
 		bin_pfx[i >> 1] |= val;
 	}
+	return 0;
+}
+
+static int get_short_sha1(const char *name, int len, unsigned char *sha1,
+			  unsigned flags)
+{
+	int status;
+	char hex_pfx[40];
+	unsigned char bin_pfx[20];
+	struct disambiguate_state ds;
+	int quietly = !!(flags & GET_SHA1_QUIETLY);
+
+	if (len < MINIMUM_ABBREV || len > 40)
+		return -1;
+	if (prepare_prefixes(name, len, bin_pfx, hex_pfx) < 0)
+		return -1;
 
 	prepare_alt_odb();
 
@@ -327,6 +343,31 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
+
+int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
+{
+	char hex_pfx[40];
+	unsigned char bin_pfx[20];
+	struct disambiguate_state ds;
+	int len = strlen(prefix);
+
+	if (len < MINIMUM_ABBREV || len > 40)
+		return -1;
+	if (prepare_prefixes(prefix, len, bin_pfx, hex_pfx) < 0)
+		return -1;
+
+	prepare_alt_odb();
+
+	memset(&ds, 0, sizeof(ds));
+	ds.always_call_fn = 1;
+	ds.cb_data = cb_data;
+	ds.fn = fn;
+
+	find_short_object_filename(len, hex_pfx, &ds);
+	find_short_packed_object(len, bin_pfx, &ds);
+	return ds.ambiguous;
+}
+
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
 	int status, exists;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 9acaf1d..115eaa5 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -251,4 +251,13 @@ test_expect_success 'ambiguous commit-ish' '
 	test_must_fail git log 11021982...
 '
 
+test_expect_success 'rev-parse --disambiguate' '
+	# The test creates 16 objects that share the prefix and two
+	# commits created by commit-tree in earlier tests do not share
+	# the prefix.
+	git rev-parse --disambiguate=11021982 >actual &&
+	test "$(wc -l <actual)" = 16 &&
+	test "$(sed -e "s/^\(........\).*/\1/" actual |	sort -u)" = 11021982
+'
+
 test_done
-- 
1.7.11.1.229.g706c98f
