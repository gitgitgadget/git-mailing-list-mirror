From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup_explicit_git_dir: adjust relative $GIT_WORK_TREE after moving cwd
Date: Sun, 26 Dec 2010 18:46:54 +0700
Message-ID: <1293364014-8463-2-git-send-email-pclouds@gmail.com>
References: <1293285457-11915-2-git-send-email-pclouds@gmail.com>
 <1293364014-8463-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 12:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWp5J-00084m-6h
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 12:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0LZLsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Dec 2010 06:48:19 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50738 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab0LZLsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 06:48:18 -0500
Received: by pva4 with SMTP id 4so1512854pva.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 03:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lkK0yksY3WoCeiefVbvQMMmgBayE9T1BGIw2TXzh7UE=;
        b=owB3EMnSyU4czTBAKRB4jVAn8O0xyqkt3KI28ubnwCHe1Pbrr2lTSNtt60iTIF9b9D
         WTsokynFtCkqHJLb5/05V51YhSR2YTCIuLbT++qZ0fyA9QTuz3ZZeccAM1u6B9Hm3XU9
         TeS6VoC7anJmybKmTccEZ7sE3nC+lYgZqP5QE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FWQYSyrXTE/zrxhLd90xYeJgj58MZ56SGAchYAreHVK5gEicbPLlIXkF9ox4dE0LW5
         4aOSO1knxMEgiAubAz0MXLlhha864UA+xhuhW3fChpFQ5iBDN7/aS1Cr4wQIv1DKQEFc
         i4jzvi9sY1lcojHOprIRAG2yh7Vf1eUu6Yrow=
Received: by 10.142.225.21 with SMTP id x21mr4196981wfg.403.1293364097574;
        Sun, 26 Dec 2010 03:48:17 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id x35sm15821642wfd.13.2010.12.26.03.48.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 03:48:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 26 Dec 2010 18:47:02 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1293364014-8463-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164190>

setup_explicit_git_dir() can move cwd. If $GIT_WORK_TREE is relative
to original cwd, then the subsequent git processes will take wrong
worktree.

Instead of making $GIT_WORK_TREE absolute too, we just say "." and let
subsequent git processes handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This one is on top of nd/setup. If nd/setup does not make it in the
 next release, I can still make similar patch for master, but I don't
 think this happens in real life, therefore not really urgent to fix.

 There are only few cases where git spawns more git processes.
 For those that do that, setup_work_tree() is likely called by git.c
 already, which is what the first patch is for.

 setup.c             |    7 +++++++
 t/t1501-worktree.sh |   12 ++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 3d73269..10b8f16 100644
--- a/setup.c
+++ b/setup.c
@@ -392,6 +392,13 @@ static const char *setup_explicit_git_dir(const ch=
ar *gitdirenv,
 		set_git_dir(make_absolute_path(gitdirenv));
 		if (chdir(worktree))
 			die_errno("Could not chdir to '%s'", worktree);
+		/*
+		 * Make sure subsequent git processes find correct worktree
+		 * if $GIT_WORK_TREE is set relative
+		 */
+		if (work_tree_env)
+			setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
+
 		cwd[len++] =3D '/';
 		cwd[len] =3D '\0';
 		free(gitfile);
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 1f3b50d..fa35c3e 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -351,4 +351,16 @@ test_expect_success 'relative $GIT_WORK_TREE and g=
it subprocesses' '
 	)
 '
=20
+test_expect_success 'relative $GIT_WORK_TREE and git subprocesses (2)'=
 '
+	(
+	cd repo.git/work/sub &&
+	GIT_DIR=3D../.. &&
+	GIT_WORK_TREE=3D.. &&
+	export GIT_DIR GIT_WORK_TREE &&
+	test-subprocess rev-parse --show-toplevel >actual &&
+	echo "$TRASH_DIRECTORY/repo.git/work" >expected &&
+	test_cmp expected actual
+	)
+'
+
 test_done
--=20
1.7.3.4.878.g439c7
