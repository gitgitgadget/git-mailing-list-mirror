Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B7E20209
	for <e@80x24.org>; Mon,  3 Jul 2017 09:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbdGCJ51 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 05:57:27 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:37308
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753383AbdGCJ50 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 05:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1499075843;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=bN/RTZ9ZBV/kkHHW6pzQkWmxwVCBTYjTEuF2A0wb1Js=;
        b=GT8QCfiupugTL+ldWIw8tez6St4sTDC6iV2/yS9CnJm9pIg4i8NGaqj7J5ZVrI9X
        4Tbxuubkocg6qvmNjIOV+3Fsnk0QiFmiPOYjpCmVeJJqrArlJMXsW6y62ilKs8uqPAZ
        fms4eiJSmJ+YylS7IKVh+STh/T31xOvCf43bDCrk=
From:   =?UTF-8?Q?=C5=81ukasz_Gryglicki?= <lukaszgryglicki@o2.pl>
To:     git@vger.kernel.org
Message-ID: <0102015d07e215ae-a711670e-8315-40b9-90cf-f95075525622-000000@eu-west-1.amazonses.com>
Subject: [PATCH] area: git-merge: add --signoff flag to git-merge
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 3 Jul 2017 09:57:23 +0000
X-SES-Outgoing: 2017.07.03-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added --signoff flag to `git-merge` command, added test coverage,
updated documentation.

Signed-off-by: lukaszgryglicki <lukaszgryglicki@o2.pl>
---
 Documentation/git-merge.txt  |  8 ++++++
 builtin/merge.c              |  4 +++
 t/t9904-git-merge-signoff.sh | 60 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
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
index 900bafdb45d0b..cb09f4138136b 100644
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
 
@@ -775,6 +777,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	strbuf_stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
 		abort_commit(remoteheads, _("Empty commit message."));
+	if (signoff)
+		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 	strbuf_release(&merge_msg);
 	strbuf_addbuf(&merge_msg, &msg);
 	strbuf_release(&msg);
diff --git a/t/t9904-git-merge-signoff.sh b/t/t9904-git-merge-signoff.sh
new file mode 100755
index 0000000000000..eed15b9a85371
--- /dev/null
+++ b/t/t9904-git-merge-signoff.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='git merge --signoff
+
+This test runs git merge --signoff and make sure that it works.
+'
+
+. ./test-lib.sh
+
+# A simple files to commit
+cat >file1 <<EOF
+1
+EOF
+
+cat >file2 <<EOF
+2
+EOF
+
+cat >file3 <<EOF
+3
+EOF
+
+# Expected commit message after merge --signoff
+cat >expected-signed <<EOF
+Merge branch 'master' into other-branch
+
+Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+EOF
+
+# Expected commit message after merge without --signoff (or with --no-signoff)
+cat >expected-unsigned <<EOF
+Merge branch 'master' into other-branch
+EOF
+
+
+# We configure an alias to do the merge --signoff so that
+# on the next subtest we can show that --no-signoff overrides the alias
+test_expect_success 'merge --signoff adds a sign-off line' '
+	git commit --allow-empty -m "Initial empty commit" &&
+  git checkout -b other-branch &&
+	git add file1 && git commit -m other-branch &&
+  git checkout master &&
+	git add file2 && git commit -m master-branch &&
+  git checkout other-branch &&
+  git config alias.msob "merge --signoff --no-edit" &&
+	git msob master &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	test_cmp expected-signed actual
+'
+
+test_expect_success 'master --no-signoff does not add a sign-off line' '
+	git checkout master &&
+  git add file3 && git commit -m master-branch-2 &&
+  git checkout other-branch &&
+	git msob --no-signoff master &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	test_cmp expected-unsigned actual
+'
+
+test_done

--
https://github.com/git/git/pull/381
