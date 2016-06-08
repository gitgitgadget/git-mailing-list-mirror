From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] attr.c: correct ugly hack for git_all_attrs()
Date: Wed,  8 Jun 2016 15:58:17 -0700
Message-ID: <20160608225818.726-5-gitster@pobox.com>
References: <20160608225818.726-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 00:58:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAmQp-0005Gq-5u
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 00:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423817AbcFHW6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 18:58:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423789AbcFHW63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 18:58:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7476620084;
	Wed,  8 Jun 2016 18:58:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=t+vA
	yhIl9vtv8UuPQKfOTMK7zBE=; b=ggSyPuNCpc9W9x4YVvEt9h8HLmbiJntx4ljP
	aFy++dGDRDjB4aLWCVc/mHmVqEiInUV9nHyRs5sMsMXmgz9t+Zm9VFwR4GrzA+0V
	p2TBj/Mv7LrV2lOUoYou6jVpYWgRY4J4oPxf6QLARj6PxE9BUcYVqv10wReyuW6o
	QQvUBUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=a0Ybqo
	Ak5mlUbJJBJ1bw34JZ4T00J3OHb49dWOr7zS6qUvUrOhGFvSM9k+uXny8orQSAex
	J3g2CXnf4O+AWFZW3rpGRENLf7qXWwrGx5lJ9eA/JCDT9gFh2F/xxyCPC78UdJfV
	MGstgfbdA3OWNv7MWpIvB2S0DL0x3IuFlK3Qo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D3A920081;
	Wed,  8 Jun 2016 18:58:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9E2F2007C;
	Wed,  8 Jun 2016 18:58:27 -0400 (EDT)
X-Mailer: git-send-email 2.9.0-rc2-262-g9161bbf
In-Reply-To: <20160608225818.726-1-gitster@pobox.com>
X-Pobox-Relay-ID: 833B7166-2DCC-11E6-A114-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296857>

The collect_some_attrs() function has an ugly hack since

06a604e6 (attr: avoid heavy work when we know the specified attr is
not defined, 2014-12-28) added an optimization that relies on the
fact that the caller knows what attributes it is interested in, so
that we can leave once we know the final answer for all the
attributes the caller asked.

git_all_attrs() that asks "what attributes are on this path?"
however does not know what attributes it is interested in, other
than the vague "we are interested in all of them", which is not a
very useful thing to say.  As a way to disable this optimization
for this caller, the said commit added a code to skip it when
the caller passes a NULL for the check structure.

However, it skipped the optimization not when check is NULL, but
when the number of attributes being checked is 0, which is
unnecessarily pessimistic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index 0e61950..cdf064e 100644
--- a/attr.c
+++ b/attr.c
@@ -743,8 +743,8 @@ static int macroexpand_one(int nr, int rem)
 
 /*
  * Collect attributes for path into the array pointed to by
- * check_all_attr. If num is non-zero, only attributes in check[] are
- * collected. Otherwise all attributes are collected.
+ * check_all_attr.  If check is not NULL, only attributes in
+ * check[] are collected. Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, int pathlen,
 			       struct git_attr_check *check)
@@ -754,17 +754,6 @@ static void collect_some_attrs(const char *path, int pathlen,
 	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
-	int num;
-	struct git_attr_check_elem *celem;
-
-	if (!check) {
-		/* Yuck - ugly git_all_attrs() hack! */
-		celem = NULL;
-		num = 0;
-	} else {
-		celem = check->check;
-		num = check->check_nr;
-	}
 
 	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
@@ -781,9 +770,12 @@ static void collect_some_attrs(const char *path, int pathlen,
 	prepare_attr_stack(path, dirlen);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
-	if (num && !cannot_trust_maybe_real) {
+
+	if (check && !cannot_trust_maybe_real) {
+		struct git_attr_check_elem *celem = check->check;
+
 		rem = 0;
-		for (i = 0; i < num; i++) {
+		for (i = 0; i < check->check_nr; i++) {
 			if (!celem[i].attr->maybe_real) {
 				struct git_attr_check_elem *c;
 				c = check_all_attr + celem[i].attr->attr_nr;
@@ -791,7 +783,7 @@ static void collect_some_attrs(const char *path, int pathlen,
 				rem++;
 			}
 		}
-		if (rem == num)
+		if (rem == check->check_nr)
 			return;
 	}
 
-- 
2.9.0-rc2-262-g9161bbf
