From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Support working directory located at root
Date: Mon,  8 Feb 2010 21:53:30 +0700
Message-ID: <1265640810-6361-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 15:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeV2C-00059o-D3
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 15:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab0BHO4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 09:56:15 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:42136 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0BHO4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 09:56:14 -0500
Received: by ywh27 with SMTP id 27so5434747ywh.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=r+SEAVoM3gOSZZsUdFE01ah80sLWC8NcEYBw9DP+/Ow=;
        b=C7ONeRNsZNDPAxmyqSkY0olSn8t61euryCNqjLTfyLRKF1/lsn7rE6LdbH+tpgRX1D
         PloEnKrJ9JFKoLquVl6Zn2Rz/FWDHQLVLVPTGVTh0XpL2Lj2kR5668TWMrCOLOcKRwys
         8iIvj3qe7X7Z3pf7PwLkuLK7uOaLyg4De1eTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Hl/oc+LjgmJed6B2M/aQgUpttaPAqAZNyFdInC7eG66JxP8QVL3F/C8L3q43OMm9IJ
         tJVPyClttCXr0dGkOX5ps3gZtM5AUgfFlvoU9BiZy5gUMYhRcUKb1JHOC6/dlWquzCbk
         yjsb+XZQe14XE2FKj8Yq88SfDQT84mturckPc=
Received: by 10.101.174.20 with SMTP id b20mr1410259anp.244.1265640973741;
        Mon, 08 Feb 2010 06:56:13 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.235.86])
        by mx.google.com with ESMTPS id 21sm1472210ywh.16.2010.02.08.06.56.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 06:56:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  8 Feb 2010 21:53:32 +0700
X-Mailer: git-send-email 1.7.0.rc0.54.gd33ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139290>

Git should work regardless where the working directory is located,
even at root. This patch fixes two places where it assumes working
directory always have parent directory.

In setup_git_directory_gently(), when Git goes up to root and finds
=2Egit there, it happily sets worktree to "".

In prefix_path(), loosen the outside repo check a little bit. Usually
when a path XXX is inside worktree /foo, it must be either "/foo", or
"/foo/...". When worktree is simply "/", we can safely ignore the
check: we have a slash at the beginning already.

Not related to worktree, but also set gitdir correctly if a bare repo
is placed (insanely?) at root.

Thanks Jo=C3=A3o Carlos Mendes Lu=C3=ADs for pointing out this problem.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Tell me if this patch is rejected, I'll send another one that makes
 setup_git_* die() if worktree/gitdir is to be set empty. I don't think=
 we
 expect gitdir or worktree to be empty anywhere.

 setup.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index b38cbee..0fcd2fd 100644
--- a/setup.c
+++ b/setup.c
@@ -25,7 +25,7 @@ const char *prefix_path(const char *prefix, int len, =
const char *path)
 		len =3D strlen(work_tree);
 		total =3D strlen(sanitized) + 1;
 		if (strncmp(sanitized, work_tree, len) ||
-		    (sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')) {
+		    (len > 1 && sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')=
) {
 		error_out:
 			die("'%s' is outside repository", orig);
 		}
@@ -403,7 +403,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			if (offset !=3D len) {
-				cwd[offset] =3D '\0';
+				cwd[offset ? offset : 1] =3D '\0';
 				set_git_dir(cwd);
 			} else
 				set_git_dir(".");
@@ -427,6 +427,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	inside_git_dir =3D 0;
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
+	if (offset =3D=3D 0) /* reached root, set worktree to '/' */
+		offset =3D 1;
 	git_work_tree_cfg =3D xstrndup(cwd, offset);
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
--=20
1.7.0.rc0.54.gd33ef
