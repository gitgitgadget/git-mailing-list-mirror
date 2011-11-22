From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/3] revert: write REVERT_HEAD pseudoref during conflicted
 revert
Date: Tue, 22 Nov 2011 05:17:36 -0600
Message-ID: <20111122111736.GE7399@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:17:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoME-0002ib-2h
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab1KVLRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:17:41 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39187 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab1KVLRk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 06:17:40 -0500
Received: by ywt32 with SMTP id 32so34737ywt.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JQrG5qiYglcAIg1jHgm3IpjJdNvZO8CO20gZnQeEm6M=;
        b=ANljcgmuxU6YyQxEt03bDClaBQrHQ5qa+reRuXzutO/xNXaZ+HtDTP7lCzqDhIa9q4
         uC/W4iuzNk3H/ZBtMcmAlMd4fbwtiVlbHe+kWfsC/JTbG4paYhY60So9gBkEO5X/efRN
         /QQ451OyHsBi/0vBWwaqF7+eY2C4YgU9dI6Ok=
Received: by 10.50.169.1 with SMTP id aa1mr20195097igc.9.1321960659858;
        Tue, 22 Nov 2011 03:17:39 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e2sm58820877ibe.0.2011.11.22.03.17.38
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 03:17:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185785>

When conflicts are encountered while reverting a commit, it can be
handy to have the name of that commit easily available.  For example,
to produce a copy of the patch to refer to while resolving conflicts:

	$ git revert 2eceb2a8
	error: could not revert 2eceb2a8... awesome, buggy feature
	$ git show -R REVERT_HEAD >the-patch
	$ edit $(git diff --name-only)

Set a REVERT_HEAD pseudoref when "git revert" does not make a commit,
for cases like this.  This also makes it possible for scripts to
distinguish between a revert that encountered conflicts and other
sources of an unmerged index.

After successfully committing, resetting with "git reset", or moving
to another commit with "git checkout" or "git reset", the pseudoref is
no longer useful, so remove it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 branch.c                        |    1 +
 builtin/commit.c                |    1 +
 builtin/revert.c                |    8 +++--
 t/t3507-cherry-pick-conflict.sh |   54 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index d8098762..025a97be 100644
--- a/branch.c
+++ b/branch.c
@@ -241,6 +241,7 @@ void create_branch(const char *head,
 void remove_branch_state(void)
 {
 	unlink(git_path("CHERRY_PICK_HEAD"));
+	unlink(git_path("REVERT_HEAD"));
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d18..8f2bebec 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1514,6 +1514,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
+	unlink(git_path("REVERT_HEAD"));
 	unlink(git_path("MERGE_HEAD"));
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
diff --git a/builtin/revert.c b/builtin/revert.c
index 1d112e4c..f5ba67a5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -289,7 +289,7 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void write_cherry_pick_head(struct commit *commit)
+static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
 {
 	const char *filename;
 	int fd;
@@ -297,7 +297,7 @@ static void write_cherry_pick_head(struct commit *commit)
 
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
 
-	filename = git_path("CHERRY_PICK_HEAD");
+	filename = git_path(pseudoref);
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -597,7 +597,9 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * write it at all.
 	 */
 	if (opts->action == CHERRY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		write_cherry_pick_head(commit);
+		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
+	if (opts->action == REVERT && ((opts->no_commit && res == 0) || res == 1))
+		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
 		error(opts->action == REVERT
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index cb45574a..ee1659c1 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -253,6 +253,60 @@ test_expect_success 'revert also handles conflicts sanely' '
 	test_cmp expected actual
 '
 
+test_expect_success 'failed revert sets REVERT_HEAD' '
+	pristine_detach initial &&
+	test_must_fail git revert picked &&
+	test_cmp_rev picked REVERT_HEAD
+'
+
+test_expect_success 'successful revert does not set REVERT_HEAD' '
+	pristine_detach base &&
+	git revert base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	test_must_fail git rev-parse --verify REVERT_HEAD
+'
+
+test_expect_success 'revert --no-commit sets REVERT_HEAD' '
+	pristine_detach base &&
+	git revert --no-commit base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	test_cmp_rev base REVERT_HEAD
+'
+
+test_expect_success 'revert w/dirty tree does not set REVERT_HEAD' '
+	pristine_detach base &&
+	echo foo > foo &&
+	test_must_fail git revert base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	test_must_fail git rev-parse --verify REVERT_HEAD
+'
+
+test_expect_success 'GIT_CHERRY_PICK_HELP does not suppress REVERT_HEAD' '
+	pristine_detach initial &&
+	(
+		GIT_CHERRY_PICK_HELP="and then do something else" &&
+		GIT_REVERT_HELP="and then do something else, again" &&
+		export GIT_CHERRY_PICK_HELP GIT_REVERT_HELP &&
+		test_must_fail git revert picked
+	) &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	test_cmp_rev picked REVERT_HEAD
+'
+
+test_expect_success 'git reset clears REVERT_HEAD' '
+	pristine_detach initial &&
+	test_must_fail git revert picked &&
+	git reset &&
+	test_must_fail git rev-parse --verify REVERT_HEAD
+'
+
+test_expect_success 'failed commit does not clear REVERT_HEAD' '
+	pristine_detach initial &&
+	test_must_fail git revert picked &&
+	test_must_fail git commit &&
+	test_cmp_rev picked REVERT_HEAD
+'
+
 test_expect_success 'revert conflict, diff3 -m style' '
 	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-- 
1.7.8.rc3
