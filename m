From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Avoid the need of "--" when wildcard pathspec is used
Date: Tue, 30 Jun 2015 19:40:07 +0700
Message-ID: <1435668007-31231-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 14:39:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9upB-0001SJ-05
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbbF3Mjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 08:39:37 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34474 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbF3Mjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:39:35 -0400
Received: by pabvl15 with SMTP id vl15so5131167pab.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=flOIqme9iJ8UC+jJc75UuVFa2hP46dblxGNqfvwihA0=;
        b=cQPOEwmEqi5+rJi6sbE3qOfyB66uHFOa9acj7vLyDK8CrGuiYJvu5RSKCxiJ8j1Bdo
         6eRKKR47QVxgtjZDIIOQHfllwPqAO77chDNKdeU1xGySpMuuKLKDsCCinbhN8jhFWsgB
         GhXLIZsJB1X5d8nVCAraIB39I17W402AAubgm1aJvGx4udBVAxQ1B7ghIccqTRTPl0ai
         ma2ykMo+wB8WnmwalZXr1kilUS1J8Ykw5sdyyTkm0tW71DLcFGx06pvg8bHjox6tAW7r
         Mj1mT6Gd0Ub5NNXfY7sGmZbsVCVBUkhDJRlyUpaF5dBzVwkKYwP9azeLyuF6GL82hQVs
         fbDQ==
X-Received: by 10.68.193.232 with SMTP id hr8mr43238379pbc.145.1435667974171;
        Tue, 30 Jun 2015 05:39:34 -0700 (PDT)
Received: from lanh ([115.73.18.247])
        by mx.google.com with ESMTPSA id nl10sm45589478pdb.38.2015.06.30.05.39.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 05:39:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Jun 2015 19:40:09 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273055>

When "--" is lacking from the command line and a command can take both
revs and paths, the idea is if an argument can be seen as both an
extended SHA-1 and a path, then "--" is required or git refuses to
continue. It's currently implemented as:

(1) if an argument is rev, then it must not exist in worktree

(2) else, it must exist in worktree

(3) else, "--" is required.

These rules work for literal paths, but when wildcard pathspec is
involved, it always requires the user to add "--" because it fails (2)
and (1) is never met.

This patch prefers wildcard over extended sha-1 syntax that includes
wildcards, so that we can specify wildcards to select paths in worktree
without "--" most of the time. If wildcards are found in extended sha-1
syntax, then "--" is _always_ required.

Because ref names don't allow wildcards, you can only hit that
"needs '--'" new rule if you use ":/<pattern>", "<rev>^{/<pattern>}" or
"<rev>:wildcards/in/literal/paths". So it's really rare.

The rules after this patch become:

(1) if an arg is a rev, then it must either exist in worktree or not
    a wild card

(2) else, it either exists in worktree or is a wild card

(3) else, "--" is required.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c                           |  2 ++
 t/t2019-checkout-ambiguous-ref.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/setup.c b/setup.c
index 82c0cc2..f7cb93b 100644
--- a/setup.c
+++ b/setup.c
@@ -143,6 +143,8 @@ int check_filename(const char *prefix, const char *=
arg)
 		name =3D arg + 2;
 	} else if (!no_wildcard(arg))
 		return 1;
+	else if (!no_wildcard(arg))
+		return 1;
 	else if (prefix)
 		name =3D prefix_filename(prefix, strlen(prefix), arg);
 	else
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambig=
uous-ref.sh
index b99d519..e5ceba3 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -56,4 +56,30 @@ test_expect_success VAGUENESS_SUCCESS 'checkout repo=
rts switch to branch' '
 	test_i18ngrep ! "^HEAD is now at" stderr
 '
=20
+test_expect_success 'wildcard ambiguation' '
+	git init ambi &&
+	(
+		cd ambi &&
+		echo a >a.c &&
+		git add a.c &&
+		echo b >a.c &&
+		git checkout "*.c" &&
+		echo a >expect &&
+		test_cmp expect a.c
+	)
+'
+
+test_expect_success 'wildcard ambiguation (2)' '
+	git init ambi2 &&
+	(
+		cd ambi2 &&
+		echo a >"*.c" &&
+		git add . &&
+		test_must_fail git show :"*.c" &&
+		git show :"*.c" -- >actual &&
+		echo a >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
