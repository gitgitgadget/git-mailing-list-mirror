From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add deltifier test.
Date: Mon, 12 Dec 2005 12:41:36 -0800
Message-ID: <7v4q5ehwu7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 12 21:43:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EluUa-0000pv-Eh
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 21:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVLLUli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 15:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLLUli
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 15:41:38 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48532 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751201AbVLLUlh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 15:41:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212204101.BJCG3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 15:41:01 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13537>

This test kicks in only if you built test-delta executable, and
makes sure that the basic delta routine is working properly even
on empty files.

This commit is to make sure we have a test to catch the
breakage.  The delitifier code is still broken, which will be
fixed with the next commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is a more general reproduction recipe for the problem
   Darrin Thompson reported.  We did not produce delta from or
   to an empty blob.

 t/t0001-delta.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 test-delta.c     |   11 +++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100755 t/t0001-delta.sh

9cfcbd609c42c08de54733e610846dc6dfd22495
diff --git a/t/t0001-delta.sh b/t/t0001-delta.sh
new file mode 100755
index 0000000..2dd88e5
--- /dev/null
+++ b/t/t0001-delta.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='Deltification regression test'
+
+../test-delta 2>/dev/null
+test $? == 127 && {
+	echo "* Skipping test-delta regression test."
+	exit 0
+}
+
+. ./test-lib.sh
+
+>empty
+echo small >small
+echo smallish >smallish
+cat ../../COPYING >large
+sed -e 's/GNU/G.N.U/g' large >largish
+
+test_expect_success 'No regression in deltify code' \
+'
+fail=0
+for src in empty small smallish large largish
+do
+    for dst in empty small smallish large largish
+    do
+	if  test-delta -d $src $dst delta-$src-$dst &&
+	    test-delta -p $src delta-$src-$dst out-$src-$dst &&
+	    cmp $dst out-$src-$dst
+	then
+	    echo "* OK ($src->$dst deitify and apply)"
+	else
+	    echo "* FAIL ($src->$dst deitify and apply)"
+	    fail=1
+	fi
+    done
+done
+case "$fail" in
+0) (exit 0) ;;
+*) (exit $fail) ;;
+esac
+'
+
+test_done
diff --git a/test-delta.c b/test-delta.c
index 1be8ee0..cc05794 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -38,7 +38,10 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 	from_size = st.st_size;
-	from_buf = mmap(NULL, from_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (from_size)
+		from_buf = mmap(NULL, from_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	else
+		from_buf = "";
 	if (from_buf == MAP_FAILED) {
 		perror(argv[2]);
 		close(fd);
@@ -52,7 +55,11 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 	data_size = st.st_size;
-	data_buf = mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	if (data_size)
+		data_buf = mmap(NULL, data_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	else
+		data_buf = "";
 	if (data_buf == MAP_FAILED) {
 		perror(argv[3]);
 		close(fd);
-- 
0.99.9.GIT
