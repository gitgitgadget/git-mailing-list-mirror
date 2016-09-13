Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48105207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbcIMDYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:24:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:42340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750747AbcIMDYb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:24:31 -0400
Received: (qmail 20433 invoked by uid 109); 13 Sep 2016 03:24:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:24:26 +0000
Received: (qmail 18670 invoked by uid 111); 13 Sep 2016 03:24:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:24:23 -0700
Date:   Mon, 12 Sep 2016 20:24:23 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 16/16] init: reset cached config when entering new repo
Message-ID: <20160913032422.xy22la6uw23hnvje@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we copy the templates into place, we re-read the
config in case we copied in a default config file. But since
git_config() is backed by a cache these days, it's possible
that the call will not actually touch the filesystem at all;
we need to tell it that something has changed behind the
scenes.

Note that we also need to reset the shared_repository
config. At first glance, it seems like this should probably
just be folded into git_config_clear(). But unfortunately
that is not quite right. The shared repository value may
come from config, _or_ it may have been set manually. So
only the caller who knows whether or not they set it is the
one who can clear it (and indeed, if you _do_ put it into
git_config_clear(), then many tests fail, as we have to
clear the config cache any time we set a new config
variable).

There are three tests here. The first two actually pass
already, though it's largely luck: they just don't happen to
actually read any config before we enter the new repo.

But the third one does fail without this patch; we look at
core.sharedrepository while creating the directory, but need
to make sure the value from the template config overrides
it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c      |  6 ++++++
 cache.h                |  7 +++++++
 environment.c          |  5 +++++
 t/t1301-shared-repo.sh | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index e935895..cea4550 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -195,8 +195,14 @@ static int create_default_files(const char *template_path)
 	 * First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
 	 * from it after installing.
+	 *
+	 * Before reading that config, we also need to clear out any cached
+	 * values (since we've just potentially changed what's available on
+	 * disk).
 	 */
 	copy_templates(template_path);
+	git_config_clear();
+	reset_shared_repository();
 	git_config(git_default_config, NULL);
 
 	/*
diff --git a/cache.h b/cache.h
index e9592d3..4c8d85b 100644
--- a/cache.h
+++ b/cache.h
@@ -671,8 +671,15 @@ extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 
+/*
+ * Accessors for the core.sharedrepository config which lazy-load the value
+ * from the config (if not already set). The "reset" function can be
+ * used to unset "set" or cached value, meaning that the value will be loaded
+ * fresh from the config file on the next call to get_shared_repository().
+ */
 void set_shared_repository(int value);
 int get_shared_repository(void);
+void reset_shared_repository(void);
 
 /*
  * Do replace refs need to be checked this run?  This variable is
diff --git a/environment.c b/environment.c
index c0cce6b..cd5aa57 100644
--- a/environment.c
+++ b/environment.c
@@ -351,3 +351,8 @@ int get_shared_repository(void)
 	}
 	return the_shared_repository;
 }
+
+void reset_shared_repository(void)
+{
+	need_shared_repository_from_config = 1;
+}
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 7c28642..1312004 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -181,4 +181,36 @@ test_expect_success POSIXPERM 'remote init does not use config from cwd' '
 	test_cmp expect actual
 '
 
+test_expect_success POSIXPERM 're-init respects core.sharedrepository (local)' '
+	git config core.sharedrepository 0666 &&
+	umask 0022 &&
+	echo whatever >templates/foo &&
+	git init --template=templates &&
+	echo "-rw-rw-rw-" >expect &&
+	modebits .git/foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)' '
+	rm -rf child.git &&
+	umask 0022 &&
+	git init --bare --shared=0666 child.git &&
+	test_path_is_missing child.git/foo &&
+	git init --bare --template=../templates child.git &&
+	echo "-rw-rw-rw-" >expect &&
+	modebits child.git/foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success POSIXPERM 'template can set core.sharedrepository' '
+	rm -rf child.git &&
+	umask 0022 &&
+	git config core.sharedrepository 0666 &&
+	cp .git/config templates/config &&
+	git init --bare --template=../templates child.git &&
+	echo "-rw-rw-rw-" >expect &&
+	modebits child.git/HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.0.230.g6f8d04b
