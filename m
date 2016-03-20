From: Laurent Arnoud <laurent@spkdev.net>
Subject: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Sun, 20 Mar 2016 16:07:03 +0100
Message-ID: <20160320150703.GB5139@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 16:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahexD-0000sW-0G
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 16:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819AbcCTPHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 11:07:09 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:51864 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbcCTPHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 11:07:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id 55347FF016;
	Sun, 20 Mar 2016 15:07:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160320042912.GD18312@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289355>

The `tag.gpgsign` config option allows to sign all
commits automatically.

Support `--no-sign` option to countermand configuration `tag.gpgsign`.

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
Reviewed-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt  |  3 +++
 Documentation/git-tag.txt |  4 ++++
 builtin/tag.c             | 21 ++++++++++++++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..076c68a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2729,6 +2729,9 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+tag.gpgSign::
+	A boolean to specify whether all tags created should be GPG signed.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index abab481..757baa1 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -64,6 +64,10 @@ OPTIONS
 --sign::
 	Make a GPG-signed tag, using the default e-mail address's key.
 
+--no-sign::
+	Countermand `tag.gpgSign` configuration variable that is
+	set to force each and every tag to be signed.
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
-- 
2.7.0
