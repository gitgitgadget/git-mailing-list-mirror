From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/17] pack-objects: support narrow packs with pathspecs
Date: Sun,  5 Sep 2010 16:47:32 +1000
Message-ID: <1283669264-15759-6-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:49:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os92H-0007yI-Bm
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab0IEGtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:49:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35545 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0IEGs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:48:59 -0400
Received: by pwi3 with SMTP id 3so717333pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wSoIz/p+K7/lWGUlappaPzJx3bxvRSSjwxIso960cQk=;
        b=a6HZoeepFNEOWwd0VUsmBd/Ae+Or0ogMwk7mmxL/MT2Db/mrr8q6bA+ojLft/9A6fT
         2+pBGbcxyiYffN02/JchASXD/WLDe5fbzb/p9LDScauC7N4JnRQSGGmS5pNmYLcoKnFf
         /B0dTXjRJ07ISoL+ntAC0GXdtFDipylMyrM/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XQgrK5OERC6aLoW6kmTY+dgE0KXG2H5b9JRX/qDZwpwpoIs/UUyMrwTlXxUx6gSkLs
         fXRIuugxJG2SSvgtoYEDsDCLQIK91QMj/LkA3jN8ybxGfRZJxUkVv4bKY5sCz75c41ZH
         Vx927KKFGg/ih5F/bUDiKIkpokfcTfVEFBaJo=
Received: by 10.115.14.6 with SMTP id r6mr1932155wai.8.1283669339188;
        Sat, 04 Sep 2010 23:48:59 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id d39sm8037680wam.4.2010.09.04.23.48.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:48:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:48:50 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155430>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-pack-objects.txt |    2 +-
 builtin/pack-objects.c             |   18 ++++++++++++++++--
 t/t6000-rev-list-misc.sh           |    9 +++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index 8ed09c0..cad8c06 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=3DN] [--depth=3DN]
 	[--revs [--unpacked | --all]*] [--stdout | base-name]
-	[--keep-true-parents] < object-list
+	[--keep-true-parents] [ -- path... ] < object-list
=20
=20
 DESCRIPTION
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 789f6bf..26044b8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -30,8 +30,8 @@ static const char pack_usage[] =3D
   "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset=
]\n"
   "        [--threads=3DN] [--non-empty] [--revs [--unpacked | --all]*=
]\n"
   "        [--reflog] [--stdout | base-name] [--include-tag]\n"
-  "        [--keep-unreachable | --unpack-unreachable \n"
-  "        [<ref-list | <object-list]";
+  "        [--keep-unreachable | --unpack-unreachable]\n"
+  "        [ -- path ... ] [<ref-list | <object-list]";
=20
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -2278,6 +2278,11 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			grafts_replace_parents =3D 0;
 			continue;
 		}
+		if (!strcmp(arg, "--")) {
+			if (!pack_to_stdout)
+				die("either --stdout of pack basename must be specified");
+			break;
+		}
 		usage(pack_usage);
 	}
=20
@@ -2300,6 +2305,15 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 	if (pack_to_stdout !=3D !base_name)
 		usage(pack_usage);
=20
+	if (!argv[i] || !strcmp(argv[i], "--")) {
+		if (rp_ac+(argc-i)+1 >=3D rp_ac_alloc) {
+			rp_ac_alloc =3D rp_ac + (argc-i) + 1;
+			rp_av =3D xrealloc(rp_av, rp_ac_alloc * sizeof(*rp_av));
+		}
+		memcpy(rp_av+rp_ac, argv+i, sizeof(*argv)*(argc-i));
+		rp_ac +=3D argc-i;
+	}
+
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit =3D pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index b6a7c9c..0386313 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -31,6 +31,15 @@ test_expect_success 'rev-list --objects with pathspe=
cs and deeper paths' '
 	! grep unwanted_file output
 '
=20
+test_expect_success 'pack-objects with pathspecs' '
+	echo HEAD|git pack-objects --revs --stdout -- foo > output.pack &&
+	git index-pack --stdin -o output.idx < output.pack &&
+	git verify-pack -v output.pack >output &&
+	grep "^e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 blob" output &&
+	test "$(grep blob output|wc -l)" =3D 1 &&
+	test "$(grep tree output|wc -l)" =3D 2
+'
+
 test_expect_success 'rev-list --objects with pathspecs and copied file=
s' '
 	git checkout --orphan junio-testcase &&
 	git rm -rf . &&
--=20
1.7.1.rc1.69.g24c2f7
