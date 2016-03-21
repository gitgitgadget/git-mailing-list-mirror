From: Laurent Arnoud <laurent@spkdev.net>
Subject: [PATCH v4] Add the tag.gpgsign option to sign annotated tags
Date: Mon, 21 Mar 2016 21:50:15 +0100
Message-ID: <20160321205015.GF20083@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
 <20160321192904.GC20083@spk-laptop>
 <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:50:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6mP-0008Ay-2b
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928AbcCUUuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:50:20 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:34400 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbcCUUuU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:50:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id EFC34FF016;
	Mon, 21 Mar 2016 20:50:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289459>

The `tag.gpgsign` config option allows to sign annotated tags
automatically.

`--annotate` command line option disable configuration `tag.gpgsign`.

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
---
 Documentation/config.txt |  5 +++++
 builtin/tag.c            | 20 +++++++++++++++-----
 t/t7004-tag.sh           | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..62f7d2a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2729,6 +2729,11 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+tag.gpgSign::
+	A boolean to specify whether annotated tags created should be GPG signed.
+	If `--annotate` is specified on the command line, it takes
+	precedence over this option.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..748aeac 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -29,6 +29,7 @@ static const char * const git_tag_usage[] = {
 };
 
 static unsigned int colopts;
+static unsigned int sign_tag_config;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
@@ -166,6 +167,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
+	if (!strcmp(var, "tag.gpgsign")) {
+		sign_tag_config = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
 	return git_default_config(var, value, cb);
@@ -326,7 +332,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int create_reflog = 0;
-	int annotate = 0, force = 0;
+	int annotate = -1, force = 0;
 	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -381,16 +387,20 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	if (argc == 0 && !cmdmode)
+		cmdmode = 'l';
+
+	if (!cmdmode && sign_tag_config && annotate < 1)
+		opt.sign = 1;
+
 	if (keyid) {
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
 	if (opt.sign)
 		annotate = 1;
-	if (argc == 0 && !cmdmode)
-		cmdmode = 'l';
 
-	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
+	if ((annotate > 0 || msg.given || msgfile || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
@@ -474,7 +484,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
-	if (annotate)
+	if (annotate > 0)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
 	transaction = ref_transaction_begin(&err);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index cf3469b..7791d00 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -775,6 +775,39 @@ test_expect_success GPG '-s implies annotated tag' '
 	test_cmp expect actual
 '
 
+get_tag_header config-implied-annotate $commit commit $time >expect
+./fakeeditor >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+	'git tag -s implied if configured with tag.gpgsign' \
+	'test_config tag.gpgsign true &&
+	GIT_EDITOR=./fakeeditor git tag config-implied-annotate &&
+	get_tag_msg config-implied-annotate >actual &&
+	test_cmp expect actual
+'
+
+get_tag_header config-implied-annotate-disabled $commit commit $time >expect
+echo "A message" >>expect
+test_expect_success GPG \
+	'git tag -a disable configured tag.gpgsign' \
+	'test_config tag.gpgsign true &&
+	git tag -a -m "A message" config-implied-annotate-disabled &&
+	get_tag_msg config-implied-annotate-disabled >actual &&
+	test_cmp expect actual &&
+	test_must_fail git tag -v config-implied-annotate-disabled
+'
+
+get_tag_header config-disabled-gpgsign $commit commit $time >expect
+echo "A message" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+	'git tag --sign enable GPG sign' \
+	'test_config tag.gpgsign false &&
+	git tag --sign -m "A message" config-disabled-gpgsign &&
+	get_tag_msg config-disabled-gpgsign >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
-- 
2.7.0
