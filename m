From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] merge: merge unborn index before setting ref
Date: Fri, 25 Mar 2011 14:10:38 -0400
Message-ID: <20110325181038.GC14898@sigill.intra.peff.net>
References: <20110325180644.GA30838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: "igor.mikushkin" <igor.mikushkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:10:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BTC-0006FS-9i
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 19:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab1CYSKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 14:10:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36835
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257Ab1CYSKk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 14:10:40 -0400
Received: (qmail 16292 invoked by uid 107); 25 Mar 2011 18:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 14:11:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 14:10:38 -0400
Content-Disposition: inline
In-Reply-To: <20110325180644.GA30838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170010>

When we merge into an unborn branch, there are basically two
steps:

  1. Write the sha1 of the new commit into the ref pointed
     to by HEAD.

  2. Update the index with the new content, and check it out
     to the working tree.

We currently do them in this order. However, (2) is the step
that is much more likely to fail, since it can be blocked by
things like untracked working tree files. When it does, the
merge fails and we are left with an empty index but an
updated HEAD.

This patch switches the order, so that a failure in updating
the index leaves us unchanged. Of course, a failure in
updating the ref now leaves us with an updated index and
mis-matched HEAD. That is arguably not much better, but it
is probably less likely to actually happen.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this while diagnosing the pull problem fixed in 4/4. As
discused, this is just trading one set of error conditions for another.
The "right" thing to do is probably to rollback, but of course that can
fail, too, and it's more effort. I think in practice this is fine.

 builtin/merge.c            |    2 +-
 t/t7607-merge-overwrite.sh |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index aa3453c..c8d028c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1063,9 +1063,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
 		if (!remote_head)
 			die("%s - not something we can merge", argv[0]);
+		read_empty(remote_head->sha1, 0);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		read_empty(remote_head->sha1, 0);
 		return 0;
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index c86e298..b54e840 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -157,6 +157,10 @@ test_expect_success 'will not overwrite untracked file on unborn branch' '
 	test_cmp important c0.c
 '
 
+test_expect_success 'failed merge leaves unborn branch in the womb' '
+	test_must_fail git rev-parse --verify HEAD
+'
+
 test_expect_success 'set up unborn branch and content' '
 	git symbolic-ref HEAD refs/heads/unborn &&
 	rm -f .git/index &&
-- 
1.7.4.33.gb8855.dirty
