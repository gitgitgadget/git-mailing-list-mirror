From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 10/29] Run test_failed if the exit status of a test script is bad.
Date: Tue, 13 May 2014 22:30:46 +0200
Message-ID: <1400013065-27919-11-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJQP-0004n2-02
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151AbaEMUfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:35:22 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:64584 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaEMUfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:35:17 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so723719lan.28
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=scDdJhwo1TN/TmV+6arU07pJLMLtgHL65y585o8jJk0=;
        b=eqWKQ3V1r/ghaZgiVuQbcQitGrdyH2bE5YYPD98wVh16bZRJvv+3eKIqTAeX+RKhsb
         ocjWnb0r0J+8PtkmIHoS48Odp8X/Wmz7EKQZV477HfkfUCKPfU07L2fGFcwOw8CZ9m/J
         qLTsCRhjBBIvhz57v84UONWfgeqZutkqwOa9HXOsejp4CeWyT6JAcwVVdbwcLWq/I3kR
         ns2BMS7kW4MYDZ68Qy8AbN55kCrQXzVuJFa/XsqqVmetrNu3JWg6GmonxVNAqL5jNXxP
         1l7H2WvZzsyDdyaMwsLSLPgmSs9hTU7KapotAnV8ndYkf6Bx/QA5+7tSnJTiDASzh9Jl
         Bw1A==
X-Gm-Message-State: ALoCoQlkTWq9oeZ9M1iI4Oz/wgjpST4N0lK35NzUshLrAoswalzp3KpnxZqy59RislPlA5xR3TUz
X-Received: by 10.112.139.166 with SMTP id qz6mr30068768lbb.13.1400013288777;
        Tue, 13 May 2014 13:34:48 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.34.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:34:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248828>

There were two problems with the old code:

 - Since "set -e" is in effect (that is set in scaffold) the run-test
   script exited immediately if a t-*.sh script failed.  This is not
   nice, as we want the error report that test_failed prints.

 - The code ran "cd -" between running the t-*.sh script and checking
   the exit status, so the exit status was lost.  (Actually, the exit
   status was saved in $ERR, but nothing ever looked at $ERR.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
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
