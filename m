From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Check packs and then files.
Date: Mon, 11 Jul 2005 00:00:55 -0700
Message-ID: <7vwtnxvnbs.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
	<7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
	<7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
	<7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
	<7vy88gzn6s.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507082109140.17536@g5.osdl.org>
	<7vfyumj8hn.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 09:02:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrsIE-0004Zd-Mz
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 09:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVGKHBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 03:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVGKHBX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 03:01:23 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56735 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261161AbVGKHBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 03:01:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711070054.YFJW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 03:00:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyumj8hn.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun, 10 Jul 2005 21:02:12 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This reverses the order of object lookup, to check pack index
first and then go to the filesystem to find .git/objects/??/
hierarchy.  When most of the objects are packed, this saves
quite many stat() calls and negative dcache entries; while the
price this approach has to pay is negligible, even when most of
the objects are outside pack, because checking pack index file
is quite cheap.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 sha1_file.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

0394e2b0ed5b197510340f187d02ef2274b6cad2
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1035,14 +1035,17 @@ void * read_sha1_file(const unsigned cha
 {
 	unsigned long mapsize;
 	void *map, *buf;
+	struct pack_entry e;
 
+	if (find_pack_entry(sha1, &e))
+		return read_packed_sha1(sha1, type, size);
 	map = map_sha1_file_internal(sha1, &mapsize);
 	if (map) {
 		buf = unpack_sha1_file(map, mapsize, type, size);
 		munmap(map, mapsize);
 		return buf;
 	}
-	return read_packed_sha1(sha1, type, size);
+	return NULL;
 }
 
 void *read_object_with_reference(const unsigned char *sha1,
@@ -1343,9 +1346,9 @@ int has_sha1_file(const unsigned char *s
 	struct stat st;
 	struct pack_entry e;
 
-	if (find_sha1_file(sha1, &st))
+	if (find_pack_entry(sha1, &e))
 		return 1;
-	return find_pack_entry(sha1, &e);
+	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
 
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type)
