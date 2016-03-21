From: Laurent Arnoud <laurent@spkdev.net>
Subject: [PATCH v3] Add the tag.gpgsign option to sign annotated tags
Date: Mon, 21 Mar 2016 20:32:07 +0100
Message-ID: <20160321193207.GD20083@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5Z5-0001NJ-9W
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbcCUTc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:32:29 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:34043 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbcCUTcL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:32:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id 9E660FF016;
	Mon, 21 Mar 2016 19:32:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289443>

The `tag.gpgsign` config option allows to sign all
annotated tags automatically.

Support `--no-sign` option to countermand configuration `tag.gpgsign`.

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
Reviewed-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt  |  5 +++++
 Documentation/git-tag.txt |  6 +++++-
 builtin/tag.c             | 21 ++++++++++++++++-----
 t/t7004-tag.sh            | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..ba9d4da 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2729,6 +2729,11 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+tag.gpgSign::
+	A boolean to specify whether annotated tags created should be GPG signed.
+	If `--no-sign` is specified on the command line, it takes
+	precedence over this option.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index abab481..180edd2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
+'git tag' [-a | -s | --no-sign | -u <keyid>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
@@ -64,6 +64,10 @@ OPTIONS
 --sign::
 	Make a GPG-signed tag, using the default e-mail address's key.
 
+--no-sign::
+	Countermand `tag.gpgSign` configuration variable that is
+	set to force annoted tags to be signed.
+
 -u <keyid>::
 --local-user=<keyid>::
 	Make a GPG-signed tag, using the given key.
diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..2a7b2f2 100644
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
+		sign_tag_config = git_config_bool(var, value) ? 1 : 0;
+		return 0;
+	}
+
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
 	return git_default_config(var, value, cb);
@@ -195,7 +201,7 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 
 static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 {
-	if (sign && do_sign(buf) < 0)
+	if (sign > 0 && do_sign(buf) < 0)
 		return error(_("unable to sign the tag"));
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		return error(_("unable to write tag file"));
@@ -204,7 +210,7 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 
 struct create_tag_options {
 	unsigned int message_given:1;
-	unsigned int sign;
+	int sign;
 	enum {
 		CLEANUP_NONE,
 		CLEANUP_SPACE,
@@ -378,17 +384,22 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	memset(&filter, 0, sizeof(filter));
 	filter.lines = -1;
+	opt.sign = -1;
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	if (argc == 0 && !cmdmode)
+		cmdmode = 'l';
+
+	if (!cmdmode && sign_tag_config && opt.sign != 0)
+		opt.sign = 1;
+
 	if (keyid) {
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	if (opt.sign)
+	if (opt.sign > 0)
 		annotate = 1;
-	if (argc == 0 && !cmdmode)
-		cmdmode = 'l';
 
 	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index cf3469b..4e45361 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -775,6 +775,51 @@ test_expect_success GPG '-s implies annotated tag' '
 	test_cmp expect actual
 '
 
+get_tag_header config-implied-annotate $commit commit $time >expect
+./fakeeditor >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+git config tag.gpgsign true
+test_expect_success GPG \
+	'git tag -s implied if configured with tag.gpgsign' \
+	'GIT_EDITOR=./fakeeditor git tag config-implied-annotate &&
+	get_tag_msg config-implied-annotate >actual &&
+	test_cmp expect actual
+'
+git config --unset tag.gpgsign
+
+get_tag_header config-implied-annotate-disabled $commit commit $time >expect
+echo "A message" >>expect
+git config tag.gpgsign true
+test_expect_success GPG \
+	'git tag --no-sign disable configured tag.gpgsign' \
+	'git tag --no-sign -m "A message" config-implied-annotate-disabled &&
+	get_tag_msg config-implied-annotate-disabled >actual &&
+	test_cmp expect actual &&
+	test_must_fail git tag -v config-implied-annotate-disabled
+'
+git config --unset tag.gpgsign
+
+get_tag_header config-disabled-gpgsign $commit commit $time >expect
+echo "A message" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+git config tag.gpgsign false
+test_expect_success GPG \
+	'git tag --sign enable GPG sign' \
+	'git tag --sign -m "A message" config-disabled-gpgsign &&
+	get_tag_msg config-disabled-gpgsign >actual &&
+	test_cmp expect actual
+'
+git config --unset tag.gpgsign
+
+git config tag.gpgsign true
+test_expect_success GPG \
+	'git tag --no-sign disable configured tag.gpgsign and annotate' \
+	'git tag --no-sign config-non-annotated-tag &&
+	tag_exists config-non-annotated-tag &&
+	test_must_fail git tag -v config-non-annotated-tag
+'
+git config --unset tag.gpgsign
+
 test_expect_success GPG \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
-- 
2.7.0
