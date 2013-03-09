From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] match_basename: use strncmp instead of strcmp
Date: Sat,  9 Mar 2013 11:09:50 +0700
Message-ID: <1362802190-7331-4-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 05:11:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEB7d-0006q6-V5
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 05:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933699Ab3CIEKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 23:10:20 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:47105 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933657Ab3CIEKR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 23:10:17 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1867315pbc.21
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 20:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TkiztcV7ShELF851KTeuvqW9nAtxsGkUNEKH7RlW9hk=;
        b=NArDkKNBEPZbMef1A+mJEfeRP5w7psvG8rdtXPmQSHgCxCRvSgmOH70SMkX/OWPwwu
         dJlWTfEHX97tVaTZmMa86568+rTwkcMBjz2IypaSoEvghS7w7twCEMjjJ3WrWsgYX37Y
         r33gJccD2Vlinxdi8XHmAcOxk3C9wFHA0ENyMyvAXdF1RlXMufpwNgVfY9vA6fkCzgaA
         jfSXmr1mK5D0INPlxCQXIBpJbWlZqTXzZfCmNgPyFj7+Rn/7eAtq3wmm9tM0Mwc1nc8r
         q8raertumJnR2pxvyvgOeJtAAfuRYb8qhU8vovDEUG4p5dObyabL+uI7wUrQtBkR9DKR
         d0Zg==
X-Received: by 10.68.0.41 with SMTP id 9mr8148578pbb.132.1362802216539;
        Fri, 08 Mar 2013 20:10:16 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id 1sm8148623pbg.18.2013.03.08.20.10.13
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Mar 2013 20:10:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 09 Mar 2013 11:10:11 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217699>

strncmp provides length information, compared to strcmp, which could
be taken advantage by the implementation. Even better, we could check
if the lengths are equal before calling strncmp, eliminating a bit of
strncmp calls.

        before      after
user    0m0.519s    0m0.489s
user    0m0.521s    0m0.504s
user    0m0.523s    0m0.507s
user    0m0.532s    0m0.510s
user    0m0.534s    0m0.513s
user    0m0.536s    0m0.514s
user    0m0.537s    0m0.522s
user    0m0.545s    0m0.523s
user    0m0.546s    0m0.527s
user    0m0.548s    0m0.529s

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
index f58320d..2a91d14 100644
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
