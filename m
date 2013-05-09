From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 2/3] mergetools/kdiff3: allow opting-out of auto-merges
Date: Thu,  9 May 2013 02:13:29 -0700
Message-ID: <1368090810-40596-2-git-send-email-davvid@gmail.com>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 11:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMv3-0003oY-6Z
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 11:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab3EIJNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 05:13:42 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:40244 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab3EIJNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 05:13:40 -0400
Received: by mail-pb0-f51.google.com with SMTP id wy7so1838274pbc.24
        for <git@vger.kernel.org>; Thu, 09 May 2013 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=t3IG20SVsp1Nf7adQlW0uvJJ7BG8fB+RJ9othmPA8Mc=;
        b=Nq64+wz3ZXpAsM567kH+SflGvzwFhkMTvuuLnAdcjOZzlu5pxiuPxuOExUgGy7nlPo
         nKJ0Rq/RBa65iIa9Z+Rk5SHWsa0f3NHmU+G66+T+OINhTYP2SgX5zikoh4cuRiD76Gfd
         rCHH40M4L31jH9VJU8XBft1QCypVt8q0M9HusBQkAOFhCVOz98NVeWS1FZlygVAmpxLX
         JMrV1w6cVQyTjzg6U4t7xzudWOCqraSc2uPriImkX/fnK6k6tGAbWXxcMUp+/rFd418U
         8c32kIF9Ver+V+1J5gwgVNyL2ZGG1I/rlafdqM8ttYk01KU+oeQSMQSHUWs1uakLQKQQ
         8H7w==
X-Received: by 10.68.106.196 with SMTP id gw4mr11504970pbb.126.1368090820289;
        Thu, 09 May 2013 02:13:40 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id wi6sm2323180pbc.22.2013.05.09.02.13.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 02:13:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.38.gd586103
In-Reply-To: <1368090810-40596-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223721>

By default, "git mergetool" passes the `--auto` flag to `kdiff3` when
merging a file.  The `--auto` flag tells `kdiff3` to skip showing the
GUI and automatically save the merged result when it is able to
trivially resolve a merge.

Some users prefer to eyeball the merged result using mergetool and the
use of `--auto` prevents them from doing so.  Add a configuration
variable to allow opting-out of the auto-merge feature.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Marked "RFC" because I am kinda against adding more configuration
variables.  Someone ran into this and I did personally find the
behavior a bit surprising.  Alternatively, we *could* change the
default behavior, but I am not convinced that doing so is a good idea
either, hence this patch.  Other then the "kinda against",
it does make the behavior less surprising.

 Documentation/merge-config.txt |  9 +++++++++
 mergetools/kdiff3              | 20 ++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index d78d6d8..3bd5f21 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -59,6 +59,15 @@ merge.tool::
 
 include::mergetools-merge.txt[]
 
+mergetool.kdiff3.manualMerge::
+	Tell Git that not to use `kdiff3`'s auto-merge feature.
+	By default, "git mergetool" passes the `--auto` flag to `kdiff3`
+	when merging a file.  The `--auto` flag tells `kdiff3` to skip
+	showing the GUI and automatically save the merged result when it
+	is able to trivially resolve a merge.  The `--auto` flag will
+	not be used when this variable is set to `true`.  False by
+	default.
+
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
 	strategy.  Level 0 outputs nothing except a final error
diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index a30034f..d0acda9 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -1,3 +1,18 @@
+kdiff3_initialized=
+kdiff3_args=--auto
+
+kdiff3_init () {
+	if test -n "$kdiff3_initialized"
+	then
+		return
+	fi
+	if test "$(git config --bool mergetool.kdiff3.manualMerge)" = true
+	then
+		kdiff3_args=
+	fi
+	kdiff3_initialized=true
+}
+
 diff_cmd () {
 	"$merge_tool_path" \
 		--L1 "$MERGED (A)" --L2 "$MERGED (B)" \
@@ -5,16 +20,17 @@ diff_cmd () {
 }
 
 merge_cmd () {
+	kdiff3_init
 	if $base_present
 	then
-		"$merge_tool_path" --auto \
+		"$merge_tool_path" $kdiff3_args \
 			--L1 "$MERGED (Base)" \
 			--L2 "$MERGED (Local)" \
 			--L3 "$MERGED (Remote)" \
 			-o "$MERGED" "$BASE" "$LOCAL" "$REMOTE" \
 		>/dev/null 2>&1
 	else
-		"$merge_tool_path" --auto \
+		"$merge_tool_path" $kdiff3_args \
 			--L1 "$MERGED (Local)" \
 			--L2 "$MERGED (Remote)" \
 			-o "$MERGED" "$LOCAL" "$REMOTE" \
-- 
1.8.3.rc1.38.g0f1704c
