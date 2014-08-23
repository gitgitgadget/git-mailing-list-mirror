From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] fast-import: stop using lock_ref_sha1
Date: Sat, 23 Aug 2014 01:33:22 -0400
Message-ID: <20140823053322.GE18075@peff.net>
References: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 07:33:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL3x9-0002AK-Nj
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbaHWFdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:33:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:57255 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751976AbaHWFdX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:33:23 -0400
Received: (qmail 13897 invoked by uid 102); 23 Aug 2014 05:33:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 00:33:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 01:33:22 -0400
Content-Disposition: inline
In-Reply-To: <20140823052334.GA17813@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255733>

We can use lock_any_ref_for_update instead. Besides being
more flexible, the only difference between the two is that
lock_ref_sha1 does not allow "top-level" refs like
"refs/foo" to be updated. However, we know that we do not
have such a ref, because we explicitly add the "tags/"
prefix ourselves.

Note that we now must feed the whole name "refs/tags/X"
instead of just "tags/X" to the function. As a result, our
failure error message is uses the longer name. This is
probably a good thing, though.

As an interesting side note, if we forgot to switch this
input to the function, the tests do not currently catch it.
We import a tag "X" and then check that we can access it at
"tags/X". If we accidentally created "tags/X" at the
top-level $GIT_DIR instead of under "refs/", we would still
find it due to our ref lookup procedure!

We do not make such a mistake in this patch, of course, but
while we're thinking about it, let's make the fast-import
tests more robust by checking for fully qualified
refnames.

Signed-off-by: Jeff King <peff@peff.net>
---
As I mentioned, I'd be OK with dropping this one in favor of just
waiting for Ronnie's transaction patches to graduate.

 fast-import.c          | 4 ++--
 t/t9300-fast-import.sh | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a1479e9..04a85a4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1738,8 +1738,8 @@ static void dump_tags(void)
 
 	for (t = first_tag; t; t = t->next_tag) {
 		strbuf_reset(&ref_name);
-		strbuf_addf(&ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name.buf, NULL);
+		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
+		lock = lock_any_ref_for_update(ref_name.buf, NULL, 0, NULL);
 		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
 			failure |= error("Unable to update %s", ref_name.buf);
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5fc9ef2..f4c6673 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -153,7 +153,7 @@ tag series-A
 An annotated tag without a tagger
 EOF
 test_expect_success 'A: verify tag/series-A' '
-	git cat-file tag tags/series-A >actual &&
+	git cat-file tag refs/tags/series-A >actual &&
 	test_cmp expect actual
 '
 
@@ -165,7 +165,7 @@ tag series-A-blob
 An annotated tag that annotates a blob.
 EOF
 test_expect_success 'A: verify tag/series-A-blob' '
-	git cat-file tag tags/series-A-blob >actual &&
+	git cat-file tag refs/tags/series-A-blob >actual &&
 	test_cmp expect actual
 '
 
@@ -232,8 +232,8 @@ EOF
 test_expect_success \
 	'A: tag blob by sha1' \
 	'git fast-import <input &&
-	git cat-file tag tags/series-A-blob-2 >actual &&
-	git cat-file tag tags/series-A-blob-3 >>actual &&
+	git cat-file tag refs/tags/series-A-blob-2 >actual &&
+	git cat-file tag refs/tags/series-A-blob-3 >>actual &&
 	test_cmp expect actual'
 
 test_tick
-- 
2.1.0.346.ga0367b9
