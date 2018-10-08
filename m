Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103731F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 21:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJIFLJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:11:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49340 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbeJIFLF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:11:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8B32160788;
        Mon,  8 Oct 2018 21:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539035835;
        bh=VRLjC3u3UxT6bbCxIljy6X2n2kesAyJuv3+EwlcMsTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xkHVrBD4WRkv/lVS83veKEcBy3v8vD1NwpMdB3m8L8nFp5HmrEY15lod+Iq4kfvCm
         nBeu3so8/Cc+U+CI68Mr/Yjkok5bwS/RsrMPToeOsvjJGoCtFb83NtVhBqB5EjMIF2
         oNeHRR6JsuaZ3aAFPJhA8c3Ol8YGx+EA7LPugqdaNZ9gTEc1ft6LjtyQqBl0x4+96r
         cYRjwqV0fe52uBtkV3LvhJ/xT6fZwQH3+ik07auwQKQc148+JsI1qxxAZlzXf9dxKB
         QehLqRcdLJPn1SQKVSMFPYh6gk8jjxD7XxACFFb5P6iB23Z0VIEyeZZNjw/FSoJnop
         GSbY3grfhizyeeJ8AUQCLPeHrvEHXCBex5hyMR9y9DxcHgxYIUlGgALWLqhhEYg/hT
         d7sg1msMAU5G981InR/4xGa3vaCkk8eG22lfstEKezzvZ6uoR0JFY2NdnJWKiMV33C
         p/PxLsNnx7jzErOQwHyGdQZ1rk+8Q/Ybp7XV5BkJ/x1jp0KlEl6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/14] transport: use parse_oid_hex instead of a constant
Date:   Mon,  8 Oct 2018 21:56:56 +0000
Message-Id: <20181008215701.779099-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008215701.779099-1-sandals@crustytoothpaste.net>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
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
