Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A001F744
	for <e@80x24.org>; Fri, 17 Jun 2016 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbcFQHqT (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 03:46:19 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60741 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754013AbcFQHqQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 03:46:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7F72720A87;
	Fri, 17 Jun 2016 03:46:15 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Jun 2016 03:46:15 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=xBzYKCwL1+8fEUhvRMczDwRyayc
	=; b=g9PuSujlKAI6Hy7yA+0BgHiXDCVMsyyr+h/dQsaG9GXjs5e1a1xoUxnZUdi
	VrkTRf+SwBcNdZ/em0ggxOIxsCa+9xmpaUbKrgyJKaHODOLytCI2Ou2Ef4dVgwRN
	W7DFCDwqWuzvU/nEovzuRr3B3gpA3TOiTaRn4xhxwfiCL0mI=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=xBzY
	KCwL1+8fEUhvRMczDwRyayc=; b=pUT2O8YY1d91MrRmtPFqW+pG9QNV2//Bb76O
	gAmLies681Jfc3OkcwbHlxXyQiEM2ZWF1Qir2Dz248kKjnIn3dEEQnbPnu2Rbtk9
	c6oqbx6lT4Yv+q+eklgymW3lSb2MDwklvo3qL6GsTqZkGYto/upfEYOJALztmRqZ
	bIUdRYo=
X-Sasl-enc: mTCo/xvkIvYIC32w3hKE0PzYEyrEjQJ1VCQFiztnmylX 1466149575
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 06C06CC021;
	Fri, 17 Jun 2016 03:46:14 -0400 (EDT)
From:	Michael J Gruber <git@drmicha.warpmail.net>
To:	git@vger.kernel.org
Subject: [PATCH 1/5] Documentation/technical: describe signature formats
Date:	Fri, 17 Jun 2016 09:46:08 +0200
Message-Id: <e1291ccb031f5da1935d7d0b8db57fe6ea951b2b.1466148698.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.9.0.382.g87fd384
In-Reply-To: <cover.1466148698.git.git@drmicha.warpmail.net>
References: <cover.1466148698.git.git@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We use different types of signature formats in different places.
Set up the infrastructure and overview to describe them systematically
in our technical documentation.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/Makefile                       |  1 +
 Documentation/technical/signature-format.txt | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/technical/signature-format.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 35c1385..b43d66e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -76,6 +76,7 @@ TECH_DOCS += technical/protocol-common
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
+TECH_DOCS += technical/signature-format
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
new file mode 100644
index 0000000..fda4fb8
--- /dev/null
+++ b/Documentation/technical/signature-format.txt
@@ -0,0 +1,17 @@
+Git signature format
+====================
+
+== Overview
+
+Git uses cryptographic signatures in various places, currently objects (tags,
+commits, mergetags) and transactions (pushes). In every case, the command which
+is about to create an object or transaction determines a payload from that,
+calls gpg to obtain a detached signature for the payload (`gpg -bsa`) and
+embeds the signature into the object or transaction.
+
+Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
+and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
+produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
+
+The signed payload and the way the signature is embedded depends
+on the type of the object resp. transaction.
-- 
2.9.0.382.g87fd384

