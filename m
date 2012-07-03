From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 17/25] sha1_name.c: introduce get_sha1_committish()
Date: Tue,  3 Jul 2012 14:37:07 -0700
Message-ID: <1341351435-31011-18-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAo4-00061R-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab2GCViV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551Ab2GCVhv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31AD38670
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LTmw
	nU7p6lTConMSJPzg3aaMxQE=; b=KMvNXkdP6kmhEyn93YVEtGH21bmSlvYlALQj
	7gFYO2aeZBqIHaNdSXDmeevH/gYjetNWC2+pk2C91NOXxq1VTbjZudACn/gNNjWZ
	b47X9hW4XMk6DBojfEUATrKSX5dO8N/Lp2lYJ8t9HGePLx36IWyYz3rD2ORHtSJF
	oxpsjY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZFITKx
	wnTa+aJ10SaeQPl19rAtQeCqvZ6GNZ4Xkej74PZamjhA56sIRE86r7Ui/9ccwtLo
	hn0HgKWqGMFXU5IuoEIWYiiDiMocOFNcpiSLLZU5yVDvxUYvqmp/nGGCanTzHpXK
	fTDBu/77c8b1xb1WEJCv1Ttb3fMH8dO6hRu5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 294B2866F
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8287A866E for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 56B660E2-C557-11E1-8E6F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200960>

Many callers know that the user meant to name a committish by
syntactical positions where the object name appears.  Calling this
function allows the machinery to disambiguate shorter-than-unique
abbreviated object names between committish and others.

Note that this does NOT error out when the named object is not a
committish. It is merely to give a hint to the disambiguation
machinery.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                             |  1 +
 commit.c                            |  2 +-
 revision.c                          |  6 +++---
 sha1_name.c                         | 21 +++++++++++++++++++--
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 5 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index e1fa63b..e947b48 100644
--- a/cache.h
+++ b/cache.h
@@ -817,6 +817,7 @@ struct object_context {
 #define GET_SHA1_ONLY_TO_DIE 04000
 
 extern int get_sha1(const char *str, unsigned char *sha1);
+extern int get_sha1_committish(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc);
 
diff --git a/commit.c b/commit.c
index 35af498..8b84eff 100644
--- a/commit.c
+++ b/commit.c
@@ -67,7 +67,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	unsigned char sha1[20];
 	struct commit *commit;
 
-	if (get_sha1(name, sha1))
+	if (get_sha1_committish(name, sha1))
 		return NULL;
 	commit = lookup_commit_reference(sha1);
 	if (!commit || parse_commit(commit))
diff --git a/revision.c b/revision.c
index 7444f2e..c3160f2 100644
--- a/revision.c
+++ b/revision.c
@@ -979,7 +979,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
 		flags ^= UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1(arg, sha1))
+	if (get_sha1_committish(arg, sha1))
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, sha1, 0);
@@ -1120,8 +1120,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs,
 			next = "HEAD";
 		if (dotdot == arg)
 			this = "HEAD";
-		if (!get_sha1(this, from_sha1) &&
-		    !get_sha1(next, sha1)) {
+		if (!get_sha1_committish(this, from_sha1) &&
+		    !get_sha1_committish(next, sha1)) {
 			struct commit *a, *b;
 			struct commit_list *exclude;
 
diff --git a/sha1_name.c b/sha1_name.c
index c045be8..9e13d60 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -872,7 +872,7 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 		struct strbuf sb;
 		strbuf_init(&sb, dots - name);
 		strbuf_add(&sb, name, dots - name);
-		st = get_sha1(sb.buf, sha1_tmp);
+		st = get_sha1_committish(sb.buf, sha1_tmp);
 		strbuf_release(&sb);
 	}
 	if (st)
@@ -881,7 +881,7 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	if (!one)
 		return -1;
 
-	if (get_sha1(dots[3] ? (dots + 3) : "HEAD", sha1_tmp))
+	if (get_sha1_committish(dots[3] ? (dots + 3) : "HEAD", sha1_tmp))
 		return -1;
 	two = lookup_commit_reference_gently(sha1_tmp, 0);
 	if (!two)
@@ -999,6 +999,23 @@ int get_sha1(const char *name, unsigned char *sha1)
 	return get_sha1_with_context(name, 0, sha1, &unused);
 }
 
+/*
+ * Many callers know that the user meant to name a committish by
+ * syntactical positions where the object name appears.  Calling this
+ * function allows the machinery to disambiguate shorter-than-unique
+ * abbreviated object names between committish and others.
+ *
+ * Note that this does NOT error out when the named object is not a
+ * committish. It is merely to give a hint to the disambiguation
+ * machinery.
+ */
+int get_sha1_committish(const char *name, unsigned char *sha1)
+{
+	struct object_context unused;
+	return get_sha1_with_context(name, GET_SHA1_COMMITTISH,
+				     sha1, &unused);
+}
+
 /* Must be called only when object_name:filename doesn't exist. */
 static void diagnose_invalid_sha1_path(const char *prefix,
 				       const char *filename,
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 1a736b0..7c92451 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -102,7 +102,7 @@ test_expect_failure 'disambiguate commit' '
 	test $(git rev-parse $commit^) = $(git rev-parse 1102198268)
 '
 
-test_expect_failure 'log name1..name2 takes only commit-ishes on both ends' '
+test_expect_success 'log name1..name2 takes only commit-ishes on both ends' '
 	git log 11021982..11021982 &&
 	git log ..11021982 &&
 	git log 11021982.. &&
-- 
1.7.11.1.229.g706c98f
