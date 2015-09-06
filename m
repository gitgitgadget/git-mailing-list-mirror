From: =?UTF-8?q?G=C3=A1bor=20Bern=C3=A1t?= <bernat@primeranks.net>
Subject: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Sun,  6 Sep 2015 15:11:04 +0200
Message-ID: <1441545064-3126-1-git-send-email-bernat@primeranks.net>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
Cc: peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
	mikachu@gmail.com, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, mfwitten@gmail.com,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 06 15:11:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYZjW-00045W-30
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 15:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbbIFNLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 09:11:25 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36375 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbIFNLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 09:11:23 -0400
Received: by wicgb1 with SMTP id gb1so19704863wic.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R/MOIRG3CjL2kuG6cYSvi4qbMusiXEAsOZ2gmUwsH74=;
        b=Y0iMV4vMyl4A641fW6h1pMyg0xpB4W0nkb4KggaHQhdsESLNGM01YsAzF4Gcudvj2v
         rmQQF3D/Yfx+RCIFQq4P0M56szcR/3fhH0tjzopO1221YAI7PafwWcAlnc/Ex2TpbzNQ
         vuBXv/6rKlzTbb0jl8Xfmiv6zxcOeQp7Zh/8HoCwC0YWwlysLl/HPhuy+T2YjYEc3oGf
         jUKEX6saYSZDCiEhhWG80R2qepREzmeO+q0WxAcToFf07a/1Y14/8BVrUvMMZdI5gF7f
         WQdNDezgq/c7w8zZa4X3+s9a3q3CyH0elGz5ppI+apfyN8iHO635wsvtRlV3A0mHxgAJ
         5l5Q==
X-Received: by 10.180.108.175 with SMTP id hl15mr25490357wib.1.1441545082459;
        Sun, 06 Sep 2015 06:11:22 -0700 (PDT)
Received: from g22.int.gravityrd.com (cl-86-125-185-118.cablelink.mures.rdsnet.ro. [86.125.185.118])
        by smtp.gmail.com with ESMTPSA id u1sm7787896wiz.22.2015.09.06.06.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Sep 2015 06:11:21 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.3.gb3280a4
In-Reply-To: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277425>

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
 git-filter-branch.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5b3f63d..924cf3d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -277,9 +277,49 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 # Rewrite the commits
 
 git_filter_branch__commit_count=0
+
+if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
+then
+	show_seconds=t
+else
+	show_seconds=
+fi
+
+case "$show_seconds" in
+t)
+	start_timestamp=$(date +%s)
+	next_sample_at=0
+	;;
+'')
+	progress=""
+	;;
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
2.6.0.rc0.3.gb3280a4
