From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] do not force write of packed refs
Date: Wed,  5 Nov 2008 21:55:53 +0100
Message-ID: <1225918554-29722-1-git-send-email-drizzd@aon.at>
References: <20081105202849.GA9484@localhost>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 21:57:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxpR2-0004pf-0t
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 21:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbYKEUzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 15:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755382AbYKEUzr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 15:55:47 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:40326 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053AbYKEUzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 15:55:44 -0500
Received: from darc.dyndns.org ([84.154.100.25]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Nov 2008 21:55:40 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KxpPu-0007nk-D9; Wed, 05 Nov 2008 21:55:54 +0100
X-Mailer: git-send-email 1.6.0.3.617.ge4eb0
In-Reply-To: <20081105202849.GA9484@localhost>
X-OriginalArrivalTime: 05 Nov 2008 20:55:41.0523 (UTC) FILETIME=[DD279230:01C93F88]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100182>

We force writing a ref if it does not exist. Originally, we only had to look
for the ref file to check if it existed. Now we have to look for a packed ref
as well. Luckily, resolve_ref already does all the work for us.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 refs.c               |    7 ++++---
 t/t3210-pack-refs.sh |    7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 0a126fa..fc8105d 100644
--- a/refs.c
+++ b/refs.c
@@ -794,10 +794,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	char *ref_file;
 	const char *orig_ref = ref;
 	struct ref_lock *lock;
-	struct stat st;
 	int last_errno = 0;
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
+	int inexistent = 0;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -825,12 +825,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 			orig_ref, strerror(errno));
 		goto error_return;
 	}
+	inexistent = is_null_sha1(lock->old_sha1);
 	/* When the ref did not exist and we are creating it,
 	 * make sure there is no existing ref that is packed
 	 * whose name begins with our refname, nor a ref whose
 	 * name is a proper prefix of our refname.
 	 */
-	if (is_null_sha1(lock->old_sha1) &&
+	if (inexistent &&
             !is_refname_available(ref, NULL, get_packed_refs(), 0))
 		goto error_return;
 
@@ -844,7 +845,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	lock->ref_name = xstrdup(ref);
 	lock->orig_ref_name = xstrdup(orig_ref);
 	ref_file = git_path("%s", ref);
-	if (lstat(ref_file, &st) && errno == ENOENT)
+	if (inexistent)
 		lock->force_write = 1;
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 087ef75..413019a 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -96,6 +96,13 @@ test_expect_success \
      git branch -d n/o/p &&
      git branch n'
 
+test_expect_success \
+	'see if up-to-date packed refs are preserved' \
+	'git branch q &&
+	 git pack-refs --all --prune &&
+	 git update-ref refs/heads/q refs/heads/q &&
+	 ! test -f .git/refs/heads/q'
+
 test_expect_success 'pack, prune and repack' '
 	git tag foo &&
 	git pack-refs --all --prune &&
-- 
1.6.0.3.617.ge4eb0
