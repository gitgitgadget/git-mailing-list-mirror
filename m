Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFEC1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 12:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500AbcG1Mty (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 08:49:54 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:42693 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401AbcG1Mtx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 08:49:53 -0400
Received: from [62.224.174.160] (helo=sandbox)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bSkl4-0003mx-2P; Thu, 28 Jul 2016 14:49:50 +0200
Date:	Thu, 28 Jul 2016 14:49:47 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH 2/3] submodule-config: combine early return code into one goto
Message-ID: <20160728124947.GB2530@sandbox>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
 <20160725143706.GA4872@sandbox>
 <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net>
 <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
 <xmqqmvl4xdlm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvl4xdlm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So we have simpler return handling code and all the cleanup code in
almost one place.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
This is an updated cleanup patch. Now with goto so we have simpler code.

 submodule-config.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 853989e..a887574 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -376,7 +376,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 {
 	struct strbuf rev = STRBUF_INIT;
 	unsigned long config_size;
-	char *config;
+	char *config = NULL;
 	unsigned char sha1[20];
 	enum object_type type;
 	const struct submodule *submodule = NULL;
@@ -397,10 +397,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
-		strbuf_release(&rev);
-		return NULL;
-	}
+	if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev))
+		goto out;
 
 	switch (lookup_type) {
 	case lookup_name:
@@ -410,22 +408,12 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		submodule = cache_lookup_path(cache, sha1, key);
 		break;
 	}
-	if (submodule) {
-		strbuf_release(&rev);
-		return submodule;
-	}
+	if (submodule)
+		goto out;
 
 	config = read_sha1_file(sha1, &type, &config_size);
-	if (!config) {
-		strbuf_release(&rev);
-		return NULL;
-	}
-
-	if (type != OBJ_BLOB) {
-		strbuf_release(&rev);
-		free(config);
-		return NULL;
-	}
+	if (!config || type != OBJ_BLOB)
+		goto out;
 
 	/* fill the submodule config into the cache */
 	parameter.cache = cache;
@@ -445,6 +433,11 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	default:
 		return NULL;
 	}
+
+out:
+	strbuf_release(&rev);
+	free(config);
+	return submodule;
 }
 
 static const struct submodule *config_from_path(struct submodule_cache *cache,
-- 
2.0.2.832.g083c931

