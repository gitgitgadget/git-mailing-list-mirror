Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E6E1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbcIDQNO (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61558 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754517AbcIDQNE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:04 -0400
X-AuditID: 12074413-ab7ff70000000955-8d-57cc473577a4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 58.21.02389.5374CC75; Sun,  4 Sep 2016 12:09:25 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5d026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:24 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/38] resolve_gitlink_ref(): avoid memory allocation in many cases
Date:   Sun,  4 Sep 2016 18:08:23 +0200
Message-Id: <bc87063e6a1b203cf7345b30e060caae245a3ca6.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqGvqfibcYOoBY4uuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGScWzmYsuMdZsep6cgPjTfYuRk4O
        CQETiSu9h1m7GLk4hAS2MkpM+nqDHcI5ySSx9etPFpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXM
        IEWzJs4EGyUsECZxfsVHRhCbRUBV4t7KY2BxXoEoiTnfZ0Ktk5O4tO0LM4jNKWAhcWb3XCCb
        A2ibuUT7i+wJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoQEnPAO
        xl0n5Q4xCnAwKvHwTtA9Ey7EmlhWXJl7iFGSg0lJlHfWwZPhQnxJ+SmVGYnFGfFFpTmpxYcY
        JTiYlUR4tV2AynlTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzXXYEa
        BYtS01Mr0jJzShDSTBycIMN5gIbfBKnhLS5IzC3OTIfIn2JUlBLnfQmSEABJZJTmwfXCEsIr
        RnGgV4R5E9yAqniAyQSu+xXQYCagwet2nwYZXJKIkJJqYOTYsqGsuGR5GHdIVkMY1+TaF4Vf
        TTWPzzm2JpN38eOAgA6DDJ9X6RLLrOUXOEyJ3ytUwF108dTU03z/Dn7+FN+w45nelw2Vm6Su
        GAbp7z9uWXlEsuWpTFXLd7tnE7UzX84Lz/7l2hgmMmlrhHjJ/p2vZOpXGU53OMmRfeT01kCv
        Zc+2FlfuO6/EUpyRaKjFXFScCADdvsoL4wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we don't have to strip trailing '/' from the submodule path, then
don't allocate and copy the submodule name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 647ead5..34c0c5e 100644
--- a/refs.c
+++ b/refs.c
@@ -1301,19 +1301,26 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
-	int len = strlen(path);
-	struct strbuf submodule = STRBUF_INIT;
+	size_t len = strlen(path);
 	struct ref_store *refs;
 	int flags;
 
-	while (len && path[len-1] == '/')
+	while (len && path[len - 1] == '/')
 		len--;
+
 	if (!len)
 		return -1;
 
-	strbuf_add(&submodule, path, len);
-	refs = get_ref_store(submodule.buf);
-	strbuf_release(&submodule);
+	if (path[len]) {
+		/* We need to strip off one or more trailing slashes */
+		char *stripped = xmemdupz(path, len);
+
+		refs = get_ref_store(stripped);
+		free(stripped);
+	} else {
+		refs = get_ref_store(path);
+	}
+
 	if (!refs)
 		return -1;
 
-- 
2.9.3

