From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 29/38] pack v4: code to retrieve a name
Date: Thu, 05 Sep 2013 02:19:52 -0400
Message-ID: <1378362001-1738-30-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvj-0007oz-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442Ab3IEGUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380Ab3IEGUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:21 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3W2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id EE4D82DA05F2	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233897>

The name dictionary is loaded if not already done.  We know it is
located right after the SHA1 table (20 bytes per object) which is
itself right after the 12-byte header.

Then the index is parsed from the input buffer and a pointer to the
corresponding entry is returned.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 cache.h        |  3 +++
 packv4-parse.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/cache.h b/cache.h
index 59d9ba7..6ce327e 100644
--- a/cache.h
+++ b/cache.h
@@ -1015,6 +1015,8 @@ struct pack_window {
 	unsigned int inuse_cnt;
 };
 
+struct packv4_dict;
+
 extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
@@ -1027,6 +1029,7 @@ extern struct packed_git {
 	unsigned char *bad_object_sha1;
 	int version;
 	int index_version;
+	struct packv4_dict *name_dict;
 	time_t mtime;
 	int pack_fd;
 	unsigned pack_local:1,
diff --git a/packv4-parse.c b/packv4-parse.c
index 26894bc..074e107 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -105,3 +105,27 @@ static struct packv4_dict *load_dict(struct packed_git *p, off_t *offset)
 	*offset = curpos;
 	return dict;
 }
+
+static void load_name_dict(struct packed_git *p)
+{
+	off_t offset = 12 + p->num_objects * 20;
+	struct packv4_dict *names = load_dict(p, &offset);
+	if (!names)
+		die("bad pack name dictionary in %s", p->pack_name);
+	p->name_dict = names;
+}
+
+const unsigned char *get_nameref(struct packed_git *p, const unsigned char **srcp)
+{
+	unsigned int index;
+
+	if (!p->name_dict)
+		load_name_dict(p);
+
+	index = decode_varint(srcp);
+	if (index >= p->name_dict->nb_entries) {
+		error("%s: index overflow", __func__);
+		return NULL;
+	}
+	return p->name_dict->data + p->name_dict->offsets[index];
+}
-- 
1.8.4.38.g317e65b
