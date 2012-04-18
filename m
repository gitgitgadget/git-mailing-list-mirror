From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v4 3/4] t4052: Test diff-stat output with minimum columns
Date: Wed, 18 Apr 2012 14:09:33 -0700
Message-ID: <1334783377-31229-1-git-send-email-lucian.poston@gmail.com>
References: <1334716196-9870-3-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 23:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKc9M-0005Q4-AF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab2DRVKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 17:10:48 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:38492 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab2DRVKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 17:10:47 -0400
Received: by dake40 with SMTP id e40so10395083dak.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vCQTXLN5RAlYdmaaa+WYB0odR8A22s28czl22qF9Du8=;
        b=W9sRgtQEXoj3AVcFaXk4e9NEtOXV+CjXfWHlpdlHf8fll/2hJ0WgFRYvNYU3LWt6dt
         Z5xjgQqF9SzVJZDzSynMDQuVVwr1q9DEAQhciOHOAZNI4Vk5r2GK6FesP7k0gBUV74C9
         JrV8F40B5+3APHsZLYegV7NxdvamnITPu596h53cnTSOD/dp0z4UnamrhNiK0SOW2pyz
         NKVfrxipMY1p+0AqgJuovlg0e9rmDAlX9h6r6n0qr1fOP+3USh4eG6GhauXnJDxDzgS8
         N+gHosHRybA0+JfNCh5MooZOakvFZUBrUXn3Aff4Nf/Edl+h2PjlJeJXrl4/xP0RDKCd
         FxnA==
Received: by 10.68.225.132 with SMTP id rk4mr9139514pbc.157.1334783446883;
        Wed, 18 Apr 2012 14:10:46 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id o2sm165668pbq.61.2012.04.18.14.10.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 14:10:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334716196-9870-3-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195907>

When COLUMNS or --stat-width restricts the diff-stat width to near the
minimum, 26 columns, the graph_width value becomes negative. Consequently, the
graph part of diff-stat is not resized properly.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index d748e5e..b8eec8f 100755
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
+while read teststate verb expect cmd args
+do
+	test_expect_$teststate "$cmd $verb prefix greater than COLUMNS (big change)" '
+		COLUMNS=1 git $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+
+	test "$cmd" != diff || continue
+
+	test_expect_$teststate "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
+		COLUMNS=1 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
+done <<\EOF
+success ignores expect80 format-patch -1 --stdout
+failure respects expect1 diff HEAD^ HEAD --stat
+failure respects expect1 show --stat
+failure respects expect1 log -1 --stat
+EOF
+
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-- 
1.7.3.4
