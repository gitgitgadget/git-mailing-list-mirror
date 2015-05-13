From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 9/9] t5520: check reflog action in fast-forward merge
Date: Wed, 13 May 2015 17:08:56 +0800
Message-ID: <1431508136-15313-10-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:10:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfz-0003Or-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212AbbEMJJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:55 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34601 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbbEMJJt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:49 -0400
Received: by pdbqa5 with SMTP id qa5so45432949pdb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RLTZeN8/WcER/3AZzmCysdA5VQ+qBscYj6dzzpYRVXE=;
        b=lTZlM50cLweifKSYuSRba9G/juiGfhlyABQs+LQ8EgGl58vtuXSdGEmRjjvCgNRSuP
         6HyMHRowrK5FQuRliLgnAkFfdog7wZqoitKE6yer6P4pps5EY6dHVZGyytGDNAnctDxb
         +w17+C4n/yJFGDmwikwGOKdScI4Nqqn1B8D3XQLSnmK7aab2hzqMQpdheKOGvzKzo6g/
         jgg1F7mXY0q29cL/eNTsprVmczuNuYMYEYu/QWYwW/JQZ2XxKB8m2JIEmjejhBb9hC+e
         0kAmGcwfnyGUARNde3fywqpts1iGAbx2DLw/npgLTIoh2efZH7LSpYoI4mofHOFsr1zE
         AOpg==
X-Received: by 10.68.94.193 with SMTP id de1mr35391661pbb.153.1431508189432;
        Wed, 13 May 2015 02:09:49 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:48 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268958>

When testing a fast-forward merge with git-pull, check to see if the
reflog action is "pull" with the arguments passed to git-pull.

While we are in the vicinity, remove the empty line as well.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5520-pull.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 96d2e7c..da120b2 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -86,7 +86,6 @@ test_expect_success 'pulling into void must not create an octopus' '
 '
 
 test_expect_success 'test . as a remote' '
-
 	git branch copy master &&
 	git config branch.copy.remote . &&
 	git config branch.copy.merge refs/heads/master &&
@@ -95,7 +94,11 @@ test_expect_success 'test . as a remote' '
 	git checkout copy &&
 	verbose test "$(cat file)" = file &&
 	git pull &&
-	verbose test "$(cat file)" = updated
+	verbose test "$(cat file)" = updated &&
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
@@ -106,7 +109,11 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git reset --hard HEAD^ &&
 	verbose test "$(cat file)" = file &&
 	git pull . second &&
-	verbose test "$(cat file)" = modified
+	verbose test "$(cat file)" = modified &&
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull . second: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'fail if wildcard spec does not match any refs' '
-- 
2.1.4
