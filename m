From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 10/31] Run test_failed if the exit status of a test script is bad.
Date: Fri, 16 May 2014 16:45:57 +0200
Message-ID: <1400251578-17221-11-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJSt-0004SE-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbaEPOuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:50:19 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:39705 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188AbaEPOuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:50:15 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so2047097lab.15
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndG5UYT4cBLqk69lTgHgwq6PghVtrtQ8fAcRW8TsN6A=;
        b=Ue9XBbANMnedvAZ7GCY6rz5hoEyN404t2J1S0py3vsmevYoFcyRXOHjJ2OUgsW+MZC
         5NpfE0p/Bzc3//L863JOs+mBDGiuqDYEM1TU7F2i66wMRq125pKPQZx6r8Q4ZGKXVngc
         V9dbElwF5BropNKAPcAbjoc82PDT/xybnkQRvqJtoSSwfC+Qljst83pDzb5f1rKwBltl
         JG0wYgfgP3jrZD+FP/cgfu3zGYUSoQ859ZnRLPdsf4KCwmk9jdmpymFDEINpRg6Uvgmj
         7M66LCuDFYn4//Cz1vkkGNBCwpMbaSBEMjOrenz015NCpbzpGlwLlGvIeFmRg+ddzGMn
         GBEQ==
X-Gm-Message-State: ALoCoQmZkV8i6Dpj9bbOngO9JaDpRT5MzJ0PH8Rrs6rMv/PYYA0tm8ddgqQ1omFzxIMkg5Mx0awQ
X-Received: by 10.152.37.37 with SMTP id v5mr75642laj.90.1400251814239;
        Fri, 16 May 2014 07:50:14 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.50.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:50:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249318>

There were two problems with the old code:

 - Since "set -e" is in effect (that is set in scaffold) the run-test
   script exited immediately if a t-*.sh script failed.  This is not
   nice, as we want the error report that test_failed prints.

 - The code ran "cd -" between running the t-*.sh script and checking
   the exit status, so the exit status was lost.  (Actually, the exit
   status was saved in $ERR, but nothing ever looked at $ERR.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/run-tests | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/regression/run-tests b/regression/run-tests
index a10e796..8e0af9f 100755
--- a/regression/run-tests
+++ b/regression/run-tests
@@ -55,11 +55,15 @@ function run_test
 
 	# run the test
 	cd "$REPODIR" > /dev/null
-	"$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"
-	ERR=$?
+	if "$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"; then
+		ERR=false
+	else
+		ERR=true
+	fi
+
 	cd - > /dev/null
 
-	[ $? -ne 0 ] && test_failed
+	$ERR && test_failed
 	diff -u "t-$1.out" "$LOGFILE" || test_failed
 
 	echo "done."
-- 
1.8.3.1
