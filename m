From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 16:32:55 -0400
Message-ID: <201307182032.r6IKWtWC016218@freeze.ariadne.com>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
	<878v16kfqy.fsf@linux-k42r.v.cablecom.net>
	<7v38rd6l3j.fsf@alter.siamese.dyndns.org> <51E7E05E.4000201@gmail.com> <7v4nbr4v7m.fsf@alter.siamese.dyndns.org>
Cc: n1xim.email@gmail.com, trast@inf.ethz.ch, git@vger.kernel.org,
	fonseca@diku.dk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:33:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzuss-0006Wi-WF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759262Ab3GRUdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:33:02 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:44641
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754929Ab3GRUdA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 16:33:00 -0400
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id 1uZb1m0030cZkys53wYz7F; Thu, 18 Jul 2013 20:32:59 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id 1wYz1m0031KKtkw3WwYzbf; Thu, 18 Jul 2013 20:32:59 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r6IKWvxl016219;
	Thu, 18 Jul 2013 16:32:57 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r6IKWtWC016218;
	Thu, 18 Jul 2013 16:32:55 -0400
In-reply-to: <7v4nbr4v7m.fsf@alter.siamese.dyndns.org> (gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1374179579;
	bh=hzgpodUOPUlCaCpvDFlucIbbGbQp+d8bTCCHjlKC+3g=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=rbkNOdJoUjzoCrgRoLO6B7rqS3X3DZ28oEFlopM+KIl3ea5oYxvBFkTa2+nN3znWi
	 XHgLJIPunRJCbhurSinucF9gTGR4tLjejjPsq0ZhQ4ObQhZ871z/W4OgtqTdn6QCfG
	 TGmCiQzZvE7oAJwwS6wkLwYMYMwZMGuPdquoPXXQowy3uA6qT0aMeTKqTp3T6Km4GR
	 kHPLuBfEhxzzcmA8FlOxjCUEdpmIPqbOD7veObnQCG0y9p5GXRJGUzMsaIEgeAzQ6n
	 nnUr0di9RIrERpy4T+RJ/SIEMQ0/99UNnXU4/T8WIAthY7dJs6x4CUr2Ny9uzL6PPz
	 Ziw/aeNcIpfyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230740>

I've been looking into writing a proper test for this patch.  My first
attempt tests the symptom that was seen initially, that "git commit"
fails if fd 0 is closed.

One problem is how to arrange for fd 0 to be closed.  I could use the
bash redirection "<&-", but I think you want to be more portable than
that.  This version uses execvp() inside a small C program, and
execvp() is a Posix function.

I've tested that this test does what it should:  If you remove the
fix, "fd >= 0", the test fails.  If you then remove "test-close-fd-0"
from before "git init" in the test, the test is nullified and succeeds
again.

Here is the diff.  What do people think of it?

diff --git a/Makefile b/Makefile
index 0600eb4..6b410f5 100644
--- a/Makefile
+++ b/Makefile
@@ -557,6 +557,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-close-fd-0
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 986b2a8..6a31103 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -25,6 +25,13 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
 	grep "cannotwrite/test" err
 '
 
+test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
+	git init &&
+	echo Test. >test-file &&
+	git add test-file &&
+	test-close-fd-0 git commit -m Message.
+'
+
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
 	test-regex
diff --git a/test-close-fd-0.c b/test-close-fd-0.c
new file mode 100644
index 0000000..3745c34
--- /dev/null
+++ b/test-close-fd-0.c
@@ -0,0 +1,14 @@
+#include <unistd.h>
+
+/* Close file descriptor 0 (which is standard-input), then execute the
+ * remainder of the command line as a command. */
+
+int main(int argc, char **argv)
+{
+	/* Close fd 0. */
+	close(0);
+	/* Execute the requested command. */
+	execvp(argv[1], &argv[1]);
+	/* If execve() failed, return an error. */
+	return 1;
+}
diff --git a/wrapper.c b/wrapper.c
index dd7ecbb..6a015de 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 		template[5] = letters[v % num_letters]; v /= num_letters;
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
-		if (fd > 0)
+		if (fd >= 0)
 			return fd;
 		/*
 		 * Fatal error (EPERM, ENOSPC etc).

Dale
