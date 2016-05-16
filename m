From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/12] attr: retire git_check_attrs() API
Date: Mon, 16 May 2016 14:05:45 -0700
Message-ID: <20160516210545.6591-13-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Pik-0001Oc-Jz
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbcEPVGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:06:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751441AbcEPVGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:06:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D5C41C756;
	Mon, 16 May 2016 17:06:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WSD+
	AjxQeEUGMoJzOUzJ3fnBRxA=; b=laEAiFDa3ZOpPPvybD47UqvIEMm3bCIT+eyG
	BADjM6k70OQTM85/4UWAKghwOqNbIHsxqEpROuZemyn3ack/6wkAnlsn4Bu8Du5j
	Ps9ZoOXmzzTmCTFf2Ihw/87YkjeOEXJj3GcDxo30pmVsO2PKTVAycagHSAHjtZny
	TVoGbrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mJegZu
	wlvod3QqCIJwMtVTT07YaD0d5PLgjKblr2DlzmuQv8W6nVDZow0C5DlqIy00U/TB
	7W5nFMwxbAxTnDrVrIDvSbdm4cseaoJ/6byxx8x8L1YPmwp9+09SsAQC8eIcjrUQ
	SawuOhyqcE+kMHMz26q8sjansrJSfGthmpw+M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1655B1C753;
	Mon, 16 May 2016 17:06:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 734901C752;
	Mon, 16 May 2016 17:06:15 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: 06DB8932-1BAA-11E6-B1CD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294796>

Since nobody uses the old API, make it file-scope static, and update
the documentation to describe the new API.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-gitattributes.txt | 62 +++++++++++++++------------
 attr.c                                        |  3 +-
 attr.h                                        |  2 -
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 2602668..6f13f94 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -16,10 +16,15 @@ Data Structure
 	of no interest to the calling programs.  The name of the
 	attribute can be retrieved by calling `git_attr_name()`.
 
+`struct git_attr_check_elem`::
+
+	This structure represents one attribute and its value.
+
 `struct git_attr_check`::
 
-	This structure represents a set of attributes to check in a call
-	to `git_check_attr()` function, and receives the results.
+	This structure represents a collection of `git_attr_check_elem`.
+	It is passed to `git_check_attr()` function, specifying the
+	attributes to check, and receives their values.
 
 
 Attribute Values
@@ -48,49 +53,47 @@ value of the attribute for the path.
 Querying Specific Attributes
 ----------------------------
 
-* Prepare an array of `struct git_attr_check` to define the list of
-  attributes you would want to check.  To populate this array, you would
-  need to define necessary attributes by calling `git_attr()` function.
+* Prepare `struct git_attr_check` using git_attr_check_initl()
+  function, enumerating the names of attributes whose values you are
+  interested in, terminated with a NULL pointer.
 
 * Call `git_check_attr()` to check the attributes for the path.
 
-* Inspect `git_attr_check` structure to see how each of the attribute in
-  the array is defined for the path.
+* Inspect `git_attr_check` structure to see how each of the
+  attribute in the array is defined for the path.
 
 
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
-. Prepare an array of `struct git_attr_check` with two elements (because
-  we are checking two attributes).  Initialize their `attr` member with
-  pointers to `struct git_attr` obtained by calling `git_attr()`:
+. Prepare a `struct git_attr_check` with two elements (because
+  we are checking two attributes):
 
 ------------
-static struct git_attr_check check[2];
+static struct git_attr_check *check;
 static void setup_check(void)
 {
-	if (check[0].attr)
+	if (check)
 		return; /* already done */
-	check[0].attr = git_attr("crlf");
-	check[1].attr = git_attr("ident");
+	check = git_attr_check_initl("crlf", "ident", NULL);
 }
 ------------
 
-. Call `git_check_attr()` with the prepared array of `struct git_attr_check`:
+. Call `git_check_attr()` with the prepared `struct git_attr_check`:
 
 ------------
 	const char *path;
 
 	setup_check();
-	git_check_attr(path, ARRAY_SIZE(check), check);
+	git_check_attr(path, check);
 ------------
 
-. Act on `.value` member of the result, left in `check[]`:
+. Act on `.value` member of the result, left in `check->check[]`:
 
 ------------
-	const char *value = check[0].value;
+	const char *value = check->check[0].value;
 
 	if (ATTR_TRUE(value)) {
 		The attribute is Set, by listing only the name of the
@@ -115,14 +118,17 @@ Querying All Attributes
 
 To get the values of all attributes associated with a file:
 
-* Call `git_all_attrs()`, which returns an array of `git_attr_check`
-  structures.
+* Prepare an empty `git_attr_check` structure by calling
+  `git_attr_check_alloc()`.
+
+* Call `git_all_attrs()`, which populates the `git_attr_check`
+  with the attributes attached to the path.
 
-* Iterate over the `git_attr_check` array to examine the attribute
-  names and values.  The name of the attribute described by a
-  `git_attr_check` object can be retrieved via
-  `git_attr_name(check[i].attr)`.  (Please note that no items will be
-  returned for unset attributes, so `ATTR_UNSET()` will return false
-  for all returned `git_array_check` objects.)
+* Iterate over the `git_attr_check.check[]` array to examine
+  the attribute names and values.  The name of the attribute
+  described by a  `git_attr_check.check[]` object can be retrieved via
+  `git_attr_name(check->check[i].attr)`.  (Please note that no items
+  will be returned for unset attributes, so `ATTR_UNSET()` will return
+  false for all returned `git_array_check` objects.)
 
-* Free the `git_array_check` array.
+* Free the `git_array_check` by calling `git_attr_check_free()`.
diff --git a/attr.c b/attr.c
index 9c187bc..c3295a9 100644
--- a/attr.c
+++ b/attr.c
@@ -769,7 +769,8 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attrs(const char *path, int num, struct git_attr_check_elem *check)
+static int git_check_attrs(const char *path, int num,
+			   struct git_attr_check_elem *check)
 {
 	int i;
 
diff --git a/attr.h b/attr.h
index b5557ae..7dc49f8 100644
--- a/attr.h
+++ b/attr.h
@@ -52,8 +52,6 @@ extern void git_attr_check_free(struct git_attr_check *);
  */
 char *git_attr_name(struct git_attr *);
 
-int git_check_attrs(const char *path, int, struct git_attr_check_elem *);
-
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
-- 
2.8.2-748-gfb85f76
