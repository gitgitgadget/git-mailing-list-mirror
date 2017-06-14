Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8606D20282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbdFNSIC (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:08:02 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35455 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbdFNSH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:07:59 -0400
Received: by mail-pg0-f45.google.com with SMTP id k71so3528053pgd.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z2X+IBGmIbJbFriZquYK1P6XvdcTv5xNuoyOYRyISMw=;
        b=Yw38YQz0fco1npU0mJJrL/Polh74resAyPz+poHH1yGGH2fd/+BeOQ0KJSfYAlQEq8
         qvdHVBc9qmx+4JNWgdEtpg5BDS3f/9bsOukLGQCsX7SeZNUl8VueUiLVXiaJjoPGHgK2
         P30HV+V/54fLWQEYZn5rP+4Ulw+gYYTvpSX9sQUGTS1TJP4H5qYpin2gtB8GPH7xc4c9
         OiAWmQLdzfWkWXYivEumbr0sEg7cIqeJMME3x59X7rVpobjkNfQtJRWHzbokhbjGQoxI
         aJBtDtqHCi9rPMYZHDK4O4A8/GY/HL0KIzEEkHVESH7OF2Asp4QvE+LCaJY6gVlzyLLu
         1+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z2X+IBGmIbJbFriZquYK1P6XvdcTv5xNuoyOYRyISMw=;
        b=XVou3j0bj79KVpnGo7cqOPG0dlNBVz0AQucWIa54S1OmAyv1lTkUa7rDSUXlDlcJJn
         YbqiJnhJ7glaGuW2cbilXZmJaW2iU5obo7ojRluM3wxGTBUUEJ+3ecBfiw5q7aLQ0klx
         ol1FYRAoBsP4pSTYhFHwBE8CiOLrMQ+COci5oz2Jk4ZKsjw52kFh1gAT6hLNleBMFsDV
         EZUBSRxGmaXLcPGLlP7Y/REfSx+kSeQwlKiuy/dHtlLGQCNpp6Qhm48jALl2EtWQIjg/
         lEKqjvjNDTjyhkQwkJT80Sz6IQ1kHMLldYO28kROE5cVtP2Mgzj7OUMN7RKQuX5+2qWk
         N+IQ==
X-Gm-Message-State: AKS2vOxCLn4NBTiN0EDHG5v6cq4C7uobJYxEMiwhfeEhQ98+dkdckwjD
        HGYsL0v3sOa8tR+AX7TVpA==
X-Received: by 10.98.64.6 with SMTP id n6mr1216804pfa.196.1497463673002;
        Wed, 14 Jun 2017 11:07:53 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t2sm1001646pfi.76.2017.06.14.11.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:07:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 6/6] config: don't implicitly use gitdir or commondir
Date:   Wed, 14 Jun 2017 11:07:39 -0700
Message-Id: <20170614180739.72193-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170614180739.72193-1-bmwill@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git_config_with_options()' takes a 'config_options' struct which
contains feilds for 'git_dir' and 'commondir'.  If those feilds happen
to be NULL the config machinery falls back to querying global repository
state.  Let's change this and instead use these fields in the
'config_options' struct explicilty all the time.  Since the API is
slightly changing to require these two fields to be set if callers want
the config machinery to load the repository's config, let's change the
name to 'config_with_optison()'.  This allows the config machinery to
not implicitly rely on any global repository state.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/config.c | 26 +++++++++++++++-----------
 config.c         | 21 +++++++++++----------
 config.h         |  6 +++---
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 753c40a5c..82db29fae 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -243,8 +243,8 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	git_config_with_options(collect_config, &values,
-				&given_config_source, &config_options);
+	config_with_options(collect_config, &values,
+			    &given_config_source, &config_options);
 
 	ret = !values.nr;
 
@@ -321,8 +321,8 @@ static void get_color(const char *var, const char *def_color)
 	get_color_slot = var;
 	get_color_found = 0;
 	parsed_color[0] = '\0';
