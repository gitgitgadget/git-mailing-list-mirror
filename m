From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] Allow to use crc32 as a lighter checksum on index
Date: Mon,  6 Feb 2012 12:48:38 +0700
Message-ID: <1328507319-24687-5-git-send-email-pclouds@gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 06:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHNS-0002wA-2V
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab2BFFoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 00:44:30 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61644 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab2BFFo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:44:29 -0500
Received: by daed14 with SMTP id d14so164111dae.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 21:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qBY+wLwSVSGM7GqRcKB8AgIXU6nKcpJy7ySeN7QwsLk=;
        b=M8wDI/lzYa91JhhtwY481F+bGvQlh+w4LjfiZ5UQWoplQswJbmXioY1IdLB3eIxT00
         HsZyPeiQxw6/dwN4lnzRVIwiDavJwfTxXMdcO5l/rV7TmTqaxl/1P/RI5lgsFBQanj9B
         zYs8KZbEOxxx3Q5MeQCE6m8F1UmdWfyziLvk4=
Received: by 10.68.233.135 with SMTP id tw7mr34701414pbc.67.1328507068613;
        Sun, 05 Feb 2012 21:44:28 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id d1sm19772343pbg.13.2012.02.05.21.44.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 21:44:27 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 12:49:18 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190020>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-update-index.txt |   12 +++++++-
 builtin/update-index.c             |   11 +++++++
 cache.h                            |    2 +
 read-cache.c                       |   54 ++++++++++++++++++++++++++++=
--------
 4 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index a3081f4..2574a4e 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
 	     [(--cacheinfo <mode> <object> <file>)...]
-	     [--chmod=3D(+|-)x]
+	     [--chmod=3D(+|-)x] [--[no-]crc32]
 	     [--assume-unchanged | --no-assume-unchanged]
 	     [--skip-worktree | --no-skip-worktree]
 	     [--ignore-submodules]
@@ -109,6 +109,16 @@ you will need to handle the situation manually.
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
=20
+--crc32::
+--no-crc32::
+	Normally SHA-1 is used to check for index integrity. When the
+	index is large, SHA-1 computation cost can be significant.
+	--crc32 will convert current index to use (cheaper) crc32
+	instead. Note that later writes to index by other commands can
+	convert the index back to SHA-1. Older git versions may not
+	understand crc32 index, --no-crc32 can be used to convert it
+	back to SHA-1.
+
 -g::
 --again::
 	Runs 'git update-index' itself on the paths whose index
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6a23fa..6913226 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -707,6 +707,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 {
 	int newfd, entries, has_errors =3D 0, line_termination =3D '\n';
 	int read_from_stdin =3D 0;
+	int do_crc =3D -1;
 	int prefix_length =3D prefix ? strlen(prefix) : 0;
 	char set_executable_bit =3D 0;
 	struct refresh_params refresh_args =3D {0, &has_errors};
@@ -791,6 +792,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			"(for porcelains) forget saved unresolved conflicts",
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			resolve_undo_clear_callback},
+		OPT_BOOL(0, "crc32", &do_crc,
+			 "use crc32 as checksum instead of sha1"),
 		OPT_END()
 	};
=20
@@ -852,6 +855,14 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 	}
 	argc =3D parse_options_end(&ctx);
=20
+	if (do_crc !=3D -1) {
+		if (do_crc)
+			the_index.hdr_flags |=3D CACHE_F_CRC;
+		else
+			the_index.hdr_flags &=3D ~CACHE_F_CRC;
+		active_cache_changed =3D 1;
+	}
+
 	if (read_from_stdin) {
 		struct strbuf buf =3D STRBUF_INIT, nbuf =3D STRBUF_INIT;
=20
diff --git a/cache.h b/cache.h
index c2e884a..7352402 100644
--- a/cache.h
+++ b/cache.h
@@ -105,6 +105,8 @@ struct cache_header {
 	unsigned int hdr_entries;
 };
=20
+#define CACHE_F_CRC	1	/* use crc32 instead of sha1 for index checksum =
*/
+
 struct ext_cache_header {
 	struct cache_header h;
 	unsigned int hdr_flags;
diff --git a/read-cache.c b/read-cache.c
index fd21af6..a34878e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1185,20 +1185,33 @@ static struct cache_entry *refresh_cache_entry(=
struct cache_entry *ce, int reall
=20
 static int verify_hdr(struct cache_header *hdr, unsigned long size)
 {
+	int do_crc;
 	git_SHA_CTX c;
 	unsigned char sha1[20];
=20
 	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
 		return error("bad signature");
-	if (hdr->hdr_version !=3D htonl(2) &&
-	    hdr->hdr_version !=3D htonl(3) &&
-	    hdr->hdr_version !=3D htonl(4))
+	if (hdr->hdr_version =3D=3D htonl(2) ||
+	    hdr->hdr_version =3D=3D htonl(3))
+		do_crc =3D 0;
+	else if (hdr->hdr_version =3D=3D htonl(4)) {
+		struct ext_cache_header *ehdr =3D (struct ext_cache_header *)hdr;
+		do_crc =3D ntohl(ehdr->hdr_flags) & CACHE_F_CRC;
+	}
+	else
 		return error("bad index version");
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, size - 20);
-	git_SHA1_Final(sha1, &c);
-	if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
-		return error("bad index file sha1 signature");
+	if (do_crc) {
+		uint32_t crc =3D crc32(0, NULL, 0);
+		crc =3D crc32(crc,(void *) hdr, size - sizeof(uint32_t));
+		if (crc !=3D *(uint32_t*)((unsigned char *)hdr + size - sizeof(uint3=
2_t)))
+			return error("bad index file crc32 signature");
+	} else {
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, hdr, size - 20);
+		git_SHA1_Final(sha1, &c);
+		if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
+			return error("bad index file sha1 signature");
+	}
 	return 0;
 }
=20
@@ -1421,11 +1434,24 @@ static int write_index_ext_header(struct sha1fi=
le *f,
 static int ce_flush(struct sha1file *f)
 {
 	unsigned char sha1[20];
-	int fd =3D sha1close(f, sha1, 0);
+	int fd;
=20
-	if (fd < 0)
-		return -1;
-	return (write_in_full(fd, sha1, 20) !=3D 20) ? -1 : 0;
+	if (f->do_crc) {
+		uint32_t crc;
+
+		assert(f->do_sha1 =3D=3D 0);
+		sha1flush(f);
+		crc =3D crc32_end(f);
+		fd =3D sha1close(f, sha1, 0);
+		if (fd < 0)
+			return -1;
+		return (write_in_full(fd, &crc, sizeof(crc)) !=3D sizeof(crc)) ? -1 =
: 0;
+	} else {
+		fd =3D sha1close(f, sha1, 0);
+		if (fd < 0)
+			return -1;
+		return (write_in_full(fd, sha1, 20) !=3D 20) ? -1 : 0;
+	}
 }
=20
 static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
@@ -1568,6 +1594,10 @@ int write_index(struct index_state *istate, int =
newfd)
 	hdr.h.hdr_entries =3D htonl(entries - removed);
=20
 	f =3D sha1fd(newfd, NULL);
+	if (istate->hdr_flags & CACHE_F_CRC) {
+		crc32_begin(f);
+		f->do_sha1 =3D 0;
+	}
 	if (ce_write(f, &hdr, hdr_size) < 0)
 		return -1;
=20
--=20
1.7.8.36.g69ee2
