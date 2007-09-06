From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-apply: do not read past the end of buffer
Date: Wed, 05 Sep 2007 22:06:15 -0700
Message-ID: <7vmyw0e62g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 07:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9ZN-0007iD-Hh
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 07:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbXIFFGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 01:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbXIFFGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 01:06:16 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61137 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbXIFFGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 01:06:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070906050614.PQVQ20651.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 6 Sep 2007 01:06:14 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id kt6F1X0051gtr5g0000000; Thu, 06 Sep 2007 01:06:15 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57820>

When the preimage we are patching is shorter than what the patch
text expects, we tried to match the buffer contents at the
"original" line with the fragment in full, without checking we
have enough data to match in the preimage.  This caused the size
of a later memmove() to wrap around and attempt to scribble
almost the entire address space.  Not good.

The code that follows the part this patch touches tries to match
the fragment with line offsets.  Curiously, that code does not
have the problem --- it guards against reading past the end of
the preimage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is an ancient part of the code; I am somewhat surprised
   that nobody has ever reported it earlier.

 builtin-apply.c         |    3 +-
 t/t4123-apply-shrink.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletions(-)
 create mode 100755 t/t4123-apply-shrink.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index 25b1447..976ec77 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1514,7 +1514,8 @@ static int find_offset(const char *buf, unsigned long size, const char *fragment
 	}
 
 	/* Exact line number? */
-	if (!memcmp(buf + start, fragment, fragsize))
+	if ((start + fragsize <= size) &&
+	    !memcmp(buf + start, fragment, fragsize))
 		return start;
 
 	/*
diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
new file mode 100755
index 0000000..984157f
--- /dev/null
+++ b/t/t4123-apply-shrink.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='apply a patch that is larger than the preimage'
+
+. ./test-lib.sh
+
+cat >F  <<\EOF
+1
+2
+3
+4
+5
+6
+7
+8
+999999
+A
+B
+C
+D
+E
+F
+G
+H
+I
+J
+
+EOF
+
+test_expect_success setup '
+
+	git add F &&
+	mv F G &&
+	sed -e "s/1/11/" -e "s/999999/9/" -e "s/H/HH/" <G >F &&
+	git diff >patch &&
+	sed -e "/^\$/d" <G >F &&
+	git add F
+
+'
+
+test_expect_success 'apply should fail gracefully' '
+
+	if git apply --index patch
+	then
+		echo Oops, should not have succeeded
+		false
+	else
+		status=$?
+		echo "Status was $status"
+		if test -f .git/index.lock
+		then
+			echo Oops, should not have crashed
+			false
+		fi
+	fi
+'
+
+test_done
