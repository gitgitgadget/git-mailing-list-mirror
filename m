Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351991F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJOHpH (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50594 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbeJOHpG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 650B261B7E;
        Mon, 15 Oct 2018 00:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561741;
        bh=VRLjC3u3UxT6bbCxIljy6X2n2kesAyJuv3+EwlcMsTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=aqKmND3kzjY3CNASqN0SVyw/8wP9NtX5dMO29KCzhqMlp6zE17uplB4WzXzDYPdo2
         vgR/MxWk123WGIvFb01HNQ8nMj10zA5nobdxx+E+u8uftfL9fRslBhoiuhaZzJC3xw
         /XTIV29ensjFsg8Gb/9Brf3D2K0QkU+mXmHQlin9TALKvgEauNED6XX3ZnAtWxERbz
         ro7Z3NSIdyzzwEFSHyw2b3lgubxyeMpmmvXwHUbuEiSThjvzTcQ+vVOxdhYUIrEiJ4
         GNl/XJQFIwLAkeoq5danlPmWYbIb0lwV8MLG7upukozhvXlQVJE6xm3RfjfOaCuUnN
         T0eOQDXxcjzvG/OdvbMJwmjuBNkLuh+NTT8JZk7HBRpHBcOElO4UxAEECWb8hD1vnD
         cx3DijFCTaec/nZPdOr73po5V0YUydGe4dOYjiboJO41hoymoZeb3+hH5vYkiOP+uZ
         iC/7MMbuqRRuastamnOP26P7N1PWm1f8WEgNWgktGqVtpp5bXDq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 10/15] transport: use parse_oid_hex instead of a constant
Date:   Mon, 15 Oct 2018 00:01:57 +0000
Message-Id: <20181015000202.951965-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use parse_oid_hex to compute a pointer instead of using GIT_SHA1_HEXSZ.
This simplifies the code and makes it independent of the hash length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/transport.c b/transport.c
index 1c76d64aba..44b9ddf670 100644
--- a/transport.c
+++ b/transport.c
@@ -1346,15 +1346,16 @@ static void read_alternate_refs(const char *path,
 	fh = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, fh) != EOF) {
 		struct object_id oid;
+		const char *p;
 
-		if (get_oid_hex(line.buf, &oid) ||
-		    line.buf[GIT_SHA1_HEXSZ] != ' ') {
+		if (parse_oid_hex(line.buf, &oid, &p) ||
+		    *p != ' ') {
 			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
 		}
 
-		cb(line.buf + GIT_SHA1_HEXSZ + 1, &oid, data);
+		cb(p + 1, &oid, data);
 	}
 
 	fclose(fh);
