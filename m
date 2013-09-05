From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 10/38] pack v4: commit object encoding
Date: Thu, 05 Sep 2013 02:19:33 -0400
Message-ID: <1378362001-1738-11-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvj-0007oz-57
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429Ab3IEGUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235Ab3IEGUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:17 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00ANT2XQCY00@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id D9FC32DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233896>

This goes as follows:

- Tree reference: either variable length encoding of the index
  into the SHA1 table or the literal SHA1 prefixed by 0 (see
  encode_sha1ref()).

- Parent count: variable length encoding of the number of parents.
  This is normally going to occupy a single byte but doesn't have to.

- List of parent references: a list of encode_sha1ref() encoded
  references, or nothing if the parent count was zero.

- Author reference: variable length encoding of an index into the author
  identifier dictionary table which also covers the time zone.  To make
  the overall encoding efficient, the author table is sorted by usage
  frequency so the most used names are first and require the shortest
  index encoding.

- Author time stamp: variable length encoded.  Year 2038 ready!

- Committer reference: same as author reference.

- Committer time stamp: same as author time stamp.

The remainder of the canonical commit object content is then zlib
compressed and appended to the above.

Rationale: The most important commit object data is densely encoded while
requiring no zlib inflate processing on access, and all SHA1 references
are most likely to be direct indices into the pack index file requiring
no SHA1 search into the pack index file.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index 12527c0..d4a79f4 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -14,6 +14,9 @@
 #include "pack.h"
 #include "varint.h"
 
+
+static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+
 struct data_entry {
 	unsigned offset;
 	unsigned size;
@@ -274,6 +277,122 @@ static int encode_sha1ref(const unsigned char *sha1, unsigned char *buf)
 	return 1 + 20;
 }
 
+/*
+ * This converts a canonical commit object buffer into its
+ * tightly packed representation using the already populated
+ * and sorted commit_name_table dictionary.  The parsing is
+ * strict so to ensure the canonical version may always be
+ * regenerated and produce the same hash.
+ */
+void *pv4_encode_commit(void *buffer, unsigned long *sizep)
+{
+	unsigned long size = *sizep;
+	char *in, *tail, *end;
+	unsigned char *out;
+	unsigned char sha1[20];
+	int nb_parents, index, tz_val;
+	unsigned long time;
+	z_stream stream;
+	int status;
+
+	/*
+	 * It is guaranteed that the output is always going to be smaller
+	 * than the input.  We could even do this conversion in place.
+	 */
+	in = buffer;
+	tail = in + size;
+	buffer = xmalloc(size);
+	out = buffer;
+
+	/* parse the "tree" line */
+	if (in + 46 >= tail || memcmp(in, "tree ", 5) || in[45] != '\n')
+		goto bad_data;
+	if (get_sha1_lowhex(in + 5, sha1) < 0)
+		goto bad_data;
+	in += 46;
+	out += encode_sha1ref(sha1, out);
+
+	/* count how many "parent" lines */
+	nb_parents = 0;
+	while (in + 48 < tail && !memcmp(in, "parent ", 7) && in[47] == '\n') {
+		nb_parents++;
+		in += 48;
+	}
+	out += encode_varint(nb_parents, out);
+
+	/* rewind and parse the "parent" lines */
+	in -= 48 * nb_parents;
+	while (nb_parents--) {
+		if (get_sha1_lowhex(in + 7, sha1))
+			goto bad_data;
+		out += encode_sha1ref(sha1, out);
+		in += 48;
+	}
+
+	/* parse the "author" line */
+	/* it must be at least "author x <x> 0 +0000\n" i.e. 21 chars */
+	if (in + 21 >= tail || memcmp(in, "author ", 7))
+		goto bad_data;
+	in += 7;
+	end = get_nameend_and_tz(in, &tz_val);
+	if (!end)
+		goto bad_data;
+	index = dict_add_entry(commit_name_table, tz_val, in, end - in);
+	if (index < 0)
+		goto bad_dict;
+	out += encode_varint(index, out);
+	time = strtoul(end, &end, 10);
+	if (!end || end[0] != ' ' || end[6] != '\n')
+		goto bad_data;
+	out += encode_varint(time, out);
+	in = end + 7;
+
+	/* parse the "committer" line */
+	/* it must be at least "committer x <x> 0 +0000\n" i.e. 24 chars */
+	if (in + 24 >= tail || memcmp(in, "committer ", 7))
+		goto bad_data;
+	in += 10;
+	end = get_nameend_and_tz(in, &tz_val);
+	if (!end)
+		goto bad_data;
+	index = dict_add_entry(commit_name_table, tz_val, in, end - in);
+	if (index < 0)
+		goto bad_dict;
+	out += encode_varint(index, out);
+	time = strtoul(end, &end, 10);
+	if (!end || end[0] != ' ' || end[6] != '\n')
+		goto bad_data;
+	out += encode_varint(time, out);
+	in = end + 7;
+
+	/* finally, deflate the remaining data */
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, pack_compression_level);
+	stream.next_in = (unsigned char *)in;
+	stream.avail_in = tail - in;
+	stream.next_out = (unsigned char *)out;
+	stream.avail_out = size - (out - (unsigned char *)buffer);
+	status = deflate(&stream, Z_FINISH);
+	end = (char *)stream.next_out;
+	deflateEnd(&stream);
+	if (status != Z_STREAM_END) {
+		error("deflate error status %d", status);
+		goto bad;
+	}
+
+	*sizep = end - (char *)buffer;
+	return buffer;
+
+bad_data:
+	error("bad commit data");
+	goto bad;
+bad_dict:
+	error("bad dict entry");
+bad:
+	free(buffer);
+	return NULL;
+}
+
 static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
 {
 	unsigned i, nr_objects = p->num_objects;
-- 
1.8.4.38.g317e65b