-	git_config_with_options(git_get_color_config, NULL,
-				&given_config_source, &config_options);
+	config_with_options(git_get_color_config, NULL,
+			    &given_config_source, &config_options);
 
 	if (!get_color_found && def_color) {
 		if (color_parse(def_color, parsed_color) < 0)
@@ -353,8 +353,8 @@ static int get_colorbool(const char *var, int print)
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
 	get_color_ui_found = -1;
-	git_config_with_options(git_get_colorbool_config, NULL,
-				&given_config_source, &config_options);
+	config_with_options(git_get_colorbool_config, NULL,
+			    &given_config_source, &config_options);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -442,8 +442,8 @@ static int get_urlmatch(const char *var, const char *url)
 		show_keys = 1;
 	}
 
-	git_config_with_options(urlmatch_config_entry, &config,
-				&given_config_source, &config_options);
+	config_with_options(urlmatch_config_entry, &config,
+			    &given_config_source, &config_options);
 
 	ret = !values.nr;
 
@@ -539,6 +539,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.respect_includes = !given_config_source.file;
 	else
 		config_options.respect_includes = respect_includes_opt;
+	if (!nongit) {
+		config_options.commondir = get_git_common_dir();
+		config_options.git_dir = get_git_dir();
+	}
 
 	if (end_null) {
 		term = '\0';
@@ -583,9 +587,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
-		if (git_config_with_options(show_all_config, NULL,
-					    &given_config_source,
-					    &config_options) < 0) {
+		if (config_with_options(show_all_config, NULL,
+					&given_config_source,
+					&config_options) < 0) {
 			if (given_config_source.file)
 				die_errno("unable to read config file '%s'",
 					  given_config_source.file);
diff --git a/config.c b/config.c
index dd7ad5e1e..822d63787 100644
--- a/config.c
+++ b/config.c
@@ -219,8 +219,6 @@ static int include_by_gitdir(const struct config_options *opts,
 
 	if (opts->git_dir)
 		git_dir = opts->git_dir;
-	else if (have_git_dir())
-		git_dir = get_git_dir();
 	else
 		goto done;
 
@@ -1549,8 +1547,6 @@ static int do_git_config_sequence(const struct config_options *opts,
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
-	else if (have_git_dir())
-		repo_config = git_pathdup("config");
 	else
 		repo_config = NULL;
 
@@ -1581,9 +1577,9 @@ static int do_git_config_sequence(const struct config_options *opts,
 	return ret;
 }
 
-int git_config_with_options(config_fn_t fn, void *data,
-			    struct git_config_source *config_source,
-			    const struct config_options *opts)
+int config_with_options(config_fn_t fn, void *data,
+			struct git_config_source *config_source,
+			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 
@@ -1614,9 +1610,14 @@ static void git_config_raw(config_fn_t fn, void *data)
 	struct config_options opts = {0};
 
 	opts.respect_includes = 1;
-	if (git_config_with_options(fn, data, NULL, &opts) < 0)
+	if (have_git_dir()) {
+		opts.commondir = get_git_common_dir();
+		opts.git_dir = get_git_dir();
+	}
+
+	if (config_with_options(fn, data, NULL, &opts) < 0)
 		/*
-		 * git_config_with_options() normally returns only
+		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
 		 * non-fatal potential errors are guarded by "if"
 		 * statements that are entered only when no error is
@@ -1676,7 +1677,7 @@ void read_early_config(config_fn_t cb, void *data)
 		opts.git_dir = gitdir.buf;
 	}
 
-	git_config_with_options(cb, data, NULL, &opts);
+	config_with_options(cb, data, NULL, &opts);
 
 	strbuf_release(&commondir);
 	strbuf_release(&gitdir);
diff --git a/config.h b/config.h
index 63b92784c..9e038cce2 100644
--- a/config.h
+++ b/config.h
@@ -45,9 +45,9 @@ extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void read_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
-extern int git_config_with_options(config_fn_t fn, void *,
-				   struct git_config_source *config_source,
-				   const struct config_options *opts);
+extern int config_with_options(config_fn_t fn, void *,
+			       struct git_config_source *config_source,
+			       const struct config_options *opts);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
-- 
2.13.1.518.g3df882009-goog

