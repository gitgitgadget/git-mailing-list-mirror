From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/13] match_basename: use strncmp instead of strcmp
Date: Tue, 12 Mar 2013 20:04:51 +0700
Message-ID: <1363093500-16796-5-git-send-email-pclouds@gmail.com>
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
	id 1UFOuO-0007Yu-H0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab3CLNFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:05:47 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:55125 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab3CLNFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:05:45 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so4963496pbb.18
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=BYX96aPhtcGx0Pjrg9uETXAuftVPc8DvsAlp247jq2U=;
        b=SfaPpLvjEqisUFcGk86LE4H9J1lqSmUzpUws2xYW7boqb4uB5bw05X/Kcmrh0mxabb
         9Qj172gEU7VQNaJjydywvN1Qt1N1mnPbDYxbutcYlvTl512Lbr/JoTbWEapIKN2Lk2p3
         l1n6eRyC9Yh8Q7k1euDm9hzIY9kGF925IKtuXFpqbuwnBl2gW2x+syWufdmB8U3GmXSV
         aNI77l7vas1braH4gemvzWLI2j/0whZRTOZ/CbIHPX/bQkbm8nmx47cie8pjPTz7ABKR
         tRXvA0wfiiZNBUHQODYLAvTZpRxKX7XjXFRZVoH61iJe7nLM7DAkzYunCCs4FqyzsIph
         B4JQ==
X-Received: by 10.68.11.135 with SMTP id q7mr36996238pbb.5.1363093544464;
        Tue, 12 Mar 2013 06:05:44 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ix6sm24996744pbc.17.2013.03.12.06.05.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:05:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:36 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217951>

strncmp provides length information, compared to strcmp, which could
be taken advantage by the implementation. Even better, we could check
if the lengths are equal before calling strncmp, eliminating a bit of
strncmp calls.

treat_leading_path:   0.000  0.000
read_directory:       3.558  3.578
+treat_one_path:      2.305  2.323
++is_excluded:        2.098  2.117
+++prep_exclude:      0.223  0.224
+++matching:          1.529  1.544
++dir_exist:          0.035  0.035
++index_name_exists:  0.291  0.290
lazy_init_name_hash:  0.257  0.258
+simplify_away:       0.086  0.087
+dir_add_name:        0.445  0.445

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
index a69c8ac..a2ab200 100644
--- a/dir.c
+++ b/dir.c
@@ -636,12 +636,14 @@ int match_basename(const char *basename, int base=
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
