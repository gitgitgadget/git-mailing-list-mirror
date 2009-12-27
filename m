From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Fix core.worktree being used when GIT_DIR is not set
Date: Sun, 27 Dec 2009 20:28:33 +0700
Message-ID: <1261920513-25189-1-git-send-email-pclouds@gmail.com>
References: <200912071115.48085.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 14:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOtBV-0005NY-Rl
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 14:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbZL0N3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 08:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZL0N3U
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 08:29:20 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57017 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbZL0N3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 08:29:19 -0500
Received: by pwj9 with SMTP id 9so5900780pwj.21
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+6d39+xZ3l1Zl4lyo2d1y9PXivllcVWJZb1itv9R93s=;
        b=Dohu4Czf1whT6jLWAifuLJ5Cup0/yJBQzoLsw0CRFJlbUzqSoDWLqexuKTHJJg7+uw
         sOOBvpxE/yaOfyHX0g/6oKYI7ejSweGZWi6B9+F8YCTlcdGZOjrC5UM+Bu/DHwwCZHOs
         XT41dBs168Vbr17eH0q6iEDvB+vZG4/0/+ZGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CctQe5MPEwQIAP/onrMUSspFkabBmUT2gD2OwSGJTn5bbTnUHB675PS7yz1X3Zea46
         653TJ5ZT2gs/PA1dWrOhxS8/DhqavrTHKmazVQJfMtu8xq34LI/oh4qYpbSfVVnN4O1n
         dZdA21aQR0d5qrTH9HjaScmbKSD5FIjjYr7rE=
Received: by 10.142.7.21 with SMTP id 21mr9062687wfg.97.1261920558777;
        Sun, 27 Dec 2009 05:29:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.211.127])
        by mx.google.com with ESMTPS id 21sm10831540pzk.3.2009.12.27.05.29.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Dec 2009 05:29:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 27 Dec 2009 20:28:34 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <200912071115.48085.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135704>

According to config.txt:
> core.worktree::
>         Set the path to the working tree.  The value will not be
>         used in combination with repositories found automatically in
>         a .git directory (i.e. $GIT_DIR is not set).

This behavior was changed after e90fdc3 (Clean up work-tree handling -
2007-08-01) and 9459aa7 (Do check_repository_format() early (re-fix) -
2007-12-05). If core.worktree is set, even if git_dir automatically
found (and git_work_tree_cfg set), git_work_tree_cfg will be reset to
core.worktree. This makes core.worktree effective even if GIT_DIR is
not set, in contrast to config.txt.

This patch makes sure it only checks for core.worktree if GIT_DIR is se=
t.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c             |   19 +++++++++++++------
 t/t1501-worktree.sh |    4 ++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/setup.c b/setup.c
index 2cf0f19..35b7915 100644
--- a/setup.c
+++ b/setup.c
@@ -283,6 +283,18 @@ const char *read_gitfile_gently(const char *path)
 	return path;
 }
=20
+static int check_repository_work_tree(const char *var, const char *val=
ue, void *cb)
+{
+	if (strcmp(var, "core.worktree") =3D=3D 0) {
+		if (!value)
+			return config_error_nonbool(var);
+		free(git_work_tree_cfg);
+		git_work_tree_cfg =3D xstrdup(value);
+		inside_work_tree =3D -1;
+	}
+	return 0;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
@@ -320,6 +332,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (!work_tree_env) {
 				retval =3D set_work_tree(gitdirenv);
 				/* config may override worktree */
+				git_config(check_repository_work_tree, NULL);
 				if (check_repository_format_gently(nongit_ok))
 					return NULL;
 				return retval;
@@ -474,12 +487,6 @@ int check_repository_format_version(const char *va=
r, const char *value, void *cb
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		if (is_bare_repository_cfg =3D=3D 1)
 			inside_work_tree =3D -1;
-	} else if (strcmp(var, "core.worktree") =3D=3D 0) {
-		if (!value)
-			return config_error_nonbool(var);
-		free(git_work_tree_cfg);
-		git_work_tree_cfg =3D xstrdup(value);
-		inside_work_tree =3D -1;
 	}
 	return 0;
 }
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 74e6443..9756f35 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -30,6 +30,10 @@ test_rev_parse() {
=20
 EMPTY_TREE=3D$(git write-tree)
 mkdir -p work/sub/dir || exit 1
+
+git config core.worktree work
+test_rev_parse 'core.worktree without GIT_DIR' false false true ''
+
 mv .git repo.git || exit 1
=20
 say "core.worktree =3D relative path"
--=20
1.6.5.2.216.g9c1ec
