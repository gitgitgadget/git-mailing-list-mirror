Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A0C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 20:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjB0U1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 15:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0U1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 15:27:52 -0500
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07D1FC6
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 12:27:50 -0800 (PST)
Received: from tilde.club (unknown [103.251.167.10])
        by tilde.club (Postfix) with ESMTPSA id 588FD220F7A6B;
        Mon, 27 Feb 2023 20:27:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 588FD220F7A6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1677529669; bh=3ebA3WpVKn821+q+uXmRZeK0dOZAPSuQQ/7IGoY/8Qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PonrxgtDwN68Vca2Hlb7CPz0EvVDRDXGv0ncoRNGEN9QA/sHesF0vPdj4tDysRwQe
         qWt/awjBnDMeUPlap+EKaQQwsJWWkdTHvUD08kPO9LNf+MRNqc9oc8cokyPfrSIzK1
         CJL30ktanLtncX94/6pBO4oGNCEJmMdemg60nYSc=
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: [PATCH v3] signature-format.txt: note SSH and X.509 signature delimiters
Date:   Mon, 27 Feb 2023 20:27:18 +0000
Message-Id: <20230227202718.173698-1-gwymor@tilde.club>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230210061611.124932-1-gwymor@tilde.club>
References: <20230210061611.124932-1-gwymor@tilde.club>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This document only explains PGP signatures, but Git now supports X.509
signatures as of 1e7adb9756 (gpg-interface: introduce new signature
format "x509" using gpgsm, 2018-07-17), and SSH signatures as of
29b315778e (ssh signing: add ssh key format and signing code,
2021-09-10).

Additionally, explain that these signature formats are controlled
`gpg.format`, linking to its documentation, and explain in said
`gpg.format` documentation that the underlying signature format is
documented in signature-format.txt.

Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
---
 Documentation/config/gpg.txt          |  3 +++
 Documentation/gitformat-signature.txt | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 86f6308c4c..37e2831cd5 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -12,6 +12,9 @@ gpg.program::
 gpg.format::
 	Specifies which key format to use when signing with `--gpg-sign`.
 	Default is "openpgp". Other possible values are "x509", "ssh".
++
+See linkgit:gitformat-signature[5] for the signature format, which differs
+based on the selected `gpg.format`.
 
 gpg.<format>.program::
 	Use this to customize the program used for the signing format you
diff --git a/Documentation/gitformat-signature.txt b/Documentation/gitformat-signature.txt
index d8e3eb1bac..d4d3a31f03 100644
--- a/Documentation/gitformat-signature.txt
+++ b/Documentation/gitformat-signature.txt
@@ -17,12 +17,24 @@ DESCRIPTION
 Git uses cryptographic signatures in various places, currently objects (tags,
 commits, mergetags) and transactions (pushes). In every case, the command which
 is about to create an object or transaction determines a payload from that,
-calls gpg to obtain a detached signature for the payload (`gpg -bsa`) and
-embeds the signature into the object or transaction.
+calls an external program to obtain a detached signature for the payload
+(`gpg -bsa` in the case of PGP signatures), and embeds the signature into the
+object or transaction.
 
-Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
-and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
-produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
+Signatures begin with an "ASCII Armor" header line and end with a tail line,
+which differ depending on signature type (as selected by `gpg.format`, see
+linkgit:git-config[1]). These are, for `gpg.format` values:
+
+`gpg` (PGP)::
+	`-----BEGIN PGP SIGNATURE-----` and `-----END PGP SIGNATURE-----`.
+	Or, if gpg is told to produce RFC1991 signatures,
+	`-----BEGIN PGP MESSAGE-----` and `-----END PGP MESSAGE-----`
+
+`ssh` (SSH)::
+	`-----BEGIN SSH SIGNATURE-----` and `-----END SSH SIGNATURE-----`
+
+`x509` (X.509)::
+	`-----BEGIN SIGNED MESSAGE-----` and `-----END SIGNED MESSAGE-----`
 
 Signatures sometimes appear as a part of the normal payload
 (e.g. a signed tag has the signature block appended after the payload
