From: Jeff King <peff@peff.net>
Subject: [PATCH] shortlog: ignore commits with missing authors
Date: Wed, 18 Sep 2013 17:14:00 -0400
Message-ID: <20130918211400.GA23856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 23:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMP4f-0006IY-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3IRVOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 17:14:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:57408 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab3IRVOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 17:14:08 -0400
Received: (qmail 29240 invoked by uid 102); 18 Sep 2013 21:14:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 16:14:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 17:14:00 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234996>

From: Jeff King <peff@peff.net>

Most of git's traversals are robust against minor breakages
in commit data. For example, "git log" will still output an
entry for a commit that has a broken encoding or missing
author, and will not abort the whole operation.

Shortlog, on the other hand, will die as soon as it sees a
commit without an author, meaning that a repository with
a broken commit cannot get any shortlog output at all.

Let's downgrade this fatal error to a warning, and continue
the operation.

We simply ignore the commit and do not count it in the total
(since we do not have any author under which to file it).
Alternatively, we could output some kind of "<empty>" record
to collect these bogus commits. It is probably not worth it,
though; we have already warned to stderr, so the user is
aware that such bogosities exist, and any placeholder we
came up with would either be syntactically invalid, or would
potentially conflict with real data.

Signed-off-by: Jeff King <peff@peff.net>
---
The real-world breakage I saw that caused this was not a missing author
line, but rather a commit that was in proper utf8, but whose encoding
header said "utf16". We can tweak the test to reproduce the exact case
by making the sed line:

  sed "/^\$/iencoding utf16" commit.tmp >broken.tmp

But I think that may be less portable, as systems with iconv that does
not understand "utf16" might leave the text intact. Simply removing the
author line, as the test below does, has the same effect.

 builtin/shortlog.c  |  6 ++++--
 t/t4201-shortlog.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index ae73d17..c226f76 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -127,9 +127,11 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 			author = buffer + 7;
 		buffer = eol;
 	}
-	if (!author)
-		die(_("Missing author: %s"),
+	if (!author) {
+		warning(_("Missing author: %s"),
 		    sha1_to_hex(commit->object.sha1));
+		return;
+	}
 	if (log->user_format) {
 		struct pretty_print_context ctx = {0};
 		ctx.fmt = CMIT_FMT_USERFORMAT;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 5493500..4286699 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -172,4 +172,20 @@ test_cmp expect out'
 	git shortlog HEAD~2.. > out &&
 test_cmp expect out'
 
+test_expect_success 'shortlog ignores commits with missing authors' '
+	git commit --allow-empty -m normal &&
+	git commit --allow-empty -m soon-to-be-broken &&
+	git cat-file commit HEAD >commit.tmp &&
+	sed "/^author/d" commit.tmp >broken.tmp &&
+	commit=$(git hash-object -w -t commit --stdin <broken.tmp) &&
+	git update-ref HEAD $commit &&
+	cat >expect <<-\EOF &&
+	A U Thor (1):
+	      normal
+
+	EOF
+	git shortlog HEAD~2.. >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.rc4.16.g228394f
