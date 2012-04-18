From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v4 3/4] t4052: Test diff-stat output with minimum columns
Date: Tue, 17 Apr 2012 19:29:49 -0700
Message-ID: <1334716196-9870-3-git-send-email-lucian.poston@gmail.com>
References: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 04:32:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKKgi-0001d4-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 04:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab2DRCcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 22:32:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39614 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2DRCcC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 22:32:02 -0400
Received: by pbcun15 with SMTP id un15so8354023pbc.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rVKLic9nbohXvAG5LPS82FxHGbTC3Miqh029GkQskzo=;
        b=YXAdSP6mPjaTTH0XRr2DY9+DrklUEGNYueSog4pl5jk4VhoGw2AMM1itb1gJijq2HU
         7LefYdNsFj2qA4lMlvmiQa0afIaY2qSuMjtjDoZePbMJ5FSbiZ0acyJ22gApqZna39di
         hikrD7kioDK5WOWbpmw3SMaR3WE3u/xkPuRlNmvWro+TBdudBlk142Mzk4kZTkxvQpJ0
         1fM9Q2b/s/Q8RnXIj5JOFpYPPnTI0Xnh2eOo64b/ViP30C7PcqnRTkeyM8Fx1bma16lk
         CyC4tfwu4KdVhm4JnHqMRUfVEuYexNCF9ShnsF/jIpD5enAOYWOQwKjOd1oENOCv8ssS
         Qyzw==
Received: by 10.68.218.38 with SMTP id pd6mr2166085pbc.141.1334716322038;
        Tue, 17 Apr 2012 19:32:02 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id vh6sm2178424pbc.25.2012.04.17.19.32.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 19:32:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195834>

When COLUMNS or --stat-width restricts the diff-stat width to near the
minimum, 26 columns, the graph_width value becomes negative. Consequently, the
graph part of diff-stat is not resized properly.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index d748e5e..6305c99 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -284,6 +284,34 @@ respects expect200 show --stat
 respects expect200 log -1 --stat
 EOF
 
+cat >expect1 <<'EOF'
+ ...aaaaaaa | 1000 ++++++
+EOF
+cat >expect1-graph <<'EOF'
+|  ...aaaaaaa | 1000 ++++++
+EOF
+while read verb expect cmd args
+do
+	test_expect_failure "$cmd $verb prefix greater than COLUMNS (big change)" '
+		COLUMNS=1 git $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+
+	test "$cmd" != diff || continue
+
+	test_expect_failure "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
+		COLUMNS=1 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
+done <<\EOF
+ignores expect80 format-patch -1 --stdout
+respects expect1 diff HEAD^ HEAD --stat
+respects expect1 show --stat
+respects expect1 log -1 --stat
+EOF
+
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-- 
1.7.3.4
