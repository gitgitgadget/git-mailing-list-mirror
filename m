Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308671F462
	for <e@80x24.org>; Sun, 16 Jun 2019 18:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfFPSx6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 14:53:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60164 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726926AbfFPSx5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Jun 2019 14:53:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:159e:486:c87b:cfd7])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B4276074A;
        Sun, 16 Jun 2019 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560711236;
        bh=ws/Xhm5WN7RyZkcjH8yBrGszRMfK4DiJ2XCDXTGo2Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OvTqOr6V0bkn1f0JM3DFY8D6pT1Qj/tkjzKNuuolaHZj4Fc5JKA9PooM/mxQ9DCEm
         h0BCIJoHjtMfPszL/Xi4DusP5CGp3PN0HMNKt9wVF1OtZQOqQ4BTz7ENE+AaIWpHmI
         mLuJy0VjN3q7Z1+yOhfWBIULSkIAFxE6D0Cn617sdwG1PXkTRD8VFAGWXfXWB6HpGX
         oE5yWqjTIz6uwpeWk5BasOPoVO5DWm/YEhDZncevy4sguHcz60uclUiubw6FGv1NDB
         kVlxHDvThBX9yz5SfhgMGm/ERgJo0r56rtfXfcNc7TsW1XmsJDcEgtpnAx6UKk2Pkp
         mx+WQzAoQg0W2hbrq0e1bC8WimY/0CKb9GMYjViGmlOzWk2s2bwWMic+/EXpSuGJqC
         q9JqrdFGqmOZwT/IzRM+9qjwEwDn6Co6X3qh8zmTrwjpFheWW5otTbArhOo5sIIqtx
         xxJidKYkWOjdIrDsLHP/JsuR+NNGy/Utf+yO8spWtMlZALJeIXU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/10] t0027: make hash size independent
Date:   Sun, 16 Jun 2019 18:53:26 +0000
Message-Id: <20190616185330.549436-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5
In-Reply-To: <20190616185330.549436-1-sandals@crustytoothpaste.net>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several parts of this test generate files that have specific hard-coded
object IDs in them.  We don't really care about what the object ID in
question is, so we turn them all to zeros.

However, because some of these values are fixed and some are generated,
they can be of different lengths, which causes problems when running
with SHA-256.  Furthermore, some assertions in this test use only fixed
object IDs and some use both fixed and generated ones, so converting
only the expected results fixes some tests while breaking others.
Convert both actual and expected object IDs to the all-zeros object ID
of the appropriate length to ensure that the test passes when using
SHA-256.

The astute observer will notice that both tr and sed are used here.
Converting the tr call to a sed y/// command looks logical at first, but
it isn't possible because POSIX doesn't allow escapes in y/// commands
other than "\\" and "\n".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0027-auto-crlf.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 3587e454f1..959b6da449 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -15,8 +15,10 @@ compare_ws_file () {
 	pfx=$1
 	exp=$2.expect
 	act=$pfx.actual.$3
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
+	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
+		sed -e "s/0000*/$ZERO_OID/" >"$exp" &&
+	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" |
+		sed -e "s/0000*/$ZERO_OID/" >"$act" &&
 	test_cmp "$exp" "$act" &&
 	rm "$exp" "$act"
 }
