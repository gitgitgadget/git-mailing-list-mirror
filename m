From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] pack-refs: prune top-level refs like "refs/foo"
Date: Sat, 23 Aug 2014 01:27:07 -0400
Message-ID: <20140823052707.GB18075@peff.net>
References: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 07:27:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL3rA-00072k-8g
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbaHWF1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:27:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:57241 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752030AbaHWF1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:27:09 -0400
Received: (qmail 13572 invoked by uid 102); 23 Aug 2014 05:27:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 00:27:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 01:27:07 -0400
Content-Disposition: inline
In-Reply-To: <20140823052334.GA17813@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255730>

After we have packed all refs, we prune any loose refs that
correspond to what we packed. We do so by first taking a
lock with lock_ref_sha1, and then deleting the loose ref
file.

However, lock_ref_sha1 will refuse to take a lock on any
refs that exist at the top-level of the "refs/" directory,
and we skip pruning the ref.  This is almost certainly not
what we want to happen here. The criteria to be pruned
should not differ from that to be packed; if a ref makes it
to prune_ref, it's because we want it both packed and
pruned (if there are refs you do not want to be packed, they
should be omitted much earlier by pack_ref_is_possible,
which we do in this case if --all is not given).

We can fix this by switching to lock_any_ref_for_update.
This behaves exactly the same with the exception of this
top-level check.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c               | 3 ++-
 t/t3210-pack-refs.sh | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 27927f2..82e5b1b 100644
--- a/refs.c
+++ b/refs.c
@@ -2387,7 +2387,8 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+	struct ref_lock *lock = lock_any_ref_for_update(r->name, r->sha1,
+							0, NULL);
 
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 1a2080e..3a017bf 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -151,4 +151,11 @@ test_expect_success 'delete ref while another dangling packed ref' '
 	test_cmp /dev/null result
 '
 
+test_expect_success 'pack ref directly below refs/' '
+	git update-ref refs/top HEAD &&
+	git pack-refs --all --prune &&
+	grep refs/top .git/packed-refs &&
+	test_path_is_missing .git/refs/top
+'
+
 test_done
-- 
2.1.0.346.ga0367b9
