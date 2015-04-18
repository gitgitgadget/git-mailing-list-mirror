From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Sat, 18 Apr 2015 08:19:06 +0700
Message-ID: <1429319946-19890-1-git-send-email-pclouds@gmail.com>
References: <55300D2C.9030903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens.Lehmann@web.de, dennis@kaarsemaker.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 03:19:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjHPk-0006JZ-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 03:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbDRBTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 21:19:13 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35730 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbDRBTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 21:19:13 -0400
Received: by pabtp1 with SMTP id tp1so142099671pab.2
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=42FvJlgLFiRGfgcKvbaGmr8mBx9anr+2L5DigtOMw5A=;
        b=KmE5WQod+zxJWy1RxIUL/3HutLvtJ6RFrF2HChtpL40wNbP1r60GPdbuqFFLLVTYvc
         cKTJjkhtGOBfeJaQugg/VVVDLn4fb2KUftE1UYa/kbHUaHWCYiWsv56D3cbDx/9eROQ1
         2jSM2tZfNHG0y15qycF32OC3IHRphcOXeSj9EPkJerGybWFSPmQlXbo1My/r4SdT3goa
         oTDNwzASB+FiRRySfFmUUcCsJbZ+z3spKy5JlRXHovbNFDTZFsVmOABbmNjxDFHGk4oy
         NwAKmc9WXnndjhnN8m2ORvlMFj5ahYO3T8psXm5ZzCAZ6HSogKsK5RWm7vwmhERoFp83
         rL7g==
X-Received: by 10.70.125.129 with SMTP id mq1mr964197pdb.19.1429319952598;
        Fri, 17 Apr 2015 18:19:12 -0700 (PDT)
Received: from lanh ([115.73.194.67])
        by mx.google.com with ESMTPSA id al13sm11338325pac.23.2015.04.17.18.19.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2015 18:19:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 18 Apr 2015 08:19:10 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <55300D2C.9030903@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267404>

A path(spec) from git perspective consists of two parts, the prefix,
and the rest. The prefix covers the part of `pwd` after expanding ".."
components. The split is to support case-insensitive match in a sane
way (see 93d9353, especially the big comment block added in dir.c).

Normally the prefix is found after prefix_path_gently() and that will
be it. Unfortunately the *STRIP_SUBMODULE* flags can strip the
trailing slash (see 2ce53f9 for the reason) and cut into this prefix
part. In the test, the prefix is "submodule/", but the final path is
just "submodule". We need to readjust prefix info when this happens.

The assert() that catches this is turned to die() to make sure it's
always active. prefix_pathspec() is not in any critical path to be a
performance concern because of this change.

93d9353 (parse_pathspec: accept :(icase)path syntax - 2013-07-14)
2ce53f9 (git add: do not add files from a submodule - 2009-01-02)

Noticed-by: djanos_ (via irc)
Helped-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Apr 17, 2015 at 2:27 AM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
 > The problem seems to be that "subrepo" is still registered as a
 > submodule in the index. But we should see a proper error message
 > instead of an assert in that case ... CCed Duy who knows much
 > more about pathspec.c than me.

 This deals with the bug in pathspec code. I leave it to you to decide
 how git-add should do when a submodule is registered in index, but
 it's no longer a submodule in worktree. Yeah maybe it should error
 out.

 pathspec.c                    | 18 +++++++++++++++---
 t/t3703-add-magic-pathspec.sh |  8 ++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 9304ee3..aa5e2c7 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -262,7 +262,6 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	} else
 		item->original =3D elt;
 	item->len =3D strlen(item->match);
-	item->prefix =3D prefixlen;
=20
 	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
 	    (item->len >=3D 1 && item->match[item->len - 1] =3D=3D '/') &&
@@ -292,6 +291,15 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 				     elt, ce_len, ce->name);
 		}
=20
+	/*
+	 * Adjust prefixlen if the above trailing slash stripping cuts
+	 * into the prefix part
+	 */
+	if ((flags & (PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
+		      PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)) &&
+	    prefixlen > item->len)
+		prefixlen =3D item->len;
+
 	if (magic & PATHSPEC_LITERAL)
 		item->nowildcard_len =3D item->len;
 	else {
@@ -299,6 +307,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 		if (item->nowildcard_len < prefixlen)
 			item->nowildcard_len =3D prefixlen;
 	}
+	item->prefix =3D prefixlen;
 	item->flags =3D 0;
 	if (magic & PATHSPEC_GLOB) {
 		/*
@@ -313,8 +322,11 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	}
=20
 	/* sanity checks, pathspec matchers assume these are sane */
-	assert(item->nowildcard_len <=3D item->len &&
-	       item->prefix         <=3D item->len);
+	if (!(item->nowildcard_len <=3D item->len &&
+	      item->prefix         <=3D item->len))
+		die("BUG: item->nowildcard_len (%d) or item->prefix (%d)"
+		    " is longer than item->len (%d)",
+		    item->nowildcard_len, item->prefix, item->len);
 	return magic;
 }
=20
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec=
=2Esh
index 5115de7..cced8c4 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -55,4 +55,12 @@ test_expect_success COLON_DIR 'a file with the same =
(short) magic name exists' '
 	git add -n "./:/bar"
 '
=20
+test_expect_success 'prefix is updated after trailing slash is strippe=
d' '
+	git init submodule &&
+	( cd submodule && test_commit test ) &&
+	git add submodule &&
+	mv submodule/.git submodule/dotgit &&
+	( cd submodule && git add . )
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
