From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] push: fix local refs update if already up-to-date
Date: Tue, 4 Nov 2008 01:07:45 +0100
Message-ID: <20081104000745.GA28480@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 01:24:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx9iE-000475-PF
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 01:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbYKDAWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 19:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYKDAWs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 19:22:48 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:3890 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbYKDAWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 19:22:47 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2008 19:22:47 EST
Received: from darc.dyndns.org ([84.154.96.60]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Nov 2008 01:07:32 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Kx9SU-0003vM-0J; Tue, 04 Nov 2008 01:07:46 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Nov 2008 00:07:32.0800 (UTC) FILETIME=[55958C00:01C93E11]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100014>

git push normally updates local refs only after a successful push. If the
remote already has the updates -- pushed indirectly through another repository,
for example -- we forget to update local tracking refs.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

The hashcpy for new_ref is now executed more often than absolutely
necessary. But this is not a critical path, right? So I decided to keep
things simple.

 builtin-send-pack.c   |   11 +++++------
 t/t5516-fetch-push.sh |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 910db92..66ad492 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -224,7 +224,7 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 {
 	struct refspec rs;
 
-	if (ref->status != REF_STATUS_OK)
+	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
 		return;
 
 	rs.src = ref->name;
@@ -438,15 +438,15 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
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
@@ -474,14 +474,13 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
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
index f0030ad..d211f93 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -437,6 +437,24 @@ test_expect_success 'push updates local refs' '
 
 '
 
+test_expect_success 'push updates local refs (2)' '
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
 test_expect_success 'push does not update local refs on failure' '
 
 	rm -rf parent child &&
-- 
1.6.0.3
