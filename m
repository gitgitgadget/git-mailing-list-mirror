From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] Automatically switch to crc32 checksum for index when it's too large
Date: Mon,  6 Feb 2012 12:48:39 +0700
Message-ID: <1328507319-24687-6-git-send-email-pclouds@gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 06:44:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHNa-0002zb-3e
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab2BFFoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 00:44:37 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61644 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2BFFog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:44:36 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so164111dae.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 21:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fMf65eDpoCFpqw/eGnKXCSgfduNrMuSplnahiLxP2uo=;
        b=nK3ylbtHMr+2zp6NnbhcDX2cbsIufdO6S6jMiJQB7A5CrIZ2ZaQdi4wVJPoiPa+9+c
         XVHLIJW8WfsgB3072e8Rf3FnKJePYBpG3tb/YiOrsLp1XmNDLWagsg/uC30l+2wrGCaH
         REpCbQMtCJHyRE/1V403xwvqL0fL+FsfcNaoY=
Received: by 10.68.204.7 with SMTP id ku7mr32346708pbc.45.1328507076663;
        Sun, 05 Feb 2012 21:44:36 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id y9sm369010pbi.3.2012.02.05.21.44.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 21:44:35 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 12:49:27 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190021>

An experiment with -O3 is done on Intel D510@1.66GHz. At around 250k
entries, index reading time exceeds 0.5s. Switching to crc32 brings it
back lower than 0.2s.

On 4M files index, reading time with SHA-1 takes ~8.4, crc32 2.8s.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I know no real repositories this size though. gentoo-x86 is "only"
 120k. Haven't checked libreoffice repo yet.

 On 2M files index, allocating one big block (i.e. reverting debed2a
 (read-cache.c: allocate index entries individually - 2011-10-24)
 saves about 0.3s. Maybe we can allocate one big block, then malloc
 separately when the block is fully used.

 Writing time is still high. "git update-index --crc32" on crc32 250k i=
ndex
 takes 0.9s (so writing time is about 0.5s)

 A better solution may be narrow clone (or just the narrow checkout
 part), where index only contains entries from checked out
 subdirectories.

 Documentation/config.txt |    7 +++++++
 builtin/update-index.c   |    1 +
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 read-cache.c             |    8 ++++++++
 6 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..55b7596 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -540,6 +540,13 @@ relatively high IO latencies.  With this set to 't=
rue', git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
=20
+core.crc32IndexThreshold::
+	Usually SHA-1 is used to check for index integerity. When the
+	number of entries in index exceeds this threshold, crc32 will
+	be used instead. Zero means SHA-1 always be used. Negative
+	value disables this threshold (i.e. crc32 or SHA-1 is decided
+	by other means).
+
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
 	a delete of the source are used to make sure that object creation
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6913226..5cb51c7 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -856,6 +856,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	argc =3D parse_options_end(&ctx);
=20
 	if (do_crc !=3D -1) {
+		core_crc32_index_threshold =3D -1;
 		if (do_crc)
 			the_index.hdr_flags |=3D CACHE_F_CRC;
 		else
diff --git a/cache.h b/cache.h
index 7352402..d05856b 100644
--- a/cache.h
+++ b/cache.h
@@ -610,6 +610,7 @@ extern unsigned long pack_size_limit_cfg;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_crc32_index_threshold;
 extern int core_apply_sparse_checkout;
=20
 enum branch_track {
diff --git a/config.c b/config.c
index 40f9c6d..905e071 100644
--- a/config.c
+++ b/config.c
@@ -671,6 +671,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.crc32indexthreshold")) {
+		core_crc32_index_threshold =3D git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode =3D OBJECT_CREATION_USES_RENAMES;
diff --git a/environment.c b/environment.c
index c93b8f4..9d9dfc2 100644
--- a/environment.c
+++ b/environment.c
@@ -66,6 +66,7 @@ unsigned long pack_size_limit_cfg;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
+int core_crc32_index_threshold =3D 250000;
=20
 /* This is set by setup_git_dir_gently() and/or git_default_config() *=
/
 char *git_work_tree_cfg;
diff --git a/read-cache.c b/read-cache.c
index a34878e..fd032d8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1582,6 +1582,14 @@ int write_index(struct index_state *istate, int =
newfd)
 		}
 	}
=20
+	if (core_crc32_index_threshold >=3D 0) {
+		if (core_crc32_index_threshold > 0 &&
+		    istate->cache_nr >=3D core_crc32_index_threshold)
+			istate->hdr_flags |=3D CACHE_F_CRC;
+		else
+			istate->hdr_flags &=3D ~CACHE_F_CRC;
+	}
+
 	hdr.h.hdr_signature =3D htonl(CACHE_SIGNATURE);
 	if (istate->hdr_flags) {
 		hdr.h.hdr_version =3D htonl(4);
--=20
1.7.8.36.g69ee2
