From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 1/2] Makefile: add check-headers target
Date: Sat,  6 Sep 2014 12:20:10 -0700
Message-ID: <1410031211-14599-1-git-send-email-davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 21:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQLXF-0007qd-3v
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 21:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbaIFTU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 15:20:29 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49627 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaIFTU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 15:20:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id p10so1234611pdj.30
        for <git@vger.kernel.org>; Sat, 06 Sep 2014 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=Klcpr0THmdvMI2lvn4cDrRDmkDXA6nopxC/l8+syTPY=;
        b=PihnPPQRQrefAdJKmByuNLOMoiveQhi2ApjiEUVqGYKinFomob9ctMejqJP+J8kHyP
         E4ffVcCbrAeAiQC+ksL1+ONmP79yIfJQ6RisXteAtcgas2D/vgUi0hTkCgJ7Q/1Rtaei
         8+uA3NAGY7uINR1ZgspPxKcbtxvQ2R8B0it26BnF2dEjvMGvqjYlkkuHi4YVu8M+XoM6
         FbP2uQ1CSAaDwf5vYljosFZ9W/KnwMie83MN46MJqgDhhB0wPmgoGYEF/Eee4/xfOS9X
         OOEOFpqbJsqHCucOFdaWolt0IBDIHEphrc9EKwwhZ+HZ2MPArZNaUOAOYwQr/0CFMpQA
         8gjg==
X-Received: by 10.66.183.235 with SMTP id ep11mr28743488pac.113.1410031227870;
        Sat, 06 Sep 2014 12:20:27 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id h4sm5267241pat.11.2014.09.06.12.20.25
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Sep 2014 12:20:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.62.g5fbb67f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256599>

This allows us to ensure that each header can be included
individually without needing to include other headers first.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch demonstrates how to verify PATCH 2/2.

 Makefile         |  6 ++++++
 check-headers.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100755 check-headers.sh

diff --git a/Makefile b/Makefile
index 30cc622..bc54024 100644
--- a/Makefile
+++ b/Makefile
@@ -2591,6 +2591,12 @@ check-docs::
 check-builtins::
 	./check-builtins.sh
 
+### Make sure headers include their dependencies
+#
+check-headers::
+	./check-headers.sh $(CC) $(ALL_CFLAGS)
+
+
 ### Test suite coverage testing
 #
 .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
diff --git a/check-headers.sh b/check-headers.sh
new file mode 100755
index 0000000..bf85c41
--- /dev/null
+++ b/check-headers.sh
@@ -0,0 +1,26 @@
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
+git ls-files *.h |
+while read header
+do
+	echo "HEADER $header" &&
+	"$@" -Wno-unused -x c -c -o "$header".bin - <"$header" &&
+	rm "$header".bin ||
+	maybe_exit $?
+done
+
+exit $exit_code
-- 
2.1.0.62.g7dc6c49
