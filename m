Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C564F1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbcFXXKA (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:10:00 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52544 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbcFXXJj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:39 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BD123280A1;
	Fri, 24 Jun 2016 23:09:37 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809778;
	bh=F704bp3bRKDLwT0XJyGFoSnPDBWo7R22GwRNMFiXRU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zv8OG6CH9SsOw5UW79n8sb8z8a5jRzVZ5P9ugxpnkhV7PJoJ/F5Xek7HeAZHtvWIj
	 PIaGX8W3IeSMOeklH3MTod6lxxxccdHSSX1VNd/ypbJDBtMv/LJFWm5bnzH13N9HcR
	 uF80SS3SfkLbP2yChaySRTgAvy9hqqy6WH+fHAf1ZDZob/bg1HnlZnGpl07yQsX1Pu
	 sfmPmfM4z880CVA4LwXW1vAoo1iBJRhFTm6zas8Fpc0BjKBAqEKzOpdB1jpI3/1hbs
	 PK1jOFTub8ddPuqvUX95MLGlXNEyjJT4P9u6rMxlrzghVbFx1lTtm+LhjNPgqQuDdv
	 7pGUeiwYGZc/gGHaE5jVnwlARO2V152BwfNZD4HPrdiC8diAp2vJMUHxzWWXZnUiYN
	 B+62aLzxZyRCl5jlxJ/atsmpA8jCtmNqEJg6fQtrz2jKOWo2qKMSWySwOkrRdTeBAQ
	 GNkExRXrrNuhwPsLSWU3Op77RP4Q3Tw/9814FPMPdSU/A+86WXS
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 02/11] contrib/coccinelle: add basic Coccinelle transforms
Date:	Fri, 24 Jun 2016 23:09:20 +0000
Message-Id: <20160624230929.82222-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Coccinelle (http://coccinelle.lip6.fr/) is a program which performs
mechanical transformations on C programs using semantic patches.  These
semantic patches can be used to implement automatic refactoring and
maintenance tasks.

Add a set of basic semantic patches to convert common patterns related
to the struct object_id transformation, as well as a README.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/README          |  2 +
 contrib/coccinelle/object_id.cocci | 95 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 contrib/coccinelle/README
 create mode 100644 contrib/coccinelle/object_id.cocci

diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
new file mode 100644
index 00000000..9c2f8879
--- /dev/null
+++ b/contrib/coccinelle/README
@@ -0,0 +1,2 @@
+This directory provides examples of Coccinelle (http://coccinelle.lip6.fr/)
+semantic patches that might be useful to developers.
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
new file mode 100644
index 00000000..8ccdbb56
--- /dev/null
+++ b/contrib/coccinelle/object_id.cocci
@@ -0,0 +1,95 @@
+@@
+expression E1;
+@@
+- is_null_sha1(E1.hash)
++ is_null_oid(&E1)
+
+@@
+expression E1;
+@@
+- is_null_sha1(E1->hash)
++ is_null_oid(E1)
+
+@@
+expression E1;
+@@
+- sha1_to_hex(E1.hash)
++ oid_to_hex(&E1)
+
+@@
+expression E1;
+@@
+- sha1_to_hex(E1->hash)
++ oid_to_hex(E1)
+
+@@
+expression E1;
+@@
+- sha1_to_hex_r(E1.hash)
++ oid_to_hex_r(&E1)
+
+@@
+expression E1;
+@@
+- sha1_to_hex_r(E1->hash)
++ oid_to_hex_r(E1)
+
+@@
+expression E1;
+@@
+- hashclr(E1.hash)
++ oidclr(&E1)
+
+@@
+expression E1;
+@@
+- hashclr(E1->hash)
++ oidclr(E1)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1.hash, E2.hash)
++ oidcmp(&E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1->hash, E2->hash)
++ oidcmp(E1, E2)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1->hash, E2.hash)
++ oidcmp(E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1.hash, E2->hash)
++ oidcmp(&E1, E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1.hash, E2.hash)
++ oidcpy(&E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1->hash, E2->hash)
++ oidcpy(E1, E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1->hash, E2.hash)
++ oidcpy(E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1.hash, E2->hash)
++ oidcpy(&E1, E2)
