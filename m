From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/8] lock_ref_sha1_basic(): do not set force_write for missing references
Date: Mon,  9 Feb 2015 10:12:39 +0100
Message-ID: <1423473164-6011-4-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:13:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkPA-0007nH-CF
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbbBIJNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:13:11 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51309 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932494AbbBIJNJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:13:09 -0500
X-AuditID: 12074411-f79fa6d000006b8a-a5-54d87a18c814
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 73.A0.27530.81A78D45; Mon,  9 Feb 2015 04:12:56 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQZ026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:12:55 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqCtRdSPE4GWjnEXXlW4mi4beK8wW
	b28uYbS4vWI+s0X3lLeMFr19n1gtNm9uZ3Fg9/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYo
	bpukxJKy4Mz0PH27BO6MJS9tC5r4K/53bGFpYPzL3cXIySEhYCIx4+hkRghbTOLCvfVsILaQ
	wGVGib1d4hD2CSaJlnkuIDabgK7Eop5mJhBbREBNYmLbIRYQm1lgNZPE1rtAvRwcwgKREg/u
	5oCEWQRUJdpfzGMFsXkFnCWmL/3FBLFKTuL88Z/MIDangIvEu3NzoNY6S8yevI95AiPvAkaG
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxgh4SW4g3HGSblDjAIcjEo8vBUf
	r4cIsSaWFVfmHmKU5GBSEuVdkHgjRIgvKT+lMiOxOCO+qDQntfgQowQHs5II7/cMoBxvSmJl
	VWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYKXqxKoUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4UE/HFwKgASfEA7f1aAbK3uCAxFygK0XqKUVFKnPcbSEIAJJFR
	mgc3FpY0XjGKA30pzHsOpIoHmHDgul8BDWYCGlxQADa4JBEhJdXAyJwk13D7TvJupX/Ldlpf
	sf7teSJE3+zOoysnPp0yOGPWnHD/krr/O7XvAjnnrIWf/W5LK6xeYK6zOLevbfPfb6H7ty19
	vT3/PueSIzqXlny8bH4zzuFwzbEtkd8uq6xOTIiaIq4pqMfNJnLXtC6e8cr8syp5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263550>

If a reference is missing, its SHA-1 will be null_sha1, which can't
possibly match a new value that ref_transaction_commit() is trying to
update it to. So there is no need to set force_write in this scenario.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 651e37e..b083858 100644
--- a/refs.c
+++ b/refs.c
@@ -2259,7 +2259,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
-	int missing = 0;
 	int attempts_remaining = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2298,13 +2297,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			orig_refname, strerror(errno));
 		goto error_return;
 	}
-	missing = is_null_sha1(lock->old_sha1);
-	/* When the ref did not exist and we are creating it,
-	 * make sure there is no existing ref that is packed
-	 * whose name begins with our refname, nor a ref whose
-	 * name is a proper prefix of our refname.
+	/*
+	 * When the ref did not exist and we are creating it, make
+	 * sure there is no existing packed ref whose name begins with
+	 * our refname, nor a packed ref whose name is a proper prefix
+	 * of our refname.
 	 */
-	if (missing &&
+	if (is_null_sha1(lock->old_sha1) &&
 	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
@@ -2320,8 +2319,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
 	ref_file = git_path("%s", refname);
-	if (missing)
-		lock->force_write = 1;
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
 
-- 
2.1.4
