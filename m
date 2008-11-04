From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] push: fix local refs update if already up-to-date
Date: Tue, 4 Nov 2008 21:57:43 +0100
Message-ID: <20081104205743.GA26788@localhost>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:59:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxSzv-00051C-Va
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 21:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbYKDU5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 15:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbYKDU5m
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 15:57:42 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:9626 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbYKDU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 15:57:41 -0500
Received: from darc.dyndns.org ([84.154.77.179]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Nov 2008 21:57:37 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KxSy7-0007nx-M5; Tue, 04 Nov 2008 21:57:43 +0100
Content-Disposition: inline
In-Reply-To: <20081104042643.GA31276@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Nov 2008 20:57:39.0675 (UTC) FILETIME=[F92A62B0:01C93EBF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100105>

git push normally updates local refs only after a successful push. If the
remote already has the updates -- pushed indirectly through another repository,
for example -- we forget to update local tracking refs.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Mon, Nov 03, 2008 at 11:26:44PM -0500, Jeff King wrote:
> Nit: Just reading the test, it is hard to see what is interesting about
> it (though obviously I can blame it back to your commit :) ). Maybe a
> more descriptive title like 'push updates uptodate local refs' would
> make sense.

That is all I changed in this update. Pending an Ack/Nack from Jeff I feel
that I'm done.

 builtin-send-pack.c   |   11 +++++------
 t/t5516-fetch-push.sh |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

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
index f0030ad..a82ce5a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -437,6 +437,24 @@ test_expect_success 'push updates local refs' '
 
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
 test_expect_success 'push does not update local refs on failure' '
 
 	rm -rf parent child &&
-- 
1.6.0.3.617.ge4eb0
