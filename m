From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/3] config: fail if --get-urlmatch finds no value
Date: Sun, 28 Feb 2016 11:54:35 +0000
Message-ID: <9ed75bdb80839deaebac642a8abd1da5b6a969d1.1456660027.git.john@keeping.me.uk>
References: <cover.1456660027.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Guilherme <guibufolo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 12:55:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZzwP-0006Pd-AS
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 12:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280AbcB1LzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 06:55:07 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:36558 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbcB1LzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 06:55:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6BAEFCDA54E;
	Sun, 28 Feb 2016 11:55:04 +0000 (GMT)
X-Quarantine-ID: <WXE8hMazbNIn>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WXE8hMazbNIn; Sun, 28 Feb 2016 11:55:02 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 8FC00CDA647;
	Sun, 28 Feb 2016 11:54:52 +0000 (GMT)
X-Mailer: git-send-email 2.7.1.503.g3cfa3ac
In-Reply-To: <cover.1456660027.git.john@keeping.me.uk>
In-Reply-To: <cover.1456660027.git.john@keeping.me.uk>
References: <20160228104557.GT1766@serenity.lan> <cover.1456660027.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287771>

The --get, --get-all and --get-regexp options to git-config exit with
status 1 if the key is not found but --get-urlmatch succeeds in this
case.

Change --get-urlmatch to behave in the same way as the other --get*
options so that all four are consistent.  --get-color is a special case
because it accepts a default value to return and so should not return an
error if the key is not found.

Also clarify this behaviour in the documentation.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-config.txt | 2 +-
 builtin/config.c             | 5 ++++-
 t/t1300-repo-config.sh       | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 153b2d8..2a04e87 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -102,7 +102,7 @@ OPTIONS
 	given URL is returned (if no such key exists, the value for
 	section.key is used as a fallback).  When given just the
 	section as name, do so for all the keys in the section and
-	list them.
+	list them.  Returns error code 1 if no value is found.
 
 --global::
 	For writing options: write to global `~/.gitconfig` file
diff --git a/builtin/config.c b/builtin/config.c
index ca9f834..1d7c6ef 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -417,6 +417,7 @@ static int urlmatch_collect_fn(const char *var, const char *value, void *cb)
 
 static int get_urlmatch(const char *var, const char *url)
 {
+	int ret;
 	char *section_tail;
 	struct string_list_item *item;
 	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
@@ -443,6 +444,8 @@ static int get_urlmatch(const char *var, const char *url)
 	git_config_with_options(urlmatch_config_entry, &config,
 				&given_config_source, respect_includes);
 
+	ret = !values.nr;
+
 	for_each_string_list_item(item, &values) {
 		struct urlmatch_current_candidate_value *matched = item->util;
 		struct strbuf buf = STRBUF_INIT;
@@ -459,7 +462,7 @@ static int get_urlmatch(const char *var, const char *url)
 	free(config.url.url);
 
 	free((void *)config.section);
-	return 0;
+	return ret;
 }
 
 static char *default_user_config(void)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8867ce1..89d8c47 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1148,6 +1148,9 @@ test_expect_success 'urlmatch' '
 		cookieFile = /tmp/cookie.txt
 	EOF
 
+	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://good.example.com >actual &&
+	test_must_be_empty actual &&
+
 	echo true >expect &&
 	git config --bool --get-urlmatch http.SSLverify https://good.example.com >actual &&
 	test_cmp expect actual &&
-- 
2.7.1.503.g3cfa3ac
