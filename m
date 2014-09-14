From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 1/2] Makefile: add check-headers target
Date: Sat, 13 Sep 2014 18:00:49 -0700
Message-ID: <1410656450-96087-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 03:01:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSyBd-0007PW-7m
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 03:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbaINBBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 21:01:00 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64061 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaINBA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 21:00:59 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so3881468pdj.10
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 18:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6wHhvPQu9QaE2OAEz4qvJJsCwN/Sc0l8WvW1Anoi84w=;
        b=NvTGPjNICM1WZQGuLyy8lw9/8HLZ1QLh/yOUmhoHbqVIekBvXmjXBP+RU4VTFrIBaK
         sUdTH1YvwrycnPzzN85GuN1LyFDrU31VQrv0mqdBL5z644NEIFUy/EKddy7hZgfMmE3v
         bfEf94mQRE8CTPCUpSNNx0MkXOk1UMAkHyklzGbLTC1l/+GMzGf/73eO8auy3QtjaSze
         tsvPM47xSXvqmpbA9eT0ZzMgdcTShADvaP4pf/uUe/OARGgyzT9EdrLPTSpf4Va1JZFd
         m0pTRs56R1a1j3LXNzxMmHb8CWk2gu6+n3LW1FIZtnPEYC1gTjm0svyXFMvMwL7XgjGm
         yTEQ==
X-Received: by 10.68.213.6 with SMTP id no6mr26577027pbc.53.1410656459163;
        Sat, 13 Sep 2014 18:00:59 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dg5sm7898741pac.12.2014.09.13.18.00.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 18:00:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.240.gb601169
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256987>

This allows us to ensure that each header can be included
individually without needing to include other headers first.

Implicitly include git-compat-util.h during the check since
the implementation files will have already included it.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since last time:

We now automatically include git-compat-util.h during the check
per the CodingGuidelines rule to always include it in all .c files.

We now use a case statement to special-case common-cmds.h, which
allows us to replace usage of git ls-files and a pipe with a simpler
for header in ... loop.

 Makefile         |  6 ++++++
 check-headers.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100755 check-headers.sh

diff --git a/Makefile b/Makefile
index e0f15a3..d7c9225 100644
--- a/Makefile
+++ b/Makefile
@@ -2408,6 +2408,12 @@ check-docs::
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
index 0000000..ef06f56
--- /dev/null
+++ b/check-headers.sh
@@ -0,0 +1,34 @@
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
+for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
+do
+	case "$header" in
+	common-cmds.h)
+		# should only be included by help.c
+		;;
+	*)
+		subdir=$(dirname "$header") &&
+		echo "HEADER $header" &&
+		"$@" -Wno-unused -I"$subdir" -include git-compat-util.h \
+			-c -o "$header".check -x c - <"$header" &&
+		rm "$header".check ||
+		maybe_exit $?
+		;;
+	esac
+done
+
+exit $exit_code
-- 
2.0.4.1.g929bde9
