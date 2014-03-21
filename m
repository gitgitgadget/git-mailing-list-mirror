From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 10/28] Run test_failed if the exit status of a test script is bad.
Date: Fri, 21 Mar 2014 08:31:48 +0100
Message-ID: <1395387126-13681-11-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQty9-0003NI-9b
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759804AbaCUHda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:30 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34888 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbaCUHdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:15 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so1372037lbi.36
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xR3hR6vkW4/2r5zgWoWf/FQ7d42awtsJuxmTNH/MQws=;
        b=PkZBxC4Sj+whimPvvPQsmASUUXeZzw1lMUvLZMmPZIvI3mXextkUJanrWYHgMcOKq2
         UTo+EQdKFx4t3GX1jZXuxlaDTGeyR2vzoafIBlOwAOX3oCektwl9kfk7TVcXKvasL9Ks
         px9ali2qPVW+we5py/kOQVA/L4XSMKDHUs547Ot+3b3HRohvSXfHmNG+iLgiu2uWa6rz
         YTSuaYwmIMH8yluWpsNodu2XaB276AZeHysF172t5azGlHE04HkyrUHWr5bCKdY+uJp2
         G+/Breyae5/O3yvod4Q/jhQqhXg6KD/oCChrvRLaGrXW7EdTKhingaEReikrJV6qaNN+
         e2Wg==
X-Gm-Message-State: ALoCoQku3zTFENSarnlkg1KyCxmxJw+wLxGAvPHasmLa/3BEjb6xE1SCOyJwx7oQwUMupzmDh95z
X-Received: by 10.152.115.178 with SMTP id jp18mr32793471lab.23.1395387194396;
        Fri, 21 Mar 2014 00:33:14 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244662>

There were two problems with the old code:

 - Since "set -e" is in effect (that is set in scaffold) the run-test
   script exited immediately if a t-*.sh script failed.  This is not
   nice, as we want the error report that test_failed prints.

 - The code ran "cd -" between running the t-*.sh script and checking
   the exit status, so the exit status was lost.  (Actually, the exit
   status was saved in $ERR, but nothing ever looked at $ERR.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/run-tests | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/regression/run-tests b/regression/run-tests
index a10e796..d39f9ef 100755
--- a/regression/run-tests
+++ b/regression/run-tests
@@ -55,11 +55,16 @@ function run_test
 
 	# run the test
 	cd "$REPODIR" > /dev/null
-	"$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"
-	ERR=$?
+	if "$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"
+	then
+	    ERR=false
+	else
+	    ERR=true
+	fi
+
 	cd - > /dev/null
 
-	[ $? -ne 0 ] && test_failed
+	$ERR && test_failed
 	diff -u "t-$1.out" "$LOGFILE" || test_failed
 
 	echo "done."
-- 
1.8.3.1
