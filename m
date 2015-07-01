From: Jeff King <peff@peff.net>
Subject: [PATCH] rev-list: disable --use-bitmap-index when pruning commits
Date: Wed, 1 Jul 2015 14:42:17 -0400
Message-ID: <20150701184217.GA8079@peff.net>
References: <1435742651-15053-1-git-send-email-lawrencesiebert@gmail.com>
 <xmqqd20bc3cj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:42:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMy7-0004Ls-SW
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbbGASmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:42:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:54422 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753786AbbGASmU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:42:20 -0400
Received: (qmail 13415 invoked by uid 102); 1 Jul 2015 18:42:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jul 2015 13:42:20 -0500
Received: (qmail 27261 invoked by uid 107); 1 Jul 2015 18:42:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jul 2015 14:42:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jul 2015 14:42:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd20bc3cj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273178>

On Wed, Jul 01, 2015 at 08:19:40AM -0700, Junio C Hamano wrote:

> Sounds good.  While at it, perhaps add a mention (perhaps by
> creating a BUGS section at the end of the file) that --count
> with --use-bitmap-index ignores pathspec silently?

I think we can just fix it rather than documenting the problem. :)

-- >8 --
Subject: rev-list: disable --use-bitmap-index when pruning commits

The reachability bitmaps do not have enough information to
tell us which commits might have changed path "foo", so the
current code produces wrong answers for:

  git rev-list --use-bitmap-index --count HEAD -- foo

(it silently ignores the "foo" limiter). Instead, we should
fall back to doing a normal traversal (it is OK to fall
back rather than complain, because --use-bitmap-index is a
pure optimization, and might not kick in for other reasons,
such as there being no bitmaps in the repository).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c      | 2 +-
 t/t5310-pack-bitmaps.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..88eddbd 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -355,7 +355,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list)
 		revs.limited = 1;
 
-	if (use_bitmap_index) {
+	if (use_bitmap_index && !revs.prune) {
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
 			uint32_t commit_count;
 			if (!prepare_bitmap_walk(&revs)) {
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6003490..d446706 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -53,6 +53,12 @@ rev_list_tests() {
 		test_cmp expect actual
 	'
 
+	test_expect_success "counting commits with limiting ($state)" '
+		git rev-list --count HEAD -- 1.t >expect &&
+		git rev-list --use-bitmap-index --count HEAD -- 1.t >actual &&
+		test_cmp expect actual
+	'
+
 	test_expect_success "enumerate --objects ($state)" '
 		git rev-list --objects --use-bitmap-index HEAD >tmp &&
 		cut -d" " -f1 <tmp >tmp2 &&
-- 
2.5.0.rc0.336.g8460790
