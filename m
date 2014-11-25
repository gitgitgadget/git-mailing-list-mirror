From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 2/2] commit: inform pre-commit that --amend was used
Date: Tue, 25 Nov 2014 23:51:29 +0100
Message-ID: <b9ef551633329702559e4cee6528b68ab757b531.1416955873.git.oystwa@gmail.com>
References: <cover.1416953772.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 23:52:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtOxt-000682-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 23:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbaKYWvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 17:51:49 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:53671 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaKYWvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 17:51:48 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so3098636wiw.16
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=f9RoXEP+7XM/pqVdEi+fOI+QXbjadDGg8nwdddnhfAQ=;
        b=i6kf3z0FIrezzOoEScR6yOJbpw1623n1zeRnt7pVdTrw5O9D62XnTRNW7hKneDhBhl
         JmSZzUl6g9+pFGL4ALHeMDGsIHguNORYGVnW+nTNnrudL9Ml9bWxgAwXbX/d1Cml2YAT
         VMcy1Bk+9m7T43Cf7+KB1oENe+FfMqxwclkzgsFm2cHG9rv58IcCPsm5Iv5ba0ZkCt8w
         Yi21DVMkzbTgJW7+EwFweYzbFhfKgSB5gK+EOL0AINOcp9U3c4eT1gRaW5UobZsT+oQH
         CbyX+s6gtmdK6rr++7qA3fG35dZ29gW/NZ98ZmzbGhxnxmz2GAWP4e1FH8ipw5D1+b8U
         XQuA==
X-Received: by 10.180.21.166 with SMTP id w6mr35777075wie.43.1416955906982;
        Tue, 25 Nov 2014 14:51:46 -0800 (PST)
Received: from bigge.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id ry19sm3830783wjb.3.2014.11.25.14.51.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Nov 2014 14:51:46 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <cover.1416953772.git.oystwa@gmail.com>
In-Reply-To: <cover.1416955873.git.oystwa@gmail.com>
References: <cover.1416955873.git.oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260247>

When a commit is amended a pre-commit hook that verifies the commit's
contents might not find what it's looking for if it looks at the
differences against HEAD when HEAD~1 might be more appropriate. Inform
the commit hook that --amend is being used so that hook authors can do
e.g.

    if test "$1" =3D amend; then
        ...
    else
        ...
    fi

to handle these situations.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
 Documentation/githooks.txt |  3 ++-
 builtin/commit.c           |  3 ++-
 t/t7503-pre-commit-hook.sh | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9ef2469..fb3e71e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -73,7 +73,8 @@ pre-commit
 ~~~~~~~~~~
=20
 This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes no parameter, and is
+with `--no-verify` option.  It takes one parameter which is "amend" if
+`--amend` was used when committing and "noamend" if not. It is
 invoked before obtaining the proposed commit log message and
 making a commit.  Exiting with non-zero status from this script
 causes the 'git commit' to abort.
diff --git a/builtin/commit.c b/builtin/commit.c
index e108c53..f9e5d27 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -694,7 +694,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
=20
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit=
", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit=
",
+					  amend ? "amend" : "noamend", NULL))
 		return 0;
=20
 	if (squash_message) {
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 99ed967..b400afe 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -133,4 +133,15 @@ test_expect_success 'check the author in hook' '
 	git show -s
 '
=20
+# a hook that checks if "amend" is passed as an argument
+write_script "$HOOK" <<EOF
+test "\$1" =3D amend
+EOF
+
+test_expect_success 'check that "amend" argument is given' '
+       git commit --amend --allow-empty
+'
+
+test_must_fail git commit --allow-empty
+
 test_done
--=20
2.2.0.rc3
