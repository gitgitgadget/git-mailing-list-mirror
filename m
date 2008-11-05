From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] push: fix local refs update if already up-to-date
Date: Wed,  5 Nov 2008 21:55:54 +0100
Message-ID: <1225918554-29722-2-git-send-email-drizzd@aon.at>
References: <20081105202849.GA9484@localhost>
 <1225918554-29722-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 21:57:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxpR0-0004pf-Pz
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 21:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbYKEUzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754723AbYKEUzn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 15:55:43 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:40326 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbYKEUzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 15:55:43 -0500
Received: from darc.dyndns.org ([84.154.100.25]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Nov 2008 21:55:40 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KxpPu-0007nn-Dq; Wed, 05 Nov 2008 21:55:54 +0100
X-Mailer: git-send-email 1.6.0.3.617.ge4eb0
In-Reply-To: <1225918554-29722-1-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 05 Nov 2008 20:55:41.0335 (UTC) FILETIME=[DD0AE270:01C93F88]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100183>

git push normally updates local refs only after a successful push. If the
remote already has the updates -- pushed indirectly through another repository,
for example -- we forget to update local tracking refs.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin-send-pack.c   |   11 +++++------
 t/t5516-fetch-push.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d68ce2d..c91c12f 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -230,7 +230,7 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 {
 	struct refspec rs;
 
-	if (ref->status != REF_STATUS_OK)
+	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
 		return;
 
 	rs.src = ref->name;
@@ -444,15 +444,15 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		}
 		else
 			new_sha1 = ref->peer_ref->new_sha1;
+		hashcpy(ref->new_sha1, new_sha1);
 
-
-		ref->deletion = is_null_sha1(new_sha1);
+		ref->deletion = is_null_sha1(ref->new_sha1);
 		if (ref->deletion && !allow_deleting_refs) {
 			ref->status = REF_STATUS_REJECT_NODELETE;
 			continue;
 		}
 		if (!ref->deletion &&
-		    !hashcmp(ref->old_sha1, new_sha1)) {
+		    !hashcmp(ref->old_sha1, ref->new_sha1)) {
 			ref->status = REF_STATUS_UPTODATE;
 			continue;
 		}
@@ -480,14 +480,13 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		    !ref->deletion &&
 		    !is_null_sha1(ref->old_sha1) &&
 		    (!has_sha1_file(ref->old_sha1)
-		      || !ref_newer(new_sha1, ref->old_sha1));
+		      || !ref_newer(ref->new_sha1, ref->old_sha1));
 
 		if (ref->nonfastforward && !ref->force && !args.force_update) {
 			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
 			continue;
 		}
 
-		hashcpy(ref->new_sha1, new_sha1);
 		if (!ref->deletion)
 			new_refs++;
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f0030ad..598664c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -437,6 +437,37 @@ test_expect_success 'push updates local refs' '
 
 '
 
+test_expect_success 'push updates up-to-date local refs' '
+
+	rm -rf parent child &&
+	mkdir parent &&
+	(cd parent && git init &&
+		echo one >foo && git add foo && git commit -m one) &&
+	git clone parent child1 &&
+	git clone parent child2 &&
+	(cd child1 &&
+		echo two >foo && git commit -a -m two &&
+		git push) &&
+	(cd child2 &&
+		git pull ../child1 master &&
+		git push &&
+	test $(git rev-parse master) = $(git rev-parse remotes/origin/master))
+
+'
+
+test_expect_success 'push preserves up-to-date packed refs' '
+
+	rm -rf parent child &&
+	mkdir parent &&
+	(cd parent && git init &&
+		echo one >foo && git add foo && git commit -m one) &&
+	git clone parent child &&
+	(cd child &&
+		git push &&
+	! test -f .git/refs/remotes/origin/master)
+
+'
+
 test_expect_success 'push does not update local refs on failure' '
 
 	rm -rf parent child &&
-- 
1.6.0.3.617.ge4eb0
