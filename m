From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 37/38] pack v4: introduce "escape hatches" in the name and path
 indexes
Date: Thu, 05 Sep 2013 02:20:00 -0400
Message-ID: <1378362001-1738-38-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvk-0007oz-8R
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab3IEGU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437Ab3IEGUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:23 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G402XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 5F6EB2DA05F2	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233900>

If the path or name index is zero, this means the entry data is to be
found inline rather than being located in the dictionary table. This is
there to allow easy completion of thin packs without having to add new
table entries which would have required a full rewrite of the pack data.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c |  6 +++---
 packv4-parse.c  | 28 ++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index fd16222..9d6ffc0 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -343,7 +343,7 @@ void *pv4_encode_commit(void *buffer, unsigned long *sizep)
 	index = dict_add_entry(commit_name_table, tz_val, in, end - in);
 	if (index < 0)
 		goto bad_dict;
-	out += encode_varint(index, out);
+	out += encode_varint(index + 1, out);
 	time = strtoul(end, &end, 10);
 	if (!end || end[0] != ' ' || end[6] != '\n')
 		goto bad_data;
@@ -361,7 +361,7 @@ void *pv4_encode_commit(void *buffer, unsigned long *sizep)
 	index = dict_add_entry(commit_name_table, tz_val, in, end - in);
 	if (index < 0)
 		goto bad_dict;
-	out += encode_varint(index, out);
+	out += encode_varint(index + 1, out);
 	time = strtoul(end, &end, 10);
 	if (!end || end[0] != ' ' || end[6] != '\n')
 		goto bad_data;
@@ -561,7 +561,7 @@ void *pv4_encode_tree(void *_buffer, unsigned long *sizep,
 			free(buffer);
 			return NULL;
 		}
-		out += encode_varint(index << 1, out);
+		out += encode_varint((index + 1) << 1, out);
 		out += encode_sha1ref(name_entry.sha1, out);
 	}
 
diff --git a/packv4-parse.c b/packv4-parse.c
index 4c218d2..6db4ed3 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -125,11 +125,19 @@ const unsigned char *get_nameref(struct packed_git *p, const unsigned char **src
 		load_name_dict(p);
 
 	index = decode_varint(srcp);
-	if (index >= p->name_dict->nb_entries) {
+
+	if (!index) {
+		/* the entry data is inline */
+		const unsigned char *data = *srcp;
+		*srcp += 2 + strlen((const char *)*srcp + 2) + 1;
+		return data;
+	}
+
+	if (index - 1 >= p->name_dict->nb_entries) {
 		error("%s: index overflow", __func__);
 		return NULL;
 	}
-	return p->name_dict->data + p->name_dict->offsets[index];
+	return p->name_dict->data + p->name_dict->offsets[index - 1];
 }
 
 static void load_path_dict(struct packed_git *p)
@@ -151,16 +159,24 @@ static void load_path_dict(struct packed_git *p)
 	p->path_dict = paths;
 }
 
-const unsigned char *get_pathref(struct packed_git *p, unsigned int index)
+const unsigned char *get_pathref(struct packed_git *p, unsigned int index,
+				 const unsigned char **srcp)
 {
 	if (!p->path_dict)
 		load_path_dict(p);
 
-	if (index >= p->path_dict->nb_entries) {
+	if (!index) {
+		/* the entry data is inline */
+		const unsigned char *data = *srcp;
+		*srcp += 2 + strlen((const char *)*srcp + 2) + 1;
+		return data;
+	}
+
+	if (index - 1 >= p->path_dict->nb_entries) {
 		error("%s: index overflow", __func__);
 		return NULL;
 	}
-	return p->path_dict->data + p->path_dict->offsets[index];
+	return p->path_dict->data + p->path_dict->offsets[index - 1];
 }
 
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
@@ -296,7 +312,7 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			unsigned mode;
 			int len;
 
-			path = get_pathref(p, what >> 1);
+			path = get_pathref(p, what >> 1, &scp);
 			sha1 = get_sha1ref(p, &scp);
 			if (!path || !sha1)
 				return -1;
-- 
1.8.4.38.g317e65b
