From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t7501: fix "empty commit" test with NO_PERL
Date: Thu, 23 Jan 2014 14:54:57 -0500
Message-ID: <20140123195456.GA31871@sigill.intra.peff.net>
References: <20140123195404.GA31314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 20:55:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QNB-0005Z0-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbaAWTy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:54:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:37690 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751710AbaAWTy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:54:58 -0500
Received: (qmail 27143 invoked by uid 102); 23 Jan 2014 19:54:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 13:54:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 14:54:57 -0500
Content-Disposition: inline
In-Reply-To: <20140123195404.GA31314@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240934>

t7501.9 tries to check that "git commit" will fail when the
index is unchanged. It relies on previous tests not to have
modified the index. When it was originally written, this was
always the case. However, commit c65dc35 (t7501: test the
right kind of breakage, 2012-03-30) changed earlier tests (4
and 5) to leave a modification in the index.

We never noticed, however, because t7501.7, between the two,
clears the index state as a side effect. However, that test
depends on the PERL prerequisite, and so it does not always
run. Therefore if NO_PERL is set, we do not run the
intervening test, the index is left unclean, and t7501.9
fails.

We could fix this by moving t7501.9 up in the script.
However, this patch instead leaves it in place and adds a
"git reset" before the commit. This makes the test more
explicit about its preconditions, and will future-proof it
against any other changes in the test state.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7501-commit.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index f04798f..94eec83 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -57,6 +57,7 @@ test_expect_success 'using invalid commit with -C' '
 '
 
 test_expect_success 'nothing to commit' '
+	git reset --hard &&
 	test_must_fail git commit -m initial
 '
 
-- 
1.8.5.2.500.g8060133
