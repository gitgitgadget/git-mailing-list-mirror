From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/25] refs: document the lifetime of the args passed to each_ref_fn
Date: Sat, 25 May 2013 11:08:24 +0200
Message-ID: <1369472904-12875-26-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATz-0005No-NX
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3EYJJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:40 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:61917 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755204Ab3EYJJg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:36 -0400
X-AuditID: 12074412-b7f216d0000008d4-66-51a07fcff7f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.35.02260.FCF70A15; Sat, 25 May 2013 05:09:35 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gv1000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:33 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHu+fkGgwdc5whZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzmicu4C54JJIxdF9h9kaGO8LdDFyckgImEh0nLvEAmGLSVy4t56t
	i5GLQ0jgMqPEhPVTGSGcC0wSvSsvMoFUsQnoSizqaQazRQQcJU48uM4KUsQs0Mso8fDRd7CE
	sEC4xO7+WUA2BweLgKpEwx6wDbwCrhIvt/5jg9imIHF51hpmkBJOoPjbE5wgYSEBF4nnn86x
	TmDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJMyEdjCuPyl3iFGA
	g1GJh1egfH6gEGtiWXFl7iFGSQ4mJVFe/toFgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeBlS
	gHK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8HnVAjYJFqempFWmZ
	OSUIaSYOThDBBbKBB2hDIEghb3FBYm5xZjpE0SlGRSlx3gSQhABIIqM0D24ALCG8YhQH+keY
	NwWkigeYTOC6XwENZgIafDN3PsjgkkSElFQDYwPHtD96L9T2TE+4Ozf/d0Td+eTOo/scVkkv
	nZAQn/lvRpeN09Onb2qvHaoJEg62Vt744uDRQ47fuOZPXVvhzHdkZswWHyPrlRY31m40m/S7
	5ERZn4UJ88vj93RSm5ZHTSmSWx+0Js9z2csd+5bvlDH4aC/QoiVkkNt64t7URlmG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225505>

The lifetime of the memory pointed to by the refname and sha1
arguments to each_ref_fn was never documented, but some callers used
to assume that it was essentially permanent.  In fact the API does
*not* guarantee that these objects live beyond a single callback
invocation.

In the current code, the lifetimes are bound together with the
lifetimes of the ref_caches.  Since these are usually long, the
callers usually got away with their sloppiness.  But even today, if a
ref_cache is invalidated the memory can be freed.  And planned changes
to reference caching, needed to eliminate race conditions, will
probably need to shorten the lifetimes of these objects.

The commits leading up to this have (hopefully) fixed all of the
callers of the for_each_ref()-like functions.  This commit does the
last step: documents what each_ref_fn callbacks can assume about
object lifetimes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/refs.h b/refs.h
index a35eafc..122ec03 100644
--- a/refs.h
+++ b/refs.h
@@ -15,13 +15,23 @@ struct ref_lock {
 #define REF_ISBROKEN 0x04
 
 /*
- * Calls the specified function for each ref file until it returns
- * nonzero, and returns the value.  Please note that it is not safe to
- * modify references while an iteration is in progress, unless the
- * same callback function invocation that modifies the reference also
- * returns a nonzero value to immediately stop the iteration.
+ * The signature for the callback function for the for_each_*()
+ * functions below.  The memory pointed to by the refname and sha1
+ * arguments is only guaranteed to be valid for the duration of a
+ * single callback invocation.
+ */
+typedef int each_ref_fn(const char *refname,
+			const unsigned char *sha1, int flags, void *cb_data);
+
+/*
+ * The following functions invoke the specified callback function for
+ * each reference indicated.  If the function ever returns a nonzero
+ * value, stop the iteration and return that value.  Please note that
+ * it is not safe to modify references while an iteration is in
+ * progress, unless the same callback function invocation that
+ * modifies the reference also returns a nonzero value to immediately
+ * stop the iteration.
  */
-typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_ref_in(const char *, each_ref_fn, void *);
-- 
1.8.2.3
