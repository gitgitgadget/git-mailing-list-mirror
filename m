Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D540E1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdJEUxL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:53:11 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:48854
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751454AbdJEUxK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Oct 2017 16:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1507236789;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Dw0t/MJsnfDVbFwzfAXGK6t00fdAizNzJ7khl+wPk3A=;
        b=PEzRVMRebai0LBF+vbplQKVnD9Ajz1EQs71czOR/54G+iJpt+QIjp4UrU1tc6kqk
        INw5X/JLN/LTZrpNaNd8nzNo/8Is1rddf5YwVFRmBetDGJRvMU4n3VYeumZBp+2uv2Z
        //bxSmr1a0LRSr/jVItizjPXA2h9Ie/xoGdMdpi4=
From:   =?UTF-8?Q?Damien_Mari=C3=A9?= <damien@dam.io>
To:     git@vger.kernel.org
Message-ID: <0102015eee503678-52126849-7580-4832-9d46-0f5ac7a52336-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] run-command: add hint when a hook is ignored
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 5 Oct 2017 20:53:07 +0000
X-SES-Outgoing: 2017.10.05-54.240.7.17
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
 Documentation/config.txt               |  3 ++
 advice.c                               |  2 +
 advice.h                               |  1 +
 contrib/completion/git-completion.bash |  1 +
 run-command.c                          | 10 +++++
 t/t7519-ignored-hook-warning.sh        | 67 ++++++++++++++++++++++++++++++=
++++
 6 files changed, 84 insertions(+)
 create mode 100755 t/t7519-ignored-hook-warning.sh

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
index b5e6eb37c0eb3..9456355595cc1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1169,11 +1169,21 @@ const char *find_hook(const char *name)
 =09strbuf_reset(&path);
 =09strbuf_git_path(&path, "hooks/%s", name);
 =09if (access(path.buf, X_OK) < 0) {
+=09=09int err =3D errno;
 #ifdef STRIP_EXTENSION
 =09=09strbuf_addstr(&path, STRIP_EXTENSION);
 =09=09if (access(path.buf, X_OK) >=3D 0)
 =09=09=09return path.buf;
+=09=09else if (errno =3D=3D EACCES)
+=09=09=09err =3D errno;
 #endif
+=09=09if (err =3D=3D EACCES && advice_ignored_hook) {
+=09=09=09advise(_(
+=09=09=09=09"The '%s' hook was ignored because "
+=09=09=09=09"it's not set as executable.\n"
+=09=09=09=09"You can disable this warning with "
+=09=09=09=09"`git config advice.ignoredHook false`."), path.buf);
+=09=09}
 =09=09return NULL;
 =09}
 =09return path.buf;
diff --git a/t/t7519-ignored-hook-warning.sh b/t/t7519-ignored-hook-warning=
.sh
new file mode 100755
index 0000000000000..59052a4429111
--- /dev/null
+++ b/t/t7519-ignored-hook-warning.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description=3D'ignored hook warning'
+
+. ./test-lib.sh
+
+# install hook that always succeeds
+HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
+HOOK=3D"$HOOKDIR/pre-commit"
+mkdir -p "$HOOKDIR"
+cat > "$HOOK" <<EOF
+#!/bin/sh
+exit 0
+EOF
+
+chmod +x "$HOOK"
+
+test_expect_success 'no warning if proper hook' '
+
+    if git commit -m "more" 2>&1 >/dev/null | grep hint
+    then
+        false
+    else
+        true
+    fi
+
+'
+
+chmod -x "$HOOK"
+
+test_expect_success POSIXPERM 'warning if hook not set as executable' '
+
+    if git commit -m "more" 2>&1 >/dev/null | grep hint
+    then
+        true
+    else
+        false
+    fi
+'
+
+test_expect_success 'no warning if advice.ignoredHook set to false' '
+
+    git config advice.ignoredHook false &&
+    if git commit -m "more" 2>&1 >/dev/null | grep hint
+    then
+        false
+    else
+        true
+    fi
+'
+
+rm "$HOOK"
+
+test_expect_success 'no warning if unset advice.ignoredHook and hook remov=
ed' '
+
+    git config --unset advice.ignoredHook &&
+    if git commit -m "more" 2>&1 >/dev/null | grep hint
+    then
+        false
+    else
+        true
+    fi
+'
+git commit -m "more" 2>&1 >/dev/null
+
+
+test_done
\ No newline at end of file

--
https://github.com/git/git/pull/411
