From: Caleb Thompson <cjaysson@gmail.com>
Subject: [PATCH v3 5/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 13:56:26 -0500
Message-ID: <1401130586-93105-6-git-send-email-caleb@calebthompson.io>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 20:56:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp04w-0001UC-NH
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 20:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbaEZS4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 14:56:47 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35788 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbaEZS4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 14:56:46 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so262870igb.6
        for <git@vger.kernel.org>; Mon, 26 May 2014 11:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=50r09CPjAfi8ZvM73viG2K2NOekQoOsz9P1WFBJVe40=;
        b=G6qdjSiSwlPlhMsc6sXmZxz/cbJbSqQh4g0lo7m+nsNgMZE3OUS5CXi/A75HqGeWDv
         b2yuXXS1WLybqkhVxPXiz6ToMAOMV+2TlezYkzs7iJcohjvcVXoPeEToIGGMlLhjfUH5
         KVaxdjwhf8nXbp6RibB18F2QLLttsktevE/4Wzv7YM7BPhpjFESo1Tqk+uhJmWTYeNv0
         LG+xdKQRLjXOHLtg020NtV/0ClmSQnFGDFEmUHoQtJ3gECHkcjm+3RZfKIZgDK8n842x
         KfOg/9QqPhfC1taICeSIS1BSKo6Ek98QOhXkXMzT6Rhe3DBget7TT6JExrrTQoPBu/x8
         49qQ==
X-Received: by 10.50.253.163 with SMTP id ab3mr27805687igd.35.1401130605486;
        Mon, 26 May 2014 11:56:45 -0700 (PDT)
Received: from sirius.att.net (107-216-44-113.lightspeed.austtx.sbcglobal.net. [107.216.44.113])
        by mx.google.com with ESMTPSA id ql7sm1708857igc.19.2014.05.26.11.56.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 11:56:44 -0700 (PDT)
X-Google-Original-From: Caleb Thompson <caleb@calebthompson.io>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250114>

Add a new configuration variable commit.verbose to implicitly pass
`--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
setting.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 Documentation/config.txt               |  5 +++++
 Documentation/git-commit.txt           |  8 +++++++-
 builtin/commit.c                       |  6 +++++-
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 36 ++++++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..a245928 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1009,6 +1009,11 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean to enable/disable inclusion of diff information in the
+	commit message template when using an editor to prepare the commit
+	message.  Defaults to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..8cb3439 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,7 +282,13 @@ configuration variable documented in linkgit:git-config[1].
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
-	lines prefixed with '#'.
+	lines prefixed with '#'.  The `commit.verbose` configuration
+	variable can be set to true to implicitly send this option.
+
+--no-verbose::
+	Do not show the unified diff at the bottom of the commit message
+	template.  This is the default behavior, but can be used to override
+	the `commit.verbose` configuration variable.
 
 -q::
 --quiet::
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..7978d7f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1417,6 +1417,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
@@ -1484,7 +1488,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
-		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
+		OPT_BOOL('v', "verbose", &verbose, N_("show diff in commit message template")),
 
 		OPT_GROUP(N_("Commit message options")),
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c59a76..b8f4b94 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,7 @@ _git_config ()
 		color.ui
 		commit.status
 		commit.template
+		commit.verbose
 		core.abbrev
 		core.askpass
 		core.attributesfile
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 310b68b..b9eb317 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -7,6 +7,10 @@ write_script check-for-diff <<-EOF
 	exec grep '^diff --git' "\$1"
 EOF
 
+write_script check-for-no-diff <<-EOF
+	exec grep -v '^diff --git' "\$1"
+EOF
+
 cat >message <<'EOF'
 subject
 
@@ -49,6 +53,38 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
 	check_message message
 '
 
+test_expect_success 'commit shows verbose diff with set commit.verbose=true' '
+	echo morecontent >>file &&
+	git add file &&
+	test_config commit.verbose true &&
+	test_set_editor "$(pwd)/check-for-diff" &&
+	git commit --amend
+'
+
+test_expect_success 'commit --verbose overrides verbose=false' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose false  &&
+	test_set_editor "$(pwd)/check-for-diff" &&
+	git commit --amend --verbose
+'
+
+test_expect_success 'commit does not show verbose diff with commit.verbose=false' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose false &&
+	test_set_editor "$(pwd)/check-for-no-diff" &&
+	git commit --amend
+'
+
+test_expect_success 'commit --no-verbose overrides commit.verbose=true' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose true &&
+	test_set_editor "$(pwd)/check-for-no-diff" &&
+	git commit --amend --no-verbose
+'
+
 cat >diff <<'EOF'
 This is an example commit message that contains a diff.
 
-- 
1.9.3
