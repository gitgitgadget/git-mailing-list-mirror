From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git_open_noatime(): drop unused parameter
Date: Sun, 15 May 2011 12:16:29 -0700
Message-ID: <7voc33pyeq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLgnv-0006PG-Ar
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab1EOTQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:16:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab1EOTQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:16:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA0814A69;
	Sun, 15 May 2011 15:18:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	Q+YjImWj9NAmPxFMfplyf/oAcE=; b=jWtLFpOI20uZ+lZl7v8e87QSHcXD88KXJ
	W/WDjP+/zgP1cbuCgIyPdRDQ75KLU8o2Q2C0GWYmh1Hr9djrLdnTHOlt0CXbDhUQ
	0//EnZEcypDH4HJF288sokh7n4RKEK0hIL9YNQ1pJUcLLY1YYpJ5bhHVC0iqw0xp
	QRmK0do79c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=x3j
	0Ck51OTrZhNoyKohcTp2zJJo8Y2I53441HR78bnVM/ImbGQFGw4khzin47XEHqIo
	V1aJ4pawJfwAKNjYyo6APXaFp3bm3dJJMAi/JvxWWJ/jk3VRFUD6/rsPsXqnUoYx
	5wzMI3qQBH+ActNet6lcTWMFIzEIwh4KfS+vyZmM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 967D34A68;
	Sun, 15 May 2011 15:18:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA5CE4A67; Sun, 15 May 2011
 15:18:36 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 230C070E-7F28-11E0-AF07-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173647>

Since commit c793430 (Limit file descriptors used by packs, 2011-02-28),
the extra parameter added in f2e872aa (Work around EMFILE when there are
too many pack files, 2010-11-01) is not used anymore.

Remove it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ee06d99..1a7e410 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -31,8 +31,6 @@ static inline uintmax_t sz_fmt(size_t s) { return s; }
 
 const unsigned char null_sha1[20];
 
-static int git_open_noatime(const char *name, struct packed_git *p);
-
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
@@ -227,6 +225,7 @@ struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
 static void read_info_alternates(const char * alternates, int depth);
+static int git_open_noatime(const char *name);
 
 /*
  * Prepare alternate object database registry.
@@ -360,7 +359,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 	int fd;
 
 	sprintf(path, "%s/%s", relative_base, alt_file_name);
-	fd = git_open_noatime(path, NULL);
+	fd = git_open_noatime(path);
 	if (fd < 0)
 		return;
 	if (fstat(fd, &st) || (st.st_size == 0)) {
@@ -475,7 +474,7 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 	struct pack_idx_header *hdr;
 	size_t idx_size;
 	uint32_t version, nr, i, *index;
-	int fd = git_open_noatime(path, p);
+	int fd = git_open_noatime(path);
 	struct stat st;
 
 	if (fd < 0)
@@ -757,7 +756,7 @@ static int open_packed_git_1(struct packed_git *p)
 	while (pack_max_fds <= pack_open_fds && unuse_one_window(NULL, -1))
 		; /* nothing */
 
-	p->pack_fd = git_open_noatime(p->pack_name, p);
+	p->pack_fd = git_open_noatime(p->pack_name);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
 	pack_open_fds++;
@@ -1145,7 +1144,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long siz
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
 
-static int git_open_noatime(const char *name, struct packed_git *p)
+static int git_open_noatime(const char *name)
 {
 	static int sha1_file_open_flag = O_NOATIME;
 
@@ -1170,7 +1169,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	char *name = sha1_file_name(sha1);
 	struct alternate_object_database *alt;
 
-	fd = git_open_noatime(name, NULL);
+	fd = git_open_noatime(name);
 	if (fd >= 0)
 		return fd;
 
@@ -1179,7 +1178,7 @@ static int open_sha1_file(const unsigned char *sha1)
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		name = alt->name;
 		fill_sha1_path(name, sha1);
-		fd = git_open_noatime(alt->base, NULL);
+		fd = git_open_noatime(alt->base);
 		if (fd >= 0)
 			return fd;
 	}
-- 
1.7.5.1.334.gdfd07
