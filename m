From: Jeff King <peff@peff.net>
Subject: [PATCH] apply: don't segfault on binary files with missing data
Date: Mon, 18 Oct 2010 14:39:17 -0400
Message-ID: <20101018183916.GA21988@sigill.intra.peff.net>
References: <20101018174031.GA9511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmFmYcOrbCBDYXJyw6k=?= <rafael.carre@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:38:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ubg-0003Ck-Vo
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757534Ab0JRSio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 14:38:44 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49623 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab0JRSin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 14:38:43 -0400
Received: (qmail 5741 invoked by uid 111); 18 Oct 2010 18:38:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 18 Oct 2010 18:38:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Oct 2010 14:39:17 -0400
Content-Disposition: inline
In-Reply-To: <20101018174031.GA9511@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159280>

Usually when applying a binary diff generated without
--binary, it will be rejected early, as we don't even have
the full sha1 of the pre- and post-images.

However, if the diff is generated with --full-index (but not
--binary), then we will actually try to apply it. If we have
the postimage blob, then we can take a shortcut and never
even look at the binary diff at all (e.g., this can happen
when rebasing changes within a repository).

If we don't have the postimage blob, though, we try to look
at the actual fragments, of which there are none, and get a
segfault. This patch checks explicitly for that case and
complains to the user instead of segfaulting. We need to
keep the check at a low level so that the "shortcut" case
above continues to work.

We also add a test that demonstrates the segfault. While
we're at it, let's also explicitly test the shortcut case.

Reported-by: Rafa=C3=ABl Carr=C3=A9 <rafael.carre@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/apply.c         |    6 ++++++
 t/t4103-apply-binary.sh |   27 ++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..f051e66 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2645,6 +2645,12 @@ static int apply_binary_fragment(struct image *i=
mg, struct patch *patch)
 	unsigned long len;
 	void *dst;
=20
+	if (!fragment)
+		return error("missing binary patch data for '%s'",
+			     patch->new_name ?
+			     patch->new_name :
+			     patch->old_name);
+
 	/* Binary patch is irreversible without the optional second hunk */
 	if (apply_in_reverse) {
 		if (!fragment->next)
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 9692f16..08ad6d8 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -37,7 +37,16 @@ test_expect_success 'setup' "
 	git diff-tree -p -C master binary >C.diff &&
=20
 	git diff-tree -p --binary master binary >BF.diff &&
-	git diff-tree -p --binary -C master binary >CF.diff
+	git diff-tree -p --binary -C master binary >CF.diff &&
+
+	git diff-tree -p --full-index master binary >B-index.diff &&
+	git diff-tree -p -C --full-index master binary >C-index.diff &&
+
+	git init other-repo &&
+	(cd other-repo &&
+	 git fetch .. master &&
+	 git reset --hard FETCH_HEAD
+	)
 "
=20
 test_expect_success 'stat binary diff -- should not fail.' \
@@ -100,6 +109,22 @@ test_expect_success 'apply binary diff (copy) -- s=
hould fail.' \
 	'do_reset &&
 	 test_must_fail git apply --index C.diff'
=20
+test_expect_success 'apply binary diff with full-index' '
+	do_reset &&
+	git apply B-index.diff
+'
+
+test_expect_success 'apply binary diff with full-index (copy)' '
+	do_reset &&
+	git apply C-index.diff
+'
+
+test_expect_success 'apply full-index binary diff in new repo' '
+	(cd other-repo &&
+	 do_reset &&
+	 test_must_fail git apply ../B-index.diff)
+'
+
 test_expect_success 'apply binary diff without replacement.' \
 	'do_reset &&
 	 git apply BF.diff'
--=20
1.7.3.1.227.ge6319.dirty
