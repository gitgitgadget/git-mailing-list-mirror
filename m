From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/13] match_pathname: avoid calling strncmp if baselen is 0
Date: Tue, 12 Mar 2013 20:04:49 +0700
Message-ID: <1363093500-16796-3-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOuN-0007Yu-11
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab3CLNFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:05:35 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:46656 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3CLNFa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:05:30 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp2so4981473pbb.20
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KNiKJ/UlPy1l2Jc7GNUJvBclFNZwlSWbE4c+u6FTSb4=;
        b=eDVK94/dTlsGxc2eKYOpQjPzxBUkyS8neUrYKw+HFHXI4mm7ibh5EpihMyItXzNitC
         CzimSenWXMeOmosA7rvjq2wpF1LNShhqijj3Eblfweq3eWaPmhri6oZ53JZMbtnLV4Mm
         IxVviiwi2G6LxBcv2M2E+6BhntV9c9vThw8Cl6LyLhkg/i0heG1zKJSrFBkEPBhm8Nzd
         i+xzQPukCdT32aQIe81Gv9V0OAe4YD0H2qp3uvnCQsrGfvJPGImfYtoqReznbo+weQWs
         oczrJwIF4lqoIra4umGQE26G/0syzBxm8kn0lmVKRedxyqg9/qYQTnVwp8ADI9jKaIlt
         YfYw==
X-Received: by 10.68.179.67 with SMTP id de3mr29383715pbc.130.1363093530225;
        Tue, 12 Mar 2013 06:05:30 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id 1sm24995638pbg.18.2013.03.12.06.05.26
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:05:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:24 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217952>

This reduces "git status" user time by a little bit. This is the
sorted results of 10 consecutive runs of "git ls-files
--exclude-standard -o" on webkit.git, compiled with gcc -O2:

treat_leading_path:   0.000  0.000
read_directory:       4.102  3.674
+treat_one_path:      2.843  2.427
++is_excluded:        2.632  2.221
+++prep_exclude:      0.225  0.224
+++matching:          2.054  1.650
++dir_exist:          0.035  0.035
++index_name_exists:  0.292  0.288
lazy_init_name_hash:  0.258  0.257
+simplify_away:       0.085  0.085
+dir_add_name:        0.446  0.441

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 69c045b..32a3adb 100644
--- a/dir.c
+++ b/dir.c
@@ -688,8 +688,8 @@ int match_pathname(const char *pathname, int pathle=
n,
 	 * may not end with a trailing slash though.
 	 */
 	if (pathlen < baselen + 1 ||
-	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp_icase(pathname, base, baselen))
+	    (baselen && (pathname[baselen] !=3D '/' ||
+			 strncmp_icase(pathname, base, baselen))))
 		return 0;
=20
 	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
--=20
1.8.1.2.536.gf441e6d
