Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB501F462
	for <e@80x24.org>; Wed,  5 Jun 2019 21:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFEVdb (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 17:33:31 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:47278 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEVda (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 17:33:30 -0400
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 4FED416052C
        for <git@vger.kernel.org>; Wed,  5 Jun 2019 23:33:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 4FED416052C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1559770406; bh=VI0A3cwz7oMnuuqoo3GNV8wVKmV+XqDnaimBFsItV2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtJpGSboGaPJJIeDhBF9V1pV4VOcHhv78EzfoRwfEhMjkwsF+I3PwliWzs/kBD73a
         0Qx5OwyezlFSeiI1htkfpxHatNckVF1UxD/au0NBXL957aNzS/a+rkBQIcvS5Ge36x
         woysw7AZyK6ksAovNMrnSUfv3b0SHKlz1Bypbu9U=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 4AA831A00B8;
        Wed,  5 Jun 2019 23:33:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 1B59C10003B;
        Wed,  5 Jun 2019 23:33:26 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Johannes.Schindelin@gmx.de,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH v4] tag: add tag.gpgSign config option to force all tags be GPG-signed
Date:   Wed,  5 Jun 2019 23:33:21 +0200
Message-Id: <20190605213321.6577-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <2146612842.10496277.1559768996738.JavaMail.zimbra@desy.de>
References: <2146612842.10496277.1559768996738.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As many CI/CD tools don't allow to control command line options when
executing `git tag` command, a default value in the configuration file
will allow to enforce tag signing if required.

The new config-file option tag.gpgSign is added to define default behavior
of tag signings. To override default behavior the command line option -s,
--sign and --no-sign can be used:

    $ git tag -m "commit message"

will generate a GPG signed tag if tag.gpgSign option is true, while

    $ git tag --no-sign -m "commit message"

will skip the signing step.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 Documentation/config/tag.txt |  8 ++++++++
 Documentation/git-tag.txt    |  7 +++++++
 builtin/tag.c                | 22 ++++++++++++++++------
 t/t7004-tag.sh               | 21 +++++++++++++++++++++
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.txt
index 663663bdec..ef5adb3f42 100644
--- a/Documentation/config/tag.txt
+++ b/Documentation/config/tag.txt
@@ -8,6 +8,14 @@ tag.sort::
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
 	value of this variable will be used as the default.
 
+tag.gpgSign::
+	A boolean to specify whether all tags should be GPG signed.
+	Use of this option when running in an automated script can
+	result in a large number of tags being signed. It is therefore
+	convenient to use an agent to avoid typing your gpg passphrase
+	several times. Note that this option doesn't affects tag signing
+	behavior enabled by "-u <keyid>" or "--local-user=<keyid>" options.
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index a74e7b926d..2e5599a67f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -64,6 +64,13 @@ OPTIONS
 -s::
 --sign::
 	Make a GPG-signed tag, using the default e-mail address's key.
+	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
+	configuration variable if it exists, or disabled oder otherwise.
+	See linkgit:git-config[1].
+
+--no-sign::
+	Override `tag.gpgSign` configuration variable that is
+	set to force each and every tag to be signed.
 
 -u <keyid>::
 --local-user=<keyid>::
diff --git a/builtin/tag.c b/builtin/tag.c
index ef37dccf86..e0a4c25382 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -33,6 +33,7 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 static int force_sign_annotate;
+static int config_sign_tag = -1; /* unspecified */
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
@@ -144,6 +145,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	int status;
 	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
 
+	if (!strcmp(var, "tag.gpgsign")) {
+		config_sign_tag = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "tag.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -442,15 +448,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	memset(&filter, 0, sizeof(filter));
 	filter.lines = -1;
+	opt.sign = -1;
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
-	if (keyid) {
-		opt.sign = 1;
-		set_signing_key(keyid);
-	}
-	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
-
 	if (!cmdmode) {
 		if (argc == 0)
 			cmdmode = 'l';
@@ -463,6 +464,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (cmdmode == 'l')
 		setup_auto_pager("tag", 1);
 
+	if (opt.sign == -1)
+		opt.sign = cmdmode ? 0 : config_sign_tag > 0;
+
+	if (keyid) {
+		opt.sign = 1;
+		set_signing_key(keyid);
+	}
+	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
+
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6aeeb279a0..80eb13d94e 100755
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
+get_tag_header no-sign $commit commit $time >expect
+echo "A message" >>expect
+test_expect_success GPG \
+	'git tag --no-sign configured tag.gpgsign skip GPG sign' \
+	'test_config tag.gpgsign true &&
+	git tag -a --no-sign -m "A message" no-sign &&
+	get_tag_msg no-sign>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
-- 
2.22.0.rc3.1.gdbadaa0575

