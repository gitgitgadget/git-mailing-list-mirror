From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/12] packed_ref_cache: increment refcount when locked
Date: Wed, 19 Jun 2013 09:51:28 +0200
Message-ID: <1371628293-28824-8-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDC6-0003fT-5K
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668Ab3FSHwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:05 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45880 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756659Ab3FSHv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:59 -0400
X-AuditID: 1207440f-b7f786d000001f20-16-51c1631e2d3b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F2.49.07968.E1361C15; Wed, 19 Jun 2013 03:51:58 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWZ002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:57 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqCuXfDDQ4N8mK4uuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ+zsmMRS8JinYt2tv8wNjOu5uhg5OCQETCSaOgq7GDmBTDGJC/fW
	s3UxcnEICVxmlFj4dxc7hHObSeLK1gOMIFVsAroSi3qamUBsEQE1iYlth1hAipgFdjNKLD99
	ih0kISzgJTF/9l8wm0VAVWL//EesIDavgIvE1K+nmSDWKUhMefieGeQKTgFXibPLPEHCQkAl
	805NZp3AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkiY8e9g7Fov
	c4hRgINRiYfXcN2BQCHWxLLiytxDjJIcTEqivOxJBwOF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifDqOQDleFMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoSvGIgQwWLUtNT
	K9Iyc0oQ0kwcnCCCC2QDD9CGI4kgG4oLEnOLM9Mhik4xKkqJ894DSQiAJDJK8+AGwBLCK0Zx
	oH+EeVlB9vAAkwlc9yugwUxAg4W+7wMZXJKIkJJqYOQXsJ+0St3t8JaDwfd8si8s3NVma5j2
	aKb4tKne1SoqwfMV229L/Z3duPgZt5Cae66q1pbeb7oFCl87p187FhpgIXjuQMOGE9psnSci
	5Itezvn7kPuNwYnimhMFJ5y6eNfILdlSetG0h11W/YnrGkOtk8KxfMbsK/k7Tm0+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228365>

Increment the packed_ref_cache reference count while it is locked to
prevent its being freed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index d90f487..6d48b42 100644
--- a/refs.c
+++ b/refs.c
@@ -820,7 +820,9 @@ struct packed_ref_cache {
 	/*
 	 * Iff the packed-refs file associated with this instance is
 	 * currently locked for writing, this points at the associated
-	 * lock (which is owned by somebody else).
+	 * lock (which is owned by somebody else).  The referrer count
+	 * is also incremented when the file is locked and decremented
+	 * when it is unlocked.
 	 */
 	struct lock_file *lock;
 };
@@ -2096,6 +2098,8 @@ int lock_packed_refs(struct lock_file *lock, int flags)
 	/* Read the current packed-refs while holding the lock: */
 	packed_ref_cache = get_packed_ref_cache(&ref_cache);
 	packed_ref_cache->lock = lock;
+	/* Increment the reference count to prevent it from being freed: */
+	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
 }
 
@@ -2116,6 +2120,7 @@ int commit_packed_refs(void)
 	if (commit_lock_file(packed_ref_cache->lock))
 		error = -1;
 	packed_ref_cache->lock = NULL;
+	release_packed_ref_cache(packed_ref_cache);
 	return error;
 }
 
@@ -2128,6 +2133,7 @@ void rollback_packed_refs(void)
 		die("internal error: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
 	packed_ref_cache->lock = NULL;
+	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(&ref_cache);
 }
 
-- 
1.8.3.1
