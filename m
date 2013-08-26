From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fetch-pack: do not remove .git/shallow file when --depth is not specified
Date: Mon, 26 Aug 2013 09:17:26 +0700
Message-ID: <1377483446-24834-1-git-send-email-pclouds@gmail.com>
References: <20130826002202.GA26940@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kacper Kornet <kornet@camk.edu.pl>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 04:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDmNE-000090-I9
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 04:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab3HZCRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Aug 2013 22:17:38 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33505 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab3HZCRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 22:17:38 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so2848958pab.27
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0s58HtYNUJjzdASsjE958GsLCeJFu9wyvGWwxckFkm0=;
        b=sb/Fna0VokX5DCfRruAGS1YiyavKmj7D/P182NW1P60z+Yx1rhLugDc5b8t5EXgZvy
         6LtSQHpp74D9Z4bNeeR2c80L1pUpb8/A6Xk4cgmYPykEluTCk60WGq5NxxSrUaHaKv4F
         oDq9sG5jveWgMRn/VD1OwZHUYDrAForbodaDZVnASOv9xxUQWMVrGtaxyOYbHujxeuoY
         aVmnaIRCnBIwix12iAyZQkWvEuaE0wPbOfhiGPpW5FDiSvHnmztbAZw91BTQfroVwHZu
         pDxpTldFTCWIo0ooQOxgYZMI237ZILkriGaEFe56bsD7vdjGUMGbhGpTfehYKjaJTe4H
         WJAA==
X-Received: by 10.68.194.104 with SMTP id hv8mr255801pbc.168.1377483457641;
        Sun, 25 Aug 2013 19:17:37 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id qp10sm16610625pab.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 25 Aug 2013 19:17:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 26 Aug 2013 09:17:29 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <20130826002202.GA26940@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232971>

fetch_pack() can remove .git/shallow file when a shallow repository
becomes a full one again. This behavior is triggered incorrectly when
tags are also fetched because fetch_pack() will be called twice. At
the first fetch_pack() call:

 - shallow_lock is set up
 - alternate_shallow_file points to shallow_lock.filename, which is
   "shallow.lock"
 - commit_lock_file is called, which sets shallow_lock.filename to "".
   alternate_shallow_file also becomes "" because it points to the
   same memory.

At the second call, setup_alternate_shallow() is not called and
alternate_shallow_file remains "". It's mistaken as unshallow case and
=2Egit/shallow is removed. The end result is a broken repository.

=46ix this by always initializing alternate_shallow_file when
fetch_pack() is called. As an extra measure, check if args->depth > 0
before commit/rollback shallow file.

Reported-by: Kacper Kornet <kornet@camk.edu.pl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 > The two possible fixes which I see are:
 >
 > 1) Replace back if (alternate_shallow_file) condition in fetch pack =
with
 > =C2=A0 =C2=A0if (args->depth > 0)
 >
 > 2) alternate_shallow_file should be copy of shallow_lock.filename no=
t a
 > =C2=A0 =C2=A0reference to it

 3) Move alternate_shallow_file to struct fetch_pack_args, which will
    always be zero'd by memset

 I think #1 is better. It's the original condition before 6035d6a
 replaces it with "if (alternate_shallow_file)". Apparently I did not
 see that fetch_pack() could be called twice. #3 is also an option,
 but we still need static "shallow_lock" anyway, so I disregarded it.

 fetch-pack.c          |  4 +++-
 t/t5500-fetch-pack.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6b5467c..76190a8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -888,6 +888,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 		packet_flush(fd[1]);
 	if (args->depth > 0)
 		setup_alternate_shallow();
+	else
+		alternate_shallow_file =3D NULL;
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
@@ -978,7 +980,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args=
,
 	}
 	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lock=
file);
=20
-	if (alternate_shallow_file) {
+	if (args->depth > 0 && alternate_shallow_file) {
 		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
 			unlink_or_warn(git_path("shallow"));
 			rollback_lock_file(&shallow_lock);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index fd2598e..a80584e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -505,4 +505,20 @@ test_expect_success 'test --all, --depth, and expl=
icit tag' '
 	) >out-adt 2>error-adt
 '
=20
+test_expect_success 'shallow fetch with tags does not break the reposi=
tory' '
+	mkdir repo1 &&
+	(
+		cd repo1 &&
+		git init &&
+		test_commit 1 &&
+		test_commit 2 &&
+		test_commit 3 &&
+		mkdir repo2 &&
+		cd repo2 &&
+		git init &&
+		git fetch --depth=3D2 ../.git master:branch &&
+		git fsck
+	)
+'
+
 test_done
--=20
1.8.2.82.gc24b958
