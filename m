From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH RFC] Convert ce_path_match() use to match_pathspec()
Date: Mon, 25 May 2009 18:42:04 +1000
Message-ID: <1243240924-5981-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 10:42:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8VlG-00089r-S9
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 10:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbZEYImO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 04:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbZEYImO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 04:42:14 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:35832 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbZEYImM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 04:42:12 -0400
Received: by pzk7 with SMTP id 7so2417395pzk.33
        for <git@vger.kernel.org>; Mon, 25 May 2009 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=J1BaA//msmDUXRqS2gEpBgpmbvvzmS5ylhZBiyziIHc=;
        b=Df5qmy22hxEChhFebfa375k8Z5X/YZjPq6diJz+5QpBcFGP2Aif6GU1FYn2J70Agei
         jSDJtSm2DlRL4J9vUrsUW5gwmMKOUw4gab9ob1Gp0LIS5lHCtJY//YSYfHzkupSAFsyp
         Q636Nc2EqKufIEGedNpFUm5WodfyhukFh2kO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=U5OAI5rUjXAMQEhtLtIL0OjT8/k4RAof0x0tmI8a8Bu1vSenyIx841WxwDZ0/QpV0f
         D32ma1ucZL3Rkp8bq/QWQyjODyv344W/HRsVQ0lKo1sSWpAx94pUE9c9hidZBTILCQoE
         ktHy0q+IOZ5Yib6zcz8KP6ZYovG5CaOW5F3X4=
Received: by 10.115.107.1 with SMTP id j1mr14338561wam.149.1243240932740;
        Mon, 25 May 2009 01:42:12 -0700 (PDT)
Received: from dektop ([119.12.0.200])
        by mx.google.com with ESMTPS id n33sm8467944wag.34.2009.05.25.01.42.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 01:42:12 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 25 May 2009 18:42:06 +1000
X-Mailer: git-send-email test
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119901>

Back in history, ce_path_match() was first introduced in commit
fdee7d07ba6c79b3e5125e96adbe1d9c3e75ce1d, in diff-cache.c. It seems
to be used to handle pathspec that we have today. But it did not
support wildcards.

About one year later, match_pathspec() was introduced as match() in
commit 0d78153952e70c21e94dc6b7eefcb2ac5337a902, builtin-add.c. This
version supported wildcards.

=46or some reasons diff code did not get converted to use
match_pathspec(). So diff commands do not understand wildcards. I was
not here that time to know the reasons. But I find it quite handy to
do "git diff -- '*.sh'", just like the rest of git commands.

Hence this patch, which simply calls match_pathspec() inside
ce_path_match(). With this, "git diff-files" and "git diff-index" now
support wildcards. "git diff-tree" does not because it does not use
ce_path_match().

"git update-index --again" is also affected (in a good way hopefully)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 So.. comments?

 read-cache.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 3f58711..d2daf01 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -677,28 +677,10 @@ int ce_same_name(struct cache_entry *a, struct ca=
che_entry *b)
=20
 int ce_path_match(const struct cache_entry *ce, const char **pathspec)
 {
-	const char *match, *name;
-	int len;
-
 	if (!pathspec)
 		return 1;
=20
-	len =3D ce_namelen(ce);
-	name =3D ce->name;
-	while ((match =3D *pathspec++) !=3D NULL) {
-		int matchlen =3D strlen(match);
-		if (matchlen > len)
-			continue;
-		if (memcmp(name, match, matchlen))
-			continue;
-		if (matchlen && name[matchlen-1] =3D=3D '/')
-			return 1;
-		if (name[matchlen] =3D=3D '/' || !name[matchlen])
-			return 1;
-		if (!matchlen)
-			return 1;
-	}
-	return 0;
+	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL);
 }
=20
 /*
--=20
test
