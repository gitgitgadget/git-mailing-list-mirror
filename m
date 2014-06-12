From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v5 4/4] commit: Add commit.verbose configuration
Date: Thu, 12 Jun 2014 15:00:25 -0500
Message-ID: <1402603225-46240-1-git-send-email-caleb@calebthompson.io>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 22:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvBAw-0003ou-Ro
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 22:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbaFLUAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 16:00:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55924 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752013AbaFLUAh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 16:00:37 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0C38B637;
	Thu, 12 Jun 2014 16:00:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 12 Jun 2014 16:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=
	mesmtp; bh=ZfCCXhipZtq5QFtZ3Lu6jZRZSIQ=; b=UqlBJ8FBlL4aIhej/GwPx
	CjCdwdNCN0fhQnu91GeGX1D7uSGVCtKY4JQbP0NpnOI/QG58hxzjtjvxdt9rhTMe
	tb8eDOvm2DRz/7VYdKXc4AkLshJtqmLt1tRPvDYD2b+4raNmFob8nEBbJANuCp5c
	+q/30YiszuB1Lgewr8u1gY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=ZfCCXhipZtq5QFtZ3Lu6jZRZS
	IQ=; b=cm75w8lXCAs//SrLplIQrrb3bZyP5p83mQwGrdX5qggiNm5SU0oZAagJ5
	ppVbsQHGa/4eCHQ6LjWXu6ul4GtRxb2miLdw2PYK9aKrAngl6oLRZ7lKdyWT0az0
	vhFclY06nRhakBXLy69YnMuDjqtkR1aaMFig3Wy9EhlYxccpJo=
X-Sasl-enc: KO5NClczEiP2r2zsIUVqob1gGLvjrgd2h5cmvVR88Ibf 1402603236
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6C93768019B;
	Thu, 12 Jun 2014 16:00:35 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251492>

Add a new configuration variable commit.verbose to implicitly pass
--verbose to git-commit. Ensure that --no-verbose to git-commit
negates that setting.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 Documentation/config.txt               |  5 +++++
 Documentation/git-commit.txt           |  8 +++++++-
 builtin/commit.c                       |  4 ++++
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 36 ++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd2d651..ec51e1c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1017,6 +1017,11 @@ commit.template::
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
index 99c2044..c782388 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1489,6 +1489,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
		sign_commit = git_config_bool(k, v) ? "" : NULL;
		return 0;
	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose = git_config_bool(k, v);
+		return 0;
+	}

	status = git_gpg_config(k, v, NULL);
	if (status)
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
index 35a4d06..402d6a1 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
	exec grep '^diff --git' "$1"
 EOF

+write_script check-for-no-diff <<-'EOF'
+	exec grep -v '^diff --git' "$1"
+EOF
+
 cat >message <<'EOF'
 subject

@@ -48,6 +52,38 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
	check_message message
 '

+test_expect_success 'commit shows verbose diff with commit.verbose true' '
+	echo morecontent >>file &&
+	git add file &&
+	test_config commit.verbose true &&
+	test_set_editor "$PWD/check-for-diff" &&
+	git commit --amend
+'
+
+test_expect_success 'commit --verbose overrides commit.verbose false' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose false  &&
+	test_set_editor "$PWD/check-for-diff" &&
+	git commit --amend --verbose
+'
+
+test_expect_success 'commit does not show verbose diff with commit.verbose false' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose false &&
+	test_set_editor "$PWD/check-for-no-diff" &&
+	git commit --amend
+'
+
+test_expect_success 'commit --no-verbose overrides commit.verbose true' '
+	echo evenmorecontent >>file &&
+	git add file &&
+	test_config commit.verbose true &&
+	test_set_editor "$PWD/check-for-no-diff" &&
+	git commit --amend --no-verbose
+'
+
 cat >diff <<'EOF'
 This is an example commit message that contains a diff.

--
2.0.0
