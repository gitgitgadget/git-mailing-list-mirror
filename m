From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 12/23] pack v4: creation code
Date: Tue, 27 Aug 2013 00:25:56 -0400
Message-ID: <1377577567-27655-13-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsJ-0007jK-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab3H0E1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:27:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab3H0E0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:33 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600DCD9O4IO90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 82CD32DA052D	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233059>

Let's actually open the destination pack file and write the header and
the tables.

The header isn't much different from pack v3, except for the pack version
number of course.

The first table is the sorted SHA1 table normally found in the pack index
file.  With pack v4 we write this table in the main pack file instead as
it is index referenced by subsequent objects in the pack.  Doing so has
many advantages:

- The SHA1 references used to be duplicated on disk: once in the pack
  index file, and then at least once or more within commit and tree
  objects referencing them.  The only SHA1 which is not being listed more
  than once this way is the one for a branch tip commit object and those
  are normally very few.  Now all that SHA1 data is represented only once.

- The SHA1 references found in commit and tree objects can be obtained
  on disk directly without having to deflate those objects first.

The SHA1 table size is obtained by multiplying the number of objects by 20.

And then the commit and path dictionary tables are written right after
the SHA1 table.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 2956fda..5211f9c 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -605,6 +605,48 @@ static unsigned long write_dict_table(struct sha1file *f, struct dict_table *t)
 	return hdrlen + datalen;
 }
 
+static struct sha1file * packv4_open(char *path)
+{
+	int fd;
+
+	fd = open(path, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	if (fd < 0)
+		die_errno("unable to create '%s'", path);
+	return sha1fd(fd, path);
+}
+
+static unsigned int packv4_write_header(struct sha1file *f, unsigned nr_objects)
+{
+	struct pack_header hdr;
+
+	hdr.hdr_signature = htonl(PACK_SIGNATURE);
+	hdr.hdr_version = htonl(4);
+	hdr.hdr_entries = htonl(nr_objects);
+	sha1write(f, &hdr, sizeof(hdr));
+
+	return sizeof(hdr);
+}
+
+static unsigned long packv4_write_tables(struct sha1file *f, unsigned nr_objects,
+					 struct pack_idx_entry *objs)
+{
+	unsigned i;
+	unsigned long written = 0;
+
+	/* The sorted list of object SHA1's is always first */
+	for (i = 0; i < nr_objects; i++)
+		sha1write(f, objs[i].sha1, 20);
+	written = 20 * nr_objects;
+
+	/* Then the commit dictionary table */
+	written += write_dict_table(f, commit_name_table);
+
+	/* Followed by the path component dictionary table */
+	written += write_dict_table(f, tree_path_table);
+
+	return written;
+}
+
 static struct packed_git *open_pack(const char *path)
 {
 	char arg[PATH_MAX];
@@ -658,9 +700,10 @@ static struct packed_git *open_pack(const char *path)
 	return p;
 }
 
-static void process_one_pack(char *src_pack)
+static void process_one_pack(char *src_pack, char *dst_pack)
 {
 	struct packed_git *p;
+	struct sha1file *f;
 	struct pack_idx_entry *objs, **p_objs;
 	unsigned nr_objects;
 
@@ -673,15 +716,22 @@ static void process_one_pack(char *src_pack)
 	p_objs = sort_objs_by_offset(objs, nr_objects);
 
 	create_pack_dictionaries(p, p_objs);
+
+	f = packv4_open(dst_pack);
+	if (!f)
+		die("unable to open destination pack");
+	packv4_write_header(f, nr_objects);
+	packv4_write_tables(f, nr_objects, objs);
 }
 
 int main(int argc, char *argv[])
 {
-	if (argc != 2) {
-		fprintf(stderr, "Usage: %s <packfile>\n", argv[0]);
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s <src_packfile> <dst_packfile>\n", argv[0]);
 		exit(1);
 	}
-	process_one_pack(argv[1]);
-	dict_dump();
+	process_one_pack(argv[1], argv[2]);
+	if (0)
+		dict_dump();
 	return 0;
 }
-- 
1.8.4.22.g54757b7
