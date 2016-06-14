From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] gpg-interface: check gpg signature for correct header
Date: Tue, 14 Jun 2016 14:05:05 +0200
Message-ID: <b057610446674c3323fbba09494229621ec4c032.1465905749.git.git@drmicha.warpmail.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, ZhenTian <loooseleaves@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 14:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCn5t-0001Iv-0M
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 14:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbcFNMFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 08:05:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50472 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376AbcFNMFI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 08:05:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 58ED5200C6;
	Tue, 14 Jun 2016 08:05:07 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 14 Jun 2016 08:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=E5T+6f/o5KiUoiTPXD0+h2m0vHQ
	=; b=XFdllYER6J6gq8PYQWHL9D7ZABHkcc+DJjLubIZu2eLQSgOPeMNdH9fjTul
	yoOs8UwkNkcqlAxEzduff626TUYB1szkEme4/ls9fOfoAH9mBUR49zY+baBHKfA+
	dOArxDNmIgkny1lKSm57+9Iq13ytF/1a6UNRJ7nb/FsnskY4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=E5T+
	6f/o5KiUoiTPXD0+h2m0vHQ=; b=kUweIP3+zCsOQ/Oy1TC5wUV3uxZiFen3gNGp
	ScdyIccbQwuJU/uXjcsl10KDy3tuD2ep3xZ47eLE98HHuElQv6PK2uuIqfRHLnGa
	8lybYZxN1LyBWQjsvDwCO1/oV7GuzROwUZH0P+hq7dVSscbzuSb8aSG1hwNdy4Ud
	JkzJ+ms=
X-Sasl-enc: A7ArshdM31f4ikIB7AUmN+qQyLQb7koLl3zgtlbAatqt 1465905906
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id D5137CCDAD;
	Tue, 14 Jun 2016 08:05:06 -0400 (EDT)
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297292>

When we create a signature, it may happen that gpg returns with
"success" but not with an actual detached signature on stdout.

Check for the correct header to catch these cases better. We use the
same parse_signature function for that that we use otherwise, so that
gpg specifics are localised there.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
So, this is the real thing.

Between you and me: parse_signature in fact is more lenient, but hey - it's
exactly as lenient as we are otherwise, bar running gpg --verify.

 gpg-interface.c |  2 +-
 t/t7004-tag.sh  | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c4b1e8c..784953c 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -185,7 +185,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 
 	sigchain_pop(SIGPIPE);
 
-	if (finish_command(&gpg) || !len || len < 0)
+	if (finish_command(&gpg) || !len || len < 0 || parse_signature(signature->buf, signature->len) == signature->len)
 		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f9b7d79..467e968 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1202,10 +1202,18 @@ test_expect_success GPG,RFC1991 \
 # try to sign with bad user.signingkey
 git config user.signingkey BobTheMouse
 test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured' \
+	'git tag -s fails if gpg is misconfigured (bad key)' \
 	'test_must_fail git tag -s -m tail tag-gpg-failure'
 git config --unset user.signingkey
 
+# try to produce invalid signature
+git config gpg.program echo
+test_expect_success GPG \
+	'git tag -s fails if gpg is misconfigured (bad signature format)' \
+	'test_must_fail git tag -s -m tail tag-gpg-failure'
+git config --unset gpg.program
+
+
 # try to verify without gpg:
 
 rm -rf gpghome
-- 
2.9.0.382.g87fd384
