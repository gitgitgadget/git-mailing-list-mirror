From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/32] pack-objects: support --narrow-tree
Date: Wed, 25 Aug 2010 08:20:02 +1000
Message-ID: <1282688422-7738-13-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1sz-0001Xh-J2
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268Ab0HXWWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:22:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43052 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab0HXWWP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:22:15 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so50255pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xNY6tuqW10+5ean3VnV4M4KgLkE9UQ5M7KL8u+zJLqc=;
        b=CICJwQAcs8XG18p+Dg5shGyy6JGuKp9U2oQNO1FJqFLCqKIfAibdp264Z2F7kMiVVJ
         phTJdFe8WTBSKkLukq3qn1ADvLV2r5RT4QyUxG+AqvMAbtDxLi29SXvt36OW3L3VXK0C
         WO6GIgeUrOVAvVMM0on6CRi+wrENX4GeQaye8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wPdffVV2tNLpV4OMaRTY6MU/rfvcOc6AuC1OPmQz4ZrLUDtnX8/mut6gosLGnoIkx9
         a/pTUhVOajr5CZ97B1aPe69/KATCEaSeXnI05s5wFqfkpGoxpAVRMK/RS77tM+VtJuM1
         cvnilXaG4lc2ov6V9Ah3OyyXttkXWi3Ovw6hY=
Received: by 10.114.74.7 with SMTP id w7mr8416729waa.85.1282688535752;
        Tue, 24 Aug 2010 15:22:15 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id x9sm952820waj.3.2010.08.24.15.22.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:14 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:10 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154355>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c     |    9 +++++++++
 t/t6061-rev-list-narrow.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a664223..36ab350 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -106,6 +106,7 @@ static int object_ix_hashsz;
 static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
=20
+const char *narrow_prefix;
=20
 static void *get_delta(struct object_entry *entry)
 {
@@ -2055,6 +2056,10 @@ static void get_object_list(int ac, const char *=
*av)
 	init_revisions(&revs, NULL);
 	save_commit_buffer =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
+	if (narrow_prefix) {
+		revs.narrow_tree =3D 1;
+		revs.narrow_prefix =3D narrow_prefix;
+	}
=20
 	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
 		int len =3D strlen(line);
@@ -2259,6 +2264,10 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			grafts_replace_parents =3D 0;
 			continue;
 		}
+		if (!prefixcmp(arg, "--narrow-tree=3D")) {
+			narrow_prefix =3D arg + 14;
+			continue;
+		}
 		usage(pack_usage);
 	}
=20
diff --git a/t/t6061-rev-list-narrow.sh b/t/t6061-rev-list-narrow.sh
index e489347..30ef46f 100755
--- a/t/t6061-rev-list-narrow.sh
+++ b/t/t6061-rev-list-narrow.sh
@@ -155,4 +155,31 @@ test_expect_success 'rev-list --narrow-tree=3Dt1/t=
12 with merges' '
 	test_cmp merge.expected result
 '
=20
+cat <<EOF >pack.expected
+04156ae83e615fa5b6019170928bc131539f9996
+0da28f8308e336bd4b2c26b61c7fc44e41a30e49
+3b52e9990a52d9ea46b25199b5810566324759f4
+4fc1656b01ce8b21987c55a2870b8c9a431ec772
+52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4
+72e05e456b9ff4c01ccf6178ce60d9b52b41aae4
+7475cb8a389b36ce238b9ee6cbfdfa26a1b67e35
+74a398027f0b59183db54ca8c67dc30b5aeed0ff
+aa0602ee56ea4cb5e5bfff8713bb8a9a6ab4303e
+ab246f7eb05e94f695d2a0e30093d94fde7b837e
+af9c31c0e217154296d93d66b9a5a41892c7b321
+ba7a30916c792624a8372cb26da50f5594098222
+d77d258d806b2aa7cdb5a301e6a54f023d9bdcfe
+d81015b2a1c40fc6cbc5bf5a8b16949018c3aede
+fa0bba1767985729582729a12a5459cd041d6cf6
+EOF
+
+test_expect_success 'pack-object --narrow-tree=3Dt1/t12' '
+	echo $MERGE|git pack-objects --revs --narrow-tree=3Dt1/t12 --stdout >=
p.pack &&
+	git index-pack -o p.idx p.pack &&
+	git verify-pack -v p.pack |
+		grep "^[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" |
+		cut -d " " -f 1 >result &&
+	test_cmp pack.expected result
+'
+
 test_done
--=20
1.7.1.rc1.69.g24c2f7
