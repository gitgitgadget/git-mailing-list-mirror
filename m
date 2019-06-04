Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AF91F462
	for <e@80x24.org>; Tue,  4 Jun 2019 11:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfFDLxz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 07:53:55 -0400
Received: from smtp-o-3.desy.de ([131.169.56.156]:35385 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfFDLxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 07:53:54 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 07:53:51 EDT
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 44C6360261
        for <git@vger.kernel.org>; Tue,  4 Jun 2019 13:44:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 44C6360261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1559648670; bh=fsuu/9pZrUyMnDAX6WAo9QH43eQIMOxdoaqnhOKHUto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEtenS9bf2t9aMyOrwxRwfawWeG/Z9fiJ+kDR//Qyy/QIbg+D0MyFIKlSK6kX0U01
         0Ru/u+/re32V9UeusTA9+zvfrOZbNCxJKjHRgCPjhp07SvaQn1HpCUiQU3WNEKfWNF
         LxbXiLkPRLgXBeW7spkRLX7Xefjb2eC+Yg46z5/o=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [IPv6:2001:638:700:1038::1:83])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 401F3A0097;
        Tue,  4 Jun 2019 13:44:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 1B07110003B;
        Tue,  4 Jun 2019 13:44:30 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH v2] tag: add tag.gpgSign config option to force all tags be GPG-signed
Date:   Tue,  4 Jun 2019 13:43:56 +0200
Message-Id: <20190604114356.11042-2-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604114356.11042-1-tigran.mkrtchyan@desy.de>
References: <60741736.3439901.1509090074292.JavaMail.zimbra@desy.de>
 <20190604114356.11042-1-tigran.mkrtchyan@desy.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As may CI/CD tools don't allow to control command line options when
executing `git tag` command, a default value in the configuration file
will allow to enforce tag signing if required.

The new config-file option tag.gpgSign enforces signed tags. Additional
command line option --no-gpg-sign is added to disable such behavior if
needed. E.g.:

    $ git tag -m "commit message"

will generate a GPG signed tag if tag.gpgSign option is true, while

    $ git tag --no-gpg-sign -m "commit message"

will skip the signing step.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 Documentation/git-tag.txt |  7 +++++++
 builtin/tag.c             | 18 +++++++++++++++---
 t/t7004-tag.sh            | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index a74e7b926d..d9dbfb4e37 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -64,6 +64,9 @@ OPTIONS
 -s::
 --sign::
 	Make a GPG-signed tag, using the default e-mail address's key.
+	The default behabior of tag GPG-signing controlled by `tag.gpgSign`
+	configuration variable if it exists, or disabled oder otherwise.
+	See linkgit:git-config[1].
 
 -u <keyid>::
 --local-user=<keyid>::
@@ -193,6 +196,10 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
+--no-gpg-sign::
+	Countermand `tag.gpgSign` configuration variable that is
+	set to force each and every tag to be signed.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/builtin/tag.c b/builtin/tag.c
index ef37dccf86..7f9aef4840 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -33,6 +33,7 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 static int force_sign_annotate;
+static int sign_tag;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
@@ -144,6 +145,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
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
@@ -392,6 +398,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_format format = REF_FORMAT_INIT;
 	int icase = 0;
 	int edit_flag = 0;
+	int no_gpg_sign = 0;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -413,6 +420,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
 		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
+		OPT_BOOL(0, "no-gpg-sign", &no_gpg_sign, N_("do not GPG-sign tag")),
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
@@ -445,6 +453,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	if (no_gpg_sign) {
+		sign_tag = 0;
+	}
+
 	if (keyid) {
 		opt.sign = 1;
 		set_signing_key(keyid);
@@ -463,7 +475,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (cmdmode == 'l')
 		setup_auto_pager("tag", 1);
 
-	if ((create_tag_object || force) && (cmdmode != 0))
+	if ((create_tag_object || force || no_gpg_sign) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
@@ -556,8 +568,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	create_reflog_msg(&object, &reflog_msg);
 
-	if (create_tag_object) {
-		if (force_sign_annotate && !annotate)
+	if (create_tag_object || sign_tag) {
+		if (sign_tag || (force_sign_annotate && !annotate))
 			opt.sign = 1;
 		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object);
 	}
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6aeeb279a0..98a07a29d2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -932,6 +932,27 @@ test_expect_success GPG \
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
2.21.0

