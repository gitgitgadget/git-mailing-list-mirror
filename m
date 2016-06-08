From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] attr.c: always pass check[] to collect_some_attrs()
Date: Wed,  8 Jun 2016 15:58:18 -0700
Message-ID: <20160608225818.726-6-gitster@pobox.com>
References: <20160608225818.726-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 00:58:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAmQp-0005Gq-PD
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 00:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423844AbcFHW6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 18:58:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423789AbcFHW6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 18:58:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82DFA21EED;
	Wed,  8 Jun 2016 18:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jPum
	MlJ96PzU+8kAQTSx+UDXY9U=; b=d7vzjJd3VozKxgsLNKH3qvBCqSX8VXbxH0Tb
	b/TixklDXGJ+jnWq4jWHMundbWMxeRUusf28UqZ7IqLlIH9jdNCBO6hlTkfdjpKd
	nDjROJqiKg+T8u+NxBjtIUJ4fxUtwpNX1zLw6L/7shoMKoEHSv1kcehRfg16Yibz
	cBc7LaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hqBpx+
	60cNy0FQJ4cAO+CH1A+5T4XT1LjQew5j/pGvKjiRjlPEDZtLxTn+/ITfwDfA1Ers
	ngdB7OE2y3sss6GDmVgGb+1tLa2kn9/XEtmbqH9v2W4MvLcadtKR0BXKyLHfJqzU
	VANyhXcobG9rv/ZH0FPy84a/Qk88j/zxYE0I8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C71021EEC;
	Wed,  8 Jun 2016 18:58:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F188121EEB;
	Wed,  8 Jun 2016 18:58:29 -0400 (EDT)
X-Mailer: git-send-email 2.9.0-rc2-262-g9161bbf
In-Reply-To: <20160608225818.726-1-gitster@pobox.com>
X-Pobox-Relay-ID: 8471A438-2DCC-11E6-A10F-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296854>

This function used to be called with check=NULL to signal it to
collect all attributes in the global check_all_attr[] array.

Because the longer term plan is to allocate check_all_attr[] and
attr_stack data structures per git_attr_check instance (i.e. "check"
here) to make the attr subsystem thread-safe, it is unacceptable.

Pass "Are we grabbing all attributes defined in the system?" bit as
a separate argument and pass it from the callers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/attr.c b/attr.c
index cdf064e..95d2f77 100644
--- a/attr.c
+++ b/attr.c
@@ -743,11 +743,12 @@ static int macroexpand_one(int nr, int rem)
 
 /*
  * Collect attributes for path into the array pointed to by
- * check_all_attr.  If check is not NULL, only attributes in
- * check[] are collected. Otherwise all attributes are collected.
+ * check_all_attr.  If collect_all is zero, only attributes in
+ * check[] are collected.  Otherwise, check[] is cleared and
+ * any and all attributes that are visible are collected in it.
  */
 static void collect_some_attrs(const char *path, int pathlen,
-			       struct git_attr_check *check)
+			       struct git_attr_check *check, int collect_all)
 
 {
 	struct attr_stack *stk;
@@ -768,10 +769,11 @@ static void collect_some_attrs(const char *path, int pathlen,
 	}
 
 	prepare_attr_stack(path, dirlen);
+
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
-	if (check && !cannot_trust_maybe_real) {
+	if (!collect_all && !cannot_trust_maybe_real) {
 		struct git_attr_check_elem *celem = check->check;
 
 		rem = 0;
@@ -790,6 +792,17 @@ static void collect_some_attrs(const char *path, int pathlen,
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
 		rem = fill(path, pathlen, basename_offset, stk, rem);
+
+	if (collect_all) {
+		git_attr_check_clear(check);
+		for (i = 0; i < attr_nr; i++) {
+			const struct git_attr *attr = check_all_attr[i].attr;
+			const char *value = check_all_attr[i].value;
+			if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
+				continue;
+			git_attr_check_append(check, attr)->value = value;
+		}
+	}
 }
 
 static int git_check_attrs(const char *path, int pathlen,
@@ -798,7 +811,7 @@ static int git_check_attrs(const char *path, int pathlen,
 	int i;
 	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, check);
+	collect_some_attrs(path, pathlen, check, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
 		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
@@ -812,19 +825,7 @@ static int git_check_attrs(const char *path, int pathlen,
 
 void git_all_attrs(const char *path, struct git_attr_check *check)
 {
-	int i;
-
-	git_attr_check_clear(check);
-	collect_some_attrs(path, strlen(path), NULL);
-
-	for (i = 0; i < attr_nr; i++) {
-		const char *name = check_all_attr[i].attr->name;
-		const char *value = check_all_attr[i].value;
-		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
-			continue;
-		git_attr_check_append(check, git_attr(name));
-		check->check[check->check_nr - 1].value = value;
-	}
+	collect_some_attrs(path, strlen(path), check, 1);
 }
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
-- 
2.9.0-rc2-262-g9161bbf
