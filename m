From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH] Preserve cwd in setup_git_directory()
Date: Thu, 24 Jul 2008 15:12:22 +0700
Message-ID: <20080724081222.GA32354@laptop>
References: <20080724031441.GA26072@laptop> <48882628.7030305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Geoff Russell <geoffrey.russell@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 10:13:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLvxK-0006z1-Ll
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYGXIMq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 04:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYGXIMp
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:12:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:36199 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYGXIMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:12:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2762620rvb.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EDkVVl8Wr4pVUKIAgG5lno0/AYSmFv5H3PTO/JrTZgo=;
        b=x20lGuMPm3qBDOkeZ5/mMAvPfGkis/d2adSfROwKPYzeM89vlfpj3rADUztZNzJOwB
         i+0VJxaKY5m8yvDWM2l+mi3v6Bqdrr9UiThzLg7v3e8vNyfTAw/2CquiGlLHN5U9Vl9Y
         R4CFbvlOUbDEWqIh+Ez3IV6NYdjy4gSBHAJJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AgI6Tjx/RvLvRQlyePgGIQgD9D2kgeaoIMLmpu0aVkCicZzfmpIsv3hFDWwxQvU0Du
         yDgZ6BSNfCGL11ErKBByo+Ttw4KhJm13qgcQS8zVQV2Ff18evmpSfbObrikfANeTy/px
         L6/Co3mDSrs4lXReeKH8OdPmeJW99xq6G7tcE=
Received: by 10.114.92.2 with SMTP id p2mr519981wab.223.1216887163286;
        Thu, 24 Jul 2008 01:12:43 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.2.9])
        by mx.google.com with ESMTPS id j31sm11375112waf.51.2008.07.24.01.12.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 01:12:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Jul 2008 15:12:22 +0700
Content-Disposition: inline
In-Reply-To: <48882628.7030305@viscovery.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89846>

When GIT_DIR is not set, cwd is used to determine where .git is.
If core.worktree is set, setup_git_directory() needs to jump back
to the original cwd in order to setup worktree, this leads to
incorrect .git location later in setup_work_tree().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  On Thu, Jul 24, 2008 at 08:50:16AM +0200, Johannes Sixt wrote:
  > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
  > > --- a/setup.c
  > > +++ b/setup.c
  > > @@ -577,10 +577,14 @@ const char *setup_git_directory(void)
  > >  	/* If the work tree is not the default one, recompute prefix */
  > >  	if (inside_work_tree < 0) {
  > >  		static char buffer[PATH_MAX + 1];
  > > +		static char cwd[PATH_MAX + 1];
  > >  		char *rel;
  > > +		getcwd(cwd, PATH_MAX);
  >=20
  > This needs an error check.

  Check added.

 setup.c             |    5 +++++
 t/t1501-worktree.sh |   13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 6cf9094..fa1d696 100644
--- a/setup.c
+++ b/setup.c
@@ -577,10 +577,15 @@ const char *setup_git_directory(void)
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
 		static char buffer[PATH_MAX + 1];
+		static char cwd[PATH_MAX + 1];
 		char *rel;
+		if (!getcwd(cwd, PATH_MAX))
+			die ("Could not get the current working directory");
 		if (retval && chdir(retval))
 			die ("Could not jump back into original cwd");
 		rel =3D get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
+		if (retval && chdir(cwd))
+			die ("Could not jump back into original cwd");
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
=20
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2ee88d8..d53d66a 100755
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
