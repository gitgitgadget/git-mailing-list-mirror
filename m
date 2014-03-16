From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] pack-objects: support --keep
Date: Sun, 16 Mar 2014 20:35:02 +0700
Message-ID: <1394976904-15395-4-git-send-email-pclouds@gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 14:34:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBDD-0005zf-MT
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbaCPNen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 09:34:43 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:51399 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaCPNem (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:34:42 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so4603025pad.14
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7114gu/xRas2Fe1TNPNgAAS8UKjPe3xSPvzWoEpyYKI=;
        b=aiFl2e38ZvemsIRs2E1/thr58G064rvZwWCvhdVuP5L4W/YObY9+NJ5cOKL0QGx1VW
         dcTbkB115osJe/l+L+kbdoP22lKGvo/NqElykyCSHI+MpRdLtqgC22wA0/WjRTlHdfuv
         L2Rma4Cb0tMLU5inlOTL4/CyR+yniVPDsrlSLn0xRltPO8l4xqB6BeWi6aMstfb+uFJr
         nVsu1DBQdIoJT3CjzArrGM4ydeJ+ltLjHrh99IfkAzKLAIHdJUn4ypGCgSgv54YVC6ui
         11ghOqx9oGOKuz5dCbQmSypwHaH/gUNw7L0Inu8AjpfOdxD9RIX5kE1hsBTahIn9UTmz
         jTqA==
X-Received: by 10.68.89.162 with SMTP id bp2mr1485938pbb.151.1394976881471;
        Sun, 16 Mar 2014 06:34:41 -0700 (PDT)
Received: from lanh ([115.73.203.48])
        by mx.google.com with ESMTPSA id qq5sm34432047pbb.24.2014.03.16.06.34.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 06:34:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Mar 2014 20:35:23 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244197>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-pack-objects.txt |  4 ++++
 builtin/pack-objects.c             | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index cdab9ed..8aae3b5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -117,6 +117,10 @@ base-name::
 	has a .keep file to be ignored, even if it would have
 	otherwise been packed.
=20
+--keep::
+	Before moving the index into its final destination
+	create an empty .keep file for the associated pack file.
+
 --incremental::
 	This flag causes an object already in a pack to be ignored
 	even if it would have otherwise been packed.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1fb972f..46c7a57 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -57,6 +57,7 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int keep_pack;
=20
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
@@ -745,6 +746,23 @@ static off_t write_reused_pack(struct sha1file *f)
 	return reuse_packfile_offset - sizeof(struct pack_header);
 }
=20
+static void write_keep_file(const unsigned char *sha1)
+{
+	const char *msg =3D "pack-objects --keep\n";
+	char name[PATH_MAX];
+	int keep_fd =3D odb_pack_keep(name, sizeof(name), sha1);
+	if (keep_fd < 0) {
+		if (errno !=3D EEXIST)
+			die_errno(_("cannot write keep file '%s'"),
+				  name);
+		return;
+	}
+	write_or_die(keep_fd, msg, strlen(msg));
+	if (close(keep_fd) !=3D 0)
+		die_errno(_("cannot close written keep file '%s'"),
+			  name);
+}
+
 static void write_pack_file(void)
 {
 	uint32_t i =3D 0, j;
@@ -805,6 +823,9 @@ static void write_pack_file(void)
 			struct stat st;
 			char tmpname[PATH_MAX];
=20
+			if (keep_pack)
+				write_keep_file(sha1);
+
 			/*
 			 * Packs are runtime accessed in their mtime
 			 * order since newer packs are more likely to contain
@@ -2609,6 +2630,8 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 			 N_("use a bitmap index if available to speed up counting objects")=
),
 		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
 			 N_("write a bitmap index together with the pack index")),
+		OPT_BOOL(0, "keep", &keep_pack,
+			 N_("create .keep for the new pack")),
 		OPT_END(),
 	};
=20
@@ -2672,6 +2695,9 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	if (!pack_to_stdout && thin)
 		die("--thin cannot be used to build an indexable pack.");
=20
+	if (pack_to_stdout && keep_pack)
+		die("--keep cannot be used with --stdout");
+
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.")=
;
=20
--=20
1.9.0.40.gaa8c3ea
