From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] add: add --bulk to index all objects into a pack file
Date: Thu,  3 Oct 2013 11:00:11 +0700
Message-ID: <1380772811-15415-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 03 06:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRa5R-0003yZ-5H
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 06:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab3JCEAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Oct 2013 00:00:21 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:62658 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab3JCEAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 00:00:20 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so1853152pbc.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 21:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=wiqZtndMDNtTsteivRGhNzhvgx+LzFgYMDy6fMGiy0A=;
        b=R3KwjwRX106rE63mPFoqJJ/Ea/CK0SamkGVoabO/+HmNR3itywWiELuUYRBo8PTAMk
         nBvTrNUVEWy8JquL2z8G/Wsq0Jq4yW0L4f+ELPOcEDsPp2ZsrAxBaYyrLp6D3Ccxlb7d
         E7fR+3flVxEkTgDuDV99PwUeVWvXi20K7HbnAb9K0LQ9kfxz+hEgl3/eYVPaJJoiOMgS
         GRt/8UV1lHKwR6sTG6mgU6r5dxqh+ahPr5BxWWvLdezAsyf7L9yLpCtM4AuuO+UjCw8C
         DYUWDW4WIM9lEBPkbJztFLnTMyIR96vmQNCJX0BgHJx8C9g1RVADPn7TKu+jDsEkCJ4T
         UWSg==
X-Received: by 10.68.254.105 with SMTP id ah9mr6166081pbd.87.1380772819617;
        Wed, 02 Oct 2013 21:00:19 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id bt1sm5262190pbb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 02 Oct 2013 21:00:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Oct 2013 11:00:14 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235680>

The use case is

    tar -xzf bigproject.tar.gz
    cd bigproject
    git init
    git add .
    # git grep or something

The first add will generate a bunch of loose objects. With --bulk, all
of them are forced into a single pack instead, less clutter on disk
and maybe faster object access.

This is the equivalent of "git -c core.bigFileThreshold=3D0 add ." so
it's not really a new functionality. Just some convenient and public
exposure.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Interestingly index_stream() seems a bit slower than standard
 index_core(). Perhaps mmap() is faster than a series of read() for
 small files. Room for improvement later.

 Documentation/git-add.txt |  6 ++++++
 builtin/add.c             | 10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 48754cb..36a77f6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -160,6 +160,12 @@ today's "git add <pathspec>...", ignoring removed =
files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
=20
+--bulk::
+	Normally new objects are indexed and stored in loose format,
+	one file per new object in "$GIT_DIR/objects". This option
+	forces putting all objects into a single new pack. This may
+	be useful when you need to add a lot of files initially.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin/add.c b/builtin/add.c
index 226f758..40cbb71 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -336,7 +336,7 @@ static struct lock_file lock_file;
 static const char ignore_error[] =3D
 N_("The following paths are ignored by one of your .gitignore files:\n=
");
=20
-static int verbose, show_only, ignored_too, refresh_only;
+static int verbose, show_only, ignored_too, refresh_only, bulk_index;
 static int ignore_add_errors, intent_to_add, ignore_missing;
=20
 #define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
@@ -368,6 +368,7 @@ static struct option builtin_add_options[] =3D {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh t=
he index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip file=
s which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even =
missing - files are ignored in dry run")),
+	OPT_BOOL( 0 , "bulk", &bulk_index, N_("pack all objects instead of cr=
eating loose ones")),
 	OPT_END(),
 };
=20
@@ -560,6 +561,13 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
 		free(seen);
 	}
=20
+	if (bulk_index)
+		/*
+		 * Pretend all blobs are "large" files, forcing them
+		 * all into a pack
+		 */
+		big_file_threshold =3D 0;
+
 	plug_bulk_checkin();
=20
 	if ((flags & ADD_CACHE_IMPLICIT_DOT) && prefix) {
--=20
1.8.2.82.gc24b958
