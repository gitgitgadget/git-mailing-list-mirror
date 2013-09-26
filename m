From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/10] repack: add --pack-version and fall back to core.preferredPackVersion
Date: Thu, 26 Sep 2013 09:26:48 +0700
Message-ID: <1380162409-18224-10-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1JH-0003EA-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3IZC1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:55 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61066 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IZC1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:54 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so472579pbc.21
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qeBnXS2+rzobmGRLRQAxCrUePKlwcdn/R9jZ3F4dsW8=;
        b=ubtE6XJdVvjjXhiFGXfFMlUmnLkFjchINIMVfiR1JIfV3e2w16BDjTON//t6OFadDL
         cjgfswqQ2IlMcvFMlf8wLMZEobP0fvTfqFUc71PCFdRGm7jbXDGR3B0FRWz4tJ0tBShs
         ijUH/lRTEav0jzdk5D4LHwsAiR83Z+pnkq/YUS8tqP4I+w0Nxxz5p3AaSN1xFnNKj3OK
         eyC5mc/QTdVom2fSr2bC5/3NB//b1b40vYPpLTQf+xvWSwgD/7SQJbWZVI2nbCA/xgYR
         xn/Mk0JEFi3EXSz8uT++t/1KmjZ/DvKuXtSDDEYcAm4zarIMLIjvkPqkuDoMKXzIJBE0
         qGFA==
X-Received: by 10.68.224.38 with SMTP id qz6mr14703657pbc.156.1380162473755;
        Wed, 25 Sep 2013 19:27:53 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id fi4sm44948752pbc.28.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:48 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235396>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-repack.txt |  6 +++++-
 git-repack.sh                |  8 +++++++-
 t/t7700-repack.sh            | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
index 4c1aff6..c43eb4a 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=3D<n>] =
[--depth=3D<n>]
+'git repack' [options]
=20
 DESCRIPTION
 -----------
@@ -110,6 +110,10 @@ other objects in that pack they already have local=
ly.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
=20
+--pack-version=3D<version>::
+	Force the version for the generated pack.
+	Valid values are 2 and 4. Default value is specified by
+	core.preferredPackVersion setting. See linkgit:git-config[1].
=20
 Configuration
 -------------
diff --git a/git-repack.sh b/git-repack.sh
index 7579331..0d898eb 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -21,12 +21,13 @@ window=3D         size of the window used for delta=
 compression
 window-memory=3D  same as the above, but limit memory size instead of =
entries count
 depth=3D          limits the maximum delta depth
 max-pack-size=3D  maximum size of each packfile
+pack-version=3D   format version of the output pack
 "
 SUBDIRECTORY_OK=3D'Yes'
 . git-sh-setup
=20
 no_update_info=3D all_into_one=3D remove_redundant=3D unpack_unreachab=
le=3D
-local=3D no_reuse=3D extra=3D
+local=3D no_reuse=3D extra=3D packver=3D
 while test $# !=3D 0
 do
 	case "$1" in
@@ -43,6 +44,8 @@ do
 	-l)	local=3D--local ;;
 	--max-pack-size|--window|--window-memory|--depth)
 		extra=3D"$extra $1=3D$2"; shift ;;
+	--pack-version)
+		packver=3D"$2"; shift ;;
 	--) shift; break;;
 	*)	usage ;;
 	esac
@@ -92,6 +95,9 @@ esac
=20
 mkdir -p "$PACKDIR" || exit
=20
+[ -n "$packver" ] || packver=3D"`git config --int core.preferredPackVe=
rsion`"
+[ -n "$packver" ] && args=3D"$args --version=3D$packver"
+
 args=3D"$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
 names=3D$(git pack-objects --keep-true-parents --honor-pack-keep --non=
-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d954b84..8383e1b 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -164,5 +164,40 @@ test_expect_success 'objects made unreachable by g=
rafts only are kept' '
 	git cat-file -t $H1
 	'
=20
+test_expect_success 'repack respects core.preferredPackVersion' '
+	git init pv4 &&
+	(
+		unset GIT_TEST_PACKV4 &&
+		cd pv4 &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git config core.preferredPackVersion 4 &&
+		git repack -ad &&
+		P=3D`ls .git/objects/pack/pack-*.pack` &&
+		# Offset 4 is pack version
+		test-dump ntohl "$P" 4 >ver.actual &&
+		echo 4 >ver.expected &&
+		test_cmp ver.expected ver.actual
+	)
+'
+
+test_expect_success 'repack --pack-version=3D4' '
+	git init pv4.2 &&
+	(
+		unset GIT_TEST_PACKV4 &&
+		cd pv4.2 &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git repack -ad --pack-version=3D4 &&
+		P=3D`ls .git/objects/pack/pack-*.pack` &&
+		# Offset 4 is pack version
+		test-dump ntohl "$P" 4 >ver.actual &&
+		echo 4 >ver.expected &&
+		test_cmp ver.expected ver.actual
+	)
+'
+
 test_done
=20
--=20
1.8.2.82.gc24b958
