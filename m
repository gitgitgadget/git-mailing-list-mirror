From: =?UTF-8?q?G=C3=A1bor=20Bern=C3=A1t?= <bernat@primeranks.net>
Subject: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Mon,  7 Sep 2015 15:52:08 +0200
Message-ID: <1441633928-18035-1-git-send-email-bernat@primeranks.net>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
Cc: peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
	mikachu@gmail.com, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 15:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYwqO-0000qU-L2
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 15:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbbIGNwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 09:52:21 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38083 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbIGNwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 09:52:19 -0400
Received: by wiclk2 with SMTP id lk2so84997004wic.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VPX/zZdGHCCaTvNUVoc+ia0OdmWRz9BKkm/Yqe74X8g=;
        b=gtDXSfBEzyo0S29XovAlV46nzmnqQvhVSIsUk8ZlGQBQ3WIw91fJhrdsjrpmvaC0T3
         sMPpeMdxJDzxx6iKaklnr2ojxZPk8N+QlaJ8f56DVtsKxN5PejQqSkxxnbYDivE2PK6g
         vKFz/YYrm9CVKyFvrCSJZjv71W98Bd/r8abcnO+6N7zEGnsHq6jajD8GQb4laZAdEdqE
         go0ShagV6oeupf5irMgFlcIA6DQU0aeAQT/e3aLgIyu63+TpwLnvZ0w8VlnvzoqRJYBH
         zwUyhejkfuojIFY4ZlF/w1+rNQKXIvCdj/PjsUuaAaN/48I5jDf4X1UV+HMiwUZ4jKKQ
         nRAg==
X-Received: by 10.180.100.74 with SMTP id ew10mr35786935wib.12.1441633938296;
        Mon, 07 Sep 2015 06:52:18 -0700 (PDT)
Received: from g22.int.gravityrd.com (cl-86-125-171-220.cablelink.mures.rdsnet.ro. [86.125.171.220])
        by smtp.gmail.com with ESMTPSA id x10sm463774wiy.6.2015.09.07.06.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 06:52:17 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.3.gb3280a4
In-Reply-To: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277462>

From: Gabor Bernat <gabor.bernat@gravityrd.com>

adds seconds progress and estimated seconds time if getting the current
timestamp is supported by the date +%s command

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
