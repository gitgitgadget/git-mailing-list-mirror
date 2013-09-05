From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 34/38] pack v4: code to retrieve a path component
Date: Thu, 05 Sep 2013 02:19:57 -0400
Message-ID: <1378362001-1738-35-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvx-0007xc-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486Ab3IEGUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43577 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab3IEGUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:22 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3Y2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 414262DA0547	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233904>

Because the path dictionary table is located right after the name
dictionary table, we currently need to load the later to find the
former.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 cache.h        |  2 ++
 packv4-parse.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/cache.h b/cache.h
index 6ce327e..5f2147a 100644
--- a/cache.h
+++ b/cache.h
@@ -1030,6 +1030,8 @@ extern struct packed_git {
 	int version;
 	int index_version;
 	struct packv4_dict *name_dict;
+	off_t name_dict_end;
+	struct packv4_dict *path_dict;
 	time_t mtime;
 	int pack_fd;
 	unsigned pack_local:1,
diff --git a/packv4-parse.c b/packv4-parse.c
index 431f47e..b80b73e 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -114,6 +114,7 @@ static void load_name_dict(struct packed_git *p)
 	if (!names)
 		die("bad pack name dictionary in %s", p->pack_name);
 	p->name_dict = names;
+	p->name_dict_end = offset;
 }
 
 const unsigned char *get_nameref(struct packed_git *p, const unsigned char **srcp)
@@ -131,6 +132,41 @@ const unsigned char *get_nameref(struct packed_git *p, const unsigned char **src
 	return p->name_dict->data + p->name_dict->offsets[index];
 }
 
+static void load_path_dict(struct packed_git *p)
+{
+	off_t offset;
+	struct packv4_dict *paths;
+
+	/*
+	 * For now we need to load the name dictionary to know where
+	 * it ends and therefore where the path dictionary starts.
+	 */
+	if (!p->name_dict)
+		load_name_dict(p);
+
+	offset = p->name_dict_end;
+	paths = load_dict(p, &offset);
+	if (!paths)
+		die("bad pack path dictionary in %s", p->pack_name);
+	p->path_dict = paths;
+}
+
+const unsigned char *get_pathref(struct packed_git *p, const unsigned char **srcp)
+{
+	unsigned int index;
+
+	if (!p->path_dict)
+		load_path_dict(p);
+
+	index = decode_varint(srcp);
+	if (index < 1 || index - 1 >= p->path_dict->nb_entries) {
+		error("%s: index overflow", __func__);
+		return NULL;
+	}
+	index -= 1;
+	return p->path_dict->data + p->path_dict->offsets[index];
+}
+
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 		     off_t offset, unsigned long size)
 {
-- 
1.8.4.38.g317e65b
