Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F9720899
	for <e@80x24.org>; Wed, 26 Jul 2017 07:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbdGZHjs (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 03:39:48 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:56450
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750907AbdGZHjr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jul 2017 03:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1501054785;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=2N7flhCIg/kSvbwMNou0d3nbYs7XPoZEAlCBIR5rth0=;
        b=f6K9S4lBoaMiIxeKSn+Sx/dvrUPKroEoZ3kUe+kpEaAYlYZt4OKPftdupP7BYVFK
        oWoO5zgeMuA4UI0HdhhfAPO9lOZLqKEPRUhjGWk9xQ86sEDGsfsP4KyByA0DobI0NMs
        W52zMo7jOgXnMrBZnrloWTkbnFkc9r2/pWG9IQtY=
From:   =?UTF-8?Q?=C5=81ukasz_Gryglicki?= <lukaszgryglicki@o2.pl>
To:     git@vger.kernel.org
Message-ID: <0102015d7dd656e3-4b41453e-ad40-4e56-98cf-67597b81c281-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
References: <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
Subject: [PATCH v4] merge: add a --signoff flag.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 26 Jul 2017 07:39:45 +0000
X-SES-Outgoing: 2017.07.26-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some projects require every commit, even merges, to be signed off [*1*].
Because "git merge" does not have a "--signoff"
option like "git commit" does, the user needs to add one
manually when the command presents an editor to describe the
merge, or later use "git commit --amend --signoff".

Help developers of these projects by teaching "--signoff" option to "git me=
rge".

*1*
https://public-inbox.org/git/CAHv71zK5SqbwrBFX=3Da8-DY9H3KT4FEyMgv__p2gZzNr=
0WUAPUw@mail.gmail.com/T/#u

Requested-by: Dan Kohn <dan@linuxfoundation.org>
Signed-off-by: =C5=81ukasz Gryglicki <lukaszgryglicki@o2.pl>
---
 Documentation/git-merge.txt |  8 +++++
 builtin/merge.c             |  4 +++
 t/t7614-merge-signoff.sh    | 88 +++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 100 insertions(+)
 create mode 100755 t/t7614-merge-signoff.sh

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 04fdd8cf086db..630cb4b7f90d7 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -64,6 +64,14 @@ OPTIONS
 -------
 include::merge-options.txt[]
=20
+--signoff::
+=09Add Signed-off-by line by the committer at the end of the commit
+=09log message.  The meaning of a signoff depends on the project,
+=09but it typically certifies that committer has
+=09the rights to merge work under the same license and
+=09agrees to a Developer Certificate of Origin
+=09(see http://developercertificate.org/ for more information).
+
 -S[<keyid>]::
 --gpg-sign[=3D<keyid>]::
 =09GPG-sign the resulting merge commit. The `keyid` argument is
diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb45d0b..78c36e9bf353b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -70,6 +70,7 @@ static int continue_current_merge;
 static int allow_unrelated_histories;
 static int show_progress =3D -1;
 static int default_to_upstream =3D 1;
+static int signoff;
 static const char *sign_commit;
=20
 static struct strategy all_strategy[] =3D {
@@ -233,6 +234,7 @@ static struct option builtin_merge_options[] =3D {
 =09{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 =09  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 =09OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored f=
iles (default)")),
+=09OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
 =09OPT_END()
 };
=20
@@ -763,6 +765,8 @@ static void prepare_to_commit(struct commit_list *remot=
eheads)
 =09strbuf_addch(&msg, '\n');
 =09if (0 < option_edit)
 =09=09strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_ch=
ar);
+=09if (signoff)
+=09=09append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
 =09write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
 =09if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-=
msg",
 =09=09=09    git_path_merge_msg(), "merge", NULL))
diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
new file mode 100755
index 0000000000000..823d840d423df
--- /dev/null
+++ b/t/t7614-merge-signoff.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description=3D'git merge --signoff
+
+This test runs git merge --signoff and makes sure that it works.
+'
+
+. ./test-lib.sh
+
+# Setup test files
+test_setup () {
+  # Expected commit message after merge --signoff
+  printf "Merge branch 'master' into other-branch\n\n" >expected-signed &&
+  printf "Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/"=
)\n" >>expected-signed &&
+
+  # Expected commit message after merge without --signoff (or with --no-si=
gnoff)
+  echo "Merge branch 'master' into other-branch" >expected-unsigned &&
+
+  # Initial commit and feature branch to merge master into it.
+  git commit --allow-empty -m "Initial empty commit" &&
+  git checkout -b other-branch &&
+  test_commit other-branch file1 1
+}
+
+# Create fake editor that just copies file
+create_fake_editor () {
+  echo 'cp "$1" "$1.saved"' | write_script save-editor
+}
+
+test_expect_success 'setup' '
+  test_setup && create_fake_editor
+'
+
+test_expect_success 'git merge --signoff adds a sign-off line' '
+  git checkout master &&
+  test_commit master-branch-2 file2 2 &&
+  git checkout other-branch &&
+  git merge master --signoff --no-edit &&
+  git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+  test_cmp expected-signed actual
+'
+
+test_expect_success 'git merge does not add a sign-off line' '
+  git checkout master &&
+  test_commit master-branch-3 file3 3 &&
+  git checkout other-branch &&
+  git merge master --no-edit &&
+  git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+  test_cmp expected-unsigned actual
+'
+
+test_expect_success 'git merge --no-signoff flag cancels --signoff flag' '
+  git checkout master &&
+  test_commit master-branch-4 file4 4 &&
+  git checkout other-branch &&
+  git merge master --no-edit --signoff --no-signoff &&
+  git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+  test_cmp expected-unsigned actual
+'
+
+test_expect_success 'git merge --signoff adds S-o-b line in commit message=
 editor' '
+  git checkout master &&
+  test_commit master-branch-5 file5 5 &&
+  git checkout other-branch &&
+  GIT_EDITOR=3D./save-editor git merge master -m "My Message" --edit --sig=
noff &&
+  test_i18ngrep "^My Message" .git/MERGE_MSG.saved &&
+  test_i18ngrep "^Signed-off-by: " .git/MERGE_MSG.saved
+'
+
+test_expect_success 'git merge --no-signoff does not add S-o-b line in com=
mit message editor' '
+  git checkout master &&
+  test_commit master-branch-6 file6 6 &&
+  git checkout other-branch &&
+  GIT_EDITOR=3D./save-editor git merge master -m "My Message" --edit --no-=
signoff &&
+  test_i18ngrep "^My Message" .git/MERGE_MSG.saved &&
+  test_i18ngrep ! "^Signed-off-by: " .git/MERGE_MSG.saved
+'
+
+test_expect_success 'git merge --no-signoff cancels --signoff flag in comm=
it message editor' '
+  git checkout master &&
+  test_commit master-branch-7 file7 7 &&
+  git checkout other-branch &&
+  GIT_EDITOR=3D./save-editor git merge master -m "My Message" --edit --sig=
noff --no-signoff &&
+  test_i18ngrep "^My Message" .git/MERGE_MSG.saved &&
+  test_i18ngrep ! "^Signed-off-by: " .git/MERGE_MSG.saved
+'
+
+test_done

--
https://github.com/git/git/pull/390
