From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] attr.c: pass struct git_attr_check down the callchain
Date: Wed,  8 Jun 2016 15:58:15 -0700
Message-ID: <20160608225818.726-3-gitster@pobox.com>
References: <20160608225818.726-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 00:58:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAmQo-0005Gq-Jo
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 00:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423812AbcFHW61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 18:58:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423789AbcFHW6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 18:58:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B1D120078;
	Wed,  8 Jun 2016 18:58:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=F4DL
	umrj2wHKce6TUu1J6bNaaBw=; b=wi0baPSm7UhC2VY24WDtYBATjdgvOWF3M2ly
	eCoeJ+iXXH6eqDl6DWD/17nMcT8wv7TVE+JaTfknLJn/nAc+J+kqOkhD6QHHSS8J
	DKbFmokiv9m/l80JDOGGi78eQ9Qu/CaH36c/JRyiiOQW9p9VRiq0PlYSZlLi6PUC
	6Hh2kkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=COHST5
	o4XfoPDmGIFk/7l9yGL3HNCVEqFgx1d9C6N967GJIqgIgALi+GT8KEA/OM7LZq5C
	6olRvyILZ3wC50G6MzXZi0g2eGh706E5KTeSgoF7FIVWn0pqR2H83LeOEvamqoZL
	KONlEEr0HWQXh0BJPnpDEtGGAl1ellmAYOE/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 424B020077;
	Wed,  8 Jun 2016 18:58:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C007F20076;
	Wed,  8 Jun 2016 18:58:23 -0400 (EDT)
X-Mailer: git-send-email 2.9.0-rc2-262-g9161bbf
In-Reply-To: <20160608225818.726-1-gitster@pobox.com>
X-Pobox-Relay-ID: 80BEFE94-2DCC-11E6-BF40-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296856>

The callchain that starts from git_check_attrs() down to
collect_some_attrs() used to take an array of git_attr_check_elem
as their parameters.  Pass the enclosing git_attr_check instance
instead, so that they will have access to new fields we will add to
the data structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/attr.c b/attr.c
index 26228ce..4e2172a 100644
--- a/attr.c
+++ b/attr.c
@@ -746,14 +746,25 @@ static int macroexpand_one(int nr, int rem)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int pathlen, int num,
-			       struct git_attr_check_elem *check)
+static void collect_some_attrs(const char *path, int pathlen,
+			       struct git_attr_check *check)
 
 {
 	struct attr_stack *stk;
 	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
+	int num;
+	struct git_attr_check_elem *celem;
+
+	if (!check) {
+		/* Yuck - ugly git_all_attrs() hack! */
+		celem = NULL;
+		num = 0;
+	} else {
+		celem = check->check;
+		num = check->check_nr;
+	}
 
 	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
@@ -773,9 +784,9 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
 	if (num && !cannot_trust_maybe_real) {
 		rem = 0;
 		for (i = 0; i < num; i++) {
-			if (!check[i].attr->maybe_real) {
+			if (!celem[i].attr->maybe_real) {
 				struct git_attr_check_elem *c;
-				c = check_all_attr + check[i].attr->attr_nr;
+				c = check_all_attr + celem[i].attr->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
 			}
@@ -789,18 +800,19 @@ static void collect_some_attrs(const char *path, int pathlen, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int pathlen, int num,
-			   struct git_attr_check_elem *check)
+static int git_check_attrs(const char *path, int pathlen,
+			   struct git_attr_check *check)
 {
 	int i;
+	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, num, check);
+	collect_some_attrs(path, pathlen, check);
 
-	for (i = 0; i < num; i++) {
-		const char *value = check_all_attr[check[i].attr->attr_nr].value;
+	for (i = 0; i < check->check_nr; i++) {
+		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
 		if (value == ATTR__UNKNOWN)
 			value = ATTR__UNSET;
-		check[i].value = value;
+		celem[i].value = value;
 	}
 
 	return 0;
@@ -811,7 +823,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, strlen(path), 0, NULL);
+	collect_some_attrs(path, strlen(path), NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -840,7 +852,7 @@ int git_check_attr_counted(const char *path, int pathlen,
 			   struct git_attr_check *check)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, pathlen, check->check_nr, check->check);
+	return git_check_attrs(path, pathlen, check);
 }
 
 int git_check_attr(const char *path, struct git_attr_check *check)
-- 
2.9.0-rc2-262-g9161bbf
