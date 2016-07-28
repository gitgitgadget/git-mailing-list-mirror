Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1091F858
	for <e@80x24.org>; Thu, 28 Jul 2016 12:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478AbcG1MtU (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 08:49:20 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:59376 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401AbcG1MtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 08:49:18 -0400
Received: from [62.224.174.160] (helo=sandbox)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bSkkT-0007fr-I3; Thu, 28 Jul 2016 14:49:13 +0200
Date:	Thu, 28 Jul 2016 14:49:11 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH 1/3] submodule-config: passing name reference for .gitmodule
 blobs
Message-ID: <20160728124910.GA2530@sandbox>
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

Commit 959b5455 (submodule: implement a config API for lookup of
.gitmodules values, 2015-08-18) implemented the initial version of the
submodule config cache. During development of that initial version we
extracted the function gitmodule_sha1_from_commit(). During that process
we missed that the strbuf rev was still used in config_from() and now is
left empty. Lets fix this by also returning this string.

This means that now when reading .gitmodules from revisions, the error
messages also contain a reference to the blob they are from.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Here you go. Now including a test.

 submodule-config.c          | 26 +++++++++++++++++---------
 t/t7411-submodule-config.sh | 11 +++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

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
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index fc97c33..400e2b1 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -82,6 +82,17 @@ test_expect_success 'error in one submodule config lets continue' '
 	)
 '
 
+test_expect_success 'error message contains blob reference' '
+	(cd super &&
+		sha1=$(git rev-parse HEAD) &&
+		test-submodule-config \
+			HEAD b \
+			HEAD submodule \
+				2>actual_err &&
+		grep "submodule-blob $sha1:.gitmodules" actual_err >/dev/null
+	)
+'
+
 cat >super/expect_url <<EOF
 Submodule url: 'git@somewhere.else.net:a.git' for path 'b'
 Submodule url: 'git@somewhere.else.net:submodule.git' for path 'submodule'
-- 
2.0.2.832.g083c931

