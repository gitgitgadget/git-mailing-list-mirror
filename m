From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] update-index: enable/disable watchman support
Date: Sun,  1 Nov 2015 14:55:46 +0100
Message-ID: <1446386146-10438-6-git-send-email-pclouds@gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:56:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zst7N-0002MO-Ui
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbbKAN4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:56:17 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37180 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbbKAN4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:56:13 -0500
Received: by wicfv8 with SMTP id fv8so35803164wic.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rbVzYuQLnbCtudMsWXg4Tushvn1la9/Ki3zNFbbeUKE=;
        b=wFOFeRStxtiuk90TMiXmToOE8vgpowYt+VthdWzrWQrLH2nkTda72BrodNm+t8VnPD
         I1rysZAjKFd7N4L2waKljJYDl9QC1vynQ5539BH4LpDnd9CQaGs5zapQt9BeKHzqaTsZ
         oo7nAUpUFGW1wHOorkCAK4J/Y5mosYqmBVBYgpPHs9i2aI9moJGleBhky6W7Fs5KBoIF
         Kgr5F3D34Hg1neH/YDRgp1UEe0KEY7g4T68jxptOy3bvpLWS4rmebwuUBwh0Aop5aFJi
         g0TJ/uDZBYkD4frdSzajwaWO8KXVN2Coo+wpIu0AGx6BYBIYTp/P8aR5Yrs4ig/U4AZu
         5gzw==
X-Received: by 10.194.243.102 with SMTP id wx6mr18388835wjc.68.1446386172059;
        Sun, 01 Nov 2015 05:56:12 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id bk2sm17185525wjc.3.2015.11.01.05.56.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:56:10 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280632>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..86aec21 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -903,6 +903,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 {
 	int newfd, entries, has_errors =3D 0, line_termination =3D '\n';
 	int untracked_cache =3D -1;
+	int use_watchman =3D -1;
 	int read_from_stdin =3D 0;
 	int prefix_length =3D prefix ? strlen(prefix) : 0;
 	int preferred_index_format =3D 0;
@@ -998,6 +999,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), 2)=
,
+		OPT_BOOL(0, "watchman", &use_watchman,
+			N_("use or not use watchman to reduce refresh cost")),
 		OPT_END()
 	};
=20
@@ -1127,6 +1130,14 @@ int cmd_update_index(int argc, const char **argv=
, const char *prefix)
 		the_index.cache_changed |=3D UNTRACKED_CHANGED;
 	}
=20
+	if (use_watchman > 0) {
+		the_index.last_update    =3D xstrdup("");
+		the_index.cache_changed |=3D WATCHMAN_CHANGED;
+	} else if (!use_watchman) {
+		the_index.last_update    =3D NULL;
+		the_index.cache_changed |=3D WATCHMAN_CHANGED;
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
--=20
2.2.0.513.g477eb31
