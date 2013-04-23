From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] submodule.c: duplicate real_path's return value
Date: Tue, 23 Apr 2013 21:00:02 +1000
Message-ID: <1366714802-12010-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 13:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUaxc-0004Bd-C9
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 13:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab3DWLA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Apr 2013 07:00:27 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42092 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab3DWLA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 07:00:26 -0400
Received: by mail-pa0-f50.google.com with SMTP id bg4so421325pad.37
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wKzek3SaNB2PpzUzL3ztCxo1LYJYOIQp0ysDFq3z9DA=;
        b=YVEtnOHxZexK4Z/eN2ET0RV4RZUsXZhqMh7gb0EfmhEEmDgoW7RK5J0bCzDDfkQftA
         PV0Q7M0TA8BHWciEp/eM+CxWfCyH0BKKS1L2Ri6oK2ZOuSOQyStFz2eLL9EgNpUcJh1d
         G60mPEy8wKBoqqLadLoHV/qLBb+YqZAahXNlGSXFuGisfXfm89B6Tp5n9Qh8dMgSUjZM
         fSsBFKFWnuVVeRlzI/WG/TFdtycMIRWTr0Pb4TCweDdqp8wHzhoLUiR/kxdPZMc1iRZA
         aNr+uBqQbHFgpfZAUCtn7yeM3gCQmm81ChxES75Covyiq0aNDARTpbg8INGxz6N8WIKT
         0bKg==
X-Received: by 10.68.198.69 with SMTP id ja5mr40206683pbc.183.1366714826286;
        Tue, 23 Apr 2013 04:00:26 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id fx2sm9635088pac.4.2013.04.23.04.00.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 04:00:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 23 Apr 2013 21:00:05 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222140>

real_path returns the pointer to an internal buffer, which may be
overwritten by the next real_path call. Duplicate the return value for
safety.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Apply on top of jl/submodule-mv.
=20
 Junio, I think this is the reason some tests failed when you merged
 nd/magic-pathspecs in (I suspect you needed to do parse_pathspec
 call, which may do real_path internaly).

 I think "bug" fix like this should go in early, hence this patch. I'm
 going to rebase nd/magic-pathspecs after this series graduates to
 master anyway, feel free to reject.

 submodule.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 6b01a02..9f442d8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1102,7 +1102,8 @@ void connect_work_tree_and_git_dir(const char *wo=
rk_tree, const char *git_dir)
 	struct strbuf configfile_name =3D STRBUF_INIT;
 	struct strbuf gitfile_content =3D STRBUF_INIT;
 	struct strbuf gitfile_name =3D STRBUF_INIT;
-	const char *real_work_tree =3D real_path(work_tree);
+	char *real_work_tree =3D xstrdup(real_path(work_tree));
+	char *to_free =3D real_work_tree;
 	const char *pathspec[] =3D { real_work_tree, git_dir, NULL };
 	const char *max_prefix =3D common_prefix(pathspec);
 	FILE *fp;
@@ -1157,4 +1158,5 @@ void connect_work_tree_and_git_dir(const char *wo=
rk_tree, const char *git_dir)
=20
 	strbuf_release(&core_worktree_setting);
 	strbuf_release(&configfile_name);
+	free(to_free);
 }
--=20
1.8.2.82.gc24b958
