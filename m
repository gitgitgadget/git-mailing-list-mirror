Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884481F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbdA0Kdx (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:33:53 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58198 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932568AbdA0Kch (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:32:37 -0500
Received: from localhost (x55b3aa69.dyn.telefonica.de [85.179.170.105])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 5EF7D16C838;
        Fri, 27 Jan 2017 11:32:36 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v4 2/5] urlmatch: enable normalization of URLs with globs
Date:   Fri, 27 Jan 2017 11:32:15 +0100
Message-Id: <3f0b0ba5f122d0098f1966de0f3a8cdaf8cd15f2.1485512626.git.patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1485512626.git.patrick.steinhardt@elego.de>
References: <cover.1485512626.git.patrick.steinhardt@elego.de>
In-Reply-To: <cover.1485512626.git.patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de> <cover.1485512626.git.patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

