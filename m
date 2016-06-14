From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Tue, 14 Jun 2016 16:44:18 +0200
Message-ID: <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, ZhenTian <loooseleaves@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 16:44:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCpZu-00036a-TM
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 16:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbcFNOo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 10:44:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42182 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035AbcFNOo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 10:44:26 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 7880D20794;
	Tue, 14 Jun 2016 10:44:20 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 14 Jun 2016 10:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=nDGopZaLT3bn1RXhYXYLBT2ouTw
	=; b=i/pxhnRfGgqEvDdhLeFUAXoXP2hlU0pQE1UPd4nH5dZhfIMM8IULYI7E1x/
	43itGKgnKTuevGUKWcIX6ua16vP95haQnaRqxKjPGWDc2isnxoo1o4C+q8FjOTc1
	hCUKXBnwJkxcKtRmgovbu1WcD7Rndd0BR2ptl0uDT7Yr9hyY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=nDGo
	pZaLT3bn1RXhYXYLBT2ouTw=; b=O+AdeYs/kBFK9KEjDy1uWDcCQBCWbGNeuXmc
	GmGqFVr/t2l1zUU8XIfKWioV13rip6jx42LkWxBFeDaQjBC+IEZS2coF09qQo15/
	6cmLz8WnlRz6rc+Anyc6Z+sWMVPuCA1RPHuxaEFuNUDtERg1vYiP1RS68N9YvCj7
	p6gZofQ=
X-Sasl-enc: QiLiWU1tcnpFo5S2T9PuGT0+ndSlJCygYU4lNPiefWLV 1465915459
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id E1A50CCDB2;
	Tue, 14 Jun 2016 10:44:19 -0400 (EDT)
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297295>

When we create a signature, it may happen that gpg returns with
"success" but not with an actual detached signature on stdout.

Check for the correct signature creation status to catch these cases
better. Really, --status-fd parsing is the only way to check gpg status
reliably. We do the same for verify already.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
That must be the real real thing now...

 gpg-interface.c | 22 +++++++++++++++-------
 t/t7004-tag.sh  | 10 +++++++++-
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c4b1e8c..850dc81 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -150,17 +150,19 @@ const char *get_signing_key(void)
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
-	const char *args[4];
-	ssize_t len;
+	const char *args[5];
 	size_t i, j, bottom;
+	struct strbuf err = STRBUF_INIT;
 
 	gpg.argv = args;
 	gpg.in = -1;
 	gpg.out = -1;
+	gpg.err = -1;
 	args[0] = gpg_program;
-	args[1] = "-bsau";
-	args[2] = signing_key;
-	args[3] = NULL;
+	args[1] = "--status-fd=2";
+	args[2] = "-bsau";
+	args[3] = signing_key;
+	args[4] = NULL;
 
 	if (start_command(&gpg))
 		return error(_("could not run gpg."));
@@ -174,19 +176,25 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	if (write_in_full(gpg.in, buffer->buf, buffer->len) != buffer->len) {
 		close(gpg.in);
 		close(gpg.out);
+		close(gpg.err);
 		finish_command(&gpg);
 		return error(_("gpg did not accept the data"));
 	}
 	close(gpg.in);
 
 	bottom = signature->len;
-	len = strbuf_read(signature, gpg.out, 1024);
+	strbuf_read(signature, gpg.out, 1024);
+	strbuf_read(&err, gpg.err, 0);
 	close(gpg.out);
+	close(gpg.err);
 
 	sigchain_pop(SIGPIPE);
 
-	if (finish_command(&gpg) || !len || len < 0)
+	if (finish_command(&gpg) || !strstr(err.buf, "\n[GNUPG:] SIG_CREATED ")) {
+		strbuf_release(&err);
 		return error(_("gpg failed to sign the data"));
+	}
+	strbuf_release(&err);
 
 	/* Strip CR from the line endings, in case we are on Windows. */
 	for (i = j = bottom; i < signature->len; i++)
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
