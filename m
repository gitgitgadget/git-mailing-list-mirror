From: Nicolas Pitre <nico@fluxnic.net>
Subject: packv4: current performance
Date: Mon, 09 Sep 2013 15:14:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309091454450.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Nguyn_Th=E1i_Ngc_Duy?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 21:14:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6uW-0003t2-GV
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735Ab3IITOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:14:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46412 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3IITOC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:14:02 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSV00KHZHFEK030@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Sep 2013 15:14:02 -0400 (EDT)
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234361>

Of course pack v4, while significantly better on disk space, is still 
lagging behind pack v2 in terms of runtime performance.  This is because 
right now the reading side is implemented as a compatibility layer that 
parses the packv4 data to regenerate a canonical object representation, 
which is then parsed again by the core code.  The full runtime benefit 
of pack v4 will be apparent when the core code is optimized to use pack 
v4 data directly (hint hint to potential contributors).

Still, I've looked a bit closer at the performance issue, and one thing 
was clear: stdio string functions are very costly.  So I've added the 
patch below to my tree which provided a big boost in performance.

    packv4-parse.c: get rid of snprintf()
    
    Profiling 'git rev-list --all --objects' shows snprintf() related
    functions topping the total execution time chart.
    
    Let's replace that with specialized string generation functions.
    This reduced the total runtime by a wopping 40% on a Core2 processor.
    
    Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/packv4-parse.c b/packv4-parse.c
index 63bba03..c62c4ae 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -163,6 +163,77 @@ const unsigned char *get_pathref(struct packed_git *p, unsigned int index)
 	return p->path_dict->data + p->path_dict->offsets[index];
 }
 
+static int tree_line(unsigned char *buf, unsigned long size,
+		     const char *label, int label_len,
+		     const unsigned char *sha1)
+{
+	static const char hex[] = "0123456789abcdef";
+	int i;
+
+	if (label_len + 1 + 40 + 1 > size)
+		return 0;
+
+	memcpy(buf, label, label_len);
+	buf += label_len;
+	*buf++ = ' ';
+
+	for (i = 0; i < 20; i++) {
+		unsigned int val = *sha1++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+
+	*buf = '\n';
+
+	return label_len + 1 + 40 + 1;
+}
+
+static int ident_line(unsigned char *buf, unsigned long size,
+		      const char *label, int label_len,
+		      const unsigned char *ident, unsigned long time, int tz)
+{
+	int ident_len = strlen((const char *)ident);
+	int len = label_len + 1 + ident_len + 1 + 1 + 5 + 1;
+	int time_len = 0;
+	unsigned char time_buf[16];
+
+	do {
+		time_buf[time_len++] = '0' + time % 10;
+		time /= 10;
+	} while (time);
+	len += time_len;
+
+	if (len > size)
+		return 0;
+
+	memcpy(buf, label, label_len);
+	buf += label_len;
+	*buf++ = ' ';
+
+	memcpy(buf, ident, ident_len);
+	buf += ident_len;
+	*buf++ = ' ';
+
+	do {
+		*buf++ = time_buf[--time_len];
+	} while (time_len);
+	*buf++ = ' ';
+
+	if (tz < 0) {
+		tz = -tz;
+		*buf++ = '-';
+	} else
+		*buf++ = '+';
+	*buf++ = '0' + tz / 1000; tz %= 1000;
+	*buf++ = '0' + tz / 100;  tz %= 100;
+	*buf++ = '0' + tz / 10;   tz %= 10;
+	*buf++ = '0' + tz;
+
+	*buf = '\n';
+
+	return len;
+}
+
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 		     off_t offset, unsigned long size)
 {
@@ -182,15 +253,17 @@ void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 	scp = src;
 
 	sha1 = get_sha1ref(p, &scp);
-	len = snprintf((char *)dcp, size, "tree %s\n", sha1_to_hex(sha1));
+	len = tree_line(dcp, size, "tree", strlen("tree"), sha1);
+	if (!len)
+		die("overflow in %s", __func__);
 	dcp += len;
 	size -= len;
 
 	nb_parents = decode_varint(&scp);
 	while (nb_parents--) {
 		sha1 = get_sha1ref(p, &scp);
-		len = snprintf((char *)dcp, size, "parent %s\n", sha1_to_hex(sha1));
-		if (len >= size)
+		len = tree_line(dcp, size, "parent", strlen("parent"), sha1);
+		if (!len)
 			die("overflow in %s", __func__);
 		dcp += len;
 		size -= len;
@@ -211,16 +284,16 @@ void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 	else
 		author_time = commit_time - (author_time >> 1);
 
-	len = snprintf((char *)dcp, size, "author %s %lu %+05d\n",
-			author, author_time, author_tz);
-	if (len >= size)
+	len = ident_line(dcp, size, "author", strlen("author"), 
+			 author, author_time, author_tz);
+	if (!len)
 		die("overflow in %s", __func__);
 	dcp += len;
 	size -= len;
 
-	len = snprintf((char *)dcp, size, "committer %s %lu %+05d\n",
-			committer, commit_time, commit_tz);
-	if (len >= size)
+	len = ident_line(dcp, size, "committer", strlen("committer"),
+			 committer, commit_time, commit_tz);
+	if (!len)
 		die("overflow in %s", __func__);
 	dcp += len;
 	size -= len;
@@ -248,6 +321,32 @@ void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 	return dst;
 }
 
+static int tree_entry_prefix(unsigned char *buf, unsigned long size,
+			     const unsigned char *path, unsigned mode)
+{
+	int path_len = strlen((const char *)path) + 1;
+	int mode_len = 0;
+	int len;
+	unsigned char mode_buf[8];
+
+	do {
+		mode_buf[mode_len++] = '0' + (mode & 7);
+		mode >>= 3;
+	} while (mode);
+
+	len = mode_len + 1 + path_len;
+	if (len > size)
+		return 0;
+
+	do {
+		*buf++ = mode_buf[--mode_len];
+	} while (mode_len);
+	*buf++ = ' ';
+	memcpy(buf, path, path_len);
+
+	return len;
+}
+
 static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			  off_t offset, unsigned int start, unsigned int count,
 			  unsigned char **dstp, unsigned long *sizep, int hdr)
@@ -315,9 +414,8 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			if (!path || !sha1)
 				return -1;
 			mode = (path[0] << 8) | path[1];
-			len = snprintf((char *)*dstp, *sizep, "%o %s%c",
-					   mode, path+2, '\0');
-			if (len + 20 > *sizep)
+			len = tree_entry_prefix(*dstp, *sizep, path + 2, mode);
+			if (!len || len + 20 > *sizep)
 				return -1;
 			hashcpy(*dstp + len, sha1);
 			*dstp += len + 20;
