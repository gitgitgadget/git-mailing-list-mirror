Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3454C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 15:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiISPAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiISPAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 11:00:11 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75213D46
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:00:09 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B4F735A505;
        Mon, 19 Sep 2022 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663599608;
        bh=1dfsGSSKdZK8qw0x678emg/W+f83A6QwJH42HnoMQmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ecdMXJgJhH+P9iEcPq23/gX09A+wmvfPMVQfATfD+YEe3ysKLWbDrAlFiB5ZYmB0B
         2W3/oN2Ed58WaA7DH4v0xFgcoBQjlE0p2E6OMrBV7oO/2rC7sc3fHKqqIDjLb8bmlT
         cUYmuokxhsSQoIki4GORWXZzIRePLqK0xNEPkBG/n20AfZkBF0bOlZWOFkhX1cquX3
         yXJZ5dq2EUL+E+7S/9w4Q7AlM099tcDy6Wd/qORj59ND4szLDnlofoKbd8S383ms60
         sXHGFnnykQRV+uhC2q5GxdAlCBYlv0GO0qQgOdHLpl+sJ7+dt/2pQrVFPVIzieIa3X
         tNUvzPSRRvH4H9OMlJaRHmlE6wcWN9HW7NM5e+rx6Lvqzbk7DtJ9rHsIcKhK+cwK16
         ydIY9LlMU3BUSwkM+kbazO6obTWbAU0WCVkFJXodkczAgvADrhHS1eUMOdKUskY8PH
         bI2Y8Xq4B1xhppP+ZpkSpx1GIWCW6TRKk2+uuKeBYHAzdPWPJ7q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH 1/2] doc: specify a header for including arbitrary format-patch metadata
Date:   Mon, 19 Sep 2022 14:52:30 +0000
Message-Id: <20220919145231.48245-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a
In-Reply-To: <20220919145231.48245-1-sandals@crustytoothpaste.net>
References: <20220919145231.48245-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now, we lack a way to specify arbitrary metadata for format-patch.
We currently special-case the base-commit value, but this is not helpful
in the general case.  There has also been interest in specifying
signatures for transport between machines using mailing list patches.

In a future commit, we will define a format for the author and committer
data such that the email represents an opaque ID instead of an email.
As a practical matter, this makes it difficult to send patches, since
many mail servers will not accept arbitrary From lines.  Even using
in-body From headers is not suitable here because we will want to
include entries in the mailmap out-of-band as part of the patch.

To make this case more general and allow us to specify this information
in a more general way, let's add a metadata header which can be included
in the patch and allow specifying arbitrary values that we can then fill
in.  We explicitly specify an extension mechanism to allow others to use
this data in a time-tested way that avoids conflicts.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .../technical/format-patch-metadata.txt       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/technical/format-patch-metadata.txt

diff --git a/Documentation/technical/format-patch-metadata.txt b/Documentation/technical/format-patch-metadata.txt
new file mode 100644
index 0000000000..5448918da9
--- /dev/null
+++ b/Documentation/technical/format-patch-metadata.txt
@@ -0,0 +1,55 @@
+format-patch Metadata
+=====================
+
+Background
+----------
+
+The current format-patch data lacks a way to express general metadata that may
+be useful to synthesize the original commit more accurately.  This may be
+helpful to emit patches as a transport for actual commits between machines in a
+case where bundles are not practical, such as a mailing list.
+
+Syntax
+------
+
+The syntax contains three space-separated components: a field name, an encoding,
+and field data.
+
+The field name contains no spaces.  Values without an `@` are specified below or
+by a future version of Git.  Values containing an `@` followed by a domain are
+specified by that domain owner, much as algorithm names in the SSH protocol.
+
+The encoding is either `plain`, in which case the field data is a literal string
+with no spaces, or `base64`, in which case the field data is one or more
+space-separated base64 items, which when interpreted have all spaces stripped
+and are then encoded.  This allows fields to be specified that contain octets
+which are not valid in or which are too long to specified in an RFC 5322 header
+unencoded.
+
+Fields
+------
+
+base-commit-sha1::
+	This specifies the base commit for this patch using a SHA-1 object ID.
+base-commit-sha256::
+	This specifies the base commit for this patch using a SHA-256 object ID.
+	appropriate.
+gpgsig-sha1::
+	This specifies a signature for this patch using the SHA-1 format, as specified
+	in the `gpgsig` header.
+gpgsig-sha256::
+	This specifies the base commit for this patch using the SHA-256 object ID, as
+	specified in the `gpgsig-sha256` header.
+
+Examples
+--------
+
+----
+X-Git-Metadata: base-commit-sha1 plain da39a3ee5e6b4b0d3255bfef95601890afd80709
+
+X-Git-Metadata: gpgsig-sha256 base64
+  LS0tLS1CRUdJTiBTU0ggU0lHTkFUVVJFLS0tLS0KYmxhaCBibGFoIGJsYWgKLS0tLS1FTkQgU1NI
+  IFNJR05BVFVSRS0tLS0tCg==
+
+X-Git-Metadata: foo@example.com plain quux
+----
