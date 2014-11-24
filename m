From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] commit: inform pre-commit if --amend is used
Date: Mon, 24 Nov 2014 12:21:51 +0100
Message-ID: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 12:22:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsrjK-0007QB-6K
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 12:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbaKXLWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 06:22:50 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:40518 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKXLWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 06:22:49 -0500
Received: by mail-la0-f46.google.com with SMTP id gd6so7379708lab.19
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 03:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=38FoGUB61GJ4hVHg7AB692FZE99+cwDSGAc0PT47TxU=;
        b=A7iXByho+dwFYWxTxMP1dClsPGUaOjlYB7Mm+/P70OwvGzTx92yR41QUEaasrd9szc
         3/c+2fAJAyJ0g2M/tuJ8hfOF0Jl1cCX9MQUufxa/2p2kLUnLyAtR1KNCbhDntw41Vyb9
         52ntjA1wqn49z6pUIQhMPjHpII+mk3rYQ49tqRVzUv2YMwsgc86jkHPL43q4qr36zBVl
         /euQINcnnmvMBbXfvIytSL7U9iKG9RmB5WW1NDrzFjBQm/VWcQqjy2zlc4/6fKAcpOx4
         m3LYYfBF9VmRGKpDVz8oipHouC/HCZsTUIa64Hk1il3q5uieiTq3H2L5rnkrWqWM8PUa
         8uOg==
X-Received: by 10.153.6.9 with SMTP id cq9mr19792166lad.79.1416828125208;
        Mon, 24 Nov 2014 03:22:05 -0800 (PST)
Received: from worklappie.data-respons.com ([46.19.18.182])
        by mx.google.com with ESMTPSA id n6sm3474446laj.16.2014.11.24.03.22.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Nov 2014 03:22:04 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260122>

When a commit is amended a pre-commit hook that verifies the commit's
contents might not find what it's looking for if for example it looks a=
t
the differences against HEAD when HEAD~1 might be more appropriate.
Inform the commit hook that --amend is being used so that hook authors
can do e.g.

    if test "$1" =3D amend
    then
        ...
    else
        ...
    fi

to handle these situations.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
 Documentation/githooks.txt |  3 ++-
 builtin/commit.c           |  3 ++-
 t/t7503-pre-commit-hook.sh | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9ef2469..e113027 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -73,7 +73,8 @@ pre-commit
 ~~~~~~~~~~
=20
 This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes no parameter, and is
+with `--no-verify` option.  It takes one parameter which is "amend" if
+`--amend` was used when committing and empty otherwise. It is
 invoked before obtaining the proposed commit log message and
 making a commit.  Exiting with non-zero status from this script
 causes the 'git commit' to abort.
diff --git a/builtin/commit.c b/builtin/commit.c
index e108c53..e38dd4a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -694,7 +694,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
=20
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit=
", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file,
+					  "pre-commit", amend ? "amend" : "", NULL))
 		return 0;
=20
 	if (squash_message) {
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b..be97676 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -136,4 +136,18 @@ test_expect_success 'check the author in hook' '
 	git show -s
 '
=20
+# a hook that checks if "amend" is passed as an argument
+cat > "$HOOK" <<EOF
+#!/bin/sh
+test "\$1" =3D amend
+EOF
+
+test_expect_success 'check that "amend" argument is given' '
+       git commit --amend --allow-empty
+'
+
+test_expect_success 'check that "amend" argument is NOT given' '
+       ! git commit --allow-empty
+'
+
 test_done
--=20
2.0.3
