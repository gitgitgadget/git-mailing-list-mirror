From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] tag: don't show non-tag contents with "-n"
Date: Mon, 6 Feb 2012 03:14:56 -0500
Message-ID: <20120206081456.GC3966@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:15:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJjD-0008H6-Le
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab2BFIO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:14:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58685
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240Ab2BFIO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:14:58 -0500
Received: (qmail 25156 invoked by uid 107); 6 Feb 2012 08:22:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 03:22:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 03:14:56 -0500
Content-Disposition: inline
In-Reply-To: <20120206081119.GA3939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190044>

When given "-n", tag will show one or more lines of the body
of an annotated tag. However, we never actually checked to
see that what we got was a tag; we might end up showing
random lines from a lightweight-tagged blob or commit.

With this patch, we'll show lines only from tag objects (but
still include non-tag objects in the listing). It might make
more sense to omit lightweight tags from the listing
entirely when "-n" is in effect. I stuck with this behavior
because it is slightly more compatible with the original
behavior.

This might be seen as a regression for people with
lightweight tags to commit, who would previously get the
subject line of the commit. The code seems to indicate that
is not expected (since it does things like parsing off
gpg signatures), but it's possible somebody has been relying
on it.

Signed-off-by: Jeff King <peff@peff.net>
---
The regression comment above makes me a little nervous. Still, if we
want to handle commits, we should do so explicitly and not munge them
with parse_signature. So I think it's a step in the right direction, and
we should let it cook for a bit and see if anybody complains.

 builtin/tag.c  |    2 +-
 t/t7004-tag.sh |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1bb42a4..0a7c174 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -94,7 +94,7 @@ static void show_tag_lines(const unsigned char *sha1, int lines)
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
 		die_errno("unable to read object %s", sha1_to_hex(sha1));
-	if (!size) {
+	if (!size || type != OBJ_TAG) {
 		free(buf);
 		return;
 	}
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e93ac73..0db0f6a 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -586,6 +586,19 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+test_expect_success 'annotations for non-tags are empty' '
+	blob=$(git hash-object -w --stdin <<-\EOF
+	Blob paragraph 1.
+
+	Blob paragraph 2.
+	EOF
+	) &&
+	git tag tag-blob $blob &&
+	echo "tag-blob        " >expect &&
+	git tag -n1 -l tag-blob >actual &&
+	test_cmp expect actual
+'
+
 # trying to verify annotated non-signed tags:
 
 test_expect_success GPG \
-- 
1.7.9.rc1.29.g43677
