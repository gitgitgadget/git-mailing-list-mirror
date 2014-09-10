From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 30/32] git_path(): keep "info/sparse-checkout" per work-tree
Date: Thu, 11 Sep 2014 05:42:06 +0700
Message-ID: <1410388928-32265-31-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqdA-0002cS-GL
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbaIJWos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:48 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41525 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:48 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so7877290pad.16
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=t7hRuf+c0/wfISnQVwPHPUUjktYsS7dyU+AnL0kpjZc=;
        b=iB2x04YmTsBe00weSLrjxBlC2NcBj4WzLY2+JTBXtjStUGI7rUzQ1Dd9fmH/3FsFnx
         rrE6gQPWFyouRPROLoapZwqJQWc8to8baI2fUp0rwuTPKckkvH8FkQcAAt6Fsa11O3+v
         CMdk6Db/F/DpQ9CxYUuQ9KMp0wfUsoig31e3dtX/a5XDjhIyz0T3Vjy7X0D8znHd8uTf
         WPNeBgEGUtYkTSL6Ruhs+lKyJpa1OlpUZEErxBPcTEMJRmfnGGFTfh0H+sl6Qzun8oeE
         aST+DaUyz5LjJTCTYx2hczh1oPtvKkjGFDe2tZoodXZdV43gswl/93IFlZEjGdz92mLZ
         D6zg==
X-Received: by 10.66.185.14 with SMTP id ey14mr2462584pac.136.1410389087799;
        Wed, 10 Sep 2014 15:44:47 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id ko5sm15601804pdb.51.2014.09.10.15.44.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:45:07 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256807>

Currently git_path("info/sparse-checkout") resolves to
$GIT_COMMON_DIR/info/sparse-checkout in multiple worktree mode. It
makes more sense for the sparse checkout patterns to be per worktree,
so you can have multiple checkouts with different parts of the tree.

With this, "git checkout --to <new>" on a sparse checkout will create
<new> as a full checkout. Which is expected, it's how a new checkout
is made. The user can reshape the worktree afterwards.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c                | 3 ++-
 t/t0060-path-utils.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index d07ae69..1f1881a 100644
--- a/path.c
+++ b/path.c
@@ -103,7 +103,8 @@ static void update_common_dir(struct strbuf *buf, i=
nt git_dir_len)
 	char *base =3D buf->buf + git_dir_len;
 	const char **p;
=20
-	if (is_dir_file(base, "logs", "HEAD"))
+	if (is_dir_file(base, "logs", "HEAD") ||
+	    is_dir_file(base, "info", "sparse-checkout"))
 		return;	/* keep this in $GIT_DIR */
 	for (p =3D common_list; *p; p++) {
 		const char *path =3D *p;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index f5d6f80..93605f4 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -270,6 +270,7 @@ test_git_path GIT_COMMON_DIR=3Dbar objects         =
         bar/objects
 test_git_path GIT_COMMON_DIR=3Dbar objects/bar              bar/object=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar info/exclude             bar/info/e=
xclude
 test_git_path GIT_COMMON_DIR=3Dbar info/grafts              bar/info/g=
rafts
+test_git_path GIT_COMMON_DIR=3Dbar info/sparse-checkout     .git/info/=
sparse-checkout
 test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remote=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/branch=
es/bar
 test_git_path GIT_COMMON_DIR=3Dbar logs/refs/heads/master   bar/logs/r=
efs/heads/master
--=20
2.1.0.rc0.78.gc0d8480
