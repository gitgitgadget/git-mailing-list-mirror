Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53741F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfBSAGb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732200AbfBSAFx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D8CF261092;
        Tue, 19 Feb 2019 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534752;
        bh=AKJws+q6ssiLC0vGt7JoLJPhSwxoO7sqP72foWMRhw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fB2sGAMdO80+Sjrhmeik5kA7nzcrWwpTLrZ776SJvXPdTUrHFAKINJKCGIS29pyzm
         /k4xPsyphDp2a4mS4px82XzZzAE1GSvlq/Iq5CbEC2E0WvWWQ5bzPvaT04KiMLMT38
         pbnrfLmpDCqUNu3dQvAx+XCpvHmonagb8+2t0afq8vHHkfVKjdk9zeJrcrLSEAbC7M
         oIBC799ydKIAeWLUJmgtE+NCKesZGmLzELh3ZURtYpC3ppKlyjFA0RzjVxaFLNxKiM
         E9s54rE5P6/WxSJAsADWEeDME+6de27v9TpV0CDs+LHngZUBN+Pcw0k9pHh5xo6/I0
         OdIavFK0i8a/AQugTSaF26A+iQRsxLcL0/jFl8IZFfNxa1J6/Bod+OQDqW5+vf6prf
         ljLxK/9VfdrQ+1Rk/pwhM7qcsTREaya69hCfXETFEoSDuKFutDEF3IlL8F8Z0wYV+M
         LL/I3d+MknQHegEjlogRxh73QsJpfJL8sD4qDgxee8VPNMjKQW+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 13/35] builtin/name-rev: make hash-size independent
Date:   Tue, 19 Feb 2019 00:05:04 +0000
Message-Id: <20190219000526.476553-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the_hash_algo when parsing instead of GIT_SHA1_HEXSZ so that this
function works with any size hash.  Rename the variable forty to
counter, as this is a better name and is independent of the hash size.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/name-rev.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f1cb45c227..05ccf53e00 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -361,23 +361,25 @@ static char const * const name_rev_usage[] = {
 static void name_rev_line(char *p, struct name_ref_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int forty = 0;
+	int counter = 0;
 	char *p_start;
+	const unsigned hexsz = the_hash_algo->hexsz;
+
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
 		if (!ishex(*p))
-			forty = 0;
-		else if (++forty == GIT_SHA1_HEXSZ &&
+			counter = 0;
+		else if (++counter == hexsz &&
 			 !ishex(*(p+1))) {
 			struct object_id oid;
 			const char *name = NULL;
 			char c = *(p+1);
 			int p_len = p - p_start + 1;
 
-			forty = 0;
+			counter = 0;
 
 			*(p+1) = 0;
-			if (!get_oid(p - (GIT_SHA1_HEXSZ - 1), &oid)) {
+			if (!get_oid(p - (hexsz - 1), &oid)) {
 				struct object *o =
 					lookup_object(the_repository,
 						      oid.hash);
@@ -390,7 +392,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 				continue;
 
 			if (data->name_only)
-				printf("%.*s%s", p_len - GIT_SHA1_HEXSZ, p_start, name);
+				printf("%.*s%s", p_len - hexsz, p_start, name);
 			else
 				printf("%.*s (%s)", p_len, p_start, name);
 			p_start = p + 1;
