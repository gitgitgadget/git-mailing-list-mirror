From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diffcore-pickaxe: unify setup and teardown code between
 log -S/-G
Date: Thu,  4 Apr 2013 21:45:26 -0700
Message-ID: <1365137126-21659-3-git-send-email-gitster@pobox.com>
References: <7v1uapfuyp.fsf@alter.siamese.dyndns.org>
 <1365137126-21659-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 05 06:46:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNyXN-0007d0-8K
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 06:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116Ab3DEEpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 00:45:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3DEEpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 00:45:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 230C011B52
	for <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=exqk
	xxp2MpvDtbJgdeEe/zw45pw=; b=jqpW0PHLk/c5VFrGgubp1QOWq3CBn1be6yWt
	5tFa4tYrXY8ddSRbQDLvyLQXseWHOHMSVSjKXNvTQJEuQyeLl4G44YikJghf5+ZA
	5AJwLYA1aSIubWEQK2RfAwG+SAbe1pRwB50TT/BRY0avVM6jY1PT11zJ/wB2TfEt
	wYXooRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xhy3e7
	e+5yxqnwyNdrUi4cZ9IMA/25Ypk+ZuQTCFzG2AXXD6A/1KjlWrzn+T/RPbfZ1Nkm
	k8vb7kg8iI35Y0AOdQRjQTd/kUCwI5XQpBUwaqGAUXhJ5v0LBQo2fZj/qS7aUZtY
	+03ZHOtY9Zs1SGa7p0SW2s65wL54VLWgcd1x8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 182DB11B51
	for <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61AE211B4D for
 <git@vger.kernel.org>; Fri,  5 Apr 2013 04:45:31 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-588-gbf1c992
In-Reply-To: <1365137126-21659-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A560F180-9DAB-11E2-A014-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220138>

The logic to decide early to do nothing and prepare the data to be
inspected are the same between has_changes() and diff_grep().
Introduce pickaxe_setup() helper to share the same code.

Similarly, introduce pickaxe_finish_filepair() to clean up after
these two functions are done with a filepair.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c | 103 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 48 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cadb071..ac5a28d 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -48,6 +48,54 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 	*q = outq;
 }
 
+static int pickaxe_setup(struct diff_filepair *p,
+			 struct diff_options *o,
+			 mmfile_t *mf_one,
+			 mmfile_t *mf_two,
+			 unsigned *what_to_free)
+{
+	struct userdiff_driver *textconv_one = NULL;
+	struct userdiff_driver *textconv_two = NULL;
+
+	if (!o->pickaxe[0])
+		return 0;
+
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(p->one);
+		textconv_two = get_textconv(p->two);
+	}
+
+	/*
+	 * If we have an unmodified pair, we know that there is no
+	 * interesting difference and we don't even have to load the
+	 * blobs, unless textconv is in play, _and_ we are using two
+	 * different textconv filters (e.g., because a pair is an
+	 * exact rename with different textconv attributes for each
+	 * side, which might generate different content).
+	 */
+	if (textconv_one == textconv_two && diff_unmodified_pair(p))
+		return 0;
+
+	mf_one->size = fill_textconv(textconv_one, p->one, &mf_one->ptr);
+	mf_two->size = fill_textconv(textconv_two, p->two, &mf_two->ptr);
+
+	*what_to_free = (textconv_one ? 1 : 0) | (textconv_two ? 2 : 0);
+	return 1;
+}
+
+static void pickaxe_finish_filepair(struct diff_filepair *p,
+				    mmfile_t *mf_one,
+				    mmfile_t *mf_two,
+				    unsigned what_to_free)
+{
+	if (what_to_free & 1)
+		free(mf_one->ptr);
+	if (what_to_free & 2)
+		free(mf_two->ptr);
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
+}
+
 struct diffgrep_cb {
 	regex_t *regexp;
 	int hit;
@@ -78,25 +126,13 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		     regex_t *regexp, kwset_t kws)
 {
 	regmatch_t regmatch;
-	struct userdiff_driver *textconv_one = NULL;
-	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
+	unsigned what_to_free;
 	int hit;
 
-	if (!o->pickaxe[0])
+	if (!pickaxe_setup(p, o, &mf1, &mf2, &what_to_free))
 		return 0;
 
-	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
-		textconv_one = get_textconv(p->one);
-		textconv_two = get_textconv(p->two);
-	}
-
-	if (textconv_one == textconv_two && diff_unmodified_pair(p))
-		return 0;
-
-	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
-	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
-
 	if (!DIFF_FILE_VALID(p->one)) {
 		if (!DIFF_FILE_VALID(p->two))
 			hit = 0; /* ignore unmerged */
@@ -125,12 +161,8 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 			      &xpp, &xecfg);
 		hit = ecbdata.hit;
 	}
-	if (textconv_one)
-		free(mf1.ptr);
-	if (textconv_two)
-		free(mf2.ptr);
-	diff_free_filespec_data(p->one);
-	diff_free_filespec_data(p->two);
+
+	pickaxe_finish_filepair(p, &mf1, &mf2, what_to_free);
 	return hit;
 }
 
@@ -201,32 +233,13 @@ static unsigned int contains(mmfile_t *mf, struct diff_options *o,
 static int has_changes(struct diff_filepair *p, struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	struct userdiff_driver *textconv_one = NULL;
-	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
+	unsigned what_to_free;
 	int ret;
 
-	if (!o->pickaxe[0])
-		return 0;
-
-	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
-		textconv_one = get_textconv(p->one);
-		textconv_two = get_textconv(p->two);
-	}
-
-	/*
-	 * If we have an unmodified pair, we know that the count will be the
-	 * same and don't even have to load the blobs. Unless textconv is in
-	 * play, _and_ we are using two different textconv filters (e.g.,
-	 * because a pair is an exact rename with different textconv attributes
-	 * for each side, which might generate different content).
-	 */
-	if (textconv_one == textconv_two && diff_unmodified_pair(p))
+	if (!pickaxe_setup(p, o, &mf1, &mf2, &what_to_free))
 		return 0;
 
-	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
-	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
-
 	if (!DIFF_FILE_VALID(p->one)) {
 		if (!DIFF_FILE_VALID(p->two))
 			ret = 0; /* ignore unmerged */
@@ -240,13 +253,7 @@ static int has_changes(struct diff_filepair *p, struct diff_options *o,
 		ret = contains(&mf1, o, regexp, kws) !=
 		      contains(&mf2, o, regexp, kws);
 
-	if (textconv_one)
-		free(mf1.ptr);
-	if (textconv_two)
-		free(mf2.ptr);
-	diff_free_filespec_data(p->one);
-	diff_free_filespec_data(p->two);
-
+	pickaxe_finish_filepair(p, &mf1, &mf2, what_to_free);
 	return ret;
 }
 
-- 
1.8.2-588-gbf1c992
