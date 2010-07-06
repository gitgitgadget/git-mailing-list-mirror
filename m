From: Greg Price <price@ksplice.com>
Subject: [PATCH v2] pack-refs: remove newly empty directories
Date: Tue,  6 Jul 2010 19:29:19 -0400
Message-ID: <1278458959-22252-1-git-send-email-price@ksplice.com>
References: <AANLkTilDcpdekvsw9b4TN8QNpubs6wkpibXdzz2AkTf-@mail.gmail.com>
Cc: git@vger.kernel.org, Greg Price <price@ksplice.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 01:29:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWHaK-00020z-1b
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 01:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab0GFX3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 19:29:41 -0400
Received: from c-71-192-160-118.hsd1.nh.comcast.net ([71.192.160.118]:36186
	"EHLO ksplice.lan" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755257Ab0GFX3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 19:29:40 -0400
Received: from price by ksplice.lan with local (Exim 4.69)
	(envelope-from <price@ksplice.com>)
	id 1OWHa5-0006fC-Ok; Tue, 06 Jul 2010 19:29:37 -0400
X-Mailer: git-send-email 1.6.6.32.g6380e
In-Reply-To: <AANLkTilDcpdekvsw9b4TN8QNpubs6wkpibXdzz2AkTf-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150417>

In a large repository which uses directories to organize many refs,
"git pack-refs --all --prune" does not improve performance so much
as it should, unless we remove all the now-empty directories as well.

Signed-off-by: Greg Price <price@ksplice.com>
---
This version removes empty grandparent directories, etc, but always
leaves in place refs/heads/ and its siblings.

We also tolerate duplicate slashes in refnames, because
check_ref_format() in refs.c does the same.

 pack-refs.c          |   30 ++++++++++++++++++++++++++++++
 t/t3210-pack-refs.sh |    6 ++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 7f43f8a..a935856 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -60,6 +60,35 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 	return 0;
 }
 
+/* Remove empty parents, but spare refs/ and immediate subdirs.
+   Note, munges *name. */
+static void try_remove_empty_parents(char *name)
+{
+	char *p, *q;
+	int i;
+	p = name;
+	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
+		while (*p && *p != '/')
+			p++;
+		/* tolerate duplicate slashes; see check_ref_format() */
+		while (*p == '/')
+			p++;
+	}
+	for (q = p; *q; q++)
+		;
+	while (1) {
+		while (q > p && *q != '/')
+			q--;
+		while (q > p && *(q-1) == '/')
+			q--;
+		if (q == p)
+			break;
+		*q = '\0';
+		if (rmdir(git_path("%s", name)))
+			break;
+	}
+}
+
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
@@ -68,6 +97,7 @@ static void prune_ref(struct ref_to_prune *r)
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
+		try_remove_empty_parents(r->name);
 	}
 }
 
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 413019a..ffd4e9f 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -60,6 +60,12 @@ test_expect_success 'see if git pack-refs --prune remove ref files' '
      ! test -f .git/refs/heads/f
 '
 
+test_expect_success 'see if git pack-refs --prune removes empty dirs' '
+     git branch r/s/t &&
+     git pack-refs --all --prune &&
+     ! test -e .git/refs/heads/r
+'
+
 test_expect_success \
     'git branch g should work when git branch g/h has been deleted' \
     'git branch g/h &&
-- 
1.6.6.32.g6380e
