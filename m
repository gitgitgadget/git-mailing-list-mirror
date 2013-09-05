From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 06/38] pack v4: split the object list and dictionary creation
Date: Thu, 05 Sep 2013 02:19:29 -0400
Message-ID: <1378362001-1738-7-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSxC-00009K-9D
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762781Ab3IEGV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab3IEGUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:16 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00ANT2XQCY00@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:14 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id B22582DA05B8	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233929>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 58 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 5c08871..20d97a4 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -261,7 +261,7 @@ static int sort_by_offset(const void *e1, const void *e2)
 	return 0;
 }
 
-static int create_pack_dictionaries(struct packed_git *p)
+static struct idx_entry *get_packed_object_list(struct packed_git *p)
 {
 	uint32_t nr_objects, i;
 	struct idx_entry *objects;
@@ -275,7 +275,15 @@ static int create_pack_dictionaries(struct packed_git *p)
 	}
 	qsort(objects, nr_objects, sizeof(*objects), sort_by_offset);
 
-	for (i = 0; i < nr_objects; i++) {
+	return objects;
+}
+
+static int create_pack_dictionaries(struct packed_git *p,
+				    struct idx_entry *objects)
+{
+	unsigned int i;
+
+	for (i = 0; i < p->num_objects; i++) {
 		void *data;
 		enum object_type type;
 		unsigned long size;
@@ -310,20 +318,21 @@ static int create_pack_dictionaries(struct packed_git *p)
 				typename(type), sha1_to_hex(objects[i].sha1));
 		free(data);
 	}
-	free(objects);
 
 	return 0;
 }
 
-static int process_one_pack(const char *path)
+static struct packed_git *open_pack(const char *path)
 {
 	char arg[PATH_MAX];
 	int len;
 	struct packed_git *p;
 
 	len = strlcpy(arg, path, PATH_MAX);
-	if (len >= PATH_MAX)
-		return error("name too long: %s", path);
+	if (len >= PATH_MAX) {
+		error("name too long: %s", path);
+		return NULL;
+	}
 
 	/*
 	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
@@ -333,8 +342,10 @@ static int process_one_pack(const char *path)
 		strcpy(arg + len - 5, ".idx");
 		len--;
 	} else if (!has_extension(arg, ".idx")) {
-		if (len + 4 >= PATH_MAX)
-			return error("name too long: %s.idx", arg);
+		if (len + 4 >= PATH_MAX) {
+			error("name too long: %s.idx", arg);
+			return NULL;
+		}
 		strcpy(arg + len, ".idx");
 		len += 4;
 	}
@@ -345,17 +356,36 @@ static int process_one_pack(const char *path)
 	 */
 	if (len + 1 >= PATH_MAX) {
 		arg[len - 4] = '\0';
-		return error("name too long: %s.pack", arg);
+		error("name too long: %s.pack", arg);
+		return NULL;
 	}
 
 	p = add_packed_git(arg, len, 1);
-	if (!p)
-		return error("packfile %s not found.", arg);
+	if (!p) {
+		error("packfile %s not found.", arg);
+		return NULL;
+	}
 
 	install_packed_git(p);
-	if (open_pack_index(p))
-		return error("packfile %s index not opened", p->pack_name);
-	return create_pack_dictionaries(p);
+	if (open_pack_index(p)) {
+		error("packfile %s index not opened", p->pack_name);
+		return NULL;
+	}
+
+	return p;
+}
+
+static void process_one_pack(char *src_pack)
+{
+	struct packed_git *p;
+	struct idx_entry *objs;
+
+	p = open_pack(src_pack);
+	if (!p)
+		die("unable to open source pack");
+
+	objs = get_packed_object_list(p);
+	create_pack_dictionaries(p, objs);
 }
 
 int main(int argc, char *argv[])
-- 
1.8.4.38.g317e65b
