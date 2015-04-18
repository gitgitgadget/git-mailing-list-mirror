From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] config.c: split some variables to
 $GIT_DIR/config.worktree
Date: Sat, 18 Apr 2015 18:10:23 +0700
Message-ID: <20150418111023.GA1496@lanh>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
 <1427804079-13061-1-git-send-email-pclouds@gmail.com>
 <20150413233739.GA786@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens.Lehmann@web.de
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Apr 18 13:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjQe5-0006qf-Op
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 13:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbbDRLKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 07:10:40 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32779 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbDRLKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 07:10:39 -0400
Received: by paboj16 with SMTP id oj16so153099027pab.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+fW2tlF0cq3pfDvQK3UCCfNYqQ6kJtxW6xFG5fa749g=;
        b=ZmQt/VRW/tc53HW1ePEM+uzeeIHt9boPANZR65plGCJzCvKbQetTmTVcFKOhVnVZ97
         t1q4Kc+/8ndnYtlp8P0kC8cAfU49AJjiAsrnIzs7eAndk1KNML6q72EXWxz8XrnANC5W
         uxT6lLBPw+szuwJHR6z3su8aAubbRZp6UtfpvsoYxphQE/WGeJ26D2GHalt4mINOjPV3
         VWD96uAC+yxBcerrDd2ue0Ar+Bw+X4fvGMxCOPihTXxDE/2sufm8V2IkeNodMP5u4dXU
         G/vNVpDdlquS+IvviU1knHnpZ5Y/VAq4C4icCKolC4245dfFbRyFGsZiv7umx/VGrKNk
         IYuA==
X-Received: by 10.70.96.65 with SMTP id dq1mr12884973pdb.79.1429355438979;
        Sat, 18 Apr 2015 04:10:38 -0700 (PDT)
Received: from lanh ([115.73.194.246])
        by mx.google.com with ESMTPSA id id2sm12641532pbb.56.2015.04.18.04.10.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 04:10:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 18 Apr 2015 18:10:23 +0700
Content-Disposition: inline
In-Reply-To: <20150413233739.GA786@wheezy.local>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267416>

On Tue, Apr 14, 2015 at 02:37:39AM +0300, Max Kirillov wrote:
> On Tue, Mar 31, 2015 at 07:14:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
> > core.worktree and core.bare, which are treated specially in 31e26eb=
 [1],
> > are now moved to info/core.worktree and the special treatment rever=
ted.
> <...>
> > -	if (get_common_dir(&sb, gitdir))
> > -		fn =3D check_repo_format;
> > -	else
> > -		fn =3D check_repository_format_version;
>=20
> By the way, after this '$GIT_DIR/common overrides core.worktree'
> from t1501 started failing. I don't know what would be
> better to do with the case, just remove maybe?

I think that test spots a real problem. In this function, I ignore the
config split when I pass NULL as worktree_config to git_config_early().
Something like this should fix it.

-- 8< --
diff --git a/setup.c b/setup.c
index 61e0403..4799e7d 100644
--- a/setup.c
+++ b/setup.c
@@ -355,10 +355,15 @@ static int check_repo_format(const char *var, con=
st char *value, void *cb)
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
 	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf sb_wt =3D STRBUF_INIT;
 	const char *repo_config;
+	const char *worktree_config =3D NULL;
 	int ret =3D 0;
=20
-	get_common_dir(&sb, gitdir);
+	if (get_common_dir(&sb, gitdir)) {
+		strbuf_addf(&sb_wt, "%s/config.worktree", get_git_dir());
+		worktree_config =3D sb_wt.buf;
+	}
 	strbuf_addstr(&sb, "/config");
 	repo_config =3D sb.buf;
=20
@@ -371,7 +376,8 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	git_config_early(check_repository_format_version, NULL, repo_config, =
NULL);
+	git_config_early(check_repository_format_version, NULL,
+			 repo_config, worktree_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
@@ -383,6 +389,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 		ret =3D -1;
 	}
 	strbuf_release(&sb);
+	strbuf_release(&sb_wt);
 	return ret;
 }
=20
-- 8< --
