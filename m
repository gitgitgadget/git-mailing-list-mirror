From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/18] lock_ref_sha1_basic(): improve diagnostics for D/F conflicts
Date: Fri,  1 May 2015 14:25:54 +0200
Message-ID: <1430483158-14349-15-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1c-0000zA-UI
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbbEAM0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:33 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45075 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753741AbbEAM0a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:30 -0400
X-AuditID: 12074414-f797f6d000004084-23-554370f3648d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.EA.16516.3F073455; Fri,  1 May 2015 08:26:27 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zr004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:26 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPu5wDnU4Mp7bYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ3z5k1vwWrJi5bKFjA2M+0W6GDk5JARMJLZ+/8ACYYtJXLi3nq2LkYtDSOAyo8TG1wsZ
	IZwTTBI9T98xg1SxCehKLOppZgKxRQTUJCa2HWIBKWIW6GCUuLB8GztIQlggWOLcw1WsIDaL
	gKrEvMcbwJp5BVwlZv+awQ6xTk7i/PGfQHEODk6g+JepiSBhIQEXifvfv7JNYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMkoER2MB45KXeIUYCDUYmHd8Mxp1Ah
	1sSy4srcQ4ySHExKory2Cc6hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR476kD5XhTEiurUovy
	YVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHgT84EaBYtS01Mr0jJzShDSTBycIMO5
	pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3ocg7bzFBYm5QFGI1lOMilLivCdAEgIgiYzSPLix
	sDTxilEc6EthXlZg0hDiAaYYuO5XQIOZgAafv+UAMrgkESEl1cDoPn/vvJt79A4a7W/J67K6
	cj3QtP+fvax79L3C3X0uvitnGf+J/X5D69vGZQIy369x/97XcjVkqUlT8Y3OKf8rPX6ylRzt
	jSht3bT1nFWHwkLP5LjDm2zWb2dbF6T8rL5/4et98h2tyyI/JRcsDFnWI5x1zW6R 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268122>

If there is a failure to lock that is likely caused by a D/F conflict,
invoke verify_refname_available() to try to generate a more helpful
error message. If that function doesn't detect an error (which could
happen if, for example, some non-reference file is blocking the
deletion of an otherwise-empty directory tree or if there was a race
with another process that just deleted the offending reference), then
generate the strerror-based error message like before.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                             | 16 ++++++++++++----
 t/t1404-update-ref-df-conflicts.sh |  8 ++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 1b466bc..cdbd31a 100644
--- a/refs.c
+++ b/refs.c
@@ -2350,8 +2350,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		ref_file = git_path("%s", orig_refname);
 		if (remove_empty_directories(ref_file)) {
 			last_errno = errno;
-			strbuf_addf(err, "there are still refs under '%s'",
-				    orig_refname);
+
+			if (!verify_refname_available(orig_refname, extras, skip,
+						      get_loose_refs(&ref_cache), err))
+				strbuf_addf(err, "there are still refs under '%s'",
+					    orig_refname);
+
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
@@ -2361,8 +2365,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	    *type_p = type;
 	if (!refname) {
 		last_errno = errno;
-		strbuf_addf(err, "unable to resolve reference %s: %s",
-			    orig_refname, strerror(errno));
+		if (last_errno != ENOTDIR ||
+		    !verify_refname_available(orig_refname, extras, skip,
+					      get_loose_refs(&ref_cache), err))
+			strbuf_addf(err, "unable to resolve reference %s: %s",
+				    orig_refname, strerror(last_errno));
+
 		goto error_return;
 	}
 	/*
diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
index 136fb48..11b6d5b 100755
--- a/t/t1404-update-ref-df-conflicts.sh
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -36,7 +36,7 @@ test_expect_success 'existing loose ref is a simple prefix of new' '
 
 	prefix=refs/1l &&
 	test_update_rejected $prefix "a c e" false "b c/x d" \
-		"unable to resolve reference $prefix/c/x: Not a directory"
+		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x$Q"
 
 '
 
@@ -52,7 +52,7 @@ test_expect_success 'existing loose ref is a deeper prefix of new' '
 
 	prefix=refs/2l &&
 	test_update_rejected $prefix "a c e" false "b c/x/y d" \
-		"unable to resolve reference $prefix/c/x/y: Not a directory"
+		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x/y$Q"
 
 '
 
@@ -68,7 +68,7 @@ test_expect_success 'new ref is a simple prefix of existing loose' '
 
 	prefix=refs/3l &&
 	test_update_rejected $prefix "a c/x e" false "b c d" \
-		"there are still refs under $Q$prefix/c$Q"
+		"$Q$prefix/c/x$Q exists; cannot create $Q$prefix/c$Q"
 
 '
 
@@ -84,7 +84,7 @@ test_expect_success 'new ref is a deeper prefix of existing loose' '
 
 	prefix=refs/4l &&
 	test_update_rejected $prefix "a c/x/y e" false "b c d" \
-		"there are still refs under $Q$prefix/c$Q"
+		"$Q$prefix/c/x/y$Q exists; cannot create $Q$prefix/c$Q"
 
 '
 
-- 
2.1.4
