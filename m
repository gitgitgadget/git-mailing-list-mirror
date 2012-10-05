From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/10] gitignore: forbid "abc**def"
Date: Fri,  5 Oct 2012 11:41:09 +0700
Message-ID: <1349412069-627-11-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:28:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2L2-0004MO-0F
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab2JEH2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:28:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53053 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab2JEH2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:28:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1394108pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ph3ZQ1c3Vh5gg5Fp5mEr3v6iaC46/Gdbq7AAc1I5cMY=;
        b=aPkrMLJ0AP/rQmeV5nPIMKPTJsbkdEKY/wF9zW9Gd9eajqGTTzh26RZd/K++7akDFK
         48sioLpnUl/eidpvQwHgiyTB4qBSTMmjfdHKnsPGFY8sH6Fkmo0R9E8/Stet3rmnngsY
         s8s7ifzBiyIxhLozpa8dZ2pYQCSskhZXjyYHtkwAB3+55Rc6VooxOKg143L8bxN4T4WT
         6ZsE2p1uWu4EjiTtdehzCadDxbPbAxWneKysXGjBltHBjHnSidDEbGu1+z+8upnmOkga
         Ydndxp79DRa/aiawtUxm8RwMPxU+aGiwIRamOG6s8TR+L8UlHk6d4X6DKpBoVnGybe9e
         pjOw==
Received: by 10.66.77.199 with SMTP id u7mr6306146paw.7.1349412134871;
        Thu, 04 Oct 2012 21:42:14 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id uu10sm5441257pbc.2.2012.10.04.21.42.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:42:14 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:42:23 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207084>

Deep down wildmatch() sees "**" as "*" that can also match slashes. On
the surface, it may be confusing to users as the above pattern can
match "abcdef", "abcxyzdef", "abc/def", "abc/x/def",
"abc/x/y/def"... For now we just forbid it. Users can only do
"**/def", "abc/**" or "abc/**/def". The syntax may be re-enabled in
future.

There's a minor problem with this particular approach. "**" inside
square brackets are mistaken as the wildcard while they are not. Git
shows a confusing message when users do that.

Note that this patch hides a potential problem that if "abc**def" is
ever supported, EXC_FLAG_NODIR flag should be turned off or only the
base name is matched against the pattern, which makes no sense.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt        |  6 ++++--
 dir.c                              | 12 +++++++++---
 t/t0003-attributes.sh              |  5 +++++
 t/t3001-ls-files-others-exclude.sh |  5 +++++
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index eb81d31..ad9fc2f 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -94,8 +94,10 @@ PATTERN FORMAT
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
 +
-Contrary to fnmatch(3), git matches "**" to anything including
-slashes, similar to rsync(1).
+In addition to fnmatch(3) syntax, "**" can be used to match one or
+more directories. For example, "abc/**/def" matches "abc/x/def",
+"abc/x/y/def", "abc/x/y/z/def" and so on. "**" must be wrapped by
+slashes.
=20
  - A leading slash matches the beginning of the pathname.
    For example, "/{asterisk}.c" matches "cat-file.c" but not
diff --git a/dir.c b/dir.c
index cb78273..f30117f 100644
--- a/dir.c
+++ b/dir.c
@@ -327,12 +327,18 @@ void parse_exclude_pattern(const char **pattern,
 		len--;
 		*flags |=3D EXC_FLAG_MUSTBEDIR;
 	}
+	*flags |=3D EXC_FLAG_NODIR;
 	for (i =3D 0; i < len; i++) {
 		if (p[i] =3D=3D '/')
-			break;
+			*flags &=3D ~EXC_FLAG_NODIR;
+		if ((p[i] =3D=3D '*' && p[i + 1] =3D=3D '*' &&
+		     (i =3D=3D 0 || p[i - 1] !=3D '\\')) &&
+		    !((i =3D=3D 0 || p[i - 1] =3D=3D '/') &&
+		      (p[i + 2] =3D=3D '\0' ||
+		       p[i + 2] =3D=3D '/' ||
+		       (p[i + 2] =3D=3D '\\' && p[i + 3] =3D=3D '/'))))
+			die(_("** in .gitignore or .gitattributes must be wrapped by slashe=
s"));
 	}
-	if (i =3D=3D len)
-		*flags |=3D EXC_FLAG_NODIR;
 	*nowildcardlen =3D simple_length(p);
 	/*
 	 * we should have excluded the trailing slash from 'p' too,
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 6c3c554..ddeb321 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -249,4 +249,9 @@ EOF
 	test_line_count =3D 0 err
 '
=20
+test_expect_success '"**" with no slashes test' '
+	echo "a**f foo=3Dbar" >.gitattributes &&
+	test_must_fail git check-attr foo -- "f"
+'
+
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index 67c8bcf..f5c62d0 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -225,4 +225,9 @@ EOF
 	test_cmp expect actual
 '
=20
+
+test_expect_success 'ls-files with "**" patterns and no slashes' '
+	test_must_fail git ls-files -o -i --exclude "one**a.1"
+'
+
 test_done
--=20
1.7.12.1.405.gb727dc9
