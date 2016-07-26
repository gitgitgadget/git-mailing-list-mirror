Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B9F203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 09:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbcGZJvH (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 05:51:07 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:40477 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbcGZJvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 05:51:06 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bRyzD-0004C0-5L; Tue, 26 Jul 2016 11:49:15 +0200
Date:	Tue, 26 Jul 2016 11:49:13 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH 1/2] fix passing a name for config from submodules
Message-ID: <20160726094913.GA3347@book.hvoigt.net>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
 <20160725143706.GA4872@sandbox>
 <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In commit 959b5455 we implemented the initial version of the submodule
config cache. During development of that initial version we extracted
the function gitmodule_sha1_from_commit(). During that process we missed
that the strbuf rev was still used in config_from() and now is left
empty. Lets fix this by also returning this string.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
This is based on 508a285 in next.

 submodule-config.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 1210b26..853989e 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -349,9 +349,9 @@ static int parse_config(const char *var, const char *value, void *data)
 }
 
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
-				      unsigned char *gitmodules_sha1)
+				      unsigned char *gitmodules_sha1,
+				      struct strbuf *rev)
 {
-	struct strbuf rev = STRBUF_INIT;
 	int ret = 0;
 
 	if (is_null_sha1(commit_sha1)) {
@@ -359,11 +359,10 @@ static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 		return 1;
 	}
 
-	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
-	if (get_sha1(rev.buf, gitmodules_sha1) >= 0)
+	strbuf_addf(rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));
+	if (get_sha1(rev->buf, gitmodules_sha1) >= 0)
 		ret = 1;
 
-	strbuf_release(&rev);
 	return ret;
 }
 
@@ -375,6 +374,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		const unsigned char *commit_sha1, const char *key,
 		enum lookup_type lookup_type)
 {
+	struct strbuf rev = STRBUF_INIT;
 	unsigned long config_size;
 	char *config;
 	unsigned char sha1[20];
@@ -397,8 +397,10 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
+	if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
+		strbuf_release(&rev);
 		return NULL;
+	}
 
 	switch (lookup_type) {
 	case lookup_name:
@@ -408,14 +410,19 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		submodule = cache_lookup_path(cache, sha1, key);
 		break;
 	}
-	if (submodule)
+	if (submodule) {
+		strbuf_release(&rev);
 		return submodule;
+	}
 
 	config = read_sha1_file(sha1, &type, &config_size);
-	if (!config)
+	if (!config) {
+		strbuf_release(&rev);
 		return NULL;
+	}
 
 	if (type != OBJ_BLOB) {
+		strbuf_release(&rev);
 		free(config);
 		return NULL;
 	}
@@ -425,8 +432,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.commit_sha1 = commit_sha1;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
-	git_config_from_mem(parse_config, "submodule-blob", "",
+	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
 			config, config_size, &parameter);
+	strbuf_release(&rev);
 	free(config);
 
 	switch (lookup_type) {
-- 
2.4.2.387.gf86f31a

