From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Turn off pathspec magic on "{checkout,reset,add} -p" on native Windows builds
Date: Sun,  1 Sep 2013 09:08:04 +0700
Message-ID: <1378001284-18426-1-git-send-email-pclouds@gmail.com>
References: <521EF02A.2020300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Sep 01 04:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFx2l-0003gU-6e
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 04:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab3IACFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 22:05:19 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42285 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab3IACFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 22:05:17 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so3373980pdi.13
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 19:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Zjx4Fc7WPB9NM6cK3V+S3epkeRveakVuxGQXeIP5SZA=;
        b=VGBSqtPacS4x3lZUhr5UOQr9f2ZMyizdOiWc50dJTEk6pyhBpg6AwgvJ0xeBamltAZ
         DBkAJPaxoVCcw385QbmKTvzRPL0bnescCcvFlKGJf1RZDRUTFdPkA/7+3Y9U2FuVdNIB
         Qa+3EHG6s177kX3F5AxyyGpJaHnft35EqMOWy/zNiGh4TPyuiZvvnBvUuGQEvUH1UK10
         wRBvaIdtNCPm+6wgxvcW7RTwJ8hRtE9LsYMFIHdAecu62Y1RWBS2DBFK/9FhHrKVpv6f
         DTNues5/5NQHBvHQ7AO0djiDKy0fpGLa8mVtjnKMubBPaeI1ttXsNy3DZNaQ1rIJvDOP
         P2dg==
X-Received: by 10.67.4.197 with SMTP id cg5mr18766250pad.10.1378001114511;
        Sat, 31 Aug 2013 19:05:14 -0700 (PDT)
Received: from lanh ([115.73.192.103])
        by mx.google.com with ESMTPSA id ye1sm7557784pab.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 31 Aug 2013 19:05:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 Sep 2013 09:08:17 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <521EF02A.2020300@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233559>

git-add--interactive.perl rejects arguments with colons in 21e9757
(Hack git-add--interactive to make it work with ActiveState Perl -
2007-08-01). Pathspec magic starts with a colon, so it won't work if
these pathspecs are passed to git-add--interactive.perl running with
ActiveState Perl. Make sure we only pass plain paths in this case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Johannes, can you check the test suite passes for you with this
 patch? I assume that Cygwin Perl behaves differently and does not hit
 this limit. So I keep the special case to GIT_WINDOWS_NATIVE only.
 I'll resend the patch with a few others on the same topic if it works
 for you.

 builtin/add.c      | 13 +++++++++++++
 builtin/checkout.c | 23 ++++++++++++++++++++---
 builtin/reset.c    | 24 ++++++++++++++++++++----
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 9d52fc7..3402239 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -270,6 +270,18 @@ int interactive_add(int argc, const char **argv, c=
onst char *prefix, int patch)
 {
 	struct pathspec pathspec;
=20
+#ifdef GIT_WINDOWS_NATIVE
+	/*
+	 * Pathspec magic is completely turned off on native Windows
+	 * builds because git-add-interactive.perl won't accept
+	 * arguments with colons in them. :/foo is an exception
+	 * because no colons remain after parsing.
+	 */
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+		       PATHSPEC_PREFER_FULL |
+		       PATHSPEC_SYMLINK_LEADING_PATH,
+		       prefix, argv);
+#else
 	/*
 	 * git-add--interactive itself does not parse pathspec. It
 	 * simply passes the pathspec to other builtin commands. Let's
@@ -281,6 +293,7 @@ int interactive_add(int argc, const char **argv, co=
nst char *prefix, int patch)
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
+#endif
=20
 	return run_add_interactive(NULL,
 				   patch ? "--patch" : NULL,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7ea1100..e12330f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1156,9 +1156,26 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 		 * cannot handle. Magic mask is pretty safe to be
 		 * lifted for new magic when opts.patch_mode =3D=3D 0.
 		 */
-		parse_pathspec(&opts.pathspec, 0,
-			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
-			       prefix, argv);
+		if (opts.patch_mode) {
+#ifdef GIT_WINDOWS_NATIVE
+			/*
+			 * Pathspec magic is completely turned off on
+			 * native Windows builds because
+			 * git-add-interactive.perl won't accept
+			 * arguments with colons in them. :/foo is an
+			 * exception because no colons remain after
+			 * parsing.
+			 */
+			parse_pathspec(&opts.pathspec,
+				       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+				       0, prefix, argv);
+#else
+			parse_pathspec(&opts.pathspec, 0,
+				       PATHSPEC_PREFIX_ORIGIN,
+				       prefix, argv);
+#endif
+		} else
+			parse_pathspec(&opts.pathspec, 0, 0, prefix, argv);
=20
 		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
diff --git a/builtin/reset.c b/builtin/reset.c
index 86150d1..65f7390 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -220,10 +220,26 @@ static void parse_args(struct pathspec *pathspec,
 		}
 	}
 	*rev_ret =3D rev;
-	parse_pathspec(pathspec, 0,
-		       PATHSPEC_PREFER_FULL |
-		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
-		       prefix, argv);
+	if (patch_mode) {
+#ifdef GIT_WINDOWS_NATIVE
+		/*
+		 * Pathspec magic is completely turned off on native
+		 * Windows builds because git-add-interactive.perl
+		 * won't accept arguments with colons in them. :/foo
+		 * is an exception because no colons remain after
+		 * parsing.
+		 */
+		parse_pathspec(pathspec,
+			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+			       PATHSPEC_PREFER_FULL, prefix, argv);
+#else
+		parse_pathspec(pathspec, 0,
+			       PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
+			       prefix, argv);
+#endif
+	} else
+		parse_pathspec(pathspec, 0, PATHSPEC_PREFER_FULL,
+			       prefix, argv);
 }
=20
 static int update_refs(const char *rev, const unsigned char *sha1)
--=20
1.8.2.83.gc99314b
