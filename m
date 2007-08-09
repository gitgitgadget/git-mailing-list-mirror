From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] allow git-bundle to create bottomless bundle
Date: Wed, 08 Aug 2007 17:01:49 -0700
Message-ID: <7vps1xzic2.fsf_-_@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
	<20070808035946.GP9527@spearce.org>
	<Pine.LNX.4.64.0708081012110.14781@racer.site>
	<7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 02:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIvTR-0002ea-HS
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 02:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763155AbXHIABw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 20:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763318AbXHIABw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 20:01:52 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57297 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763155AbXHIABv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 20:01:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809000150.EQMP7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 20:01:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zc1p1X00d1kojtg0000000; Wed, 08 Aug 2007 20:01:50 -0400
In-Reply-To: <7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Aug 2007 12:09:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55400>

While "git bundle" was a useful way to sneakernet incremental
changes, we did not allow:

	$ git bundle create v2.6.20.bndl v2.6.20

to create a bundle that contains the whole history to a
well-known good revision.  Such a bundle can be mirrored
everywhere, and people can prime their repository with it to
reduce the load on the repository that serves near the tip of
the development.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > *1* Sheesh.  While I was writing this I noticed that the current
 >     'git bundle' is suitable only for incremental sneakernet but
 >     not for this particular use case.
 >
 >     $ git bundle create 2612.bndl v2.6.12
 >
 >     does not work, although
 >
 >     $ git bundle create 2612-2613.bndl v2.6.12..v2.6.13
 >
 >     does.  We need to fix this.

 Only very lightly tested, but the fix looks obvious enough.

 builtin-bundle.c |   10 +++++++++-
 t/t5510-fetch.sh |    8 ++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 6ae5ab0..cb439ca 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -208,6 +208,10 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	struct rev_info revs;
 	struct child_process rls;
 
+	/*
+	 * NEEDSWORK: this should use something like lock-file
+	 * to create temporary that is cleaned up upon error.
+	 */
 	bundle_fd = (!strcmp(path, "-") ? 1 :
 			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
 	if (bundle_fd < 0)
@@ -267,8 +271,12 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		 * Make sure the refs we wrote out is correct; --max-count and
 		 * other limiting options could have prevented all the tips
 		 * from getting output.
+		 *
+		 * Non commit objects such as tags and blobs do not have
+		 * this issue as they are not affected by those extra
+		 * constraints.
 		 */
-		if (!(e->item->flags & SHOWN)) {
+		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {
 			warning("ref '%s' is excluded by the rev-list options",
 				e->name);
 			continue;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 426017e..439430f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -145,4 +145,12 @@ test_expect_success 'bundle does not prerequisite objects' '
 	test 4 = $(git verify-pack -v bundle.pack | wc -l)
 '
 
+test_expect_success 'bundle should be able to create a full history' '
+
+	cd "$D" &&
+	git tag -a -m '1.0' v1.0 master &&
+	git bundle create bundle4 v1.0
+
+'
+
 test_done
