From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 31/32] git_path(): keep "info/sparse-checkout" per work-tree
Date: Wed,  9 Jul 2014 14:33:16 +0700
Message-ID: <1404891197-18067-32-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:36:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mQO-0004f3-EF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbaGIHgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:36:15 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64036 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144AbaGIHgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:36:14 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so8486000pdi.41
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5Tfs+O6F+mjnU2Ki9NKVdCmpmIDnc4lS0O80TsVltXc=;
        b=oBNsroc12+J8NuWGFGXs+12iTa4eb6frn/ENqVtIyw1CsllLDWluDr/K6U7IeGSZM0
         BvuPtM/Ie2CcBQZbgud8+Zbd53S6S8anZDQrjns4ogtGm2zJi0dSNQxbQ1BafA12Mddb
         fAWl3hsgnM3kyFQDwl5jtnSI3pHizFrRCpB8IniA7ElFsR/5fljzUiTjsx5WGneqe5oQ
         OIOunCexuEww2VbeuZCv7YTg53oTtHliwLQSBZc5jAS870TTzjKfukyVDHPPg+L0ChZb
         TUVep+h6CV2Mnwm9cKi5tvjYS1yVPJK9ZZRDbUhRb3mn5IWI9B2xnH5CE8lt6YcMVZfi
         aaHQ==
X-Received: by 10.66.252.10 with SMTP id zo10mr38903791pac.7.1404891373930;
        Wed, 09 Jul 2014 00:36:13 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id og3sm57943440pbc.48.2014.07.09.00.36.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:36:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:36:11 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253106>

Currently git_path("info/sparse-checkout") resolves to
$GIT_COMMON_DIR/info/sparse-checkout in multiple worktree mode. It
makes more sense for the sparse checkout patterns to be per worktree,
so you can have multiple checkouts with different parts of the tree.

With this, "git checkout --to <new>" on a sparse checkout will create
<new> as a full checkout. Which is expected, it's how a new checkout
is made. The user can reshape the worktree afterwards.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c                | 3 ++-
 t/t0060-path-utils.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index b5af137..b1dd2bc 100644
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
index 2dabcef..da82aab 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -269,6 +269,7 @@ test_git_path GIT_COMMON_DIR=3Dbar logs/HEAD       =
         .git/logs/HEAD
 test_git_path GIT_COMMON_DIR=3Dbar objects                  bar/object=
s
 test_git_path GIT_COMMON_DIR=3Dbar objects/bar              bar/object=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar info/exclude             bar/info/e=
xclude
+test_git_path GIT_COMMON_DIR=3Dbar info/sparse-checkout     .git/info/=
sparse-checkout
 test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remote=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/branch=
es/bar
 test_git_path GIT_COMMON_DIR=3Dbar logs/refs/heads/master   bar/logs/r=
efs/heads/master
--=20
1.9.1.346.ga2b5940
