From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v2 3/3] t4052: Test that stat width is adjusted for prefixes
Date: Thu, 22 Mar 2012 22:57:51 -0700
Message-ID: <1332482276-2787-1-git-send-email-lucian.poston@gmail.com>
References: <1332444461-11957-3-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 06:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAxW5-0006yl-Ph
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 06:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab2CWF6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 01:58:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39527 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2CWF6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 01:58:20 -0400
Received: by yenl12 with SMTP id l12so2466504yen.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 22:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lv6o8SE3BD4VGfa8gLlRuqNeSb785b6oyXPe/Gp5g+A=;
        b=BFUGgKqHz4+mvXKspPEHXTZWGLdjk3ePf4GjeZMkPyWeefSfaYYBhGfAj8xEMEBTKv
         TshyDL2mjWCnM/R3O8d8ffHVC3A/xECpD9Eiv89Y6akzZYxH5w5mLD+GLOIbnwSqDMju
         eykF1xbn46XSli0bzWK43wuqtuCCOWsZhdERnFQfJOJ2LhX4lD6S88HgWWeaMmmFh0eU
         bzNbrp333hCTHgRl6sKwHEzIkI8Pa+yf2LQf4Rl1vPBlYzAn1r/kdbhXEPPsHQ8o9fHu
         0mhzwKRk/HvS/9pgkbAiLoAzHwuUNgcgLcpw1L9haRz4yBB2wR+X3WUwDZyOWXznA/X6
         /AsA==
Received: by 10.68.239.233 with SMTP id vv9mr26863390pbc.75.1332482299907;
        Thu, 22 Mar 2012 22:58:19 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id i1sm5088567pbj.70.2012.03.22.22.58.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 22:58:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1332444461-11957-3-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193747>

Add test to verify that the commit graph tree output is taken into
consideration when the diff stat output width is calculated.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 328aa8f..8b6e34a 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -198,6 +198,26 @@ respects expect200 show --stat
 respects expect200 log -1 --stat
 EOF
 
+cat >expect80graphed <<'EOF'
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++
+EOF
+cat >expect80 <<'EOF'
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++++++++++
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
