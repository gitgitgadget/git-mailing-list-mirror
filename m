From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] xdl_merge(): allow passing down marker_size in xmparam_t
Date: Sun, 17 Jan 2010 01:38:59 -0800
Message-ID: <1263721144-18605-4-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:39:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbt-0003v2-TR
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0AQJjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657Ab0AQJjO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab0AQJjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4283D91406
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vBjh
	Qt1EUSSINDI5/WbF+21hf5I=; b=dYHozydgoz+JjDxxD744MA2EF2Ep0TIvTTTI
	HiKR7MtqPooeI1rTT/yqy536VEhIYM/cXedzamuV4DAWjST6b9vwS02BHDLMOUot
	R4bwGOkRqHXuPC5WnyWk81r9uMSAVtv4m7kjHTe2YjXWFBqTUcP4Zem95EDYxeOU
	S7yoIXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dJtZYf
	jwTy8UkVrMJeDUlOuMO3foJ9r2F4k51A780Dev1WRezzdtUIlDRijR7eyAD4IMPo
	3cE/foP2kiix/1udRrFXRhvcKp/Yx2wRZfvXALWQPSkdEXMWsQP4AF8b7Udix85N
	pEwDRGadItiiZg1NfLvLaN+wDBWbpyvP84I8U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D3A491405
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C68191404 for
 <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:11 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2B3C02CA-034C-11DF-8048-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137286>

This allows the callers of xdl_merge() to pass marker_size (defaults to 7)
in xmparam_t argument, to use conflict markers of non-default length.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiff.h  |    3 +++
 xdiff/xmerge.c |   23 +++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b265909..22f3913 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -110,8 +110,11 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 typedef struct s_xmparam {
 	xpparam_t xpp;
+	int marker_size;
 } xmparam_t;
 
+#define DEFAULT_CONFLICT_MARKER_SIZE 7
+
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
 		xmparam_t const *xmp, int level, mmbuffer_t *result);
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 5c37b4e..68c815f 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -145,13 +145,15 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      xdfenv_t *xe2, const char *name2,
 			      int size, int i, int style,
-			      xdmerge_t *m, char *dest)
+			      xdmerge_t *m, char *dest, int marker_size)
 {
-	const int marker_size = 7;
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
 	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
 	int j;
 
+	if (marker_size <= 0)
+		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+
 	/* Before conflicting part */
 	size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
 			      dest ? dest + size : NULL);
@@ -214,14 +216,16 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 
 static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 				 xdfenv_t *xe2, const char *name2,
-				 xdmerge_t *m, char *dest, int style)
+				 xdmerge_t *m, char *dest, int style,
+				 int marker_size)
 {
 	int size, i;
 
 	for (size = i = 0; m; m = m->next) {
 		if (m->mode == 0)
 			size = fill_conflict_hunk(xe1, name1, xe2, name2,
-						  size, i, style, m, dest);
+						  size, i, style, m, dest,
+						  marker_size);
 		else if (m->mode == 1)
 			size += xdl_recs_copy(xe1, i, m->i1 + m->chg1 - i, 0,
 					      dest ? dest + size : NULL);
@@ -386,8 +390,9 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
  */
 static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
-		int flags, xpparam_t const *xpp, mmbuffer_t *result) {
+		int flags, xmparam_t const *xmp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
+	xpparam_t const *xpp = &xmp->xpp;
 	int i0, i1, i2, chg0, chg1, chg2;
 	int level = flags & XDL_MERGE_LEVEL_MASK;
 	int style = flags & XDL_MERGE_STYLE_MASK;
@@ -522,8 +527,10 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	}
 	/* output */
 	if (result) {
+		int marker_size = xmp->marker_size;
 		int size = xdl_fill_merge_buffer(xe1, name1, xe2, name2,
-			changes, NULL, style);
+						 changes, NULL, style,
+						 marker_size);
 		result->ptr = xdl_malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
@@ -531,7 +538,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		}
 		result->size = size;
 		xdl_fill_merge_buffer(xe1, name1, xe2, name2, changes,
-				      result->ptr, style);
+				      result->ptr, style, marker_size);
 	}
 	return xdl_cleanup_merge(changes);
 }
@@ -575,7 +582,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 	} else {
 		status = xdl_do_merge(&xe1, xscr1, name1,
 				      &xe2, xscr2, name2,
-				      flags, xpp, result);
+				      flags, xmp, result);
 	}
 	xdl_free_script(xscr1);
 	xdl_free_script(xscr2);
-- 
1.6.6.405.g80ed6.dirty
