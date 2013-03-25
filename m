From: Jeff King <peff@peff.net>
Subject: [PATCH 8/9] clone: die on errors from unpack_trees
Date: Mon, 25 Mar 2013 16:23:59 -0400
Message-ID: <20130325202359.GH16019@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 21:24:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDwW-0001Ym-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758556Ab3CYUYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:24:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39356 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112Ab3CYUYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:24:03 -0400
Received: (qmail 27961 invoked by uid 107); 25 Mar 2013 20:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:25:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:23:59 -0400
Content-Disposition: inline
In-Reply-To: <20130325201427.GA15798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219086>

When clone is populating the working tree, it ignores the
return status from unpack_trees; this means we may report a
successful clone, even when the checkout fails.

When checkout fails, we may want to leave the $GIT_DIR in
place, as it might be possible to recover the data through
further use of "git checkout" (e.g., if the checkout failed
due to a transient error, disk full, etc). However, we
already die on a number of other checkout-related errors, so
this patch follows that pattern.

In addition to marking a now-passing test, we need to adjust
t5710, which blindly assumed it could make bogus clones of
very deep alternates hierarchies. By using "--bare", we can
avoid it actually touching any objects.

Signed-off-by: Jeff King <peff@peff.net>
---
I think the "leave the data behind" fix may be to just set "junk_pid =
0" a little sooner in cmd_clone (i.e., before checkout()). Then we
would still die, but at least leave the fetched objects intact.

 builtin/clone.c              | 3 ++-
 t/t1060-object-corruption.sh | 2 +-
 t/t5710-info-alternate.sh    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index e0aaf13..7d48ef3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -579,7 +579,8 @@ static int checkout(void)
 	tree = parse_tree_indirect(sha1);
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
-	unpack_trees(1, &t, &opts);
+	if (unpack_trees(1, &t, &opts) < 0)
+		die(_("unable to checkout working tree"));
 
 	if (write_cache(fd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index eb285c0..05ba4e7 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -89,7 +89,7 @@ test_expect_success 'clone --local detects corruption' '
 	test_must_fail git clone --local bit-error corrupt-checkout
 '
 
-test_expect_failure 'clone --local detects missing objects' '
+test_expect_success 'clone --local detects missing objects' '
 	test_must_fail git clone --local missing missing-checkout
 '
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index aa04529..5a6e49d 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -58,7 +58,7 @@ git clone -l -s F G &&
 git clone -l -s D E &&
 git clone -l -s E F &&
 git clone -l -s F G &&
-git clone -l -s G H'
+git clone --bare -l -s G H'
 
 test_expect_success 'invalidity of deepest repository' \
 'cd H && {
-- 
1.8.2.13.g0f18d3c
