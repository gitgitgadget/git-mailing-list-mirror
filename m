Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C311F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 19:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbcG3TLV (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 15:11:21 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58033 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbcG3TLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 15:11:19 -0400
Received: from mfilter33-d.gandi.net (mfilter33-d.gandi.net [217.70.178.164])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 19F1AFB877;
	Sat, 30 Jul 2016 21:11:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter33-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter33-d.gandi.net (mfilter33-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 3sYwVAfLRhql; Sat, 30 Jul 2016 21:11:15 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E59AAFB8A0;
	Sat, 30 Jul 2016 21:11:13 +0200 (CEST)
Date:	Sat, 30 Jul 2016 12:11:11 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: [PATCH v2 1/2] format-patch: Add a config option format.from to set
 the default for --from
Message-ID: <20160730191111.cd6ay3l4hweyjf7f@x>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This helps users who would prefer format-patch to default to --from, and
makes it easier to change the default in the future.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/config.txt               | 10 ++++++-
 builtin/log.c                          | 46 +++++++++++++++++++++------
 contrib/completion/git-completion.bash |  1 +-
 t/t4014-format-patch.sh                | 40 +++++++++++++++++++++++-
 4 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8b1aee4..bd34774 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1253,6 +1253,16 @@ format.attach::
 	value as the boundary.  See the --attach option in
 	linkgit:git-format-patch[1].
 
+format.from::
+	Provides the default value for the `--from` option to format-patch.
+	Accepts a boolean value, or a name and email address.  If false,
+	format-patch defaults to `--no-from`, using commit authors directly in
+	the "From:" field of patch mails.  If true, format-patch defaults to
+	`--from`, using your committer identity in the "From:" field of patch
+	mails and including a "From:" field in the body of the patch mail if
+	different.  If set to a non-boolean value, format-patch uses that
+	value instead of your committer identity.  Defaults to false.
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
diff --git a/builtin/log.c b/builtin/log.c
index fd1652f..dbd2da7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -719,6 +719,7 @@ static void add_header(const char *value)
 static int thread;
 static int do_signoff;
 static int base_auto;
+static char *from;
 static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
@@ -731,6 +732,28 @@ enum {
 	COVER_AUTO
 };
 
+enum from {
+	FROM_AUTHOR,
+	FROM_USER,
+	FROM_VALUE,
+};
+
+static void set_from(enum from type, const char *value)
+{
+	free(from);
+	switch (type) {
+	case FROM_AUTHOR:
+		from = NULL;
+		break;
+	case FROM_USER:
+		from = xstrdup(git_committer_info(IDENT_NO_DATE));
+		break;
+	case FROM_VALUE:
+		from = xstrdup(value);
+		break;
+	}
+}
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -807,6 +830,16 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		base_auto = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.from")) {
+		int b = git_config_maybe_bool(var, value);
+		if (b < 0)
+			set_from(FROM_VALUE, value);
+		else if (b)
+			set_from(FROM_USER, NULL);
+		else
+			set_from(FROM_AUTHOR, NULL);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1199,16 +1232,12 @@ static int cc_callback(const struct option *opt, const char *arg, int unset)
 
 static int from_callback(const struct option *opt, const char *arg, int unset)
 {
-	char **from = opt->value;
-
-	free(*from);
-
 	if (unset)
-		*from = NULL;
+		set_from(FROM_AUTHOR, NULL);
 	else if (arg)
-		*from = xstrdup(arg);
+		set_from(FROM_VALUE, arg);
 	else
-		*from = xstrdup(git_committer_info(IDENT_NO_DATE));
+		set_from(FROM_USER, NULL);
 	return 0;
 }
 
@@ -1384,7 +1413,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	int reroll_count = -1;
 	char *branch_name = NULL;
-	char *from = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
 
@@ -1433,7 +1461,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    0, to_callback },
 		{ OPTION_CALLBACK, 0, "cc", NULL, N_("email"), N_("add Cc: header"),
 			    0, cc_callback },
-		{ OPTION_CALLBACK, 0, "from", &from, N_("ident"),
+		{ OPTION_CALLBACK, 0, "from", NULL, N_("ident"),
 			    N_("set From address to <ident> (or committer ident if absent)"),
 			    PARSE_OPT_OPTARG, from_callback },
 		OPT_STRING(0, "in-reply-to", &in_reply_to, N_("message-id"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 10f6d52..4393033 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2181,6 +2181,7 @@ _git_config ()
 		format.attach
 		format.cc
 		format.coverLetter
+		format.from
 		format.headers
 		format.numbered
 		format.pretty
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1206c48..b0579dd 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -229,6 +229,46 @@ check_patch () {
 	grep -e "^Subject:" "$1"
 }
 
+test_expect_success 'format.from=false' '
+
+	git -c format.from=false format-patch --stdout master..side |
+	sed -e "/^\$/q" >patch &&
+	check_patch patch &&
+	! grep "^From: C O Mitter <committer@example.com>\$" patch
+'
+
+test_expect_success 'format.from=true' '
+
+	git -c format.from=true format-patch --stdout master..side |
+	sed -e "/^\$/q" >patch &&
+	check_patch patch &&
+	grep "^From: C O Mitter <committer@example.com>\$" patch
+'
+
+test_expect_success 'format.from with address' '
+
+	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side |
+	sed -e "/^\$/q" >patch &&
+	check_patch patch &&
+	grep "^From: F R Om <from@example.com>\$" patch
+'
+
+test_expect_success '--no-from overrides format.from' '
+
+	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side |
+	sed -e "/^\$/q" >patch &&
+	check_patch patch &&
+	! grep "^From: F R Om <from@example.com>\$" patch
+'
+
+test_expect_success '--from overrides format.from' '
+
+	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side |
+	sed -e "/^\$/q" >patch &&
+	check_patch patch &&
+	! grep "^From: F R Om <from@example.com>\$" patch
+'
+
 test_expect_success '--no-to overrides config.to' '
 
 	git config --replace-all format.to \
-- 
git-series 0.8.7
