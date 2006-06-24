From: Junio C Hamano <junkio@cox.net>
Subject: From b65bc21e7d8dc8cafc70dfa6354cb66b8874b2d9 Mon Sep 17 00:00:00 2001
Date: Sat, 24 Jun 2006 00:59:49 -0700
Message-ID: <7v3bdv0xyd.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Jun 24 10:17:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu3Kl-0003h2-SK
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 10:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWFXIRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 04:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933305AbWFXIRe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 04:17:34 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35745 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S933267AbWFXIRb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 04:17:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624081731.POV554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 04:17:31 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [PATCH] Makefile: add framework to verify and bench sha1 implementations.
In-Reply-To: <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 24 Jun 2006 00:03:00 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22491>

With this, you can say

	MOZILLA_SHA1=YesPlease make check-sha1 

to see how fast your favorite SHA-1 implementation is and if it
fails with small to huge inputs.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * As the maintainer, I do need people to see breakage before it
   happens, without having access to all the platforms, hence
   this.

 Makefile     |    6 ++++
 test-sha1.c  |   24 +++++++++++++++++
 test-sha1.sh |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index e29e3fa..ea0044d 100644
--- a/Makefile
+++ b/Makefile
@@ -636,6 +636,12 @@ test-delta$X: test-delta.c diff-delta.o 
 test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
+test-sha1$X: test-sha1.o $(GITLIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+
+check-sha1:: test-sha1$X
+	./test-sha1.sh
+
 check:
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
diff --git a/test-sha1.c b/test-sha1.c
new file mode 100644
index 0000000..2efc315
--- /dev/null
+++ b/test-sha1.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+
+int main(int ac, char **av)
+{
+	SHA_CTX ctx;
+	unsigned char sha1[20];
+
+	SHA1_Init(&ctx);
+
+	while (1) {
+		ssize_t sz;
+		char buffer[8192];
+		sz = xread(0, buffer, sizeof(buffer));
+		if (sz == 0)
+			break;
+		if (sz < 0)
+			die("test-sha1: %s", strerror(errno));
+		SHA1_Update(&ctx, buffer, sz);
+	}
+	SHA1_Final(sha1, &ctx);
+	puts(sha1_to_hex(sha1));
+	exit(0);
+}
+
diff --git a/test-sha1.sh b/test-sha1.sh
new file mode 100755
index 0000000..01bbb57
--- /dev/null
+++ b/test-sha1.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
+/usr/bin/time ./test-sha1 >/dev/null
+
+while read expect cnt pfx
+do
+	case "$expect" in '#'*) continue ;; esac
+	actual=`
+		{
+			test -z "$pfx" || echo "$pfx"
+			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
+			tr '[\0]' '[g]'
+		} | ./test-sha1
+	`
+	if test "$expect" = "$actual"
+	then
+		echo "OK: $expect $cnt $pfx"
+	else
+		echo >&2 "OOPS: $cnt"
+		echo >&2 "expect: $expect"
+		echo >&2 "actual: $actual"
+		exit 1
+	fi
+done <<EOF
+da39a3ee5e6b4b0d3255bfef95601890afd80709 0
+3f786850e387550fdab836ed7e6dc881de23001b 0 a
+5277cbb45a15902137d332d97e89cf8136545485 0 ab
+03cfd743661f07975fa2f1220c5194cbaff48451 0 abc
+3330b4373640f9e4604991e73c7e86bfd8da2dc3 0 abcd
+ec11312386ad561674f724b8cca7cf1796e26d1d 0 abcde
+bdc37c074ec4ee6050d68bc133c6b912f36474df 0 abcdef
+69bca99b923859f2dc486b55b87f49689b7358c7 0 abcdefg
+e414af7161c9554089f4106d6f1797ef14a73666 0 abcdefgh
+0707f2970043f9f7c22029482db27733deaec029 0 abcdefghi
+a4dd8aa74a5636728fe52451636e2e17726033aa 1
+9986b45e2f4d7086372533bb6953a8652fa3644a 1 frotz
+23d8d4f788e8526b4877548a32577543cbaaf51f 10
+8cd23f822ab44c7f481b8c92d591f6d1fcad431c 10 frotz
+f3b5604a4e604899c1233edb3bf1cc0ede4d8c32 512
+b095bd837a371593048136e429e9ac4b476e1bb3 512 frotz
+08fa81d6190948de5ccca3966340cc48c10cceac 1200 xyzzy
+e33a291f42c30a159733dd98b8b3e4ff34158ca0 4090 4G
+#a3bf783bc20caa958f6cb24dd140a7b21984838d 9999 nitfol
+EOF
+
+exit
+
+# generating test vectors
+# inputs are number of megabytes followed by some random string to prefix.
+
+while read cnt pfx
+do
+	actual=`
+		{
+			test -z "$pfx" || echo "$pfx"
+			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
+			tr '[\0]' '[g]'
+		} | sha1sum |
+		sed -e 's/ .*//'
+	`
+	echo "$actual $cnt $pfx"
+done <<EOF
+0
+0 a
+0 ab
+0 abc
+0 abcd
+0 abcde
+0 abcdef
+0 abcdefg
+0 abcdefgh
+0 abcdefghi
+1
+1 frotz
+10
+10 frotz
+512
+512 frotz
+1200 xyzzy
+4090 4G
+9999 nitfol
+EOF
-- 
1.4.1.rc1.g0fca
