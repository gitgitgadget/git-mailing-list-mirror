From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Preserve cwd in setup_git_directory()
Date: Thu, 24 Jul 2008 10:14:41 +0700
Message-ID: <20080724031441.GA26072@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 05:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLrJF-0006AL-K5
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 05:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbYGXDPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 23:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYGXDPF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 23:15:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:12935 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYGXDPC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 23:15:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3169663wfd.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=C3X9/4M7v9neMyqoI31mzyZkSuhio9xYA1ViTALtFa0=;
        b=FGXJB1sjLuXpfY5SsfNhnwDKorF8QJwOVeNp7ROR3R1IG/yGr2EFG/4UGl6Imgz8wt
         zOh7619LeF8o+AAxiPZoVGkB4+Nny20AAD7tMdBcSs5NmezoJoqRJ4Jr8rxkroH0qpbw
         dI7uQuOe5f/znbKwBsm1xYEzmtYt1Z9Txc7lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=VFBKJZSaYCsc6iAcL1JIS0F2cRhpZ34Lk78wmreAh8RHFRgJQ+x+BdqSALCU+IzrwX
         /fNFX63xxTmjSBybynvYB81fCVK4vuGq7yCFWuqxSxmdGqLtKvHrCLshieC9JWgVO9HV
         IiOsamzjQcTTif7CkfTqAROsOUB/a1LecILXg=
Received: by 10.142.148.10 with SMTP id v10mr237159wfd.51.1216869302234;
        Wed, 23 Jul 2008 20:15:02 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.2.9])
        by mx.google.com with ESMTPS id 22sm12418876wfd.7.2008.07.23.20.14.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 20:15:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jul 2008 10:14:42 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89831>

When GIT_DIR is not set, cwd is used to determine where .git is.
If core.worktree is set, setup_git_directory() needs to jump back
to the original cwd in order to calculate worktree, this leads to
incorrect .git location later in setup_work_tree().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c             |    4 ++++
 t/t1501-worktree.sh |   13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 6cf9094..ef58761 100644
--- a/setup.c
+++ b/setup.c
@@ -577,10 +577,14 @@ const char *setup_git_directory(void)
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
 		static char buffer[PATH_MAX + 1];
+		static char cwd[PATH_MAX + 1];
 		char *rel;
+		getcwd(cwd, PATH_MAX);
 		if (retval && chdir(retval))
 			die ("Could not jump back into original cwd");
 		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
+		if (retval && chdir(cwd))
+			die ("Could not jump back into original cwd");
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
=20
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2ee88d8..64f8dea 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -29,7 +29,18 @@ test_rev_parse() {
 }
=20
 mkdir -p work/sub/dir || exit 1
-mv .git repo.git || exit 1
+
+git config core.worktree "$(pwd)"/work
+mv .git work || exit 1
+test_expect_success '--git-dir with relative .git' '
+	(
+	MYPWD=3D"$(pwd)"
+	cd work/sub/dir &&
+	test "$MYPWD"/work/.git =3D "$(git rev-parse --git-dir)"
+	)
+'
+
+mv work/.git repo.git || exit 1
=20
 say "core.worktree =3D relative path"
 GIT_DIR=3Drepo.git
--=20
1.5.5.GIT
