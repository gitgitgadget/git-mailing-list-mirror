Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8222018B
	for <e@80x24.org>; Wed, 20 Jul 2016 08:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbcGTIbw (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 04:31:52 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:56745 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcGTIbt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 04:31:49 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jul 2016 04:31:49 EDT
Received: from [84.46.92.130] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bPmoe-0002bU-Sp; Wed, 20 Jul 2016 10:25:16 +0200
Date:	Wed, 20 Jul 2016 10:25:15 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule-config: use explicit empty string instead of
 strbuf in config_from()
Message-ID: <20160720082515.GA823@book.hvoigt.net>
References: <578E7A07.8080006@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578E7A07.8080006@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Tue, Jul 19, 2016 at 09:05:43PM +0200, René Scharfe wrote:
> Use a string constant instead of an empty strbuf to shorten the code
> and make it easier to read.

This must have been some oversight from my original code. I also can not
see any purpose.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> ... unless someone can come up with a suitable non-empty string to feed
> to git_config_from_mem() as its name parameter.

If we would want to be absolutely correct we could use something like
"SHA1:.gitmodules". E.g. like we use to lookup the blob in
gitmodule_sha1_from_commit():

	strbuf_addf(&rev, "%s:.gitmodules", sha1_to_hex(commit_sha1));

And now I see where this was leftover from... before extracting this
function this code was filling the strbuf.

How about this instead?

---8<------
Subject: [PATCH] fix passing a name for config from submodules

In commit 959b5455 we implemented the initial version of the submodule
config cache. During development of that initial version we extracted
the function gitmodule_sha1_from_commit(). During that process we missed
that the strbuf rev was still used in config_from() and now is left
empty. Lets fix this by also returning this string.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

Its not exactly pretty with all the releases before the returns but
this is what I could quickly come up with...

 submodule-config.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 077db40..dccea59 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -371,9 +371,9 @@ static int parse_config(const char *var, const char *value, void *data)
 }
 
 static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
-				      unsigned char *gitmodules_sha1)
+				      unsigned char *gitmodules_sha1,
+				      struct strbuf *rev)
 {
-	struct strbuf rev = STRBUF_INIT;
 	int ret = 0;
 
 	if (is_null_sha1(commit_sha1)) {
@@ -381,11 +381,10 @@ static int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
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
 
@@ -420,8 +419,10 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
+	if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
+		strbuf_release(&rev);
 		return NULL;
+	}
 
 	switch (lookup_type) {
 	case lookup_name:
@@ -431,14 +432,19 @@ static const struct submodule *config_from(struct submodule_cache *cache,
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
@@ -450,6 +456,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
 			config, config_size, &parameter);
+	strbuf_release(&rev);
 	free(config);
 
 	switch (lookup_type) {
-- 
2.4.2.387.gf86f31a

