From: Laurent Arnoud <laurent@spkdev.net>
Subject: [PATCH v6] Add the option to force sign annotated tags
Date: Tue, 22 Mar 2016 21:41:26 +0100
Message-ID: <20160322204126.GI20083@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
 <20160321192904.GC20083@spk-laptop>
 <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
 <20160321205015.GF20083@spk-laptop>
 <xmqqa8lrldz4.fsf@gitster.mtv.corp.google.com>
 <20160322193617.GG20083@spk-laptop>
 <xmqqshziguot.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:41:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiT7Q-0007OH-1S
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 21:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbcCVUlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 16:41:32 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:40118 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcCVUlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 16:41:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id C102DFF232;
	Tue, 22 Mar 2016 20:41:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqshziguot.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289557>

The `tag.forcesignannotated` config option allows to sign annotated tags
automatically.

`--annotate` command line option disable configuration
`tag.forcesignannotated`.

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
---
 Documentation/config.txt |  5 +++++
 builtin/tag.c            | 20 ++++++++++++++------
 t/t7004-tag.sh           | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..95d5c9d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2729,6 +2729,11 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+tag.forceSignAnnotated::
+	A boolean to specify whether annotated tags created should be GPG signed.
+	If `--annotate` is specified on the command line, it takes
+	precedence over this option.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..528a1ba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -29,6 +29,7 @@ static const char * const git_tag_usage[] = {
 };
 
 static unsigned int colopts;
+static int force_sign_annotate;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
@@ -166,6 +167,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
+	if (!strcmp(var, "tag.forcesignannotated")) {
+		force_sign_annotate = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
 	return git_default_config(var, value, cb);
@@ -327,7 +333,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	char *cleanup_arg = NULL;
 	int create_reflog = 0;
 	int annotate = 0, force = 0;
-	int cmdmode = 0;
+	int cmdmode = 0, create_tag_object = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct ref_transaction *transaction;
@@ -385,12 +391,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	if (opt.sign)
-		annotate = 1;
+	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
+
 	if (argc == 0 && !cmdmode)
 		cmdmode = 'l';
 
-	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
+	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
@@ -431,7 +437,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
 			die(_("only one -F or -m option is allowed."));
-		annotate = 1;
 		if (msg.given)
 			strbuf_addbuf(&buf, &(msg.buf));
 		else {
@@ -474,8 +479,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
-	if (annotate)
+	if (create_tag_object) {
+		if (force_sign_annotate && !annotate)
+			opt.sign = 1;
 		create_tag(object, tag, &buf, &opt, prev, object);
+	}
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index cf3469b..f9b7d79 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -775,6 +775,47 @@ test_expect_success GPG '-s implies annotated tag' '
 	test_cmp expect actual
 '
 
+get_tag_header forcesignannotated-implied-sign $commit commit $time >expect
+echo "A message" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+	'git tag -s implied if configured with tag.forcesignannotated' \
+	'test_config tag.forcesignannotated true &&
+	git tag -m "A message" forcesignannotated-implied-sign &&
+	get_tag_msg forcesignannotated-implied-sign >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG \
+	'lightweight with no message when configured with tag.forcesignannotated' \
+	'test_config tag.forcesignannotated true &&
+	git tag forcesignannotated-lightweight &&
+	tag_exists forcesignannotated-lightweight &&
+	test_must_fail git tag -v forcesignannotated-no-message
+'
+
+get_tag_header forcesignannotated-annotate $commit commit $time >expect
+echo "A message" >>expect
+test_expect_success GPG \
+	'git tag -a disable configured tag.forcesignannotated' \
+	'test_config tag.forcesignannotated true &&
+	git tag -a -m "A message" forcesignannotated-annotate &&
+	get_tag_msg forcesignannotated-annotate >actual &&
+	test_cmp expect actual &&
+	test_must_fail git tag -v forcesignannotated-annotate
+'
+
+get_tag_header forcesignannotated-disabled $commit commit $time >expect
+echo "A message" >>expect
+echo '-----BEGIN PGP SIGNATURE-----' >>expect
+test_expect_success GPG \
+	'git tag --sign enable GPG sign' \
+	'test_config tag.forcesignannotated false &&
+	git tag --sign -m "A message" forcesignannotated-disabled &&
+	get_tag_msg forcesignannotated-disabled >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
-- 
2.7.0
