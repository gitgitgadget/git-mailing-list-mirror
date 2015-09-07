From: =?UTF-8?q?G=C3=A1bor=20Bern=C3=A1t?= <bernat@primeranks.net>
Subject: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Mon,  7 Sep 2015 14:31:35 +0200
Message-ID: <1441629095-32004-1-git-send-email-bernat@primeranks.net>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
Cc: peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
	mikachu@gmail.com, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvaY-0001Sd-5M
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbbIGMbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:31:50 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38670 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbIGMbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:31:46 -0400
Received: by wiclk2 with SMTP id lk2so82653291wic.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IYYqM7rwQTqKFMj2BrmrkHg1MDZXkLTXtfkFVELKOBA=;
        b=OFKwGVpYj8HGNDrindnIO38OLz2M5zJg9/YaWjkXF32MldmqUXJPrfLn20UJbcX+ei
         pBxwiLg0q17TTLh0PnTkeOqUq1GBzkME+s4eUdcORY68qyHnk6ItcHJMxZhvBrdlfLMQ
         fUhsyOs88vFw4nQb0EhLhU2I9xqu00WWN9Q5cFsrHAMD9oj4b1qdwVRAHdRDctd8sIAp
         kc48WzQDDuJkBOOKPSs8uOV7E88KV0Bl17dRTmyl/roYvlLYuIAjfzEEr6Aku9AlFyFQ
         cQ4I/220a5IIbhyu5SO9zi4J8xFI41NQIEO7DsdBBkrrZIkDXYWC2nJoEDUck64Dy0Bu
         rHHg==
X-Received: by 10.194.122.200 with SMTP id lu8mr33913333wjb.83.1441629105227;
        Mon, 07 Sep 2015 05:31:45 -0700 (PDT)
Received: from g22.int.gravityrd.com (cl-86-125-171-220.cablelink.mures.rdsnet.ro. [86.125.171.220])
        by smtp.gmail.com with ESMTPSA id aw1sm11159545wjc.26.2015.09.07.05.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:31:44 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.3.gb3280a4
In-Reply-To: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277456>

From: Gabor Bernat <gabor.bernat@gravityrd.com>

adds seconds progress and estimated seconds time if getting the current
timestamp is supported by the date %+s command

Signed-off-by: Gabor Bernat <gabor.bernat@gravityrd.com>
---

I've submitted this first to this list as a feature request, however
in the meantime with the help of Jeff King <peff@peff.net>, Junio C
Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
and Mikael Magnusson <mikachu@gmail.com> came up with solution, so now
I submit it as a revised patch.

The current solution updates the progress for all commits until 1
second time is elapsed. Afterwards updates it at most once a second.

Ammended build up as agreed at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/277314
---
 git-filter-branch.sh | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..565144a 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -275,11 +275,41 @@ commits=$(wc -l <../revs | tr -d " ")
 test $commits -eq 0 && die "Found nothing to rewrite"
 
 # Rewrite the commits
+report_progress ()
+{
+if test -n "$progress"
+then
+	if test $git_filter_branch__commit_count -gt $next_sample_at
+	then
+		now_timestamp=$(date +%s)
+		elapsed_seconds=$(($now_timestamp - $start_timestamp))
+		remaining_second=$(( ($commits - $git_filter_branch__commit_count) * $elapsed_seconds / $git_filter_branch__commit_count ))
+		if test $elapsed_seconds -gt 0
+		then
+			next_sample_at=$(( ($elapsed_seconds + 1) * $git_filter_branch__commit_count / $elapsed_seconds ))
+		else
+			next_sample_at=$(($next_sample_at + 1))
+		fi
+		progress=" ($elapsed_seconds seconds passed, remaining $remaining_second predicted)"
+	fi
+fi
+printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)$progress"
+}
 
 git_filter_branch__commit_count=0
+
+progress= start_timestamp=
+if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
+then
+		next_sample_at=0
+		progress="dummy to ensure this is not empty"
+		start_timestamp=$(date '+%s')
+fi
+
 while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
-	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)"
+
+	report_progress
 
 	case "$filter_subdir" in
 	"")
-- 
2.6.0.rc0.3.gb3280a4
