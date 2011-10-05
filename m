From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Report errors related to .git access during repository discovery
Date: Wed,  5 Oct 2011 19:17:31 +1100
Message-ID: <1317802651-28956-1-git-send-email-pclouds@gmail.com>
References: <4E8BF519.8090509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Federico Lucifredi <federico@canonical.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 05 10:18:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBMft-0007ra-GE
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 10:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758016Ab1JEIRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 04:17:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39448 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab1JEIRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 04:17:47 -0400
Received: by iakk32 with SMTP id k32so1533687iak.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/ZVw8FhqWJpHRiAz1hhH5mBpAaVxjeckY7Ili23IVGQ=;
        b=BQDcZAmDZfva2wM0yW1kObbZmu5r+L06odp1RYWNned9vg+TT87JS8QBy0BkYXIp2i
         UIceicaAtUJg9FcJ2W/1+BnL675RGau4Fpd1VcQuI7uLk7mfJ4IoPuTilSTb05ezTk52
         SYlOJhnNmG9N3tRP0ZRsXPtP5+RCKSzforHgo=
Received: by 10.42.136.65 with SMTP id s1mr2524996ict.5.1317802667048;
        Wed, 05 Oct 2011 01:17:47 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id z11sm2342655iba.6.2011.10.05.01.17.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 01:17:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 05 Oct 2011 19:17:33 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <4E8BF519.8090509@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182836>

If $GIT_DIR is not given, we go up step by step and look for potential
repository directory, may see .git directory but for some reasons we
decide to skip and move on.

It's probably better to report along the line, so users can stop
wondering "hey, but I have .git directory _there_".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Wed, Oct 5, 2011 at 5:11 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
 > Am 10/4/2011 23:24, schrieb Federico Lucifredi:
 >> Hello Git list,
 >>  Found a minor bug in git today - the error message reported is not
 >> correct when trying to access a repo that is not accessible
 >> permission-wise:
 >>
 >>> federico@skyplex:/etc$ git log
 >>> fatal: Not a git repository (or any of the parent directories): .g=
it
 >>
 >> with correct access permissions, everything works as expected.
 >
 > And the correct error message is...?

 That's a correct message. But it'd be even better if we help diagnose
 why. Even when you have proper access to .git dir, git can still
 refuse to accept the directory as a repository, because "HEAD" is
 invalid for example.

 I think a patch like this is an improvement. There may be many
 situations git refuses a directory but I don't cover here. Well, we
 may when users report them

 setup.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 27c1d47..b6028e5 100644
--- a/setup.c
+++ b/setup.c
@@ -269,6 +269,19 @@ const char *pathspec_prefix(const char *prefix, co=
nst char **pathspec)
 }
=20
 /*
+ * This function is used during .git detection phase. If .git does not
+ * exist, it's OK not to report because that happens a lot if you stay
+ * inside a subdirectory and git checks every level back to topdir.
+ */
+static int access_and_warn(const char *path, int perm)
+{
+	int ret =3D access(path, perm);
+	if (ret && errno !=3D ENOENT)
+		error("%s: %s", absolute_path(path), strerror(errno));
+	return ret;
+}
+
+/*
  * Test if it looks like we're at a git directory.
  * We want to see:
  *
@@ -288,22 +301,24 @@ static int is_git_directory(const char *suspect)
 		die("Too long path: %.*s", 60, suspect);
 	strcpy(path, suspect);
 	if (getenv(DB_ENVIRONMENT)) {
-		if (access(getenv(DB_ENVIRONMENT), X_OK))
+		if (access_and_warn(getenv(DB_ENVIRONMENT), X_OK))
 			return 0;
 	}
 	else {
 		strcpy(path + len, "/objects");
-		if (access(path, X_OK))
+		if (access_and_warn(path, X_OK))
 			return 0;
 	}
=20
 	strcpy(path + len, "/refs");
-	if (access(path, X_OK))
+	if (access_and_warn(path, X_OK))
 		return 0;
=20
 	strcpy(path + len, "/HEAD");
-	if (validate_headref(path))
+	if (validate_headref(path)) {
+		error("invalid HEAD at %s", absolute_path(path));
 		return 0;
+	}
=20
 	return 1;
 }
--=20
1.7.3.1.256.g2539c.dirty
