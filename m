From: Greg Price <price@ksplice.com>
Subject: [PATCH] pack-refs: remove newly empty directories
Date: Mon,  5 Jul 2010 18:27:28 -0400
Message-ID: <1278368848-7037-1-git-send-email-price@ksplice.com>
Cc: git@vger.kernel.org, Greg Price <price@ksplice.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 01:14:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVurh-0005zP-Iq
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 01:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab0GEXON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 19:14:13 -0400
Received: from c-71-192-160-118.hsd1.nh.comcast.net ([71.192.160.118]:54975
	"EHLO ksplice.lan" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751524Ab0GEXON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 19:14:13 -0400
X-Greylist: delayed 2784 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2010 19:14:12 EDT
Received: from price by ksplice.lan with local (Exim 4.69)
	(envelope-from <price@ksplice.com>)
	id 1OVu8g-0001ts-RO; Mon, 05 Jul 2010 18:27:46 -0400
X-Mailer: git-send-email 1.6.6.32.g6380e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150301>

In a large repository which uses directories to organize many refs,
"git pack-refs --all --prune" does not improve performance so much
as it should, unless we remove all the now-empty directories as well.

Signed-off-by: Greg Price <price@ksplice.com>
---
 pack-refs.c          |    8 ++++++++
 t/t3210-pack-refs.sh |    6 ++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 7f43f8a..33d7358 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -63,11 +63,19 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
+	char *p, *q;
 	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
 
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
+
+		/* remove the directory if empty */
+		for (q = p = r->name; *p; p++)
+			if (*p == '/')
+				q = p;
+		*q = '\0';
+		rmdir(r->name);
 	}
 }
 
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 413019a..c60ede1 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -60,6 +60,12 @@ test_expect_success 'see if git pack-refs --prune remove ref files' '
      ! test -f .git/refs/heads/f
 '
 
+test_expect_success 'see if git pack-refs --prune removes empty dirs' '
+     git branch r/s &&
+     git pack-refs --all --prune &&
+     ! test -e .git/refs/heads/r
+'
+
 test_expect_success \
     'git branch g should work when git branch g/h has been deleted' \
     'git branch g/h &&
-- 
1.6.6.32.g6380e
