From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 8/9] clean: use cache_name_is_other()
Date: Fri, 24 Jan 2014 20:40:35 +0700
Message-ID: <1390570836-20394-9-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:36:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gvQ-0005Io-OY
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbaAXNf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:57 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40587 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:55 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so3282684pab.38
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZW/obq35FYVtec/dRYhJLo5N6IsmOuD2QjfX7S1zC68=;
        b=m5c2N7qOio1SH+BJix40tWRdvqZVuJibUtVxX8D2ob3G1HzH6Aka7Se75pZCGFLdwi
         9ifGacnCHN6AqxZ/vtSyEcFYXeBBsrznhOk4/ne5o8pMvVjHq8aBPzIp09f1xzyzWAVm
         6dFbHTvQXi+x4HRdFDdPrYol/oesjMiLjtW8jQc310XAcSS5OfBdU+VDGVBI6xvG+tr7
         1LA5f0vGRe6gbkyOEct9R7zDSipk0fi/Xzrdc9idiqpFZWXR6ge3LvYPthpUit1QnRGj
         sJhW0HUTjjdjX5iP8M9R3OqNF7xp2rIUyzvxRLyz42WYrcQAgMenY6DZEP33EqzPU+rG
         DErg==
X-Received: by 10.68.201.226 with SMTP id kd2mr14231002pbc.157.1390570555550;
        Fri, 24 Jan 2014 05:35:55 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id i10sm7719995pat.11.2014.01.24.05.35.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:41:30 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241007>

cmd_clean() has the exact same code of index_name_is_other(). Reduce
code duplication.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 5adb52d..cb02a53 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -933,29 +933,12 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
-		int len, pos;
 		int matches =3D 0;
-		const struct cache_entry *ce;
 		struct stat st;
 		const char *rel;
=20
-		/*
-		 * Remove the '/' at the end that directory
-		 * walking adds for directory entries.
-		 */
-		len =3D ent->len;
-		if (len && ent->name[len-1] =3D=3D '/')
-			len--;
-		pos =3D cache_name_pos(ent->name, len);
-		if (0 <=3D pos)
-			continue;	/* exact match */
-		pos =3D -pos - 1;
-		if (pos < active_nr) {
-			ce =3D active_cache[pos];
-			if (ce_namelen(ce) =3D=3D len &&
-			    !memcmp(ce->name, ent->name, len))
-				continue; /* Yup, this one exists unmerged */
-		}
+		if (!cache_name_is_other(ent->name, ent->len))
+			continue;
=20
 		if (lstat(ent->name, &st))
 			die_errno("Cannot lstat '%s'", ent->name);
--=20
1.8.5.2.240.g8478abd
