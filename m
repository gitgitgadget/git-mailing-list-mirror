From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] check-headers: add header usage checks for .c files
Date: Sun, 14 Sep 2014 00:40:44 -0700
Message-ID: <1410680445-84593-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 09:41:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT4Qf-000153-Pm
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 09:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbaINHk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 03:40:57 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43923 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbaINHk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 03:40:57 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so4381656pab.40
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hPylhs5JEpgXY0tQjCR8YkGGqku3Iy7HweVmm2b+SFI=;
        b=xtyil65eyUdTSBRjCNJGjU0dmHTqdTmbdlabLpj+bkS9pWKePY8CL3sVnGUPO8VrVg
         jcBgHzyrD7S6mj6ZbbSewzLyWDsK/6jAa0VrrefIT+c8dvbqMgUHTK3ps1RnCSMyUK8C
         d9fod/kfelyPVDXv+OFTQR5ziaU6b+xzZIiyTPv3MQbalWN70XZeFdid4wF55bR6l+8L
         s3sfj7DS+641JdZ2DhtmeTRJwhSiuw8Jz1HBDK41Na3rT1f3ydQnNzP++7ihRx0ucs7x
         K1kHgKsp3qRNjKC94/zZL9eAUUUOfFXppJk4hcI6ZxHqvsBiCyT2idOQBnQkD5hWgfpX
         K+nA==
X-Received: by 10.67.23.136 with SMTP id ia8mr1709866pad.125.1410680456654;
        Sun, 14 Sep 2014 00:40:56 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dl8sm8157177pdb.65.2014.09.14.00.40.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 00:40:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.241.ga16d620
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256999>

Teach check-header.sh to ensure that the first included header in .c
files is either git-compat-util.h, builtin.h, or cache.h.

Ensure that common-cmds.h is only included by help.c.

Move the logic into functions so that we can skip parts of the check.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This depends on my previous patch that adds check-header.sh.

 check-headers.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/check-headers.sh b/check-headers.sh
index ef06f56..7f25e7a 100755
--- a/check-headers.sh
+++ b/check-headers.sh
@@ -1,5 +1,9 @@
 #!/bin/sh
 
+# This script is run via make.
+# "make check-headers SKIP_HEADER_CHECK=1" skips the header dependency check.
+# "make check-headers SKIP_USAGE_CHECK=1" skips the header usage check.
+
 exit_code=0
 
 maybe_exit () {
@@ -14,11 +18,11 @@ maybe_exit () {
 	fi
 }
 
-for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
-do
+check_header () {
+	header="$1"
 	case "$header" in
 	common-cmds.h)
-		# should only be included by help.c
+		# should only be included by help.c, not checked
 		;;
 	*)
 		subdir=$(dirname "$header") &&
@@ -29,6 +33,58 @@ do
 		maybe_exit $?
 		;;
 	esac
-done
+}
+
+check_headers () {
+	for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
+	do
+		check_header "$header"
+	done
+}
+
+check_header_usage () {
+	first=$(grep '^#include' "$1" |
+		head -n1 |
+		sed -e 's,#include ",,' -e 's,"$,,')
+
+	case "$first" in
+	cache.h|builtin.h|git-compat-util.h)
+		# happy
+		;;
+	*)
+		echo "error: $1 must #include \"git-compat-util.h\" before $first"
+		maybe_exit 1
+		;;
+	esac
+
+	if grep common-cmds.h "$1" >/dev/null && test "$1" != help.c
+	then
+		echo "error: $1 must not include common-cmds.h"
+		maybe_exit 1
+	fi
+}
+
+check_usage () {
+	# Implementation files should #include git-compat-util.h, cache.h,
+	# or builtin.h before any others.
+	for impl in *.c builtin/*.c
+	do
+		check_header_usage "$impl"
+	done
+}
+
+main () {
+	if test -z "$SKIP_HEADER_CHECK"
+	then
+		check_headers "$@"
+	fi
+
+	if test -z "$SKIP_USAGE_CHECK"
+	then
+		check_usage
+	fi
+
+	exit $exit_code
+}
 
-exit $exit_code
+main "$@"
-- 
2.1.0.241.ga16d620
