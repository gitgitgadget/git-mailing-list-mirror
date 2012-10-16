From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/5] delete_ref(): Fix deletion of refs through symbolic refs
Date: Tue, 16 Oct 2012 15:44:51 +0200
Message-ID: <1350395094-11404-3-git-send-email-johan@herland.net>
References: <CAPc5daUws-MfzC9imkytTrLaHyyywE4_OX1jAUVPCTK2WyUF=w@mail.gmail.com>
 <1350395094-11404-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 16 15:45:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7Sd-0004f2-ME
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 15:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab2JPNpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 09:45:11 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51720 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab2JPNpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 09:45:09 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3506445eek.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 06:45:08 -0700 (PDT)
Received: by 10.14.203.70 with SMTP id e46mr21274467eeo.2.1350395108391;
        Tue, 16 Oct 2012 06:45:08 -0700 (PDT)
Received: from gamma.cisco.com (64-103-25-233.cisco.com. [64.103.25.233])
        by mx.google.com with ESMTPS id o47sm11333415eem.11.2012.10.16.06.45.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 06:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <1350395094-11404-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207825>

When deleting a ref through a symref (e.g. using 'git update-ref -d HEAD'
to delete refs/heads/master), the packed version of that ref would not
be deleted, because delete_ref() would pass the symref name (as opposed
to the dereferenced ref name) to repack_without_ref().

This patch revamps the logic in delete_ref() to make it easier to read,
and to clarify how it operates when given a symref.

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c                | 33 +++++++++++++++++----------------
 t/t1400-update-ref.sh |  2 +-
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index da74a2b..df4fe20 100644
--- a/refs.c
+++ b/refs.c
@@ -1751,34 +1751,35 @@ static int repack_without_ref(const char *refname)
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
 	struct ref_lock *lock;
-	int err, i = 0, ret = 0, flag = 0;
+	int err, delete_symref, ret = 0, flag = 0;
 
 	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
 	if (!lock)
 		return 1;
-	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		const char *path;
 
-		if (!(delopt & REF_NODEREF)) {
-			i = strlen(lock->lk->filename) - 5; /* .lock */
-			lock->lk->filename[i] = 0;
-			path = lock->lk->filename;
-		} else {
-			path = git_path("%s", refname);
-		}
-		err = unlink_or_warn(path);
+	/* The following variables are at play here:
+	 *  - refname may be a symref (in this case lock->orig_ref_name holds
+	 *    the symref name, and lock->ref_name holds the dereferenced name)
+	 *  - The dereferenced ref name (lock->ref_name) may be a loose ref, a
+	 *    packed ref, or both.
+	 *  - If REF_NODEREF is enabled - and refname is a symref, we should
+	 *    delete the symref; otherwise delete the dereferenced ref.
+	 */
+	delete_symref = (flag & REF_ISSYMREF && delopt & REF_NODEREF);
+	refname = delete_symref ? lock->orig_ref_name : lock->ref_name;
+
+	if (!(flag & REF_ISPACKED) || delete_symref) {
+		/* loose */
+		err = unlink_or_warn(git_path("%s", refname));
 		if (err && errno != ENOENT)
 			ret = 1;
-
-		if (!(delopt & REF_NODEREF))
-			lock->lk->filename[i] = '.';
 	}
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
 	 * without it.
 	 */
-	ret |= repack_without_ref(refname);
+	if (!delete_symref)
+		ret |= repack_without_ref(refname);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
 	invalidate_ref_cache(NULL);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f7ec203..e415ee0 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -85,7 +85,7 @@ test_expect_success \
 	"move $m (by HEAD)" \
 	"git update-ref HEAD $B $A &&
 	 test $B"' = $(cat .git/'"$m"')'
-test_expect_failure "delete $m (by HEAD) should remove both packed and loose $m" '
+test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
 	git update-ref -d HEAD $B &&
 	! grep "$m" .git/packed-refs &&
 	! test -f .git/$m
-- 
1.7.12.1.609.g5cd6968
