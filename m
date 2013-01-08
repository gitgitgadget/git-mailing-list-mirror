From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/10] log: add log.mailmap configuration option
Date: Mon,  7 Jan 2013 16:10:21 -0800
Message-ID: <1357603821-8647-11-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmg-0006ZE-5M
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756178Ab3AHAKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756175Ab3AHAKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E90F7B7CE;
	Mon,  7 Jan 2013 19:10:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GRQ6
	fT4rRATd1P8CtHMHwtVrJqY=; b=nAcLC5mqTCiVrEh+XbyBbKhk/IlXTySUFaVs
	+irdOiaWZetXpRssQb0q9yRjCJ+7ZBolzK5lE2qUN2xShcLhQookUZb5NvfqtEsv
	ntJ3ESNgaVYE4FefBOAbIgvOG+TqE+T7JDBuVPPdjS/NAJ1sDJtDeJxw7LZfWlhp
	mvf3l84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	QwUR8dDvawFpEg6D9S/43wXcM1h/FAi5X2T5NsWHeRA2FmDk8OBY420/jdgaub3K
	gcfegCMDDFSB310NEyy/IjdOw0F4uLcMnzhiTciYU8aK3n1Ki7ItULD3f5Yy8auG
	qDlTiCsKuBxks9EnRakcSCUKxu1Jp43esiBRPUmyJvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBEEDB7CD;
	Mon,  7 Jan 2013 19:10:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19142B7CC; Mon,  7 Jan 2013
 19:10:45 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D8D6E3B2-5927-11E2-AABD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212929>

From: Antoine Pelisse <apelisse@gmail.com>

Teach "log.mailmap" configuration variable to turn "--use-mailmap"
option on to "git log", "git show" and "git whatchanged".

The "--no-use-mailmap" option from the command line can countermand
the setting.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  4 ++++
 builtin/log.c            |  7 +++++++
 t/t4203-mailmap.sh       | 24 ++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf8f911..226362a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1509,6 +1509,10 @@ log.showroot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+log.mailmap::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+
 mailmap.file::
 	The location of an augmenting mailmap file. The default
 	mailmap, located in the root of the repository, is loaded
diff --git a/builtin/log.c b/builtin/log.c
index d2bd8ce..16e6520 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@ static int default_abbrev_commit;
 static int default_show_root = 1;
 static int decoration_style;
 static int decoration_given;
+static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -106,6 +107,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
+	mailmap = use_mailmap_config;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
@@ -358,6 +360,11 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	}
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
+	if (!strcmp(var, "log.mailmap")) {
+		use_mailmap_config = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (grep_config(var, value, cb) < 0)
 		return -1;
 	return git_diff_ui_config(var, value, cb);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index e16187f..7d4d31c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -255,6 +255,21 @@ test_expect_success 'Log output with --use-mailmap' '
 '
 
 cat >expect <<\EOF
+Author: CTO <cto@company.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Other Author <other@author.xx>
+Author: Other Author <other@author.xx>
+Author: Some Dude <some@dude.xx>
+Author: A U Thor <author@example.com>
+EOF
+
+test_expect_success 'Log output with log.mailmap' '
+	git -c log.mailmap=True log | grep Author >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 EOF
@@ -263,6 +278,15 @@ test_expect_success 'Grep author with --use-mailmap' '
 	git log --use-mailmap --author Santa | grep Author >actual &&
 	test_cmp expect actual
 '
+cat >expect <<\EOF
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+EOF
+
+test_expect_success 'Grep author with log.mailmap' '
+	git -c log.mailmap=True log --author Santa | grep Author >actual &&
+	test_cmp expect actual
+'
 
 >expect
 
-- 
1.8.1.304.gf036638
