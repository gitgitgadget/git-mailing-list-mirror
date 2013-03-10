From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sun, 10 Mar 2013 13:14:27 +0700
Message-ID: <1362896070-17456-4-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 07:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEZXb-0001AZ-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 07:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145Ab3CJGO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 01:14:59 -0500
Received: from mail-da0-f50.google.com ([209.85.210.50]:59099 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab3CJGO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 01:14:58 -0500
Received: by mail-da0-f50.google.com with SMTP id t1so120140dae.23
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 22:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tC3q28mIi1PHmXA4a2IxyK9jVxiAkOf/+kxGYBs37g4=;
        b=hwIj00DIZVfeYn8PBawjO3GBj9qTdhcpHm/hj59gzCNs2BM6Tx2OEVPUeg+lDQQcfc
         BuHZ+aGD8qzd4Wx6dFFn39fjPMeNvjeeQrJoF+ViUOU1651gsQca/xAHCZyEl3WklGqa
         c4AkuHRfIN5/d3VH923Dw1KR+4JvkAXQyjgS8o6eRCMEuNVWyRj6eqe8+ZzaD6Ar9oia
         IBN3NW9kRmCMqMmMdAp1ypkfddQud2cK4hXzrp+W3IPy1JR8pMom87nvs0SJhD0xw0Bm
         T2c1l0m/WbEFt/iidqWQjRUIPGJQlkBQF7+KBSiLrzkKvuYQ1ZjrpTQBGbOkZ5Wggchd
         Q2Og==
X-Received: by 10.68.234.100 with SMTP id ud4mr17107789pbc.8.1362896098052;
        Sat, 09 Mar 2013 22:14:58 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id gf6sm13848372pbc.24.2013.03.09.22.14.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 22:14:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Mar 2013 13:14:52 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217782>

strncmp is provided length information which could be taken advantage
by the underlying implementation. Even better, we need to check if the
lengths are equal before calling strncmp, eliminating a bit of strncmp
calls.

        before      after
user    0m0.548s    0m0.516s
user    0m0.549s    0m0.523s
user    0m0.554s    0m0.532s
user    0m0.557s    0m0.533s
user    0m0.558s    0m0.535s
user    0m0.559s    0m0.542s
user    0m0.562s    0m0.546s
user    0m0.564s    0m0.551s
user    0m0.566s    0m0.556s
user    0m0.569s    0m0.561s

While at there, fix an inconsistency about pattern/patternlen in how
attr handles EXC_FLAG_MUSTBEDIR. When parse_exclude_pattern detects
this flag, it sets patternlen _not_ to include the trailing slash and
expects the caller to trim it. add_exclude does, parse_attr_line does
not.

In attr.c, the pattern could be "foo/" while patternlen tells us it
only has 3 chars. Some functions do not care about patternlen and will
see the pattern as "foo/" while others may see it as "foo". This patch
makes patternlen 4 in this case. (Although for a piece of mind,
perhaps we should trim it to "foo" like exclude, and never pass a
pathname like "abc/" to match_{base,path}name)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 2 ++
 dir.c  | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index e2f9377..1818ba5 100644
--- a/attr.c
+++ b/attr.c
@@ -255,6 +255,8 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
+		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
+			res->u.pat.patternlen++;
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
diff --git a/dir.c b/dir.c
index 9960a37..46b24db 100644
--- a/dir.c
+++ b/dir.c
@@ -610,12 +610,14 @@ int match_basename(const char *basename, int base=
namelen,
 		   int flags)
 {
 	if (prefix =3D=3D patternlen) {
-		if (!strcmp_icase(pattern, basename))
+		if (patternlen =3D=3D basenamelen &&
+		    !strncmp_icase(pattern, basename, patternlen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		if (patternlen - 1 <=3D basenamelen &&
-		    !strcmp_icase(pattern + 1,
-				  basename + basenamelen - patternlen + 1))
+		    !strncmp_icase(pattern + 1,
+				   basename + basenamelen - patternlen + 1,
+				   patternlen - 1))
 			return 1;
 	} else {
 		if (fnmatch_icase(pattern, basename, 0) =3D=3D 0)
--=20
1.8.1.2.536.gf441e6d
