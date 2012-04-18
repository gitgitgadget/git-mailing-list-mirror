From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v4 4/4] Prevent graph_width of stat width from falling below min
Date: Tue, 17 Apr 2012 19:29:50 -0700
Message-ID: <1334716196-9870-4-git-send-email-lucian.poston@gmail.com>
References: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 04:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKKgw-0001nG-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 04:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab2DRCcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 22:32:18 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:55215 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2DRCcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 22:32:17 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so9159968dak.11
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 19:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6B+TTYgHsoMjc8fqj7L65VsIj+xOaFgGyWlhmsCcorQ=;
        b=A47YrabKYg+1BdTUtXogU2XrYcejaMDzASI9xozwrr31tSM++Iv/7o+pA0LwlyIAlW
         W6qmVmSOMRr6OY4c1meQaa6fS5B4bsx9lyr8l4efyxXEN1rM8T6Ai4480nnjEBa0oKfL
         S/sbZ5FPqxQnFvCZKpEoJhoF5arXib2UeCFJZoT+N8ITJw9BABMj5YDEtlfDt8WCN0g/
         e/GQd1/xYUY4iuFTWYocbmv0TqDgecuG5/1dakivDiwywbQ3cJv+ZMSAtz71kYJT2xRG
         3aAj1kIWAtaEBIedkieIBJ/pXDIwqn0ca+PrH5sLbL0Qhu1YM7486UyU07YlZ3FTlK11
         UVKw==
Received: by 10.68.232.231 with SMTP id tr7mr2295166pbc.63.1334716337668;
        Tue, 17 Apr 2012 19:32:17 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id vh6sm2178424pbc.25.2012.04.17.19.32.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 19:32:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195835>

Update tests in t4052 fixed by this change.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c                 |    6 +++++-
 t/t4052-stat-output.sh |    4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 0b61cf7..f08b41a 100644
--- a/diff.c
+++ b/diff.c
@@ -1473,8 +1473,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * Adjust adjustable widths not to exceed maximum width
 	 */
 	if (name_width + number_width + 6 + graph_width > width) {
-		if (graph_width > width * 3/8 - number_width - 6)
+		if (graph_width > width * 3/8 - number_width - 6) {
 			graph_width = width * 3/8 - number_width - 6;
+			if (graph_width < 6)
+				graph_width = 6;
+		}
+
 		if (options->stat_graph_width &&
 		    graph_width > options->stat_graph_width)
 			graph_width = options->stat_graph_width;
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 6305c99..ced32db 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -292,7 +292,7 @@ cat >expect1-graph <<'EOF'
 EOF
 while read verb expect cmd args
 do
-	test_expect_failure "$cmd $verb prefix greater than COLUMNS (big change)" '
+	test_expect_success "$cmd $verb prefix greater than COLUMNS (big change)" '
 		COLUMNS=1 git $cmd $args >output
 		grep " | " output >actual &&
 		test_cmp "$expect" actual
@@ -300,7 +300,7 @@ do
 
 	test "$cmd" != diff || continue
 
-	test_expect_failure "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
+	test_expect_success "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
 		COLUMNS=1 git $cmd $args --graph >output
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
-- 
1.7.3.4
