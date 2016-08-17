Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE421FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 21:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbcHQV3I (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 17:29:08 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33549 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbcHQV3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 17:29:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id ti13so116068pac.0
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 14:29:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UaVIzAqNhHmYG1lcUki8puprKgqgZCeESPkxWwZX1N0=;
        b=DD0cMM1ckryCCyFPmMsDvvKfEOZ1Hq6ZkfkDvTKmAdVs7HIaxKUhCI2sslKPvnrfoo
         HhtMacui4hZSTw5MLLiP1t1GNsadudurcTK85eha9f14AIRP7Gpl5G097UQ6zaMsq/hV
         5Lrc2Yo7Cw3kE1Jh3ET0XVVyjtF67cYM9lhlC9GIW0B8gnTeMWmkxyECiL29UXsukKDD
         mfuuGZ+PmZbZQvMWzeVSg5Y+dM6E6x1UiF8NA+H0KWAcxn2iXVHlo6NEtOPqq04vB+91
         P4s3Izkm1dXLBfvjujMLOPDYGk1UqPbsEIlgurrWpk1WXdEeLbztLHIrN8M/d+g7LNWE
         RnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UaVIzAqNhHmYG1lcUki8puprKgqgZCeESPkxWwZX1N0=;
        b=fXKNltsI+VpHl0PvpErI29ZWDR9RAgXjw5GFHhFuIO9QacOd/yPYRmlsv6AK1VLuH/
         422iyCTZ8DMroGb3AONfrHtCPWlfU8f8aSNqzN9aufJYvCZajlWux9h4j0PC9X6puHLN
         H5GX1qiv9PyHTSrgvVKMo5L9B3+ZH/gHXqP1m2KU3US0g19LwKPlMh7huWGi/XDZQxcP
         FnqPu/eRL7iwK0HIzeVOPDIOVyMGCTwzuLjuE0rXg8BvOVVI7nO3ubk9vn+We5czs8HY
         t8Y8GCp44Xr9ClBYbEKv6PMG4SveVjfNVuFSbnL9qWs3OHmMcvJandCaChT8SesEoP9E
         lnmw==
X-Gm-Message-State: AEkoous3+mpJaMQ3rQ5pu1Q7kkfqE5/6mmfCNAo6wEs4Td27f4n9nRCVHf2ygTLg0SWTLKXx
X-Received: by 10.66.132.38 with SMTP id or6mr15421654pab.84.1471469346559;
        Wed, 17 Aug 2016 14:29:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:dce0:ddd0:eb1f:9744])
        by smtp.gmail.com with ESMTPSA id y200sm49408962pfb.13.2016.08.17.14.29.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 14:29:05 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 8/8] clone: recursive and reference option triggers submodule alternates
Date:	Wed, 17 Aug 2016 14:28:58 -0700
Message-Id: <20160817212858.30540-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.582.g4b18b4a
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When `--recursive` and `--reference` is given, it is reasonable to
expect that the submodules are created with references to the submodules
of the given alternate for the superproject.

  An initial attempt to do this was presented to the mailing list, which
  used flags that are passed around ("--super-reference") that instructed
  the submodule clone to look for a reference in the submodules of the
  referenced superproject. This is not well thought out, as any further
  `submodule update` should also respect the initial setup.

  When a new  submodule is added to the superproject and the alternate
  of the superproject does not know about that submodule yet, we rather
  error out informing the user instead of being unclear if we did or did
  not use a submodules alternate.

To solve this problem introduce new options that store the configuration
for what the user wanted originally.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  This replaces the tip of remotes/origin/sb/submodule-clone-rr.
  The difference to the queued version are 2 free calls at the end of
  prepare_possible_alternates()
  
  Thanks,
  Stefan

 Documentation/config.txt       | 12 ++++++
 builtin/clone.c                | 19 +++++++++
 builtin/submodule--helper.c    | 90 ++++++++++++++++++++++++++++++++++++++++++
 t/t7408-submodule-reference.sh | 43 ++++++++++++++++++++
 4 files changed, 164 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bc1c433..602f43a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2837,6 +2837,18 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.alternateLocation::
+	Specifies how the submodules obtain alternates when submodules are
+	cloned. Possible values are `no`, `superproject`.
+	By default `no` is assumed, which doesn't add references. When the
+	value is set to `superproject` the submodule to be cloned computes
+	its alternates location relative to the superprojects alternate.
+
+submodule.alternateErrorStrategy
+	Specifies how to treat errors with the alternates for a submodule
+	as computed via `submodule.alternateLocation`. Possible values are
+	`ignore`, `info`, `die`.
+
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
 	If `--annotate` is specified on the command line, it takes
diff --git a/builtin/clone.c b/builtin/clone.c
index 0182665..404c5e8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -947,6 +947,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		else
 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
