From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 08/16] vcs-svn: read the preimage when applying deltas
Date: Sat, 19 Mar 2011 18:20:46 +1100
Message-ID: <1300519254-20201-9-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTz-0007ZM-L7
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510Ab1CSHVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:51 -0400
Received: from [119.15.97.146] ([119.15.97.146]:53706 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754013Ab1CSHV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 695A5C04C;
	Sat, 19 Mar 2011 18:17:52 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7KuTUeyd2x2; Sat, 19 Mar 2011 18:17:46 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 07DA0C054;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169405>

From: Jonathan Nieder <jrnieder@gmail.com>

The source view offset heading each svndiff0 window represents a
number of bytes past the beginning of the preimage.  Together with the
source view length, it dictates to the delta applier what portion of
the preimage instructions will refer to.  Read that portion right away
using the sliding window code.

Maybe some day we will use mmap to read data more lazily.

Subversion's implementation tolerates source view offsets pointing
past the end of the preimage file but we do not, for simplicity.

This does not teach the delta applier to read instructions or copy
data from the source view.  Deltas that could produce nonempty output
will still be rejected.

Improved-by: Ramkumar Ramachandra <artagnon@gmail.com>
Improved-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |   35 +++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.c |    6 ++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 2ab580a..986dce6 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -88,4 +88,39 @@ test_expect_success 'nonempty (but unused) preimage view' '
 	test_cmp empty actual
 '
 
+test_expect_success 'preimage view: right endpoint cannot backtrack' '
+	printf "SVNQ%b%b" "Q\003QQQ" "Q\002QQQ" |
+		q_to_nul >clear.backtrack &&
+	test_must_fail test-svn-fe -d preimage clear.backtrack 14
+'
+
+test_expect_success 'preimage view: left endpoint can advance' '
+	printf "SVNQ%b%b" "Q\003QQQ" "\001\002QQQ" |
+		q_to_nul >clear.preshrink &&
+	printf "SVNQ%b%b" "Q\003QQQ" "\001\001QQQ" |
+		q_to_nul >clear.shrinkbacktrack &&
+	test-svn-fe -d preimage clear.preshrink 14 >actual &&
+	test_must_fail test-svn-fe -d preimage clear.shrinkbacktrack 14 &&
+	test_cmp empty actual
+'
+
+test_expect_success 'preimage view: offsets compared by value' '
+	printf "SVNQ%b%b" "\001\001QQQ" "\0200Q\003QQQ" |
+		q_to_nul >clear.noisybacktrack &&
+	printf "SVNQ%b%b" "\001\001QQQ" "\0200\001\002QQQ" |
+		q_to_nul >clear.noisyadvance &&
+	test_must_fail test-svn-fe -d preimage clear.noisybacktrack 15
+	test-svn-fe -d preimage clear.noisyadvance 15 &&
+	test_cmp empty actual
+'
+
+test_expect_success 'preimage view: reject truncated preimage' '
+	printf "SVNQ%b" "\010QQQQ" | q_to_nul >clear.lateemptyread &&
+	printf "SVNQ%b" "\010\001QQQ" | q_to_nul >clear.latenonemptyread &&
+	printf "SVNQ%b" "\001\010QQQ" | q_to_nul >clear.longread &&
+	test_must_fail test-svn-fe -d preimage clear.lateemptyread 9 &&
+	test_must_fail test-svn-fe -d preimage clear.latenonemptyread 9 &&
+	test_must_fail test-svn-fe -d preimage clear.longread 9
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 249efb6..1020275 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -4,6 +4,7 @@
  */
 
 #include "git-compat-util.h"
+#include "sliding_window.h"
 #include "line_buffer.h"
 #include "svndiff.h"
 
@@ -122,11 +123,12 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 	if (read_magic(delta, &delta_len))
 		return -1;
 	while (delta_len) {	/* For each window: */
-		off_t pre_off;
-		size_t pre_len;
+		off_t pre_off = pre_off;
+		size_t pre_len = pre_len;
 
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
+		    move_window(preimage, pre_off, pre_len) ||
 		    apply_one_window(delta, &delta_len))
 			return -1;
 	}
-- 
1.7.3.2.846.gf4b062
