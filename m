From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] grep: fix worktree setup
Date: Thu, 28 Aug 2008 20:04:30 +0700
Message-ID: <1219928670-25219-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 15:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYhCC-0002vE-9v
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYH1NEu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 09:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYH1NEu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:04:50 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:56670 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbYH1NEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:04:49 -0400
Received: by wf-out-1314.google.com with SMTP id 27so337062wfd.4
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=uomiSYV5HzeTEqJLL66fqCnIQ3coXqYfJf8SkxQLxI0=;
        b=QYabh6IL5riHDdjgOLNVat3KDA2KSyAvnh/Fh3D52c61cQRJdo3FWo+q5+xcH0ScwD
         RBVwxyfC5N5E9G7VpEVd8P3ivS2jBDnIGVJs4jY1tKB07DNnipo4F97tmxk5hYOjyLKQ
         Ja1xaITYZoKZGZp3p91dz+wZRfm5IJoUeyLSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=u+1eF9rt0y4Q8QntY0OZVssISxRvnMM0uMCKV7tgcrpUz4USaxNEERVsFEHavHDqJI
         YtwC2iuY4PUxjXKimkKhNVkRIWfOrtCWLiVFa7MVEiO38W2PHpIoofER389A1QfYbjbV
         1Haw5/s3Mu/i0t8Bo/DAqBcFbxFN+sXntyPaA=
Received: by 10.142.143.4 with SMTP id q4mr458942wfd.162.1219928689088;
        Thu, 28 Aug 2008 06:04:49 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.54.222])
        by mx.google.com with ESMTPS id 30sm1708897wfg.9.2008.08.28.06.04.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 06:04:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 28 Aug 2008 20:04:30 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94048>

Unless used with --cached or grepping on a tree, "git grep" will
search on working directory, so set up worktree properly

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c      |    5 ++++-
 t/t1501-worktree.sh |    5 +++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 631129d..3ded1ba 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -783,8 +783,11 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 		paths[1] =3D NULL;
 	}
=20
-	if (!list.nr)
+	if (!list.nr) {
+		if (!cached)
+			setup_work_tree();
 		return !grep_cache(&opt, paths, cached);
+	}
=20
 	if (cached)
 		die("both --cached and trees are given.");
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index e9e352c..e60116c 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -169,4 +169,9 @@ test_expect_success 'git diff' '
 	cmp diff-FILES.expected result
 '
=20
+test_expect_success 'git grep' '
+	(cd repo.git/work/sub &&
+	GIT_DIR=3D../.. GIT_WORK_TREE=3D.. git grep -l changed | grep -q dir/=
tracked)
+'
+
 test_done
--=20
1.6.0.96.g2fad1.dirty
