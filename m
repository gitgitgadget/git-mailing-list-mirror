From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] verify_lock(): report errors via a strbuf
Date: Sat, 23 May 2015 01:34:55 +0200
Message-ID: <1432337697-29161-4-git-send-email-mhagger@alum.mit.edu>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvwTH-0003OS-TQ
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbbEVXfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:35:11 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52746 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757125AbbEVXfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 19:35:09 -0400
X-AuditID: 12074411-f796c6d000000bc9-da-555fbd2bb7f3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id FE.A2.03017.B2DBF555; Fri, 22 May 2015 19:35:07 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3AFA.dip0.t-ipconnect.de [93.219.58.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4MNZ2Pu007402
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 22 May 2015 19:35:06 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqKu9Nz7UoH2rlkXXlW4mi4beK8wW
	t1fMZ7bYvLmdxYHF4+/7D0weCzaVely8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfGlUOpBW/5
	K/Ztl2lg3MDTxcjJISFgInHhwyFmCFtM4sK99WxdjFwcQgKXGSVuLX3IBOGcYJJY0X2CFaSK
	TUBXYlFPMxOILSKgJjGx7RALiM0skCuxYd8poDgHh7CAncSHXRYgYRYBVYkva0+wg9i8Ai4S
	D/fuhlomJ3H++E8wm1PAVeL20j6wkUJANb3bv7FMYORdwMiwilEuMac0Vzc3MTOnODVZtzg5
	MS8vtUjXVC83s0QvNaV0EyMkcAR3MM44KXeIUYCDUYmH1+BgXKgQa2JZcWXuIUZJDiYlUd5V
	K+JDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwnt0MlONNSaysSi3Kh0lJc7AoifPyLVH3ExJI
	TyxJzU5NLUgtgsnKcHAoSfAe2gPUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K
	ivhiYFyApHiA9hqBtPMWFyTmAkUhWk8xKkqJ81rvBkoIgCQySvPgxsLSwStGcaAvhXmPg1Tx
	AFMJXPcroMFMQINXTYgFGVySiJCSamCMPm19YoUy84opp6fa+JYtviwuxLEnfu2hdR8v6szR
	CW1Z1nztz/olFYGHipfdjcx44d62R2lBqu21cwIGtsKbJ4Z+nlIz1zT3o9XMrogHlSILYi1O
	hd/pkF10Wi7bv7Tpj0LTza9y/br3mBz6ZZc/c2W8E8g8OUWO+a/pxNu8e1pFBOce 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269771>

Instead of writing error messages directly to stderr, write them to a
"strbuf *err". In lock_ref_sha1_basic(), arrange for these errors to
be returned to its caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 100a767..625e69f 100644
--- a/refs.c
+++ b/refs.c
@@ -2198,23 +2198,28 @@ static void unlock_ref(struct ref_lock *lock)
 /*
  * Verify that the reference locked by lock has the value old_sha1.
  * Fail if the reference doesn't exist and mustexist is set. Return 0
- * on success or a negative value on error. This function should make
- * sure errno is meaningful on error.
+ * on success. On error, write an error message to err, set errno, and
+ * return a negative value.
  */
 static int verify_lock(struct ref_lock *lock,
-		       const unsigned char *old_sha1, int mustexist)
+		       const unsigned char *old_sha1, int mustexist,
+		       struct strbuf *err)
 {
+	assert(err);
+
 	if (read_ref_full(lock->ref_name,
 			  mustexist ? RESOLVE_REF_READING : 0,
 			  lock->old_sha1, NULL)) {
 		int save_errno = errno;
-		error("Can't verify ref %s", lock->ref_name);
+		strbuf_addf(err, "Can't verify ref %s", lock->ref_name);
 		errno = save_errno;
 		return -1;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
-		error("Ref %s is at %s but expected %s", lock->ref_name,
-			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
+		strbuf_addf(err, "Ref %s is at %s but expected %s",
+			    lock->ref_name,
+			    sha1_to_hex(lock->old_sha1),
+			    sha1_to_hex(old_sha1));
 		errno = EBUSY;
 		return -1;
 	}
@@ -2448,7 +2453,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 	}
-	if (old_sha1 && verify_lock(lock, old_sha1, mustexist)) {
+	if (old_sha1 && verify_lock(lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}
-- 
2.1.4
