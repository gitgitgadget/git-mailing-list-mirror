From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] convert: give saner names to crlf/eol variables, types
 and functions
Date: Mon,  9 May 2011 15:04:59 -0700
Message-ID: <1304978701-19310-3-git-send-email-gitster@pobox.com>
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
	id 1QJYaH-0005q9-MH
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280Ab1EIWFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:05:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639Ab1EIWFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:05:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64613478F;
	Mon,  9 May 2011 18:07:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3bmt
	ftk6V2FZZAuKibrYaQFSa2c=; b=Wvdqv3ajEB/tTgY78Eh1xM7qrDxlUTaL+jbx
	+Sx7kUAHH54+q+5Oeuc6T0eJTrch7YGwaGiIhGmhwBNdReivoojVnvcd1/vu/KQ4
	oUREmhSbePP1/kOSXnANYnTLIHXixoBLbftz7zJJ9lzQniFehkRI71vIYuXq1ZGm
	r5Fdn0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	K2+RaW6/GjAWTxOBjDg94vXjUdti94ejipCIMdQ56f78V6S9UvmaFGVPwwS4NAV0
	YOiG5F8nqJAnV5I+Rrmke0DVWW9+jG2BDZpUR4oNJsPScmEvDJHfNwR0DEPpBRZY
	XjWM1XWdMAusHMRvA4iSsaPXBv4W4PkPabYIPC7N2xY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51BE4478D;
	Mon,  9 May 2011 18:07:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C62B478C; Mon,  9 May 2011
 18:07:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.288.g93ebc
In-Reply-To: <1304978701-19310-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B46DE8E2-7A88-11E0-A8F3-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173264>

Back when the conversion was only about the end-of-line convention, it
might have made sense to call what we do upon seeing CR/LF simply an
"action", but these days the conversion routines do a lot more than just
tweaking the line ending.  Raname "action" to "crlf_action".

The function that decides what end of line conversion to use on the output
codepath was called "determine_output_conversion", as if there is no other
kind of output conversion.  Rename it to "output_eol"; it is a function
that returns what EOL convention is to be used.

A function that decides what "crlf_action" needs to be used on the input
codepath, given what conversion attribute is set to the path and global
end-of-line convention, was called "determine_action".  Rename it to
"input_crlf_action".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c |   61 +++++++++++++++++++++++++++++++------------------------------
 1 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/convert.c b/convert.c
index 4dba329..e0ee245 100644
--- a/convert.c
+++ b/convert.c
@@ -12,7 +12,7 @@
  * translation when the "text" attribute or "auto_crlf" option is set.
  */
 
