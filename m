From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 27 Aug 2013 00:25:53 -0400
Message-ID: <1377577567-27655-10-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsL-0007jK-1L
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab3H0E1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:27:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab3H0E0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:32 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0G9O51090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 51AD12DA052D	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233068>

This goes as follows:

- Tree reference: either variable length encoding of the index
  into the SHA1 table or the literal SHA1 prefixed by 0 (see
  add_sha1_ref()).

- Parent count: variable length encoding of the number of parents.
  This is normally going to occupy a single byte but doesn't have to.

- List of parent references: a list of add_sha1_ref() encoded references,
  or nothing if the parent count was zero.

- Author reference: variable length encoding of an index into the author
  string dictionary table which also covers the time zone.  To make the
  overall encoding efficient, the author table is already sorted by usage
  frequency so the most used names are first and require the shortest
  index encoding.

- Author time stamp: variable length encoded.  Year 2038 ready!

- Committer reference: same as author reference.

- Committer time stamp: same as author time stamp.

The remainder of the canonical commit object content is then zlib
compressed and appended to the above.

Rationale: The most important commit object data is densely encoded while
requiring no zlib inflate processing, and all SHA1 references are most
likely to be direct indices into the pack index file requiring no SHA1
search into the pack index file.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index bf33d15..cedbbd9 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -13,6 +13,9 @@
 #include "tree-walk.h"
 #include "pack.h"
 
+
+static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+
 struct data_entry {
 	unsigned offset;
 	unsigned size;
@@ -289,6 +292,122 @@ static unsigned char *add_sha1_ref(unsigned char *dst, const unsigned char *sha1
 	return dst + 20;
 }
 
+/*
+ * This converts a canonical commit object buffer into its
+ * tightly packed representation using the already populated
+ * and sorted commit_name_table dictionary.  The parsing is
+ * strict so to ensure the canonical version may always be
+ * regenerated and produce the same hash.
+ */
+void * conv_to_dict_commit(void *buffer, unsigned long *psize)
+{
+	unsigned long size = *psize;
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
+	if (get_sha1_hex(in + 5, sha1) < 0)
+		goto bad_data;
+	in += 46;
+	out = add_sha1_ref(out, sha1);
+
+	/* count how many "parent" lines */
+	nb_parents = 0;
+	while (in + 48 < tail && !memcmp(in, "parent ", 7) && in[47] == '\n') {
+		nb_parents++;
+		in += 48;
+	}
+	out = add_number(out, nb_parents);
+
+	/* rewind and parse the "parent" lines */
+	in -= 48 * nb_parents;
+	while (nb_parents--) {
+		if (get_sha1_hex(in + 7, sha1))
+			goto bad_data;
+		out = add_sha1_ref(out, sha1);
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
+	out = add_number(out, index);
+	time = strtoul(end, &end, 10);
+	if (!end || end[0] != ' ' || end[6] != '\n')
+		goto bad_data;
+	out = add_number(out, time);
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
+	out = add_number(out, index);
+	time = strtoul(end, &end, 10);
+	if (!end || end[0] != ' ' || end[6] != '\n')
+		goto bad_data;
+	out = add_number(out, time);
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
+	*psize = end - (char *)buffer;
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
1.8.4.22.g54757b7
