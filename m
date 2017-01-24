Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45F4220AC5
	for <e@80x24.org>; Tue, 24 Jan 2017 17:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750771AbdAXRBC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 12:01:02 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:45518 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbdAXRA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 12:00:58 -0500
Received: from localhost (x4e340422.dyn.telefonica.de [78.52.4.34])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 3B4DC16C850;
        Tue, 24 Jan 2017 18:00:57 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <patrick.steinhardt@elego.de>
Subject: [PATCH v2 3/4] urlmatch: split host and port fields in `struct url_info`
Date:   Tue, 24 Jan 2017 18:00:30 +0100
Message-Id: <20170124170031.18069-4-patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170124170031.18069-1-patrick.steinhardt@elego.de>
References: <20170124170031.18069-1-patrick.steinhardt@elego.de>
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `url_info` structure contains information about a normalized URL
with the URL's components being represented by different fields. The
host and port part though are to be accessed by the same `host` field,
so that getting the host and/or port separately becomes more involved
than really necessary.

To make the port more readily accessible, split up the host and port
fields. Namely, the `host_len` will not include the port length anymore
and a new `port_off` field has been added which includes the offset to
the port, if available.

The only user of these fields is `url_normalize_1`. This change makes it
easier later on to treat host and port differently when introducing
globs for domains.

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
---
 urlmatch.c | 16 ++++++++++++----
 urlmatch.h |  9 +++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/urlmatch.c b/urlmatch.c
index d350478c0..e328905eb 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -104,7 +104,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 	struct strbuf norm;
 	size_t spanned;
 	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
-	size_t host_off=0, host_len=0, port_len=0, path_off, path_len, result_len;
+	size_t host_off=0, host_len=0, port_off=0, port_len=0, path_off, path_len, result_len;
 	const char *slash_ptr, *at_ptr, *colon_ptr, *path_start;
 	char *result;
 
@@ -263,6 +263,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 				return NULL;
 			}
 			strbuf_addch(&norm, ':');
+			port_off = norm.len;
 			strbuf_add(&norm, url, slash_ptr - url);
 			port_len = slash_ptr - url;
 		}
@@ -270,7 +271,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 		url = slash_ptr;
 	}
 	if (host_off)
-		host_len = norm.len - host_off;
+		host_len = norm.len - host_off - (port_len ? port_len + 1 : 0);
 
 
 	/*
@@ -378,6 +379,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 		out_info->passwd_len = passwd_len;
 		out_info->host_off = host_off;
 		out_info->host_len = host_len;
+		out_info->port_off = port_off;
 		out_info->port_len = port_len;
 		out_info->path_off = path_off;
 		out_info->path_len = path_len;
@@ -464,11 +466,17 @@ static int match_urls(const struct url_info *url,
 		usermatched = 1;
 	}
 
-	/* check the host and port */
+	/* check the host */
 	if (url_prefix->host_len != url->host_len ||
 	    strncmp(url->url + url->host_off,
 		    url_prefix->url + url_prefix->host_off, url->host_len))
-		return 0; /* host names and/or ports do not match */
+		return 0; /* host names do not match */
+
+	/* check the port */
+	if (url_prefix->port_len != url->port_len ||
+	    strncmp(url->url + url->port_off,
+		    url_prefix->url + url_prefix->port_off, url->port_len))
+		return 0; /* ports do not match */
 
 	/* check the path */
 	pathmatchlen = url_match_prefix(
diff --git a/urlmatch.h b/urlmatch.h
index 528862adc..0ea812b03 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -18,11 +18,12 @@ struct url_info {
 	size_t passwd_len;	/* length of passwd; if passwd_off != 0 but
 				   passwd_len == 0, an empty passwd was given */
 	size_t host_off;	/* offset into url to start of host name (0 => none) */
-	size_t host_len;	/* length of host name; this INCLUDES any ':portnum';
+	size_t host_len;	/* length of host name;
 				 * file urls may have host_len == 0 */
-	size_t port_len;	/* if a portnum is present (port_len != 0), it has
-				 * this length (excluding the leading ':') at the
-				 * end of the host name (always 0 for file urls) */
+	size_t port_off;	/* offset into url to start of port number (0 => none) */
+	size_t port_len;	/* if a portnum is present (port_off != 0), it has
+				 * this length (excluding the leading ':') starting
+				 * from port_off (always 0 for file urls) */
 	size_t path_off;	/* offset into url to the start of the url path;
 				 * this will always point to a '/' character
 				 * after the url has been normalized */
-- 
2.11.0

