From: Junio C Hamano <junkio@cox.net>
Subject: {RFC/PATCH] micro-optimize get_sha1_hex()
Date: Sat, 09 Sep 2006 14:55:09 -0700
Message-ID: <7vzmd8vh6q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 23:54:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMAmp-0000UP-R4
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 23:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWIIVyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 17:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWIIVyh
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 17:54:37 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11923 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964877AbWIIVyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 17:54:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060909215435.JFRH6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Sep 2006 17:54:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LMuR1V00H1kojtg0000000
	Sat, 09 Sep 2006 17:54:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26770>

I was profiling 'git-rev-list v2.16.12..', because I suspected
insert_by_date() might be expensive (the function inserts into
singly-linked ordered list, so the data structure has to become
array based to allow optimization).  But profiling showed it was
not the bottleneck.  Probably because the kernel history is not
that bushy and we do not have too many "active" heads during
traversal.

But I noticed something else.

Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total           
 time   seconds   seconds    calls  ms/call  ms/call  name    
 21.52      0.17     0.17  2800320     0.00     0.00  hexval
 15.19      0.29     0.12    70008     0.00     0.00  get_sha1_hex
 15.19      0.41     0.12    70008     0.00     0.00  lookup_object
 15.19      0.53     0.12    68495     0.00     0.00  find_pack_entry_one
 11.39      0.62     0.09   198667     0.00     0.00  insert_obj_hash
  7.60      0.68     0.06    34675     0.00     0.00  unpack_object_header_gently
  3.80      0.71     0.03    33819     0.00     0.02  parse_commit_buffer
  1.27      0.72     0.01   103822     0.00     0.00  commit_list_insert
  1.27      0.73     0.01    67640     0.00     0.00  prepare_packed_git
  1.27      0.74     0.01    67611     0.00     0.00  created_object
  1.27      0.75     0.01    33820     0.00     0.00  use_packed_git
  1.27      0.76     0.01    33819     0.00     0.00  lookup_tree
  1.27      0.77     0.01        1    10.00    10.00  prepare_packed_git_one
  1.27      0.78     0.01                             parse_tree_indirect
  1.27      0.79     0.01                             verify_filename
  ...

The attached brings get_sha1_hex() down from 15.19% to 5.41%,
but I feel we should be able to do better.

Is this barking up the wrong tree?  Or did I pick a good target
but the shooter wasn't skilled enough?


diff --git a/sha1_file.c b/sha1_file.c
index 428d791..00aa364 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -26,26 +26,30 @@ const unsigned char null_sha1[20];
 
 static unsigned int sha1_file_open_flag = O_NOATIME;
 
-static unsigned hexval(char c)
-{
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	if (c >= 'A' && c <= 'F')
-		return c - 'A' + 10;
-	return ~0;
-}
+static const unsigned char hexval[] = {
+	  0,   1,   2,   3,    4,   5,   6,   7, /* 30-37 */
+	  8,   9, 255, 255,  255, 255, 255, 255, /* 38-3F */
+	255,  10,  11,  12,   13,  14,  15, 255, /* 40-47 */
+	255, 255, 255, 255,  255, 255, 255, 255, /* 48-4F */
+	255, 255, 255, 255,  255, 255, 255, 255, /* 50-57 */
+	255, 255, 255, 255,  255, 255, 255, 255, /* 58-5F */
+	255,  10,  11,  12,   13,  14,  15, 255, /* 60-67 */
+};
 
 int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
 	for (i = 0; i < 20; i++) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-		if (val & ~0xff)
+		unsigned int v, w, val;
+		v = *hex++;
+		if ((v < '0') || ('f' < v) ||
+		    ((v = hexval[v-'0']) == 255))
+			return -1;
+		w = *hex++;
+		if ((w < '0') || ('f' < w) ||
+		    ((w = hexval[w-'0']) == 255))
 			return -1;
-		*sha1++ = val;
-		hex += 2;
+		*sha1++ = (v << 4) | w;
 	}
 	return 0;
 }
