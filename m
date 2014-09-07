From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Sat,  6 Sep 2014 17:30:20 -0700
Message-ID: <1410049821-49861-1-git-send-email-davvid@gmail.com>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 02:30:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQQNL-0005AX-7d
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 02:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbaIGAaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 20:30:35 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63986 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaIGAae (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 20:30:34 -0400
Received: by mail-pa0-f41.google.com with SMTP id lf10so2751990pab.28
        for <git@vger.kernel.org>; Sat, 06 Sep 2014 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9feMsyNy5qZIwsZswtLVtTE5kFGPaulVNmz7o1VwooU=;
        b=mdhClEBhpoPNvy0UDxCQGfgueHLOCjxOYg82nGcd86k3QnG+K8f2qLHh/bigTchjU+
         Xn/OjjHkuB65Q+TgIvOpcKVXCryp9HBB7khdbKd2bbdbRL/NCgJZYfCNMW7j4gjjtGRN
         gcuD67tYbRs0zH79CVDjwKbD6KE34mkSUaFf7yuFdCSqzmhCfbm908kDMe9+68ULfCnS
         CggetXHL9iBSdVXlaN+1Sy9m0lXsBOOfwlHKOkfL3xHGGi6ozxtBZxUVCUhDb4InnJT0
         xNNiJNMluMw6Vvvn32U5aOWXuAT90XQlErpdkcTcmPP95JMhHk+vXdWvUyjvhG84nk30
         Xu4A==
X-Received: by 10.70.48.97 with SMTP id k1mr6230213pdn.135.1410049833858;
        Sat, 06 Sep 2014 17:30:33 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id z3sm5196150pbt.84.2014.09.06.17.30.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Sep 2014 17:30:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.62.g3e88d26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256608>

This allows us to ensure that each header can be included
individually without needing to include other headers first.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v1:
We now include xdiff, ewah, and vcs-svn headers.

 Makefile         |  6 ++++++
 check-headers.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100755 check-headers.sh

diff --git a/Makefile b/Makefile
index 30cc622..39ecc70 100644
--- a/Makefile
+++ b/Makefile
@@ -2591,6 +2591,12 @@ check-docs::
 check-builtins::
 	./check-builtins.sh
 
+### Make sure headers include their dependencies
+#
+check-headers::
+	./check-headers.sh $(CC) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS)
+
+
 ### Test suite coverage testing
 #
 .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
diff --git a/check-headers.sh b/check-headers.sh
new file mode 100755
index 0000000..2722dd2
--- /dev/null
+++ b/check-headers.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+exit_code=0
+
+maybe_exit () {
+	status="$1"
+	if test "$status" != 0
+	then
+		exit_code="$status"
+		if test -n "$CHECK_HEADERS_STOP"
+		then
+			exit "$status"
+		fi
+	fi
+}
+
+IFS='
+'
+git ls-files *.h ewah/*.h vcs-svn/*.h xdiff/*.h |
+while read header
+do
+	subdir=$(dirname "$header") &&
+	echo "HEADER $header" &&
+	"$@" -Wno-unused -I"$subdir" -c -o "$header".check -x c - <"$header" &&
+	rm "$header".check ||
+	maybe_exit $?
+done
+
+exit $exit_code
-- 
2.1.0.62.g3e88d26
