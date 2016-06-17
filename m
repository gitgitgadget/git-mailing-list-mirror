Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194E81F744
	for <e@80x24.org>; Fri, 17 Jun 2016 08:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbcFQIzF (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 04:55:05 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60072 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942AbcFQIzD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 04:55:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5777420B99;
	Fri, 17 Jun 2016 04:55:01 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 17 Jun 2016 04:55:01 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=w8io0xhYuVOsElg6dBdqgHw4tvw
	=; b=EvXf/7tAZQUt9f7GsONEonRjAeYoSapotpRXApFBPFN8IsMH9hkRSQTj0LM
	hZb7Rrq1MgkaK/F3NwIkNyIB5hr7jP9axSen1PQFw1CZMi24uUqbCme4oH+NiHeI
	HFGX5xtdDl8ZEioEuXUHon1JzNKfXokNjKgs1UTGO0lYI6EU=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=w8io
	0xhYuVOsElg6dBdqgHw4tvw=; b=sCO9qWBtpo2d3joFjuDdIEi51QGsLls1/FjN
	BCOyRuAasPz3G0nkUVMRgytF+Tzi21gPf73b0gYS6QEuOXNJbni0O30J4HmqCH0d
	p1r13/zY0zg7qZht2jCpvYHE9+UCcdPXtFE9OLQX3GtFmiCv9b21w9m1IICzZ5TI
	O0soAg8=
X-Sasl-enc: Q4XKkwnrNMNLCcu9TWKGORnHevipjGO8Fd+voQi3ZQZc 1466153700
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id CC38EF29FE;
	Fri, 17 Jun 2016 04:55:00 -0400 (EDT)
From:	Michael J Gruber <git@drmicha.warpmail.net>
To:	git@vger.kernel.org
Subject: [PATCHv2] Documentation/technical: push certificate format
Date:	Fri, 17 Jun 2016 10:54:59 +0200
Message-Id: <358c097f88671847e5003696a65d3a107aa2f59b.1466153557.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <b2557387aeea4b34da4a5b28e87063d1f2c9ff69.1466148698.git.git@drmicha.warpmail.net>
References: <b2557387aeea4b34da4a5b28e87063d1f2c9ff69.1466148698.git.git@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is the version describing the current state, not assuming any new
verify command for blobs.

 Documentation/technical/signature-format.txt | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 7afd403..1c21379 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -184,3 +184,54 @@ Date:   Wed Jun 15 09:13:29 2016 +0000
     # gpg:          There is no indication that the signature belongs to the owner.
     # Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
 ----
+
+== Push certificates
+
+- created by: `git push --signed`
+- payload: a push certificate header followed by the push transcript
+  (see pack-protocol.txt and below)
+- embedding: append the signature to the push transcript and pass it to receive hooks
+  via the environment (see below)
+- example: push of commit `dd1416f` updating `master` on `.` from `d36de3d`,
+  resulting in push certificate object `d4169b9`:
+
+----
+certificate version 0.1
+pusher C O Mitter <committer@example.com> 1465983405 +0000
+pushee .
+nonce 1465983405-07421dc1515c6f4d76d4
+
+d36de3db9b6a83076477254a3186b721a7bfaab7 dd1416f2cd1ec85957a9520a33e9053a133a775d refs/heads/master
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1
+
+iEYEABECAAYFAldhIa0ACgkQE7b1Hs3eQw2pGwCgmJs98xETSDZb6rooh/X7af3V
+zWgAn08ctVNga27jRkIdhFNetJy3x8De
+=WH0m
+-----END PGP SIGNATURE-----
+----
+
+- verify with: `gpg --verify <(git cat-file -p pushcert | sed -n '/-----BEGIN PGP/,$p') <(git cat-file -p pushcert | sed  '/-----BEGIN PGP/Q')`
+  (assuming the push certificate is stored in the blob tagged `pushcert`)
+
+----
+gpg: Signature made Wed Jun 15 11:36:45 2016 CEST using DSA key ID CDDE430D
+gpg: Good signature from "C O Mitter <committer@example.com>"
+----
+
+- pre- and post-receive hook input:
+
+----
+d36de3db9b6a83076477254a3186b721a7bfaab7 dd1416f2cd1ec85957a9520a33e9053a133a775d refs/heads/master
+----
+
+- pre- and post-receive hook environment:
+
+----
+GIT_PUSH_CERT_NONCE_STATUS=OK
+GIT_PUSH_CERT_KEY=13B6F51ECDDE430D
+GIT_PUSH_CERT=d4169b9a3c2674458f9656796132c145bbc5ba74
+GIT_PUSH_CERT_STATUS=G
+GIT_PUSH_CERT_SIGNER=C O Mitter <committer@example.com>
+GIT_PUSH_CERT_NONCE=1465983405-07421dc1515c6f4d76d4
+----
-- 
2.9.0.382.g87fd384