+
+	if (option_recursive) {
+		if (option_required_reference.nr &&
+		    option_optional_reference.nr)
+			die(_("clone --recursive is not compatible with "
+			      "both --reference and --reference-if-able"));
+		else if (option_required_reference.nr) {
+			string_list_append(&option_config,
+				"submodule.alternateLocation=superproject");
+			string_list_append(&option_config,
+				"submodule.alternateErrorStrategy=die");
+		} else if (option_optional_reference.nr) {
+			string_list_append(&option_config,
+				"submodule.alternateLocation=superproject");
+			string_list_append(&option_config,
+				"submodule.alternateErrorStrategy=info");
+		}
+	}
+
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7096848..fd571bf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -472,6 +472,93 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 	return run_command(&cp);
 }
 
+struct submodule_alternate_setup {
+	const char *submodule_name;
+	enum SUBMODULE_ALTERNATE_ERROR_MODE {
+		SUBMODULE_ALTERNATE_ERROR_DIE,
+		SUBMODULE_ALTERNATE_ERROR_INFO,
+		SUBMODULE_ALTERNATE_ERROR_IGNORE
+	} error_mode;
+	struct string_list *reference;
+};
+#define SUBMODULE_ALTERNATE_SETUP_INIT { NULL, \
+	SUBMODULE_ALTERNATE_ERROR_IGNORE, NULL }
+
+static int add_possible_reference_from_superproject(
+		struct alternate_object_database *alt, void *sas_cb)
+{
+	struct submodule_alternate_setup *sas = sas_cb;
+
+	/* directory name, minus trailing slash */
+	size_t namelen = alt->name - alt->base - 1;
+	struct strbuf name = STRBUF_INIT;
+	strbuf_add(&name, alt->base, namelen);
+
+	/*
+	 * If the alternate object store is another repository, try the
+	 * standard layout with .git/modules/<name>/objects
+	 */
+	if (ends_with(name.buf, ".git/objects")) {
+		char *sm_alternate;
+		struct strbuf sb = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+		strbuf_add(&sb, name.buf, name.len - strlen("objects"));
+		/*
+		 * We need to end the new path with '/' to mark it as a dir,
+		 * otherwise a submodule name containing '/' will be broken
+		 * as the last part of a missing submodule reference would
+		 * be taken as a file name.
+		 */
+		strbuf_addf(&sb, "modules/%s/", sas->submodule_name);
+
+		sm_alternate = compute_alternate_path(sb.buf, &err);
+		if (sm_alternate) {
+			string_list_append(sas->reference, xstrdup(sb.buf));
+			free(sm_alternate);
+		} else {
+			switch (sas->error_mode) {
+			case SUBMODULE_ALTERNATE_ERROR_DIE:
+				die(_("submodule '%s' cannot add alternate: %s"),
+				    sas->submodule_name, err.buf);
+			case SUBMODULE_ALTERNATE_ERROR_INFO:
+				fprintf(stderr, _("submodule '%s' cannot add alternate: %s"),
+					sas->submodule_name, err.buf);
+			case SUBMODULE_ALTERNATE_ERROR_IGNORE:
+				; /* nothing */
+			}
+		}
+		strbuf_release(&sb);
+	}
+
+	strbuf_release(&name);
+	return 0;
+}
+
+static void prepare_possible_alternates(const char *sm_name,
+		struct string_list *reference)
+{
+	char *sm_alternate = NULL, *error_strategy = NULL;
+	struct submodule_alternate_setup sas = SUBMODULE_ALTERNATE_SETUP_INIT;
+
+	git_config_get_string("submodule.alternateLocation", &sm_alternate);
+	if (!sm_alternate)
+		return;
+
+	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
+
+	sas.submodule_name = sm_name;
+	sas.reference = reference;
+	if (!strcmp(error_strategy, "die"))
+		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_DIE;
+	if (!strcmp(error_strategy, "info"))
+		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_INFO;
+	if (!strcmp(sm_alternate, "superproject"))
+		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
+
+	free(sm_alternate);
+	free(error_strategy);
+}
+
 static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *name = NULL, *url = NULL, *depth = NULL;
@@ -532,6 +619,9 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
+
+		prepare_possible_alternates(name, &reference);
+
 		if (clone_submodule(path, sm_gitdir, url, depth, &reference, quiet))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index dff47af..1c1e289 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -82,4 +82,47 @@ test_expect_success 'updating superproject keeps alternates' '
 	test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
+test_expect_success 'submodules use alternates when cloning a superproject' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone --reference super --recursive super super-clone &&
+	(
+		cd super-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# test submodule has correct setup
+		test_alternate_is_used .git/modules/sub/objects/info/alternates sub
+	)
+'
+
+test_expect_success 'missing submodule alternate fails clone and submodule update' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super2 &&
+	test_must_fail git clone --recursive --reference super2 super2 super-clone &&
+	(
+		cd super-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# update of the submodule succeeds
+		test_must_fail git submodule update --init &&
+		# and we have no alternates:
+		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
+		test_must_fail test_path_is_file sub/file1
+	)
+'
+
+test_expect_success 'ignoring missing submodule alternates passes clone and submodule update' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone --reference-if-able super2 --recursive super2 super-clone &&
+	(
+		cd super-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# update of the submodule succeeds
+		git submodule update --init &&
+		# and we have no alternates:
+		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
+		test_path_is_file sub/file1
+	)
+'
+
 test_done
-- 
2.9.2.582.g4b18b4a

