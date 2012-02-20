From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] xdiff: introduce XDF_INEXACT_MATCH
Date: Sun, 19 Feb 2012 18:16:26 -0800
Message-ID: <1329704188-9955-4-git-send-email-gitster@pobox.com>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 03:16:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzIoA-0007vG-1i
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 03:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab2BTCQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 21:16:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab2BTCQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 21:16:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDECC77DF
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hPmk
	U3Z+kPKtkzGoDX+5TQS4MX0=; b=jgGxJ4RL8QMoZCT4KSn6/kxpyxxxzke1W9sy
	QRISlpcLcxhQz0c6N77+r2NAtZz4Cm2WP+iThvoigRGpb1XSlIOrkWrjg4YQ6b08
	ZGNJLiBH9eqc7la4jam8i8roXPfdqZtfwkqfrNwLHPOjMq0ULlg80Bl70xjoDvIq
	xpIqMo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jyInYU
	Oj2gBzSDFlnFaRkI+OMysWU0Vufv0FqrGQtVbwdXQHQlMWNo5S2e958cI7xSa1Zi
	dFtxZB2tcHEiyq+6B2qWUrNctJVUn0Ru+ka6ls/aP2hMfdLCkIkJtCwZ6kfUaNw9
	kPLa9vJxF7YA/fqU1bloIGUM+KbJbhLmqVEYA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E568777DE
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C9E677DD for
 <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:35 -0500 (EST)
X-Mailer: git-send-email 1.7.9.1.265.g25f75
In-Reply-To: <1329704188-9955-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E9B0D566-5B68-11E1-8483-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191041>

The XDF_WHITESPACE_FLAGS mask is used to decide if a simple memcmp() is
sufficient to tell if two lines are the same for the purpose of producing
diff. In the current code, only options in the ignore-whitespace family
happen to call for a matching logic that is more complex than memcmp(),
but when we add new options, e.g. ignore-case, it will become apparent
that the mask is misnamed.

Introduce XDF_INEXACT_MATCH mask to express its true meaning: when any of
these bits are set, we may need to inspect the contents of the two lines
that are not exactly the same, as we may still consider them "matching".

The XDF_WHITESPACE_FLAGS will become useful again in a later patch in the
series and its definition is kept.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c         |    2 +-
 xdiff/xdiff.h  |    6 +++++-
 xdiff/xutils.c |    4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 52cda7a..87b2ec1 100644
--- a/diff.c
+++ b/diff.c
@@ -2142,7 +2142,7 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS) || must_show_header) {
+		if (!DIFF_XDL_TST(o, INEXACT_MATCH) || must_show_header) {
 			fprintf(o->file, "%s", header.buf);
 			strbuf_reset(&header);
 		}
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 09215af..48793f9 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -32,7 +32,11 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
-#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
+#define XDF_WHITESPACE_FLAGS \
+	(XDF_IGNORE_WHITESPACE | \
+	 XDF_IGNORE_WHITESPACE_CHANGE | \
+	 XDF_IGNORE_WHITESPACE_AT_EOL)
+#define XDF_INEXACT_MATCH XDF_WHITESPACE_FLAGS
 
 #define XDF_PATIENCE_DIFF (1 << 5)
 #define XDF_HISTOGRAM_DIFF (1 << 6)
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 0de084e..aa6de74 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -176,7 +176,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 
 	if (s1 == s2 && !memcmp(l1, l2, s1))
 		return 1;
-	if (!(flags & XDF_WHITESPACE_FLAGS))
+	if (!(flags & XDF_INEXACT_MATCH))
 		return 0;
 
 	i1 = 0;
@@ -281,7 +281,7 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	unsigned long ha = 5381;
 	char const *ptr = *data;
 
-	if (flags & XDF_WHITESPACE_FLAGS)
+	if (flags & XDF_INEXACT_MATCH)
 		return xdl_hash_record_with_whitespace(data, top, flags);
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
-- 
1.7.9.1.265.g25f75
