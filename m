Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA08F202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdJZUEa (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:04:30 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:54338 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdJZUE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:04:29 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Oct 2017 16:04:28 EDT
X-Clacks-Overhead: GNU Terry Pratchett
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 403652803FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1509047732; bh=5bymfIc1H/F+mPeZLwHJNiDcWlrRqv48rZpoEz9K3eU=;
        h=From:To:Cc:Subject:Date:From;
        b=EpGI6vaosey4wqHwjsGc0YzxGic4UPrU99OeyAYpQ+qyyFyx+mfhmAS+4N7rWKqK0
         ABXfQDKPvz2ZEnv84a2yuTqfsHoyM7VsB+AjdSrOGUcpz1np49g87elXHOfsQgQpHp
         p5IaGj2iPl4mLKRxyPhtFJku4G/qmyFkG9kp+790=
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
        by smtp-o-1.desy.de (DESY-O-1) with ESMTP id 403652803FD
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 21:55:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-1.desy.de (DESY-INTRA-1) with ESMTP id F1EBB3E902;
        Thu, 26 Oct 2017 21:55:31 +0200 (MEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     git@vger.kernel.org
Cc:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] tag: add tag.gpgSign config option to force all tags be GPG-signed
Date:   Thu, 26 Oct 2017 21:55:16 +0200
Message-Id: <20171026195516.3354-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.13.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some workflows we have no control on how git command is executed,
however a signed tags are required.

The new config-file option tag.gpgSign enforces signed tags. Additional
command line option --no-gpg-sign is added to disable such behavior if
needed. E.g.:

    $ git tag -m "commit message"

will generate a GPG signed tag if tag.gpgSign option is true, while

    $ git tag --no-gpg-sign -m "commit message"

will skip the signing step.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 Documentation/config.txt               |  4 ++++
 Documentation/git-tag.txt              |  4 ++++
 builtin/tag.c                          | 18 +++++++++++++++---
 contrib/completion/git-completion.bash |  1 +
 t/t7004-tag.sh                         | 21 +++++++++++++++++++++
 5 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6ad..fa6694bec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3161,6 +3161,10 @@ tag.forceSignAnnotated::
 	If `--annotate` is specified on the command line, it takes
 	precedence over this option.
 
+tag.gpgSign::
+
+	A boolean to specify whether all tags should be GPG signed.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 956fc019f..1dd43f18b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -181,6 +181,10 @@ This option is only applicable when listing tags without annotation lines.
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
 
+--no-gpg-sign::
+	Countermand `tag.gpgSign` configuration variable that is
+	set to force each and every tag to be signed.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/builtin/tag.c b/builtin/tag.c
index b38329b59..d9060a404 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -31,6 +31,7 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 static int force_sign_annotate;
+static int sign_tag;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
@@ -141,6 +142,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	int status;
 	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
 
+	if (!strcmp(var, "tag.gpgsign")) {
+		sign_tag = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "tag.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -372,6 +378,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
 	int icase = 0;
+	int no_gpg_sign = 0;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -393,6 +400,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
+		OPT_BOOL(0, "no-gpg-sign", &no_gpg_sign, N_("do not GPG-sign tag")),
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
@@ -426,6 +434,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	if (no_gpg_sign) {
+		sign_tag = 0;
+	}
+
 	if (keyid) {
 		opt.sign = 1;
 		set_signing_key(keyid);
@@ -444,7 +456,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (cmdmode == 'l')
 		setup_auto_pager("tag", 1);
 
-	if ((create_tag_object || force) && (cmdmode != 0))
+	if ((create_tag_object || force || no_gpg_sign) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
@@ -536,8 +548,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	create_reflog_msg(&object, &reflog_msg);
 
-	if (create_tag_object) {
-		if (force_sign_annotate && !annotate)
+	if (create_tag_object || sign_tag) {
+		if (sign_tag || (force_sign_annotate && !annotate))
 			opt.sign = 1;
 		create_tag(&object, tag, &buf, &opt, &prev, &object);
 	}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0e16f017a..0dbe689a2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2648,6 +2648,7 @@ _git_config ()
 		status.showUntrackedFiles
 		status.submodulesummary
 		submodule.
+		tag.gpgSign
 		tar.umask
 		transfer.unpackLimit
 		url.
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index a9af2de99..ccff37733 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -904,6 +904,27 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
+get_tag_header gpgsign-enabled $commit commit $time >expect
+echo "A message" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+	'git tag configured tag.gpgsign enables GPG sign' \
+	'test_config tag.gpgsign true &&
+	git tag -m "A message" gpgsign-enabled &&
+	get_tag_msg gpgsign-enabled>actual &&
+	test_cmp expect actual
+'
+
+get_tag_header no-gpg-sign $commit commit $time >expect
+echo "A message" >>expect
+test_expect_success GPG \
+	'git tag --no-gpg-sign configured tag.gpgsign skip GPG sign' \
+	'test_config tag.gpgsign true &&
+	git tag -a --no-gpg-sign -m "A message" no-gpg-sign &&
+	get_tag_msg no-gpg-sign>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
-- 
2.13.6

