Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609351F6DC
	for <e@80x24.org>; Tue, 31 Jan 2017 09:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdAaJJi (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 04:09:38 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:59147 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbdAaJJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 04:09:36 -0500
Received: from localhost (unknown [10.10.10.227])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 8F78816C886;
        Tue, 31 Jan 2017 10:01:50 +0100 (CET)
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 2/5] urlmatch: enable normalization of URLs with globs
Date:   Tue, 31 Jan 2017 10:01:44 +0100
Message-Id: <dec34b078e3019d7078be6799d3d8c0e28d912ba.1485853153.git.ps@pks.im>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1485853153.git.ps@pks.im>
References: <cover.1485853153.git.ps@pks.im>
In-Reply-To: <cover.1485853153.git.ps@pks.im>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de> <cover.1485853153.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Patrick Steinhardt <patrick.steinhardt@elego.de>

The `url_normalize` function is used to validate and normalize URLs. As
such, it does not allow for some special characters to be part of the
URLs that are to be normalized. As we want to allow using globs in some
configuration keys making use of URLs, namely `http.<url>.<key>`, but
still normalize them, we need to somehow enable some additional allowed
characters.

To do this without having to change all callers of `url_normalize`,
where most do not actually want globbing at all, we split off another
function `url_normalize_1`. This function accepts an additional
parameter `allow_globs`, which is subsequently called by `url_normalize`
with `allow_globs=0`.

As of now, this function is not used with globbing enabled. A caller
will be added in the following commit.

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
---
 urlmatch.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/urlmatch.c b/urlmatch.c
index 132d342bc..d350478c0 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -63,7 +63,7 @@ static int append_normalized_escapes(struct strbuf *buf,
 	return 1;
 }
 
-char *url_normalize(const char *url, struct url_info *out_info)
+static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
 {
 	/*
 	 * Normalize NUL-terminated url using the following rules:
@@ -191,7 +191,12 @@ char *url_normalize(const char *url, struct url_info *out_info)
 		strbuf_release(&norm);
 		return NULL;
 	}
-	spanned = strspn(url, URL_HOST_CHARS);
+
+	if (allow_globs)
+		spanned = strspn(url, URL_HOST_CHARS "*");
+	else
+		spanned = strspn(url, URL_HOST_CHARS);
+
 	if (spanned < colon_ptr - url) {
 		/* Host name has invalid characters */
 		if (out_info) {
@@ -380,6 +385,11 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return result;
 }
 
+char *url_normalize(const char *url, struct url_info *out_info)
+{
+	return url_normalize_1(url, out_info, 0);
+}
+
 static size_t url_match_prefix(const char *url,
 			       const char *url_prefix,
 			       size_t url_prefix_len)
-- 
2.11.0

