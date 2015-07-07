From: Robert Collins <robertc@robertcollins.net>
Subject: Subject: [PATCH] git am: Transform and skip patches via new hook
Date: Tue, 7 Jul 2015 19:52:10 +1200
Message-ID: <CAJ3HoZ2YdAFVt1-4dTk04=0cLTUxQocJPNSVupr09Ee01tGCAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 09:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCNft-0006FI-UT
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 09:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbbGGHwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 03:52:14 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34758 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbGGHwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 03:52:12 -0400
Received: by obbkm3 with SMTP id km3so123190153obb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 00:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=mG+pqTmlSc1wwbFxkqR6muMS7RT5sMrZkhuWncpc46E=;
        b=YEoRsQIyUOrIGmpZlnAaYsrOeUhe2vDENm7opY7M9fhhBvpF3zHXvdAww9Dakff9Ha
         3VGy+xDP5zucMc4Y3UtJbBjMWTsflxp1p2lMgNthUHT9T9Srl9hpgqR/NO1L7yzaZOVY
         LvZQ7UB7pI1ND8PudXurTB8pKrotSErjLFba5wbmkY4sU+MxFW4nz5N4AGnCiC0wTLoz
         7Vw6oIpGpMeMsoennDhuVV9YKrUO079pTvmHNvxiCHkAdDyO/BS/fRY1U5hYxI1ykRLm
         3mI2M1DPN/3s/JAN+u87I5oMzM6f9Oi6lSbtXqN5j4fdQqcemrNRMYOqTk6ltZBH2M05
         n17A==
X-Gm-Message-State: ALoCoQk511AziLffFEUmvGH0fnprDTftdxeqE7A6NAhtSdK9yYQUliB2xrcA8LLOFTgZouoIfeaP
X-Received: by 10.182.103.231 with SMTP id fz7mr2700201obb.33.1436255531543;
 Tue, 07 Jul 2015 00:52:11 -0700 (PDT)
Received: by 10.76.76.231 with HTTP; Tue, 7 Jul 2015 00:52:10 -0700 (PDT)
X-Originating-IP: [2001:470:d:2a3:ed9f:f2e4:7094:3082]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273487>

>From 0428b0a1248fb84c584a5a6c1f110770c6615d5e Mon Sep 17 00:00:00 2001
From: Robert Collins <rbtcollins@hp.com>
Date: Tue, 7 Jul 2015 15:43:24 +1200
Subject: [PATCH] git am: Transform and skip patches via new hook

A thing I need to do quite a lot of is extracting stuff from
Python to backported libraries. This involves changing nearly
every patch but its automatable.

Using a new hook (applypatch-transform) was sufficient to meet all my
needs and should be acceptable upstream as far as I can tell.

Signed-Off-By: Robert Collins <rbtcollins@hp.com>
---
 Documentation/git-am.txt                     |  6 ++---
 Documentation/githooks.txt                   | 15 ++++++++++++
 git-am.sh                                    | 15 ++++++++++++
 templates/hooks--applypatch-transform.sample | 36 ++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100755 templates/hooks--applypatch-transform.sample

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index dbea6e7..9ddcd87 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -215,9 +215,9 @@ errors in the "From:" lines).

 HOOKS
 -----
-This command can run `applypatch-msg`, `pre-applypatch`,
-and `post-applypatch` hooks.  See linkgit:githooks[5] for more
-information.
+This command can run `applypatch-msg`, `applypatch-transform`,
+`pre-applypatch`, and `post-applypatch` hooks.  See
+linkgit:githooks[5] for more information.

 SEE ALSO
 --------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7ba0ac9..251b604 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -45,6 +45,21 @@ the commit after inspecting the message file.
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.

+applypatch-transform
+~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by 'git am' before attempting to apply
+patches.  It takes two parameters - the path to the patch on
+disk, and the path to the proposed commit message (which may
+be absent).  Like applypatch-msg, both files may be edited.
+
+Exiting with 1 will cause 'git am' to skip the patch. Exiting
+with any other non-zero value will cause 'git am' to abort.
+
+The sample 'applypatch-transform' hook demonstrates mangling
+a patch from one tree shape to another while discarding irrelevant
+patches.
+
 pre-applypatch
 ~~~~~~~~~~~~~~

diff --git a/git-am.sh b/git-am.sh
index 8733071..796efea 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -869,6 +869,21 @@ To restore the original branch and stop patching
run \"\$cmdline --abort\"."

  case "$resolved" in
  '')
+ # Attempt to rewrite the patch.
+ hook="$(git rev-parse --git-path hooks/applypatch-transform)"
+ if test -x "$hook"
+ then
+ "$hook" "$dotest/patch" "$dotest/final-commit"
+ status="$?"
+ if test $status -eq 1
+ then
+ go_next
+ elif test $status -ne 0
+ then
+ stop_here $this
+ fi
+ fi
+
  # When we are allowed to fall back to 3-way later, don't give
  # false errors during the initial attempt.
  squelch=
diff --git a/templates/hooks--applypatch-transform.sample
b/templates/hooks--applypatch-transform.sample
new file mode 100755
index 0000000..97cd789
--- /dev/null
+++ b/templates/hooks--applypatch-transform.sample
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# An example hook script to transform a patch taken from an email
+# by git am.
+#
+# The hook should exit with non-zero status after issuing an
+# appropriate message if it wants to stop the commit.  The hook is
+# allowed to edit the patch file.
+#
+# To enable this hook, rename this file to "applypatch-transform".
+#
+# This example changes the path of Lib/unittest/mock.py to mock.py
+# Lib/unittest/tests/testmock to tests and Misc/NEWS to NEWS, and
+# finally skips any patches that did not alter mock.py or its tests.
+
+set -eux
+
+patch_path=$1
+
+# Pull out mock.py
+filterdiff --clean --strip 3 --addprefix=a/ -i
'a/Lib/unittest/mock.py' $patch_path > $patch_path.mock
+# And the tests
+filterdiff --clean --strip 5 --addprefix=a/tests/ -i
'a/Lib/unittest/test/testmock/' $patch_path > $patch_path.tests
+# Lastly we want to pick up any NEWS entries.
+filterdiff --strip 2 --addprefix=a/ -i a/Misc/NEWS $patch_path >
$patch_path.NEWS
+cat $patch_path.mock $patch_path.tests > $patch_path
+filtered=$(cat $patch_path)
+if [ -n "${filtered}" ]; then
+  cat $patch_path.NEWS >> $patch_path
+  exitcode=0
+else
+  exitcode=1
+fi
+
+rm $patch_path.mock $patch_path.tests $patch_path.NEWS
+exit $exitcode
-- 
2.1.0


-- 
Robert Collins <rbtcollins@hp.com>
Distinguished Technologist
HP Converged Cloud
