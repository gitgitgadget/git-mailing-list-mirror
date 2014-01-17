From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 02/14] read-cache: new extension to mark what file is watched
Date: Fri, 17 Jan 2014 16:47:28 +0700
Message-ID: <1389952060-12297-3-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:48:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W462L-000281-IZ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbaAQJsW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:22 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:53764 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaAQJsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:16 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so3903833pad.13
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=x9Uptx3DtdcHAbl4DuhBACZvbbdSMaNIwfcPrdnqEMQ=;
        b=III9qJVITezb1LSMGhf5c3aF/ffYmHVhZ+eKPwyzpxhF8fGJ7G5tzLmq5uMFOWf745
         FCMpL9Y6hxi9xhoBoo3vsYKG28LHvnOLgkAqJnSTDdkrZVq+4rrDQ/OC/WcZ8SbOyPId
         YpeDcLAoqqs2BRdLxbevhfmmlkd6C33PdF0V5fv2IbNbeitXzi/+5w7WHIX28dfBIOPX
         PsmRleh7XGJGx/u37RIbz+Q5TNaA3162NYP52/xCALkrFEqEB9oMYUoAjeS7ITvHHys5
         kJHcCTgj3Qmh3lu9G/OPPgbqvct9R2CtXT3NlMVQSU6y+YV9ATzvizFTbJyA5pDxrZV9
         P0zQ==
X-Received: by 10.66.145.166 with SMTP id sv6mr1034781pab.31.1389952096007;
        Fri, 17 Jan 2014 01:48:16 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id x5sm21329470pbw.26.2014.01.17.01.48.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:10 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240583>

If an entry is "watched", git lets an external program decide if the
entry is modified or not. It's more like --assume-unchanged, but
designed to be controlled by machine.

We are running out of on-disk ce_flags, so instead of extending
on-disk entry format again, "watched" flags are in-core only and
stored as extension instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  2 ++
 read-cache.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index a09d622..069dce7 100644
--- a/cache.h
+++ b/cache.h
@@ -168,6 +168,8 @@ struct cache_entry {
 /* used to temporarily mark paths matched by pathspecs */
 #define CE_MATCHED           (1 << 26)
=20
+#define CE_WATCHED           (1 << 27)
+
 /*
  * Extended on-disk flags
  */
diff --git a/read-cache.c b/read-cache.c
index fe1d153..6f21e3f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -33,6 +33,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_WATCH 0x57415443	  /* "WATC" */
=20
 struct index_state the_index;
=20
@@ -1293,6 +1294,19 @@ static int verify_hdr(struct cache_header *hdr,
 	return 0;
 }
=20
+static void read_watch_extension(struct index_state *istate, uint8_t *=
data,
+				 unsigned long sz)
+{
+	int i;
+	if ((istate->cache_nr + 7) / 8 !=3D sz) {
+		error("invalid 'WATC' extension");
+		return;
+	}
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (data[i / 8] & (1 << (i % 8)))
+			istate->cache[i]->ce_flags |=3D CE_WATCHED;
+}
+
 static int read_index_extension(struct index_state *istate,
 				const char *ext, void *data, unsigned long sz)
 {
@@ -1303,6 +1317,9 @@ static int read_index_extension(struct index_stat=
e *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_WATCH:
+		read_watch_extension(istate, data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1781,7 +1798,7 @@ int write_index(struct index_state *istate, int n=
ewfd)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended, hdr_version;
+	int i, err, removed, extended, hdr_version, has_watches =3D 0;
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
 	struct stat st;
@@ -1790,6 +1807,8 @@ int write_index(struct index_state *istate, int n=
ewfd)
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
+		else if (cache[i]->ce_flags & CE_WATCHED)
+			has_watches++;
=20
 		/* reduce extended entries if possible */
 		cache[i]->ce_flags &=3D ~CE_EXTENDED;
@@ -1861,6 +1880,26 @@ int write_index(struct index_state *istate, int =
newfd)
 		if (err)
 			return -1;
 	}
+	if (has_watches) {
+		int id, sz =3D (entries - removed + 7) / 8;
+		uint8_t *data =3D xmalloc(sz);
+		memset(data, 0, sz);
+		for (i =3D 0, id =3D 0; i < entries && has_watches; i++) {
+			struct cache_entry *ce =3D cache[i];
+			if (ce->ce_flags & CE_REMOVE)
+				continue;
+			if (ce->ce_flags & CE_WATCHED) {
+				data[id / 8] |=3D 1 << (id % 8);
+				has_watches--;
+			}
+			id++;
+		}
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_WATCH, sz) < 0
+			|| ce_write(&c, newfd, data, sz) < 0;
+		free(data);
+		if (err)
+			return -1;
+	}
=20
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
--=20
1.8.5.1.208.g05b12ea
