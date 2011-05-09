From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] convert: make it harder to screw up adding a conversion
 attribute
Date: Mon,  9 May 2011 15:05:01 -0700
Message-ID: <1304978701-19310-5-git-send-email-gitster@pobox.com>
References: <20110508101925.GA19525@do>
 <1304978701-19310-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYaI-0005q9-A3
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301Ab1EIWFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:05:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab1EIWFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:05:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A86D47A0;
	Mon,  9 May 2011 18:07:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yoEJ
	Td150abRPI/+cP/K69LMd8Y=; b=kGlc7UH2HdiiXRzewAw6sYpvsruOLPULDlMm
	XeAYsU9LkMstCtNRPH71UKGxJ4li2qOwPKHxPdedKeQ8LWe2yUDjrkR+X1gpvHnd
	ayZ9wQuHDxFcdl1vzz7qAdCY40zajGEdzWc0tBsxWH5YjMpo7Nb9ZX4WeN4002l1
	+ydQmLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	v6QeFpi/XM31mD+T0wjZqYLlJEKFdWgC/X+pbA4p2us50mJ3cY6Akk4ZUjUpVTzn
	dij++i4y3LPnUluy2SaSgoF5h70YbLEjC3x/1WuwBACYde3eE6uif99xy+mraUAL
	h/R3nEWqLVfLtu6HTZKEUMxExF9jPjKgN8UHom8EmKI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77DF5479F;
	Mon,  9 May 2011 18:07:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 69F5E4793; Mon,  9 May 2011
 18:07:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.288.g93ebc
In-Reply-To: <1304978701-19310-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B8B1ED9A-7A88-11E0-BD23-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173265>

The current internal API requires the callers of setup_convert_check() to
supply the git_attr_check structures (hence they need to know how many to
allocate), but they grab the same set of attributes for given path.

Define a new convert_attrs() API that fills a higher level information that
the callers (convert_to_git and convert_to_working_tree) really want, and
move the common code to interact with the attributes system to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c |   79 +++++++++++++++++++++++++++++-------------------------------
 1 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/convert.c b/convert.c
index a05820b..efc7e07 100644
--- a/convert.c
+++ b/convert.c
@@ -703,12 +703,19 @@ static enum crlf_action input_crlf_action(enum crlf_action text_attr, enum eol e
 	return text_attr;
 }
 
+struct conv_attrs {
+	struct convert_driver *drv;
+	enum crlf_action crlf_action;
+	enum eol eol_attr;
+	int ident;
+};
+
 static const char *conv_attr_name[] = {
 	"crlf", "ident", "filter", "eol", "text",
 };
 #define NUM_CONV_ATTRS ARRAY_SIZE(conv_attr_name)
 
-static void setup_convert_check(struct git_attr_check *check)
+static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
 	int i;
 	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
@@ -719,70 +726,60 @@ static void setup_convert_check(struct git_attr_check *check)
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
-	for (i = 0; i < NUM_CONV_ATTRS; i++)
-		check[i].attr = ccheck[i].attr;
+
+	if (!git_checkattr(path, NUM_CONV_ATTRS, ccheck)) {
+		ca->crlf_action = git_path_check_crlf(path, ccheck + 4);
+		if (ca->crlf_action == CRLF_GUESS)
+			ca->crlf_action = git_path_check_crlf(path, ccheck + 0);
+		ca->ident = git_path_check_ident(path, ccheck + 1);
+		ca->drv = git_path_check_convert(path, ccheck + 2);
+		ca->eol_attr = git_path_check_eol(path, ccheck + 3);
+	} else {
+		ca->drv = NULL;
+		ca->crlf_action = CRLF_GUESS;
+		ca->eol_attr = EOL_UNSET;
+		ca->ident = 0;
+	}
 }
 
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
-	struct git_attr_check check[NUM_CONV_ATTRS];
-	enum crlf_action crlf_action = CRLF_GUESS;
-	enum eol eol_attr = EOL_UNSET;
-	int ident = 0, ret = 0;
+	int ret = 0;
 	const char *filter = NULL;
+	struct conv_attrs ca;
 
-	setup_convert_check(check);
-	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
-		struct convert_driver *drv;
-		crlf_action = git_path_check_crlf(path, check + 4);
-		if (crlf_action == CRLF_GUESS)
-			crlf_action = git_path_check_crlf(path, check + 0);
-		ident = git_path_check_ident(path, check + 1);
-		drv = git_path_check_convert(path, check + 2);
-		eol_attr = git_path_check_eol(path, check + 3);
-		if (drv && drv->clean)
-			filter = drv->clean;
-	}
+	convert_attrs(&ca, path);
+	if (ca.drv)
+		filter = ca.drv->clean;
 
 	ret |= apply_filter(path, src, len, dst, filter);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
 	}
-	crlf_action = input_crlf_action(crlf_action, eol_attr);
-	ret |= crlf_to_git(path, src, len, dst, crlf_action, checksafe);
+	ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
+	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | ident_to_git(path, src, len, dst, ident);
+	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
 
 static int convert_to_working_tree_internal(const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing)
 {
-	struct git_attr_check check[NUM_CONV_ATTRS];
-	enum crlf_action crlf_action = CRLF_GUESS;
-	enum eol eol_attr = EOL_UNSET;
-	int ident = 0, ret = 0;
+	int ret = 0;
 	const char *filter = NULL;
+	struct conv_attrs ca;
 
-	setup_convert_check(check);
-	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
-		struct convert_driver *drv;
-		crlf_action = git_path_check_crlf(path, check + 4);
-		if (crlf_action == CRLF_GUESS)
-			crlf_action = git_path_check_crlf(path, check + 0);
-		ident = git_path_check_ident(path, check + 1);
-		drv = git_path_check_convert(path, check + 2);
-		eol_attr = git_path_check_eol(path, check + 3);
-		if (drv && drv->smudge)
-			filter = drv->smudge;
-	}
+	convert_attrs(&ca, path);
+	if (ca.drv)
+		filter = ca.drv->smudge;
 
-	ret |= ident_to_worktree(path, src, len, dst, ident);
+	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -792,8 +789,8 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	 * is a smudge filter.  The filter might expect CRLFs.
 	 */
 	if (filter || !normalizing) {
-		crlf_action = input_crlf_action(crlf_action, eol_attr);
-		ret |= crlf_to_worktree(path, src, len, dst, crlf_action);
+		ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
+		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src = dst->buf;
 			len = dst->len;
-- 
1.7.5.1.288.g93ebc
