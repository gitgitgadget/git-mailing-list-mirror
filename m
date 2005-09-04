From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] NUL terminate the object data in patch_delta()
Date: Sun, 4 Sep 2005 13:43:16 +0400
Message-ID: <20050904094316.GB11653@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 11:46:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBr42-0003UQ-Hy
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 11:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVIDJnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 05:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVIDJnV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 05:43:21 -0400
Received: from master.altlinux.ru ([62.118.250.235]:2575 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751318AbVIDJnV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 05:43:21 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id E71F2E5910; Sun,  4 Sep 2005 13:43:17 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id 2A35FE3EF07; Sun,  4 Sep 2005 13:43:16 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8053>

At least pretty_print_commit() expects to get NUL-terminated commit data to
work properly.  unpack_sha1_rest(), which reads objects from separate files,
and unpack_non_delta_entry(), which reads non-delta-compressed objects from
pack files, already add the NUL byte after the object data, but patch_delta()
did not do it, which caused problems with, e.g., git-rev-list --pretty when
there are delta-compressed commit objects.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

Actually I noticed the problem when trying to do "git log ^v2.6.12
v2.6.13" on the linux-2.6 repository - the output was not identical to
the original ChangeLog-2.6.13; some commits had garbage at the end of
message.

Valgrind catches this problem with messages like:

==22513== 6 errors in context 6 of 7:
==22513== Invalid read of size 1
==22513==    at 0x804E148: pretty_print_commit (commit.c:382)
==22513==    by 0x8049A00: process_commit (rev-list.c:73)
==22513==    by 0x804A1E6: main (rev-list.c:168)
==22513==  Address 0x1BF2EC23 is 8 bytes after a block of size 459 alloc'd
==22513==    at 0x1B8FFAD8: malloc (vg_replace_malloc.c:130)
==22513==    by 0x804F9B6: patch_delta (patch-delta.c:37)
==22513==    by 0x804BFE7: unpack_entry_gently (sha1_file.c:941)
==22513==    by 0x804C2FA: read_packed_sha1 (sha1_file.c:987)
==22513==    by 0x804C378: read_sha1_file (sha1_file.c:1147)
==22513==    by 0x804DD91: parse_commit (commit.c:257)
==22513==    by 0x804DF1A: pop_most_recent_commit (commit.c:329)
==22513==    by 0x804A07D: main (rev-list.c:378)
==22513== 
==22513== 260 errors in context 7 of 7:
==22513== Invalid read of size 1
==22513==    at 0x804E050: pretty_print_commit (commit.c:347)
==22513==    by 0x8049A00: process_commit (rev-list.c:73)
==22513==    by 0x804A1E6: main (rev-list.c:168)
==22513==  Address 0x1BC30C46 is 0 bytes after a block of size 430 alloc'd
==22513==    at 0x1B8FFAD8: malloc (vg_replace_malloc.c:130)
==22513==    by 0x804F9B6: patch_delta (patch-delta.c:37)
==22513==    by 0x804BFE7: unpack_entry_gently (sha1_file.c:941)
==22513==    by 0x804C2FA: read_packed_sha1 (sha1_file.c:987)
==22513==    by 0x804C378: read_sha1_file (sha1_file.c:1147)
==22513==    by 0x804DD91: parse_commit (commit.c:257)
==22513==    by 0x804DF1A: pop_most_recent_commit (commit.c:329)
==22513==    by 0x804A07D: main (rev-list.c:378)


 patch-delta.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

121db224f0f2595067e3bf7daed6c6a903d7532b
diff --git a/patch-delta.c b/patch-delta.c
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -34,9 +34,10 @@ void *patch_delta(void *src_buf, unsigne
 
 	/* now the result size */
 	size = get_delta_hdr_size(&data);
-	dst_buf = malloc(size);
+	dst_buf = malloc(size + 1);
 	if (!dst_buf)
 		return NULL;
+	dst_buf[size] = 0;
 
 	out = dst_buf;
 	while (data < top) {
