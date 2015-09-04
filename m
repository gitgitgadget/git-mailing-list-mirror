From: =?UTF-8?q?G=C3=A1bor=20Bern=C3=A1t?= <bernat@primeranks.net>
Subject: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Fri,  4 Sep 2015 17:16:38 +0200
Message-ID: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
References: <xmqq4mjgyrl9.fsf () gitster ! mtv ! corp ! google ! com>
Cc: peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
	mikachu@gmail.com, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 17:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXsjr-0006OC-Qw
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 17:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759024AbbIDPRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 11:17:12 -0400
Received: from mail-wi0-f194.google.com ([209.85.212.194]:36043 "EHLO
	mail-wi0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbbIDPRK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 11:17:10 -0400
Received: by wicmn1 with SMTP id mn1so3673196wic.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=REDrtKsujHxdwYBY0fDEWYnVTzaHgcU8sqQ0wJR8Mcg=;
        b=jC6caoW/F2GyLZXPpEWl0CQbrGnARL/KO6w8dGQZr59fXn/o1b4Nx+OojrjWjrGv03
         /GVtadbnKfm8nsrBm9HA70XUQ4qHwV6y4HC/y3EAi+QJXPHMMhihO7a6LjqZtsVXyK0C
         cY4qyrMym7y2syocMvQLjRGd9gSrvuvVZpev+u0VzGpHP/H3fiztlampGE8AqHu5NST1
         k+49GRbzpBPVX1/u0o1QeZKqD2ONpQXPH34H2rM/BVeK+giOeqYHF/wz5if2q4JcdWUb
         y8MyWcmt9mWtVuddj6tVefVuTvNZLy2boWdVnx//iWDR0pR1JfFNuLbEOJKRUVnmKosT
         1JAg==
X-Received: by 10.194.24.196 with SMTP id w4mr8155365wjf.137.1441379829593;
        Fri, 04 Sep 2015 08:17:09 -0700 (PDT)
Received: from g22.int.gravityrd.com (5-15-26-61.residential.rdsnet.ro. [5.15.26.61])
        by smtp.gmail.com with ESMTPSA id gk9sm4925371wib.9.2015.09.04.08.17.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Sep 2015 08:17:08 -0700 (PDT)
X-Mailer: git-send-email 2.5.1.408.g431338e
In-Reply-To: <xmqq4mjgyrl9.fsf () gitster ! mtv ! corp ! google ! com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277314>

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
---
 git-filter-branch.sh | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..5e9ae0f 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -277,9 +277,43 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 # Rewrite the commits
 
 git_filter_branch__commit_count=0
+
+echo $(date +%s) | grep -q '^[0-9]+$';  2>/dev/null && show_seconds=t
+case "$show_seconds" in
+	t)
+		start_timestamp=$(date +%s)
+		next_sample_at=0
+		;;
+	'')
+		progress=""
+		;;
+esac
+
 while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
-	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)"
+
+	case "$show_seconds" in
+	t)
+		if test $git_filter_branch__commit_count -gt $next_sample_at
+		then
+			now_timestamp=$(date +%s)
+			elapsed_seconds=$(($now_timestamp - $start_timestamp))
+			remaining_second=$(( ($commits - $git_filter_branch__commit_count) * $elapsed_seconds / $git_filter_branch__commit_count ))
+			if test $elapsed_seconds -gt 0
+			then
+				next_sample_at=$(( ($elapsed_seconds + 1) * $git_filter_branch__commit_count / $elapsed_seconds ))
+			else
+				next_sample_at=$(($next_sample_at + 1))
+			fi
+			progress=" ($elapsed_seconds seconds passed, remaining $remaining_second predicted)"
+		fi
+		;;
+	'')
+		progress=""
+		;;
+	esac
+
+	printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits)$progress"
 
 	case "$filter_subdir" in
 	"")
-- 
2.5.1.408.g431338e
