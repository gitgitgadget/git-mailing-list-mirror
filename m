From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC v2] read-cache: save index entry updates in ILOG index extension
Date: Thu,  8 Aug 2013 19:51:10 +0700
Message-ID: <1375966270-10968-1-git-send-email-pclouds@gmail.com>
References: <1375597720-13236-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 14:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Pfw-00018T-5m
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 14:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808Ab3HHMuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Aug 2013 08:50:39 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55509 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757818Ab3HHMuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 08:50:37 -0400
Received: by mail-ie0-f179.google.com with SMTP id c11so1709420ieb.38
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L9oo22kElZhlHENy4GYfGIsa1BptOn3ja5dC+Vl6sk8=;
        b=AzWgzyUmMmS4nYWudilDIWy6UMdYIu2vBDbmHwI9UnrnI3C8DFtevvX0MHMnPckAgW
         LOr4JS88EYgVK7d6BFde2ugxJloRK1q7OnMhezvaBYDcaUvnq5tOIh6RNKoe+EEmSr6s
         0ZUPfvdIpbLylLiuuh8qUe0O1vGT0IeYopLiPl5hSPfysML6wxdU0C9OB4/Dh1R/v8mQ
         wn6RHa8XtRRuwsRMB6vffeAhTbcBsQZ+HdwDH8LNx2n8hSrgvr6IhA/Hj0k0CTw0DIKm
         xQ7x/H5cCg3YhAaWe2uZJ7L3gTUdjZNl7vXH0RqVaIUyUZqfcV889n7uCAE0nzxNUQio
         bKlA==
X-Received: by 10.50.124.10 with SMTP id me10mr2131436igb.40.1375966237174;
        Thu, 08 Aug 2013 05:50:37 -0700 (PDT)
Received: from lanh ([115.73.221.215])
        by mx.google.com with ESMTPSA id c8sm5881678igl.4.2013.08.08.05.50.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 05:50:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 08 Aug 2013 19:51:12 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1375597720-13236-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231879>

If you have something different from both worktree and HEAD in index,
then accidentally do "git add foo", you may find it hard to recover
the previous version of foo in index. This is especially true when you
do "git add -p" with manual patch editing.

This patch makes sure that every operation that modifies the index
from worktree or stdin is recorded as list of (path, SHA-1) in index
with command+arguments of the operation.

When you make such a mistake, you can look at ILOG extension with
(unimplemented) "git ls-files --generation=3DX [ -- <paths>]" where X i=
s
from 1 (the most recent operation) to N (the least recent) . "X" could
even be "all" to list all generations.

SHA-1 syntax is also going to be extended to support :-N:path syntax
to get an entry from generation N, for convenience.

Old operation's updates are removed as new ones are added to keep the
size under 1 MB. ILOG keeps minimum 10 operations regardless of its
size. These contansts should be configurable later one. ILOG content
will be compressed later on so that it leaves minimum
footprint. Because it's only needed at index writing time, read-only
operations won't pay the cost for decompressing and compressing ILOG.

ILOG may also be used in a different way to implement "git add
--undo". Before updating entries, git-add could save _old_ entries to
ILOG (and mark to-be-added entries as "deleted/something" for
example). It then can use this information to revert the
operation. Similar candidates are "git commit -a" (destroying current
index) or "git merge" and of course "git mv" and "git rm"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c          |   1 +
 builtin/apply.c        |   1 +
 builtin/update-index.c |   1 +
 cache.h                |   3 ++
 read-cache.c           | 121 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 127 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 8266a9c..d000f8a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -456,6 +456,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	struct update_callback_data update_data;
=20
 	git_config(add_config, NULL);
+	log_index_changes(prefix, argv);
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
diff --git a/builtin/apply.c b/builtin/apply.c
index 50912c9..fc43ea8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4423,6 +4423,7 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix_)
 	prefix =3D prefix_;
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
+	log_index_changes(prefix, argv);
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index c317981..aa757cb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -799,6 +799,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 		usage_with_options(update_index_usage, options);
=20
 	git_config(git_default_config, NULL);
