From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] rm: only refresh entries that we may touch
Date: Sun, 17 Jan 2010 15:43:13 +0700
Message-ID: <1263717793-24009-1-git-send-email-pclouds@gmail.com>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 09:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWQjz-0005Rd-Sd
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 09:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab0AQIoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jan 2010 03:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090Ab0AQIoG
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 03:44:06 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:35531 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0AQIoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 03:44:04 -0500
Received: by pxi12 with SMTP id 12so2348381pxi.33
        for <git@vger.kernel.org>; Sun, 17 Jan 2010 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9euJUzqJ1WNbHX3o4kW9ydpJvSGUK+4tvywt8jeSW/Q=;
        b=v4PdefM5zt4ifUC+rrvVa23bcikMKg1v9DwcyZkR9sb83wOPEoiajWSGBWARPrqffQ
         XxTndFGdT7R3Xo6zfuw+lxLei9C81oxs/kiXI2TDsgfKw0kvP706K51c7gllpGWyvpj4
         Vbline20uROOpmJLc3nPYRkUhuluFUEn8PDwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=p4RbsWounme218emmyAjJVKY6qfc/OtZ5S7K1tJ3HDULD17EGrclUlorYr7Yl7tKi5
         PJGNE98c1tNhcWu6j17mFKHkqKNn15iZHeUfgXTfU3KgZ6qcRYBRNfyMCu6Zi3q0N+XO
         o46mMtrYludt8yih1HtoC0WbrlpfU3/czU5RA=
Received: by 10.142.6.19 with SMTP id 19mr413106wff.131.1263717842429;
        Sun, 17 Jan 2010 00:44:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.107])
        by mx.google.com with ESMTPS id 22sm3114938pzk.14.2010.01.17.00.44.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Jan 2010 00:44:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 17 Jan 2010 15:43:15 +0700
X-Mailer: git-send-email 1.6.6.181.g5ee6
In-Reply-To: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137279>

This gets rid of the whole tree cache refresh. Instead only path that
we touch will get refreshed. We may still lstat() more than needed,
but it'd be better playing safe.

This potentially reduces a large number of lstat() on big trees. Take
gentoo-x86 tree for example, which has roughly 80k files:

Unmodified Git:

$ time git rm --cached skel.ebuild
rm 'skel.ebuild'

real    0m1.441s
user    0m0.821s
sys     0m0.531s

Modified Git:

$ time ~/w/git/git rm --cached skel.ebuild
rm 'skel.ebuild'

real    0m0.941s
user    0m0.828s
sys     0m0.091s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 In the previous attempt, refresh_cache_entry() returns a new cache_ent=
ry.
 It does not modify the_index, so tests failed.

 builtin-rm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 57975db..f3772c8 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -169,9 +169,10 @@ int cmd_rm(int argc, const char **argv, const char=
 *prefix)
=20
 	if (read_cache() < 0)
 		die("index file corrupt");
-	refresh_cache(REFRESH_QUIET);
=20
 	pathspec =3D get_pathspec(prefix, argv);
+	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
+
 	seen =3D NULL;
 	for (i =3D 0; pathspec[i] ; i++)
 		/* nothing */;
--=20
1.6.6.181.g5ee6
