From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] introduce pack metadata cache files
Date: Tue, 29 Jan 2013 04:15:55 -0500
Message-ID: <20130129091555.GC9999@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 10:16:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U07Il-0007s4-5e
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 10:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab3A2JQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 04:16:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53247 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab3A2JP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 04:15:58 -0500
Received: (qmail 20007 invoked by uid 107); 29 Jan 2013 09:17:21 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 04:17:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 04:15:55 -0500
Content-Disposition: inline
In-Reply-To: <20130129091434.GA6975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214919>

The on-disk packfile format is nicely compact, but it does
not always provide the fastest format for looking up
information. This patch introduces the concept of
"metapacks", optional metadata files which can live
alongside packs and represent their data in different ways.
This can allow space-time tradeoffs in accessing certain
object data.

Such space-time tradeoffs have traditionally gone into the
.idx file (e.g., the fact that we can quickly find an
object's offset in the packfile is due to the index). In
theory, cached data could also go into the .idx file.
However, keeping it in a separate file makes backwards
compatibility much simpler. Older versions of git can simply
ignore the extra files and use the existing methods for
accessing object data. This also makes metapacks optional,
so you can easily tune the space-time tradeoff on a per-repo
basis.

TODO: document on-disk format in Documentation/technical
TODO: document api

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile   |   2 +
 metapack.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 metapack.h |  42 ++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 metapack.c
 create mode 100644 metapack.h

diff --git a/Makefile b/Makefile
index 731b6a8..3e4ae1b 100644
--- a/Makefile
+++ b/Makefile
@@ -660,6 +660,7 @@ LIB_H += mergesort.h
 LIB_H += merge-blobs.h
 LIB_H += merge-recursive.h
 LIB_H += mergesort.h
+LIB_H += metapack.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
 LIB_H += notes.h
@@ -778,6 +779,7 @@ LIB_OBJS += mergesort.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += metapack.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/metapack.c b/metapack.c
new file mode 100644
index 0000000..c859c95
--- /dev/null
+++ b/metapack.c
@@ -0,0 +1,158 @@
+#include "cache.h"
+#include "metapack.h"
+#include "csum-file.h"
+
+static struct sha1file *create_meta_tmp(void)
+{
+	char tmp[PATH_MAX];
+	int fd;
+
+	fd = odb_mkstemp(tmp, sizeof(tmp), "pack/tmp_meta_XXXXXX");
+	return sha1fd(fd, xstrdup(tmp));
+}
+
+static void write_meta_header(struct metapack_writer *mw, const char *id,
+			      uint32_t version)
+{
+	version = htonl(version);
+
+	sha1write(mw->out, "META", 4);
+	sha1write(mw->out, "\0\0\0\1", 4);
+	sha1write(mw->out, mw->pack->sha1, 20);
+	sha1write(mw->out, id, 4);
+	sha1write(mw->out, &version, 4);
+}
+
+void metapack_writer_init(struct metapack_writer *mw,
+			  const char *pack_idx,
+			  const char *name,
+			  int version)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	memset(mw, 0, sizeof(*mw));
+
+	mw->pack = add_packed_git(pack_idx, strlen(pack_idx), 1);
+	if (!mw->pack || open_pack_index(mw->pack))
+		die("unable to open packfile '%s'", pack_idx);
+
+	strbuf_addstr(&path, pack_idx);
+	strbuf_chompstr(&path, ".idx");
+	strbuf_addch(&path, '.');
+	strbuf_addstr(&path, name);
+	mw->path = strbuf_detach(&path, NULL);
+
+	mw->out = create_meta_tmp();
+	write_meta_header(mw, name, version);
+}
+
+void metapack_writer_finish(struct metapack_writer *mw)
+{
+	const char *tmp = mw->out->name;
+
+	sha1close(mw->out, NULL, CSUM_FSYNC);
+	if (rename(tmp, mw->path))
+		die_errno("unable to rename temporary metapack file");
+
+	close_pack_index(mw->pack);
+	free(mw->pack);
+	free(mw->path);
+	free((char *)tmp);
+}
+
+void metapack_writer_add(struct metapack_writer *mw, const void *data, int len)
+{
+	sha1write(mw->out, data, len);
+}
+
+void metapack_writer_add_uint32(struct metapack_writer *mw, uint32_t v)
+{
+	v = htonl(v);
+	metapack_writer_add(mw, &v, 4);
+}
+
+void metapack_writer_foreach(struct metapack_writer *mw,
+			     metapack_writer_each_fn cb,
+			     void *data)
+{
+	const unsigned char *sha1;
+	uint32_t i = 0;
+
+	/*
+	 * We'll feed these to the callback in sorted order, since that is the
+	 * order that they are stored in the .idx file.
+	 */
+	while ((sha1 = nth_packed_object_sha1(mw->pack, i++)))
+		cb(mw, sha1, data);
+}
+
+int metapack_init(struct metapack *m,
+		  struct packed_git *pack,
+		  const char *name,
+		  uint32_t *version)
+{
+	struct strbuf path = STRBUF_INIT;
+	int fd;
+	struct stat st;
+
+	memset(m, 0, sizeof(*m));
+
+	strbuf_addstr(&path, pack->pack_name);
+	strbuf_chompstr(&path, ".pack");
+	strbuf_addch(&path, '.');
+	strbuf_addstr(&path, name);
+
+	fd = open(path.buf, O_RDONLY);
+	strbuf_release(&path);
+	if (fd < 0)
+		return -1;
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	m->mapped_len = xsize_t(st.st_size);
+	m->mapped_buf = xmmap(NULL, m->mapped_len, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	m->data = m->mapped_buf;
+	m->len = m->mapped_len;
+
+	if (m->len < 8 ||
+	    memcmp(m->mapped_buf, "META", 4) ||
+	    memcmp(m->mapped_buf + 4, "\0\0\0\1", 4)) {
+		warning("metapack '%s' for '%s' does not have a valid header",
+			name, pack->pack_name);
+		metapack_close(m);
+		return -1;
+	}
+	m->data += 8;
+	m->len -= 8;
+
+	if (m->len < 20 || hashcmp(m->data, pack->sha1)) {
+		warning("metapack '%s' for '%s' does not match pack sha1",
+			name, pack->pack_name);
+		metapack_close(m);
+		return -1;
+	}
+	m->data += 20;
+	m->len -= 20;
+
+	if (m->len < 8 || memcmp(m->data, name, 4)) {
+		warning("metapack '%s' for '%s' does not have expected header id",
+			name, pack->pack_name);
+		metapack_close(m);
+		return -1;
+	}
+	memcpy(version, m->data + 4, 4);
+	*version = ntohl(*version);
+	m->data += 8;
+	m->len -= 8;
+
+	return 0;
+}
+
+void metapack_close(struct metapack *m)
+{
+	munmap(m->mapped_buf, m->mapped_len);
+}
diff --git a/metapack.h b/metapack.h
new file mode 100644
index 0000000..6af17fe
--- /dev/null
+++ b/metapack.h
@@ -0,0 +1,42 @@
+#ifndef METAPACK_H
+#define METAPACK_H
+
+struct packed_git;
+struct sha1file;
+
+struct metapack_writer {
+	char *path;
+	struct packed_git *pack;
+	struct sha1file *out;
+};
+
+void metapack_writer_init(struct metapack_writer *mw,
+			  const char *pack_idx,
+			  const char *name,
+			  int version);
+void metapack_writer_add(struct metapack_writer *mw, const void *data, int len);
+void metapack_writer_add_uint32(struct metapack_writer *mw, uint32_t v);
+void metapack_writer_finish(struct metapack_writer *mw);
+
+typedef void (*metapack_writer_each_fn)(struct metapack_writer *,
+					const unsigned char *sha1,
+					void *data);
+void metapack_writer_foreach(struct metapack_writer *mw,
+			     metapack_writer_each_fn cb,
+			     void *data);
+
+struct metapack {
+	void *mapped_buf;
+	size_t mapped_len;
+
+	void *data;
+	size_t len;
+};
+
+int metapack_init(struct metapack *m,
+		  struct packed_git *pack,
+		  const char *name,
+		  uint32_t *version);
+void metapack_close(struct metapack *m);
+
+#endif
-- 
1.8.0.2.16.g72e2fc9