+	log_index_changes(prefix, argv);
=20
 	/* We can't free this memory, it becomes part of a linked list parsed=
 atexit() */
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
diff --git a/cache.h b/cache.h
index 85b544f..a2156bf 100644
--- a/cache.h
+++ b/cache.h
@@ -168,6 +168,7 @@ struct cache_entry {
=20
 /* used to temporarily mark paths matched by pathspecs */
 #define CE_MATCHED           (1 << 26)
+#define CE_BASE              (1 << 27)
=20
 /*
  * Extended on-disk flags
@@ -277,6 +278,7 @@ struct index_state {
 		 initialized : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
+	struct strbuf *index_log;
 };
=20
 extern struct index_state the_index;
@@ -481,6 +483,7 @@ extern struct cache_entry *make_cache_entry(unsigne=
d int mode, const unsigned ch
 extern int ce_same_name(const struct cache_entry *a, const struct cach=
e_entry *b);
 extern int index_name_is_other(const struct index_state *, const char =
*, int);
 extern void *read_blob_data_from_index(struct index_state *, const cha=
r *, unsigned long *);
+extern void log_index_changes(const char *prefix, const char **argv);
=20
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index c3d5e35..4021667 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
+#include "quote.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
@@ -33,8 +34,10 @@ static struct cache_entry *refresh_cache_entry(struc=
t cache_entry *ce, int reall
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
+#define CACHE_EXT_INDEX_LOG 0x494C4F47 /* "ILOG" */
=20
 struct index_state the_index;
+static struct strbuf log_message =3D STRBUF_INIT;
=20
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
@@ -1297,6 +1300,14 @@ static int read_index_extension(struct index_sta=
te *istate,
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo =3D resolve_undo_read(data, sz);
 		break;
+	case CACHE_EXT_INDEX_LOG:
+		if (!istate->index_log) {
+			istate->index_log =3D xmalloc(sizeof(*istate->index_log));
+			strbuf_init(istate->index_log, sz);
+		}
+		strbuf_reset(istate->index_log);
+		strbuf_add(istate->index_log, data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand=
",
@@ -1509,6 +1520,14 @@ int read_index_from(struct index_state *istate, =
const char *path)
 		src_offset +=3D extsize;
 	}
 	munmap(mmap, mmap_size);
+	if (istate =3D=3D &the_index) {
+		for (i =3D 0; i < istate->cache_nr; i++) {
+			struct cache_entry *ce =3D istate->cache[i];
+			if (ce_stage(ce))
+				continue;
+			ce->ce_flags |=3D CE_BASE;
+		}
+	}
 	return istate->cache_nr;
=20
 unmap:
@@ -1538,6 +1557,11 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	if (istate->index_log) {
+		strbuf_release(istate->index_log);
+		free(istate->index_log);
+		istate->index_log =3D NULL;
+	}
 	return 0;
 }
=20
@@ -1771,6 +1795,81 @@ void update_index_if_able(struct index_state *is=
tate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
=20
+void log_index_changes(const char *prefix, const char **argv)
+{
+	if (prefix || argv) {
+		if (prefix)
+			strbuf_addf(&log_message, "[%s]", prefix);
+		sq_quote_argv(&log_message, argv, 0);
+	} else
+		strbuf_setlen(&log_message, 0);
+}
+
+static void get_updated_entries(struct index_state *istate,
+				struct cache_entry ***cache_out,
+				unsigned int *cache_nr_out)
+{
+	struct cache_entry **cache;
+	unsigned int i, nr, cache_nr =3D 0;
+
+	*cache_nr_out =3D 0;
+	*cache_out =3D NULL;
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		if (istate->cache[i]->ce_flags & CE_BASE)
+			continue;
+		cache_nr++;
+	}
+	if (!cache_nr)
+		return;
+
+	cache =3D xmalloc(cache_nr * sizeof(*istate->cache));
+	for (i =3D nr =3D 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce =3D istate->cache[i];
+		if (ce->ce_flags & CE_BASE)
+			continue;
+		cache[nr++] =3D ce;
+	}
+	*cache_out =3D cache;
+	*cache_nr_out =3D cache_nr;
+}
+
+static void write_index_log(struct strbuf *sb,
+			    const struct strbuf *old_log,
+			    const struct strbuf *msg,
+			    struct cache_entry **cache,
+			    unsigned int cache_nr)
+{
+	struct strbuf body =3D STRBUF_INIT;
+	unsigned int i, size, nr, body_len, hdr_len;
+	const char *end, *p;
+	strbuf_addf(&body, "%s%c", msg->buf, '\0');
+	for (i =3D 0; i < cache_nr; i++)
+		strbuf_addf(&body, "%s %s%c", sha1_to_hex(cache[i]->sha1),
+			    cache[i]->name, '\0');
+	strbuf_addf(sb, "%u %u%c", (unsigned int)cache_nr, (unsigned int)body=
=2Elen, '\0');
+	strbuf_addbuf(sb, &body);
+	strbuf_release(&body);
+
+	if (!old_log)
+		return;
+
+	size =3D sb->len;
+	nr =3D cache_nr;
+	end =3D old_log->buf + old_log->len;
+	p =3D old_log->buf;
+	while (p < end && (size < 1024 * 1024 || nr < 10)) {
+		if (sscanf(p, "%u %u", &cache_nr, &body_len) !=3D 2) {
+			error("fail to parse old index log at %u", (unsigned int)(p - old_l=
og->buf));
+			break;
+		}
+		hdr_len =3D strlen(p) + 1;
+		strbuf_add(sb, p, hdr_len + body_len);
+		size +=3D body_len;
+		nr +=3D cache_nr;
+		p +=3D hdr_len + body_len;
+	}
+}
+
 int write_index(struct index_state *istate, int newfd)
 {
 	git_SHA_CTX c;
@@ -1780,6 +1879,11 @@ int write_index(struct index_state *istate, int =
newfd)
 	int entries =3D istate->cache_nr;
 	struct stat st;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	unsigned int index_log_nr =3D 0;
+	struct cache_entry **index_log_entries =3D NULL;
+
+	if (istate =3D=3D &the_index && log_message.len)
+		get_updated_entries(istate, &index_log_entries, &index_log_nr);
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1846,6 +1950,23 @@ int write_index(struct index_state *istate, int =
newfd)
 		if (err)
 			return -1;
 	}
+	if (index_log_entries && log_message.len) {
+		struct strbuf sb =3D STRBUF_INIT;
+		write_index_log(&sb, istate->index_log, &log_message,
+				index_log_entries, index_log_nr);
+		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_INDEX_LOG,
+					     sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf,
+				    sb.len) < 0;
+		if (istate->index_log)
+			strbuf_release(istate->index_log);
+		else
+			istate->index_log =3D xmalloc(sizeof(*istate->index_log));
+		*istate->index_log =3D sb;
+		if (err)
+			return -1;
+	}
+	free(index_log_entries);
=20
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
--=20
1.8.2.83.gc99314b
