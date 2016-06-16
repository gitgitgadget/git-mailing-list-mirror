Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B2C1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbcFPJmr (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:42:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:55542 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753951AbcFPJmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:42:47 -0400
Received: (qmail 10306 invoked by uid 102); 16 Jun 2016 09:42:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:42:42 -0400
Received: (qmail 14527 invoked by uid 107); 16 Jun 2016 09:42:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:42:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:42:39 -0400
Date:	Thu, 16 Jun 2016 05:42:39 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] gpg-interface: check gpg signature creation status
Message-ID: <20160616094239.GG15851@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616093248.GA15130@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When we create a signature, it may happen that gpg returns with
"success" but not with an actual detached signature on stdout.

Check for the correct signature creation status to catch these cases
better. Really, --status-fd parsing is the only way to check gpg status
reliably. We do the same for verify already.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Jeff King <peff@peff.net>
---
Obviously the big change from your v3 is that this just passes the
buffer to pipe_command() instead of doing the read itself.

I changed the name of your "err" strbuf to "gpg_status" to be more
descriptive, and to match the similar usage on the verification side.

In the test, I bumped the config-setting inside the test, and used
test_config to get the automatic cleanup (using "git -c" would also have
worked).

I left the test description as-is, though it is a bit misleading. We are
not really checking for bad input anymore, but rather "did gpg send us
the special stats". Your fake "echo" fails on both counts, so the test
is still effective. A more robust test would be to output something that
_looked_ like real gpg output, but not to output the correct status
token.


 gpg-interface.c | 8 ++++++--
 t/t7004-tag.sh  | 9 ++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 74f08a2..08356f9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -153,9 +153,11 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
 	size_t i, j, bottom;
+	struct strbuf gpg_status = STRBUF_INIT;
 
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
+			 "--status-fd=2",
 			 "-bsau", signing_key,
 			 NULL);
 
@@ -167,10 +169,12 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
 	ret = pipe_command(&gpg, buffer->buf, buffer->len,
-			   signature, 1024, NULL, 0);
+			   signature, 1024, &gpg_status, 0);
 	sigchain_pop(SIGPIPE);
 
-	if (ret || signature->len == bottom)
+	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
+	strbuf_release(&gpg_status);
+	if (ret)
 		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f9b7d79..8b0f71a 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1202,10 +1202,17 @@ test_expect_success GPG,RFC1991 \
 # try to sign with bad user.signingkey
 git config user.signingkey BobTheMouse
 test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured' \
+	'git tag -s fails if gpg is misconfigured (bad key)' \
 	'test_must_fail git tag -s -m tail tag-gpg-failure'
 git config --unset user.signingkey
 
+# try to produce invalid signature
+test_expect_success GPG \
+	'git tag -s fails if gpg is misconfigured (bad signature format)' \
+	'test_config gpg.program echo &&
+	 test_must_fail git tag -s -m tail tag-gpg-failure'
+
+
 # try to verify without gpg:
 
 rm -rf gpghome
-- 
2.9.0.160.g4984cba
