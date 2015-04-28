From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: add failing tests for case-folding p4d
Date: Tue, 28 Apr 2015 10:08:01 +0100
Message-ID: <1430212081-16146-2-git-send-email-luke@diamand.org>
References: <1430212081-16146-1-git-send-email-luke@diamand.org>
Cc: Lex Spoon <lex@lexspoon.org>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 11:08:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn1VW-0000LT-0h
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 11:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbbD1JIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 05:08:42 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36645 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454AbbD1JIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 05:08:40 -0400
Received: by wizk4 with SMTP id k4so131674474wiz.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pbd6Ap1++2r9Mk1VBEt7R9zt10R67qu8oGERN0OHEw4=;
        b=hIKajZ8PP3k4fREgsaKC/0+Ju1ZVzBm431RNUt28t20Ie/HE8cEpZGrQPAKa7eyqnl
         t3tgx4P3egskfQUZS3/cFLxoJiEJI2S7tfyVf5JPsuQ/KREPD1Pu5BIcZRS9zEZmzGuG
         6UdCIJYzSa5arCDHdzoNgj+JKcO5zcXCxkw+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pbd6Ap1++2r9Mk1VBEt7R9zt10R67qu8oGERN0OHEw4=;
        b=KqZkOLTZ9QCWpUQbPUyrenAtu0JJ6vQ3Gu5/51YMOrwhXtg9on91SizemOqaBJuhii
         ju2QhAQbyRIWoh7fwEd9xoqdK9M4LGGCwALB0jkFJkCLn7jhoeKEoRit5GE/THxOCsJl
         YXY6l0NfanSFXsq6oEyQWFW8NsfDKT6y2WVEHzIgWkc30fv8oFtl7PnK/+7VOiw8g0wW
         RzBRSIOLSXA1hY8KFx3ZpaynPeQda/h/BLQY6Mgh0BsIA1UPZeiIcBUJ1fFnd9l8X0bu
         j+WVI9q/TUR44yFnpJLkho+Rb0ZyufRDmVvb4gTS/Dt/4XgD5hxLrU3nnUYf2K/LXb7z
         IC1A==
X-Gm-Message-State: ALoCoQmia+ygX2U1rMqLAKOT4eb8eC7rpSag84QUWlp45DHWz7LXMyd2pUpdBiHxT7Cz5p0PN92A
X-Received: by 10.180.97.7 with SMTP id dw7mr28263364wib.74.1430212118861;
        Tue, 28 Apr 2015 02:08:38 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id b10sm15382571wiz.9.2015.04.28.02.08.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 02:08:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.380.g8e2ddc7
In-Reply-To: <1430212081-16146-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267915>

When p4d runs on a case-folding OS, git-p4 can end up getting
very confused. This adds failing tests to demonstrate the problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh                |  2 +-
 t/t9819-git-p4-case-folding.sh | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100755 t/t9819-git-p4-case-folding.sh

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 5aa8adc..7548225 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -69,7 +69,7 @@ start_p4d() {
 	(
 		cd "$db" &&
 		{
-			p4d -q -p $P4DPORT &
+			p4d -q -p $P4DPORT "$@" &
 			echo $! >"$pidfile"
 		}
 	) &&
diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
new file mode 100755
index 0000000..78f1d0f
--- /dev/null
+++ b/t/t9819-git-p4-case-folding.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='interaction with P4 case-folding'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d with case folding enabled' '
+	start_p4d -C1
+'
+
+test_expect_success 'Create a repo, name is lowercase' '
+	(
+		client_view "//depot/... //client/..." &&
+		cd "$cli" &&
+		mkdir -p lc UC &&
+		>lc/file.txt && >UC/file.txt &&
+		p4 add lc/file.txt UC/file.txt &&
+		p4 submit -d "Add initial lc and UC repos"
+	)
+'
+
+test_expect_success 'Check p4 is in case-folding mode' '
+	(
+		cd "$cli" &&
+		>lc/FILE.TXT &&
+		p4 add lc/FILE.TXT &&
+		test_must_fail p4 submit -d "Cannot add file differing only in case" lc/FILE.TXT
+	)
+'
+
+# Check we created the repo properly
+test_expect_success 'Clone lc repo using lc name' '
+	git p4 clone //depot/lc/... &&
+	test_path_is_file lc/file.txt &&
+	git p4 clone //depot/UC/... &&
+	test_path_is_file UC/file.txt
+'
+
+# The clone should fail, since there is no repo called LC, but because
+# we have case-insensitive p4d enabled, it appears to go ahead and work,
+# but leaves an empty git repo in place.
+test_expect_failure 'Clone lc repo using uc name' '
+	test_must_fail git p4 clone //depot/LC/...
+'
+
+test_expect_failure 'Clone UC repo with lc name' '
+	test_must_fail git p4 clone //depot/uc/...
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.4.0.rc3.380.g8e2ddc7
