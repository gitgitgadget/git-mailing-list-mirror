Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5D320193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbcIDQMT (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:19 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54246 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754329AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 12074412-1c3ff70000000931-7f-57cc4732ffca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 48.47.02353.2374CC75; Sun,  4 Sep 2016 12:09:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5b026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:20 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/38] resolve_ref_recursively(): new function
Date:   Sun,  4 Sep 2016 18:08:21 +0200
Message-Id: <ee72c2f9d2019a5348748964e715c2037c3d05e5.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqGvkfibc4MBtAYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGQv6tjAW/OapONx9maWBcQNXFyMn
        h4SAiUR/1yeWLkYuDiGBrYwSR68fYIVwTjJJTFk6nxmkik1AV2JRTzMTiC0ioCYxse0QWAcz
        SNGsiTPZQRLCAo4SD/48ZgOxWQRUJZ7/WAYU5+DgFYiS+Lc2D2KbnMSlbV/AZnIKWEic2T2X
        GaRESMBcov1F9gRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQgJO
        aAfj+pNyhxgFOBiVeHgttM+EC7EmlhVX5h5ilORgUhLlnXXwZLgQX1J+SmVGYnFGfFFpTmrx
        IUYJDmYlEV5tF6By3pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3ig3
        oEbBotT01Iq0zJwShDQTByfIcB6g4X0gNbzFBYm5xZnpEPlTjIpS4rwvXYESAiCJjNI8uF5Y
        QnjFKA70ijCvIkg7DzCZwHW/AhrMBDR43e7TIINLEhFSUg2Mu1O6NHX97fqjNwTF2Gk5TTrk
        0Z2T9mdiyqPV7M4LlIM+HL09Qfz+gZn/vvw4+Hg+g9VPrsRF/Z/uXFuZfOfVhBlvPiwvf8BQ
        It91it369dbPlfGpz/cnmp/5nta49fBnpkMvezUmXrjl0+JRPbuFa9cs1kWmFXkM2Q3OazxK
        BB/kBBxZsezYJiWW4oxEQy3mouJEADUsaLHjAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new function, resolve_ref_recursively(), which is basically like
the old resolve_ref_unsafe() except that it takes a (ref_store *)
argument and also works for submodules.

Re-implement resolve_ref_unsafe() as a thin wrapper around
resolve_ref_recursively().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9e6b005..3723169 100644
--- a/refs.c
+++ b/refs.c
@@ -1216,13 +1216,14 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
+static const char *resolve_ref_recursively(struct ref_store *refs,
+					   const char *refname,
+					   int resolve_flags,
+					   unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	int unused_flags;
 	int symref_count;
-	struct ref_store *refs = get_ref_store(NULL);
 
 	if (!flags)
 		flags = &unused_flags;
@@ -1291,6 +1292,13 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return NULL;
 }
 
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	return resolve_ref_recursively(get_ref_store(NULL), refname,
+				       resolve_flags, sha1, flags);
+}
+
 /* A pointer to the ref_store for the main repository: */
 static struct ref_store *main_ref_store;
 
-- 
2.9.3

