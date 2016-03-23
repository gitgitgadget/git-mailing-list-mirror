From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/21] Inline resolve_ref_1() into resolve_ref_unsafe()
Date: Wed, 23 Mar 2016 11:04:31 +0100
Message-ID: <53338941ec04ba49db1fe6aa117f605d4d2a98f9.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmi-0001Ah-45
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbcCWKMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:52 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49379 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754691AbcCWKMj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:39 -0400
X-AuditID: 1207440c-99fff700000008b4-ef-56f26a55652f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id ED.D9.02228.55A62F65; Wed, 23 Mar 2016 06:05:09 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1J018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:07 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBua9SnM4NJfEYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZU5c9YSz4KVgx8eNVxgbG2XxdjJwcEgImEtMnPGLqYuTiEBLYyijx
	4uFbKOckk8SGw9eZQKrYBHQlFvU0g9kiAmoSE9sOsYAUMQssYJTYuHgxM0hCWMBdYsKljWA2
	i4CqxPPzH1lAbF6BKInDR66yQKxTktjw4ALYIE4BC4mTJ5cygthCAuYS2x+sZZrAyLOAkWEV
	o1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5miV5qSukmRkhA8exg/LZO5hCjAAejEg+vxJmP
	YUKsiWXFlbmHGCU5mJREec8HfQoT4kvKT6nMSCzOiC8qzUktPsQowcGsJMLbnAmU401JrKxK
	LcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8LaDNAoWpaanVqRl5pQgpJk4OEGG
	c0mJFKfmpaQWJZaWZMSDoiC+GBgHICkeoL2tYHuLCxJzgaIQracYFaXEeb1BEgIgiYzSPLix
	sDTxilEc6Eth3pUgVTzAFAPX/QpoMBPQ4IU+YINLEhFSUg2MC59vUm5qLNJTuq8+e2ey1Fyj
	I3MWrv78XoXh7pO/i1Z3cT4+ZPpG+umXV4nS+smnNpxYJas7qeRq9ZsdXjFXjjc+XurhxHe+
	+6Rm3wfOW5pTV9U/jNrg1b6Mcces5cl6Hv926Tvbx07k9rRdHZdg4iz1T3ZSS8lP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289615>

resolve_ref_unsafe() wasn't doing anything useful anymore.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f752568..120b2dd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1539,14 +1539,16 @@ out:
 }
 
 /* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_1(const char *refname,
-				 int resolve_flags,
-				 unsigned char *sha1,
-				 int *flags,
-				 struct strbuf *sb_refname)
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags)
 {
+	static struct strbuf sb_refname = STRBUF_INIT;
+	int unused_flags;
 	int symref_count;
 
+	if (!flags)
+		flags = &unused_flags;
+
 	*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
@@ -1570,7 +1572,7 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, sb_refname, &read_flags)) {
+		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
@@ -1590,7 +1592,7 @@ static const char *resolve_ref_1(const char *refname,
 			return refname;
 		}
 
-		refname = sb_refname->buf;
+		refname = sb_refname.buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
 			return refname;
@@ -1610,21 +1612,6 @@ static const char *resolve_ref_1(const char *refname,
 	return NULL;
 }
 
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
-{
-	static struct strbuf sb_refname = STRBUF_INIT;
-	int unused_flags;
-	const char *ret;
-
-	if (!flags)
-		flags = &unused_flags;
-
-	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname);
-	return ret;
-}
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
-- 
2.8.0.rc3
