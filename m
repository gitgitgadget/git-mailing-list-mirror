From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] prepare_packed_git(): sort packs by age and localness.
Date: Sat, 10 Mar 2007 18:29:20 -0800
Message-ID: <7vtzwsy0lb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 03:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQDoP-00032v-5p
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 03:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbXCKC3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 21:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbXCKC3W
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 21:29:22 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54223 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635AbXCKC3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 21:29:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311022921.HKMA1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Mar 2007 21:29:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZEVL1W00P1kojtg0000000; Sat, 10 Mar 2007 21:29:20 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41897>

When accessing objects, we first look for them in packs that
are linked together in the reverse order of discovery.

Since younger packs tend to contain more recent objects, which
are more likely to be accessed often, and local packs tend to
contain objects more relevant to our specific projects, sort the
list of packs before starting to access them.  In addition,
favoring local packs over the ones borrowed from alternates can
be a win when alternates are mounted on network file systems.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 cache.h     |    2 ++
 sha1_file.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index ae25759..db3a000 100644
--- a/cache.h
+++ b/cache.h
@@ -373,6 +373,7 @@ extern struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
 	uint32_t *index_base;
+	time_t mtime;
 	off_t index_size;
 	off_t pack_size;
 	int pack_fd;
@@ -431,6 +432,7 @@ extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+void rearrange_packed_git(void);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index 219a10f..3036817 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -739,6 +739,7 @@ struct packed_git *add_packed_git(char *path, int path_len, int local)
 	p->windows = NULL;
 	p->pack_fd = -1;
 	p->pack_local = local;
+	p->mtime = st.st_mtime;
 	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
 		hashcpy(p->sha1, sha1);
 	return p;
@@ -823,6 +824,62 @@ static void prepare_packed_git_one(char *objdir, int local)
 	closedir(dir);
 }
 
+static int sort_pack(const void *a_, const void *b_)
+{
+	struct packed_git *a = *((struct packed_git **)a_);
+	struct packed_git *b = *((struct packed_git **)b_);
+	int st;
+
+	/*
+	 * Local packs tend to contain objects specific to our
+	 * variant of the project than remote ones.  In addition,
+	 * remote ones could be on a network mounted filesystem.
+	 * Favor local ones for these reasons.
+	 */
+	st = a->pack_local - b->pack_local;
+	if (st)
+		return -st;
+
+	/*
+	 * Younger packs tend to contain more recent objects,
+	 * and more recent objects tend to get accessed more
+	 * often.
+	 */
+	if (a->mtime < b->mtime)
+		return 1;
+	else if (a->mtime == b->mtime)
+		return 0;
+	return -1;
+}
+
+void rearrange_packed_git(void)
+{
+	struct packed_git **ary, *p;
+	int i, n;
+	int (*sort_fn)(const void *, const void *);
+
+	for (n = 0, p = packed_git; p; p = p->next)
+		n++;
+	if (n < 2)
+		return;
+
+	/* prepare an array of packed_git for easier sorting */
+	ary = xcalloc(n, sizeof(struct packed_git *));
+	for (n = 0, p = packed_git; p; p = p->next)
+		ary[n++] = p;
+
+	sort_fn = sort_pack;
+	qsort(ary, n, sizeof(struct packed_git *), sort_fn);
+
+	/* link them back again */
+	for (i = 0; i < n - 1; i++)
+		ary[i]->next = ary[i + 1];
+	ary[n - 1]->next = NULL;
+	packed_git = ary[0];
+
+	free(ary);
+}
+
 static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
@@ -837,6 +894,7 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->base, 0);
 		alt->name[-1] = '/';
 	}
+	rearrange_packed_git();
 	prepare_packed_git_run_once = 1;
 }
 
-- 
1.5.0.3.942.g299fc
