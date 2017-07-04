Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87092201A0
	for <e@80x24.org>; Tue,  4 Jul 2017 06:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdGDGUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 02:20:33 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:52520
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750830AbdGDGUc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2017 02:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1499149230;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=cU2hHARSS2UPKITzNHDESvoVFOS7wXZ6wPvXCuMk73M=;
        b=CiZBFOXeK5MXO6HdJpe4F7ggtRXLvgQl8eK9I2l4EbAfjz65wyOszdsUlZM35srm
        vSHSjd268zFcLsQ1glJHpJ3Aw1H1zPbBuZhk7R7InCWKig7/SfU5a+lDr4cHQy9Txce
        GiP6I1Qbt5BP8BikgQfIHXFl4d/NFpP1i/MYDugo=
From:   =?UTF-8?Q?=C5=81ukasz_Gryglicki?= <lukaszgryglicki@o2.pl>
To:     git@vger.kernel.org
Message-ID: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015d07e215ae-a711670e-8315-40b9-90cf-f95075525622-000000@eu-west-1.amazonses.com>
References: <0102015d07e215ae-a711670e-8315-40b9-90cf-f95075525622-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] add --signoff flag to `git-merge` command.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 4 Jul 2017 06:20:28 +0000
X-SES-Outgoing: 2017.07.04-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some projects require every commit to be signed off.
Our workflow is to create feature branches and require every commit to
be signed off. When feature is finally approved we need to merge it into
master. Merge itself is usually trivial and is done by
`git merge origin/master`. Unfortunatelly this command have no --signoff
flag, so we need to either add signoff line manually or use
`git commit --amend -s` after the merge. First solution is not ideal
because not all developers are familiar with exact sign-off syntax.
The second solution works, but is obviously tedious.
This patch adds --signoff support to git-merge command. It works just
like --signoff in `git-commit` command.
More details here:
https://public-inbox.org/git/CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com/T/#u

Signed-off-by: lukaszgryglicki <lukaszgryglicki@o2.pl>
---
 Documentation/git-merge.txt  |  8 +++++
 builtin/merge.c              |  4 +++
 t/t9904-git-merge-signoff.sh | 75 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100755 t/t9904-git-merge-signoff.sh

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 04fdd8cf086db..6b308ab6d0b52 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -64,6 +64,14 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
+--signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project,
+	but it typically certifies that committer has
+	the rights to submit this work under the same license and
+	agrees to a Developer Certificate of Origin
+	(see http://developercertificate.org/ for more information).
+
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign the resulting merge commit. The `keyid` argument is
diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb45d0b..78c36e9bf353b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -70,6 +70,7 @@ static int continue_current_merge;
 static int allow_unrelated_histories;
 static int show_progress = -1;
 static int default_to_upstream = 1;
+static int signoff;
 static const char *sign_commit;
 
 static struct strategy all_strategy[] = {
@@ -233,6 +234,7 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
+	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
 	OPT_END()
 };
 
@@ -763,6 +765,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	strbuf_addch(&msg, '\n');
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
+	if (signoff)
+		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(), "merge", NULL))
diff --git a/t/t9904-git-merge-signoff.sh b/t/t9904-git-merge-signoff.sh
new file mode 100755
index 0000000000000..f542f136f5dda
--- /dev/null
+++ b/t/t9904-git-merge-signoff.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='git merge --signoff
+
+This test runs git merge --signoff and makes sure that it works.
+'
+
+. ./test-lib.sh
+
+# Setup test files
+test_setup() {
+	# A simples files to commit
+	echo "1" >file1
+	echo "2" >file2
+	echo "3" >file3
+	echo "4" >file4
+
+	# Expected commit message after merge --signoff
+	cat >expected-signed <<EOF
+Merge branch 'master' into other-branch
+
+Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+EOF
+
+	# Expected commit message after merge without --signoff (or with --no-signoff)
+	cat >expected-unsigned <<EOF
+Merge branch 'master' into other-branch
+EOF
+
+	# Initial commit and feature branch to merge master into it.
+	git commit --allow-empty -m "Initial empty commit"
+	git checkout -b other-branch
+	git add file1
+	git commit -m other-branch
+}
+
+# Setup repository, files & feature branch
+test_expect_success 'setup' '
+	test_setup
+'
+
+# Test with --signoff flag
+test_expect_success 'git merge --signoff adds a sign-off line' '
+	git checkout master &&
+	git add file2 &&
+	git commit -m master-branch &&
+	git checkout other-branch &&
+	git merge master --signoff --no-edit &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-signed actual
+'
+
+# Test without --signoff flag
+test_expect_success 'git merge does not add a sign-off line' '
+	git checkout master &&
+	git add file3 &&
+	git commit -m master-branch-2 &&
+	git checkout other-branch &&
+	git merge master --no-edit &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-unsigned actual
+'
+
+# Test for --no-signoff flag
+test_expect_success 'git merge --no-signoff flag cancels --signoff flag' '
+	git checkout master &&
+	git add file4 &&
+	git commit -m master-branch-3 &&
+	git checkout other-branch &&
+	git merge master --no-edit --signoff --no-signoff &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	test_cmp expected-unsigned actual
+'
+
+test_done

--
https://github.com/git/git/pull/382
