From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 15/25] sha1_name.c: many short names can only be
 committish
Date: Tue,  3 Jul 2012 14:37:05 -0700
Message-ID: <1341351435-31011-16-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAo3-00061R-TB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654Ab2GCViT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756543Ab2GCVhr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52D448667
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/iwK
	KZ4VpssMLQtCRJD2DOn40/c=; b=pZqrWkEclSabY5IQmduqhCiUn5tZULDvTkcF
	1jNF4845UmJ7wBmTUtGI0sK/mKRtkVR4kHSIVjMf6fOkIiCfmzVHMztT5e7ZVFMp
	NoClJBT2DRdo2cV+T7wx5r5yFa444KlZRWNmYqsv3vCUEseDlwu5nnZ9o0/dqeMD
	zTH42ME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MwjacF
	bP2dTXotBVGEXW19SBQBHVc8uOCWY6HUUKHoV0hqOSfB2AcqXCaAEKeKiEDBDNJ+
	uWO+sGrrZjWJosHTcow82nhxvMDNmzV+HrYZQfD1/Gn0fdkKh9ZR6YigvD4PoJr7
	SYt6r+26FNRq5zpOP6Pv/AIF2pchhL5YOajXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE1D8666
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BD6B8665 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5459CB0E-C557-11E1-ACB6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200958>

We know that the token "$name" that appear in "$name^{commit}",
"$name^4", "$name~4" etc. can only name a committish (either a
commit or a tag that peels to a commit).  Teach get_short_sha1() to
take advantage of that knowledge when disambiguating an abbreviated
SHA-1 given as an object name.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                             |  1 +
 sha1_name.c                         | 32 ++++++++++++++++++++++++++++----
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 2d91dbd..1508fdb 100644
--- a/cache.h
+++ b/cache.h
@@ -813,6 +813,7 @@ struct object_context {
 
 #define GET_SHA1_QUIETLY 01
 #define GET_SHA1_COMMIT 02
+#define GET_SHA1_COMMITTISH 04
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
diff --git a/sha1_name.c b/sha1_name.c
index 8feb9b5..215bb01 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -224,6 +224,24 @@ static int disambiguate_commit_only(const unsigned char *sha1, void *cb_data_unu
 	return kind == OBJ_COMMIT;
 }
 
+static int disambiguate_committish_only(const unsigned char *sha1, void *cb_data_unused)
+{
+	struct object *obj;
+	int kind;
+
+	kind = sha1_object_info(sha1, NULL);
+	if (kind == OBJ_COMMIT)
+		return 1;
+	if (kind != OBJ_TAG)
+		return 0;
+
+	/* We need to do this the hard way... */
+	obj = deref_tag(lookup_object(sha1), NULL, 0);
+	if (obj && obj->type == OBJ_COMMIT)
+		return 1;
+	return 0;
+}
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -261,6 +279,8 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	memset(&ds, 0, sizeof(ds));
 	if (flags & GET_SHA1_COMMIT)
 		ds.fn = disambiguate_commit_only;
+	else if (flags & GET_SHA1_COMMITTISH)
+		ds.fn = disambiguate_committish_only;
 
 	find_short_object_filename(len, hex_pfx, &ds);
 	find_short_packed_object(len, bin_pfx, &ds);
@@ -440,7 +460,7 @@ static int get_parent(const char *name, int len,
 		      unsigned char *result, int idx)
 {
 	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1, 0);
+	int ret = get_sha1_1(name, len, sha1, GET_SHA1_COMMITTISH);
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -473,7 +493,7 @@ static int get_nth_ancestor(const char *name, int len,
 	struct commit *commit;
 	int ret;
 
-	ret = get_sha1_1(name, len, sha1, 0);
+	ret = get_sha1_1(name, len, sha1, GET_SHA1_COMMITTISH);
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(sha1);
@@ -519,6 +539,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	unsigned char outer[20];
 	const char *sp;
 	unsigned int expected_type = 0;
+	unsigned lookup_flags = 0;
 	struct object *o;
 
 	/*
@@ -554,7 +575,10 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	else
 		return -1;
 
-	if (get_sha1_1(name, sp - name - 2, outer, 0))
+	if (expected_type == OBJ_COMMIT)
+		lookup_flags = GET_SHA1_COMMITTISH;
+
+	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
 		return -1;
 
 	o = parse_object(outer);
@@ -666,7 +690,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 	if (!ret)
 		return 0;
 
-	return get_short_sha1(name, len, sha1, 0);
+	return get_short_sha1(name, len, sha1, lookup_flags);
 }
 
 /*
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index de45468..1a736b0 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -85,7 +85,7 @@ test_expect_success 'first commit' '
 	git commit -m d8znjge0
 '
 
-test_expect_failure 'disambiguate commit-ish' '
+test_expect_success 'disambiguate commit-ish' '
 	# feed commit-ish in an unambiguous way
 	git rev-parse --verify 1102198268^{commit} &&
 
-- 
1.7.11.1.229.g706c98f
