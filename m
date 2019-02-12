Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E077D1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBLBX2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34260 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbfBLBX0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:26 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0567F60899;
        Tue, 12 Feb 2019 01:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934605;
        bh=AKJws+q6ssiLC0vGt7JoLJPhSwxoO7sqP72foWMRhw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DbgXtOXlECdM+8Jb7hC+xMbOIf4QZNygCDsZBYGa5L9Cvh83nVWa+Dd7I69e+FSVM
         IAE5TgKQSRTF3AU2arAm1xGJuAoZVX4/m2XXv1WH4fvxSsbIdXtGFJRLSgYq2Yc+qT
         b3W5xxI3+KCk+y7OuoetT+EHMeH6S8S+uYxMrccNUiIsj9fRehJZerw8Gr7Wdy2NBu
         uIF9TGCEPUfjg3dcU/JAWxDy2Tt5puQeQSl8HaZ0TrFpAS2wQ/YJSkNB3+glpNIWa7
         /rTqxjqoIrM8v+8oD8I7qKWoKAE7rSVzz7mmhYahnJdmlf+itf4BWqsfe1fjzDD7Ud
         wcq2I7vl7iHtN+qAGkONYjlWwkkZgrNP5P2NKTOa1SCTtNp10UdyVz3lsNuCiwdINL
         tmXzbF6TidxeFTZ2rcGMfeup2fwRaP6zLq+M4lyAtlckapauphw+2BuDJdULy8M1Pa
         amFHE+8LBFXRBQhSBZ4V+2c3w/C3benDbbzIWAERW26H9T2YQb5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 11/31] builtin/name-rev: make hash-size independent
Date:   Tue, 12 Feb 2019 01:22:36 +0000
Message-Id: <20190212012256.1005924-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
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