-enum action {
+enum crlf_action {
 	CRLF_GUESS = -1,
 	CRLF_BINARY = 0,
 	CRLF_TEXT,
@@ -94,9 +94,9 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-static enum eol determine_output_conversion(enum action action)
+static enum eol output_eol(enum crlf_action crlf_action)
 {
-	switch (action) {
+	switch (crlf_action) {
 	case CRLF_BINARY:
 		return EOL_UNSET;
 	case CRLF_CRLF:
@@ -119,13 +119,13 @@ static enum eol determine_output_conversion(enum action action)
 	return core_eol;
 }
 
-static void check_safe_crlf(const char *path, enum action action,
+static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
                             struct text_stat *stats, enum safe_crlf checksafe)
 {
 	if (!checksafe)
 		return;
 
-	if (determine_output_conversion(action) == EOL_LF) {
+	if (output_eol(crlf_action) == EOL_LF) {
 		/*
 		 * CRLFs would not be restored by checkout:
 		 * check if we'd remove CRLFs
@@ -136,7 +136,7 @@ static void check_safe_crlf(const char *path, enum action action,
 			else /* i.e. SAFE_CRLF_FAIL */
 				die("CRLF would be replaced by LF in %s.", path);
 		}
-	} else if (determine_output_conversion(action) == EOL_CRLF) {
+	} else if (output_eol(crlf_action) == EOL_CRLF) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
@@ -188,18 +188,19 @@ static int has_cr_in_index(const char *path)
 }
 
 static int crlf_to_git(const char *path, const char *src, size_t len,
-		       struct strbuf *buf, enum action action, enum safe_crlf checksafe)
+		       struct strbuf *buf,
+		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
 	struct text_stat stats;
 	char *dst;
 
-	if (action == CRLF_BINARY ||
-	    (action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE) || !len)
+	if (crlf_action == CRLF_BINARY ||
+	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE) || !len)
 		return 0;
 
 	gather_stats(src, len, &stats);
 
-	if (action == CRLF_AUTO || action == CRLF_GUESS) {
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS) {
 		/*
 		 * We're currently not going to even try to convert stuff
 		 * that has bare CR characters. Does anybody do that crazy
@@ -214,7 +215,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		if (is_binary(len, &stats))
 			return 0;
 
-		if (action == CRLF_GUESS) {
+		if (crlf_action == CRLF_GUESS) {
 			/*
 			 * If the file in the index has any CR in it, do not convert.
 			 * This is the new safer autocrlf handling.
@@ -224,7 +225,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		}
 	}
 
-	check_safe_crlf(path, action, &stats, checksafe);
+	check_safe_crlf(path, crlf_action, &stats, checksafe);
 
 	/* Optimization: No CR? Nothing to convert, regardless. */
 	if (!stats.cr)
@@ -234,7 +235,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
-	if (action == CRLF_AUTO || action == CRLF_GUESS) {
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS) {
 		/*
 		 * If we guessed, we already know we rejected a file with
 		 * lone CR, and we can strip a CR without looking at what
@@ -257,12 +258,12 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 }
 
 static int crlf_to_worktree(const char *path, const char *src, size_t len,
-			    struct strbuf *buf, enum action action)
+			    struct strbuf *buf, enum crlf_action crlf_action)
 {
 	char *to_free = NULL;
 	struct text_stat stats;
 
-	if (!len || determine_output_conversion(action) != EOL_CRLF)
+	if (!len || output_eol(crlf_action) != EOL_CRLF)
 		return 0;
 
 	gather_stats(src, len, &stats);
@@ -275,8 +276,8 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 	if (stats.lf == stats.crlf)
 		return 0;
 
-	if (action == CRLF_AUTO || action == CRLF_GUESS) {
-		if (action == CRLF_GUESS) {
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS) {
+		if (crlf_action == CRLF_GUESS) {
 			/* If we have any CR or CRLF line endings, we do not touch it */
 			/* This is the new safer autocrlf-handling */
 			if (stats.cr > 0 || stats.crlf > 0)
@@ -715,7 +716,7 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
-static enum action determine_action(enum action text_attr, enum eol eol_attr)
+static enum crlf_action input_crlf_action(enum crlf_action text_attr, enum eol eol_attr)
 {
 	if (text_attr == CRLF_BINARY)
 		return CRLF_BINARY;
@@ -730,7 +731,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
 	struct git_attr_check check[5];
-	enum action action = CRLF_GUESS;
+	enum crlf_action crlf_action = CRLF_GUESS;
 	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
@@ -738,9 +739,9 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		action = git_path_check_crlf(path, check + 4);
-		if (action == CRLF_GUESS)
-			action = git_path_check_crlf(path, check + 0);
+		crlf_action = git_path_check_crlf(path, check + 4);
+		if (crlf_action == CRLF_GUESS)
+			crlf_action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
 		eol_attr = git_path_check_eol(path, check + 3);
@@ -753,8 +754,8 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	action = determine_action(action, eol_attr);
-	ret |= crlf_to_git(path, src, len, dst, action, checksafe);
+	crlf_action = input_crlf_action(crlf_action, eol_attr);
+	ret |= crlf_to_git(path, src, len, dst, crlf_action, checksafe);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -767,7 +768,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 					    int normalizing)
 {
 	struct git_attr_check check[5];
-	enum action action = CRLF_GUESS;
+	enum crlf_action crlf_action = CRLF_GUESS;
 	enum eol eol_attr = EOL_UNSET;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
@@ -775,9 +776,9 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		action = git_path_check_crlf(path, check + 4);
-		if (action == CRLF_GUESS)
-			action = git_path_check_crlf(path, check + 0);
+		crlf_action = git_path_check_crlf(path, check + 4);
+		if (crlf_action == CRLF_GUESS)
+			crlf_action = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
 		eol_attr = git_path_check_eol(path, check + 3);
@@ -795,8 +796,8 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	 * is a smudge filter.  The filter might expect CRLFs.
 	 */
 	if (filter || !normalizing) {
-		action = determine_action(action, eol_attr);
-		ret |= crlf_to_worktree(path, src, len, dst, action);
+		crlf_action = input_crlf_action(crlf_action, eol_attr);
+		ret |= crlf_to_worktree(path, src, len, dst, crlf_action);
 		if (ret) {
 			src = dst->buf;
 			len = dst->len;
-- 
1.7.5.1.288.g93ebc
