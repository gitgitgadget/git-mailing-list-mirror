Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5687B2036C
	for <e@80x24.org>; Fri,  6 Oct 2017 08:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbdJFIH6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 04:07:58 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:37518
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751710AbdJFIH5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 04:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1507277275;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=/91945fRuMrn111KSWv95KsBOeRKt8aNIQ2Ttwfa6iQ=;
        b=K0UGz+tc7/zWkTgl1TF6BACCdA2ALTvSN0cJgFmHjTpsoM/61N7rQojfI1XezOx8
        vaqRbeo41246O1Lult1d3Qi2OVBnQIcI1mAOiTOlOJ+eIgfbKvSPyHGL2p5r4Bz96xL
        FS8uEj+EHdl/sLmVk16bjiwHDJI2LYOo33j7tGp8=
From:   =?UTF-8?Q?Damien_Mari=C3=A9?= <damien@dam.io>
To:     git@vger.kernel.org
Message-ID: <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
In-Reply-To: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
References: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
Subject: [PATCH v3] run-command: add hint when a hook is ignored
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 6 Oct 2017 08:07:55 +0000
X-SES-Outgoing: 2017.10.06-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an hook is present but the file is not set as executable then git will
ignore the hook.
For now this is silent which can be confusing.

This commit adds this warning to improve the situation:

  hint: The 'pre-commit' hook was ignored because it's not set as executabl=
e.
  hint: You can disable this warning with `git config advice.ignoredHook fa=
lse`

To allow the old use-case of enabling/disabling hooks via the executable fl=
ag a
new setting is introduced: advice.ignoredHook.

Signed-off-by: Damien Mari=C3=A9 <damien@dam.io>
---
 Documentation/config.txt               |  3 +++
 advice.c                               |  2 ++
 advice.h                               |  1 +
 contrib/completion/git-completion.bash |  1 +
 run-command.c                          | 18 +++++++++++++++
 t/t7520-ignored-hook-warning.sh        | 41 ++++++++++++++++++++++++++++++=
++++
 6 files changed, 66 insertions(+)
 create mode 100755 t/t7520-ignored-hook-warning.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb046..9abca499f725c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -351,6 +351,9 @@ advice.*::
 =09addEmbeddedRepo::
 =09=09Advice on what to do when you've accidentally added one
 =09=09git repo inside of another.
+=09ignoredHook::
+=09=09Advice shown if an hook is ignored because the it's not
+=09=09set as executable.
 --
=20
 core.fileMode::
diff --git a/advice.c b/advice.c
index d81e1cb7425b0..970bd2b71bf53 100644
--- a/advice.c
+++ b/advice.c
@@ -17,6 +17,7 @@ int advice_set_upstream_failure =3D 1;
 int advice_object_name_warning =3D 1;
 int advice_rm_hints =3D 1;
 int advice_add_embedded_repo =3D 1;
+int advice_ignored_hook =3D 1;
=20
 static struct {
 =09const char *name;
@@ -38,6 +39,7 @@ static struct {
 =09{ "objectnamewarning", &advice_object_name_warning },
 =09{ "rmhints", &advice_rm_hints },
 =09{ "addembeddedrepo", &advice_add_embedded_repo },
+=09{ "ignoredhook", &advice_ignored_hook},
=20
 =09/* make this an alias for backward compatibility */
 =09{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index c84a44531c7d8..f525d6f89cb44 100644
--- a/advice.h
+++ b/advice.h
@@ -19,6 +19,7 @@ extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
+extern int advice_ignored_hook;
=20
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index d93441747523a..a331ccc556b01 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2350,6 +2350,7 @@ _git_config ()
 =09=09advice.rmHints
 =09=09advice.statusHints
 =09=09advice.statusUoption
+=09=09advice.ignoredHook
 =09=09alias.
 =09=09am.keepcr
 =09=09am.threeWay
diff --git a/run-command.c b/run-command.c
index b5e6eb37c0eb3..288abbba5afd7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -5,6 +5,7 @@
 #include "argv-array.h"
 #include "thread-utils.h"
 #include "strbuf.h"
+#include "string-list.h"
=20
 void child_process_init(struct child_process *child)
 {
@@ -1169,11 +1170,28 @@ const char *find_hook(const char *name)
 =09strbuf_reset(&path);
 =09strbuf_git_path(&path, "hooks/%s", name);
 =09if (access(path.buf, X_OK) < 0) {
+=09=09int err =3D errno;
+
 #ifdef STRIP_EXTENSION
 =09=09strbuf_addstr(&path, STRIP_EXTENSION);
 =09=09if (access(path.buf, X_OK) >=3D 0)
 =09=09=09return path.buf;
+=09=09if (errno =3D=3D EACCES)
+=09=09=09err =3D errno;
 #endif
+
+=09=09if (err =3D=3D EACCES && advice_ignored_hook) {
+=09=09=09static struct string_list advise_given =3D STRING_LIST_INIT_DUP;
+=09=09=09
+=09=09=09if (!string_list_lookup(&advise_given, name)) {
+=09=09=09=09string_list_insert(&advise_given, name);
+=09=09=09=09advise(_("The '%s' hook was ignored because "
+=09=09=09=09=09=09=09"it's not set as executable.\n"
+=09=09=09=09=09=09=09"You can disable this warning with "
+=09=09=09=09=09=09=09"`git config advice.ignoredHook false`."),
+=09=09=09=09=09=09path.buf);
+=09=09=09}
+=09=09}
 =09=09return NULL;
 =09}
 =09return path.buf;
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning=
.sh
new file mode 100755
index 0000000000000..634fb7f23a040
--- /dev/null
+++ b/t/t7520-ignored-hook-warning.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description=3D'ignored hook warning'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+=09hookdir=3D"$(git rev-parse --git-dir)/hooks" &&
+=09hook=3D"$hookdir/pre-commit" &&
+=09mkdir -p "$hookdir" &&
+=09write_script "$hook" <<-\EOF
+=09exit 0
+=09EOF
+'
+
+test_expect_success 'no warning if hook is not ignored' '
+=09git commit --allow-empty -m "more" 2>message &&
+=09test_i18ngrep ! -e "hook was ignored" message
+'
+
+test_expect_success POSIXPERM 'warning if hook is ignored' '
+=09chmod -x "$hook" &&
+=09git commit --allow-empty -m "even more" 2>message &&
+=09test_i18ngrep -e "hook was ignored" message
+'
+
+test_expect_success POSIXPERM 'no warning if advice.ignoredHook set to fal=
se' '
+=09test_config advice.ignoredHook false &&
+=09chmod -x "$hook" &&
+=09git commit --allow-empty -m "even more" 2>message &&
+=09test_i18ngrep ! -e "hook was ignored" message
+'
+
+test_expect_success 'no warning if unset advice.ignoredHook and hook remov=
ed' '
+=09rm -f "$hook" &&
+=09test_unconfig advice.ignoredHook &&
+=09git commit --allow-empty -m "even more" 2>message &&
+=09test_i18ngrep ! -e "hook was ignored" message
+'
+
+test_done

--
https://github.com/git/git/pull/411
