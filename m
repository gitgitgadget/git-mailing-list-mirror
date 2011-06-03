From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] consider only branches in guess_remote_head
Date: Fri, 3 Jun 2011 01:11:13 -0400
Message-ID: <20110603051113.GB1008@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 07:11:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSMfJ-00087J-6h
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 07:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab1FCFLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 01:11:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35900
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab1FCFLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 01:11:15 -0400
Received: (qmail 4342 invoked by uid 107); 3 Jun 2011 05:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 01:11:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 01:11:13 -0400
Content-Disposition: inline
In-Reply-To: <20110603050901.GA883@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174998>

The guess_remote_head function tries to figure out where a
remote's HEAD is pointing by comparing the sha1 of the
remote's HEAD with the sha1 of various refs found on the
remote. However, we were too liberal in matching refs, and
would match tags or remote tracking branches, even though
these things could not possibly be referenced by the HEAD
symbolic ref (since git will detach when checking them out).

As a result, a clone of a remote repository with a detached
HEAD might write "refs/tags/*" into our local HEAD, which is
bogus. The resulting HEAD should be detached.

The other related code path is remote.c's get_head_names()
(which is used for, among other things, "set-head -a"). This was
not affected, however, as that function feeds only refs from
refs/heads to guess_remote_head.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c                  |    4 +++-
 t/t5707-clone-detached.sh |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index ca42a12..f073b1e 100644
--- a/remote.c
+++ b/remote.c
@@ -1667,7 +1667,9 @@ struct ref *guess_remote_head(const struct ref *head,
 
 	/* Look for another ref that points there */
 	for (r = refs; r; r = r->next) {
-		if (r != head && !hashcmp(r->old_sha1, head->old_sha1)) {
+		if (r != head &&
+		    !prefixcmp(r->name, "refs/heads/") &&
+		    !hashcmp(r->old_sha1, head->old_sha1)) {
 			*tail = copy_ref(r);
 			tail = &((*tail)->next);
 			if (!all)
diff --git a/t/t5707-clone-detached.sh b/t/t5707-clone-detached.sh
index fca8609..db4af95 100755
--- a/t/t5707-clone-detached.sh
+++ b/t/t5707-clone-detached.sh
@@ -41,7 +41,7 @@ test_expect_success 'cloned HEAD matches' '
 	git --git-dir=detached-tag/.git log -1 --format=%s >actual &&
 	test_cmp expect actual
 '
-test_expect_failure 'cloned HEAD is detached' '
+test_expect_success 'cloned HEAD is detached' '
 	head_is_detached detached-tag
 '
 
-- 
1.7.6.rc0.36.g5a0d
