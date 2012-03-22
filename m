From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v2 3/3] t4052: Test that stat width is adjusted for prefixes
Date: Thu, 22 Mar 2012 12:27:41 -0700
Message-ID: <1332444461-11957-3-git-send-email-lucian.poston@gmail.com>
References: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 20:28:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAngU-0001oL-AS
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758026Ab2CVT21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:28:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43404 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759367Ab2CVT2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:28:25 -0400
Received: by ghrr11 with SMTP id r11so2110608ghr.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qPYhuhKwbioSLTX1nHtMR7F05vhstcnEGlNe4H1tPmk=;
        b=guWI+mW5bojvBAF7WBN4DiT6wgm+1BimwZu0RFkc5YtPhj+Q45ViZvMTTdN/2wNqPS
         O9hVHeU2Q8W68/913pWWSUzETva28MIU+rLo8QgZrZnl5dJ8aPSJajrZYf/Z4XWRu4Rv
         IwxQemqmqTjkrJS4pt/Sl5e1gj575Mz57Tg3iso3tDriV+b8W3BZo58ReXFtXmT9x8G+
         jW9iBaOlJRSepXDvbsOS3gYpnGLU9ZrYaz3LEZwWJXQQ6BVCi01m/bjsvfAeiui2PpEV
         rJk4Z6Uh08/eCXkDnXxga17aVWhedMzPcCQoS7/ntCiyrPbwQzw0OhtumF3NGg6DA+6a
         gVPg==
Received: by 10.68.125.135 with SMTP id mq7mr22572640pbb.155.1332444504735;
        Thu, 22 Mar 2012 12:28:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id m5sm4281227pbo.69.2012.03.22.12.28.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:28:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193695>

Add test to verify that the commit graph tree output is taken into
consideration when the diff stat output width is calculated.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index c95f120..84dd8bb 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -198,6 +198,26 @@ respects expect200 show --stat
 respects expect200 log -1 --stat
 EOF
 
+cat >expect80graphed <<'EOF'
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++
+EOF
+cat >expect80 <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++++++++++++++++
+EOF
+while read verb expect cmd args
+do
+	test_expect_success "$cmd $verb 80 COLUMNS (long filename)" '
+		COLUMNS=80 git $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+done <<\EOF
+respects expect80 show --stat
+respects expect80 log -1 --stat
+respects expect80graphed show --stat --graph
+respects expect80graphed log -1 --stat --graph
+EOF
+
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-- 
1.7.3.4
