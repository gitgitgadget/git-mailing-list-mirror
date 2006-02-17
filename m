From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/5] Optionally support old diffs
Date: Fri, 17 Feb 2006 15:23:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602171522560.24274@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Feb 17 15:23:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA6W6-0000Hw-74
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 15:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWBQOXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 09:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWBQOXS
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 09:23:18 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12950 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751435AbWBQOXR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 09:23:17 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 61EE5146B99; Fri, 17 Feb 2006 15:23:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 55B5399F;
	Fri, 17 Feb 2006 15:23:16 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3283E146B99; Fri, 17 Feb 2006 15:23:16 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16347>


Some versions of diff do not correctly detect a missing new-line at the end
of the file under certain circumstances.

When defining NO_ACCURATE_DIFF, work around this bug.

Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    6 ++++++
 apply.c  |    8 ++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

46183bd251ffe3fc3cbbf4d94467627f922d6d43
diff --git a/Makefile b/Makefile
index b3401ac..6e00737 100644
--- a/Makefile
+++ b/Makefile
@@ -55,6 +55,9 @@ all:
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 #
+# Define NO_ACCURATE_DIFF if your diff program at least sometimes misses
+# a missing newline at the end of the file.
+#
 # Define COLLISION_CHECK below if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # sufficient guarantee that no collisions between objects will ever happen.
@@ -405,6 +408,9 @@ else
 	LIBS += $(LIB_4_CRYPTO)
 endif
 endif
+endif
+ifdef NO_ACCURATE_DIFF
+	ALL_CFLAGS += -DNO_ACCURATE_DIFF
 endif
 
 # Shell quote (do not use $(call) to accomodate ancient setups);
diff --git a/apply.c b/apply.c
index 2ad47fb..1083d4f 100644
--- a/apply.c
+++ b/apply.c
@@ -1142,6 +1142,14 @@ static int apply_one_fragment(struct buf
 		size -= len;
 	}
 
+#ifdef NO_ACCURATE_DIFF
+	if (oldsize > 0 && old[oldsize - 1] == '\n' &&
+			newsize > 0 && new[newsize - 1] == '\n') {
+		oldsize--;
+		newsize--;
+	}
+#endif
+			
 	offset = find_offset(buf, desc->size, old, oldsize, frag->newpos);
 	if (offset >= 0) {
 		int diff = newsize - oldsize;
-- 
1.2.1.g09fe-dirty
