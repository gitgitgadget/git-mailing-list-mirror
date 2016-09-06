Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9EB1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 08:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755115AbcIFICY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 04:02:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:60719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbcIFICV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 04:02:21 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mgc0l-1bSVvL0NnT-00NxjD; Tue, 06 Sep 2016 10:02:00
 +0200
Date:   Tue, 6 Sep 2016 10:01:59 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Unbreak interactive GPG prompt upon signing
Message-ID: <0b8196564ac9f1db7c59b42d7e0973ba1399ec52.1473148900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u2notH77iioGeh9XzDQnB8fCC0d6molotdH8GrXdAqZMxtggGwP
 g0Nq1EEAyktUDSOfUcoO4N8+7YJ+rj2jid42XgAuIRBdvcXifsivsPWmVo20uzdNrZNwS6I
 aw8lwbBWCHPSxV8sewj7Lh/PCzzDJQF9xqpkE0hL89zFS9gIGPhJT3kWGOoxJdy9ih+MXUy
 TsIfJS7MOKFPW0ozpJzdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cYRO9KMZudI=:PK0f81F8ppodisCyTIvgwL
 lOcstak6pgzoYI7yx8jppvjhHBdgwuI/3ML3lw7EZ++eZgwBIPcJmWwo/vFUhFJTCO5BnXUyv
 ZBkn/T833r7O+k3OfnMrJFtee7gNOO1Wbhds5JTgEtfTblJFtxQAiCC86RgoKjvz/dQMsggKd
 +jx4DhbjxUtzu+Q/CcSV6KVk0trU1g1fCcFAc6vYFBCwtI73QG/flPPdnAomgSqOi9VtjYzt2
 1GPoa6RwLj3Exa+xC9FV99DYrcdfG27zKKY+TUPeE3QQntrqgdGnZCPUfYDPmNQRQeNWdBxr/
 sYmNhoNt6ybo4CcGTCpyir6jAhKSqsnfuXmNZVuOnXqzfGG/+JKdeT5+RX6E7Ak08bGOEnzU2
 G8mI8d3XSAuVLurE/LL+GkUOtcjq4G+DtVXnoZcgfxLkT5wJVW9ORd3xbj/022jUzlqlxTEf+
 uua0LAh/jkR4aHxNDK/QxUD6AdXncqZ0lRYhKfa1amw4cGVpv5ME2yTDdkE2vM1GUYShHBgKQ
 UHN5aIy4STwUNRkq0fDyHdumW41oj3cFrx7ugZbKf3nVZUmYoZO4+kGVj24Pq5Emg4iacex5p
 1/8RA51feBWTWWsq0mrnxrQBpM9ZebBKtBlhkdCpvYcJIYRFliurl7SNDiJMUZVOQkvvCaaFF
 +Vlbefvtv0ajxANCeg9ER5kb78cbuAtvfRecsPcW4CkF7H8zrIk4Ub/aXA3VPSNTOKluX1QjY
 TxoqQgPcL10lqXvArl5EQSrLFnsP+pjCmPkLH90FdkIg0/nyZkVgi3QEzPUq9nAi94Bvvvc2y
 Kv+yDYs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the recent update in efee955 (gpg-interface: check gpg signature
creation status, 2016-06-17), we ask GPG to send all status updates to
stderr, and then catch the stderr in an strbuf.

But GPG might fail, and send error messages to stderr. And we simply
do not show them to the user.

Even worse: this swallows any interactive prompt for a passphrase. And
detaches stderr from the tty so that the passphrase cannot be read.

So while the first problem could be fixed (by printing the captured
stderr upon error), the second problem cannot be easily fixed, and
presents a major regression.

So let's just revert commit efee9553a4f97b2ecd8f49be19606dd4cf7d9c28.

This fixes https://github.com/git-for-windows/git/issues/871

Cc: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/fix-gpg-v1
Fetch-It-Via: git fetch https://github.com/dscho/git fix-gpg-v1

 gpg-interface.c | 8 ++------
 t/t7004-tag.sh  | 9 +--------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 8672eda..3f3a3f7 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -153,11 +153,9 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
 	size_t i, j, bottom;
-	struct strbuf gpg_status = STRBUF_INIT;
 
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
-			 "--status-fd=2",
 			 "-bsau", signing_key,
 			 NULL);
 
@@ -169,12 +167,10 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
 	ret = pipe_command(&gpg, buffer->buf, buffer->len,
-			   signature, 1024, &gpg_status, 0);
+			   signature, 1024, NULL, 0);
 	sigchain_pop(SIGPIPE);
 
-	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
-	strbuf_release(&gpg_status);
-	if (ret)
+	if (ret || signature->len == bottom)
 		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8b0f71a..f9b7d79 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1202,17 +1202,10 @@ test_expect_success GPG,RFC1991 \
 # try to sign with bad user.signingkey
 git config user.signingkey BobTheMouse
 test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured (bad key)' \
+	'git tag -s fails if gpg is misconfigured' \
 	'test_must_fail git tag -s -m tail tag-gpg-failure'
 git config --unset user.signingkey
 
-# try to produce invalid signature
-test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured (bad signature format)' \
-	'test_config gpg.program echo &&
-	 test_must_fail git tag -s -m tail tag-gpg-failure'
-
-
 # try to verify without gpg:
 
 rm -rf gpghome
-- 
2.10.0.windows.1.6.gc4f481a

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
