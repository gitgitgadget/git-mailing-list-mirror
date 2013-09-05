From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 28/38] pack v4: code to load and prepare a pack dictionary
 table for use
Date: Thu, 05 Sep 2013 02:19:51 -0400
Message-ID: <1378362001-1738-29-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwA-000832-AU
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557Ab3IEGUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab3IEGUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:21 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3Y2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id DCE6A2DA05B8	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233907>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-parse.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/packv4-parse.c b/packv4-parse.c
index 299fc48..26894bc 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -28,3 +28,80 @@ const unsigned char *get_sha1ref(struct packed_git *p,
 
 	return sha1;
 }
+
+struct packv4_dict {
+	const unsigned char *data;
+	unsigned int nb_entries;
+	unsigned int offsets[FLEX_ARRAY];
+};
+
+static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
+{
+	struct pack_window *w_curs = NULL;
+	off_t curpos = *offset;
+	unsigned long dict_size, avail;
+	unsigned char *src, *data;
+	const unsigned char *cp;
+	git_zstream stream;
+	struct packv4_dict *dict;
+	int nb_entries, i, st;
+
+	/* get uncompressed dictionary data size */
+	src = use_pack(p, &w_curs, curpos, &avail);
+	cp = src;
+	dict_size = decode_varint(&cp);
+	if (dict_size < 3) {
+		error("bad dict size");
+		return NULL;
+	}
+	curpos += cp - src;
+
+	data = xmallocz(dict_size);
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out = data;
+	stream.avail_out = dict_size + 1;
+
+	git_inflate_init(&stream);
+	do {
+		src = use_pack(p, &w_curs, curpos, &stream.avail_in);
+		stream.next_in = src;
+		st = git_inflate(&stream, Z_FINISH);
+		curpos += stream.next_in - src;
+	} while ((st == Z_OK || st == Z_BUF_ERROR) && stream.avail_out);
+	git_inflate_end(&stream);
+	unuse_pack(&w_curs);
+	if (st != Z_STREAM_END || stream.total_out != dict_size) {
+		error("pack dictionary bad");
+		free(data);
+		return NULL;
+	}
+
+	/* count number of entries */
+	nb_entries = 0;
+	cp = data;
+	while (cp < data + dict_size - 3) {
+		cp += 2;  /* prefix bytes */
+		cp += strlen((const char *)cp);  /* entry string */
+		cp += 1;  /* terminating NUL */
+		nb_entries++;
+	}
+	if (cp - data != dict_size) {
+		error("dict size mismatch");
+		free(data);
+		return NULL;
+	}
+
+	dict = xmalloc(sizeof(*dict) + nb_entries * sizeof(dict->offsets[0]));
+	dict->data = data;
+	dict->nb_entries = nb_entries;
+
+	cp = data;
+	for (i = 0; i < nb_entries; i++) {
+		dict->offsets[i] = cp - data;
+		cp += 2;
+		cp += strlen((const char *)cp) + 1;
+	}
+
+	*offset = curpos;
+	return dict;
+}
-- 
1.8.4.38.g317e65b
