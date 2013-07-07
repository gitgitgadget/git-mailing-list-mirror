From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 22/22] p0003-index.sh: add perf test for the index formats
Date: Sun,  7 Jul 2013 10:12:00 +0200
Message-ID: <1373184720-29767-23-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:14:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk6c-0006rv-4v
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab3GGINu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:50 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:58166 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab3GGINr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:47 -0400
Received: by mail-ee0-f45.google.com with SMTP id c1so2182727eek.18
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DeVsjffc2ErNG7V+l63R8Wze4HMmJGLHBibz8L8hkcM=;
        b=FhF8bBghFJlavhBt+Ddsjd9COCTei7axMqTqRZYaCZ54kJ65z+2EgZ3ChgKkNy3Jf6
         ZIUNYKKYB3kfnqV9ImjOrnn2nNx/4bczUIkonne2LWyVsENgnz4YG59vrse+VZxbCZrQ
         CHtMwf+4AAvhxMrxUFUt2R2/5eNtzmaIZVWfuPYt+F6xyXCsGvSLHT4oYgyy0sNJG5om
         /WHSa+vwcw2ATvj2j0k2UrXAPEYFoToKAH9GMekLyqSsKq9Z3U5P4jrIWPMJ1/t0rSzD
         9A1yXTq4LMaytPTOYGYHtjtNM60YvijvBWHMWOSsirQigwAcJwMWlBupJBLZ4bAl3FJs
         AWBg==
X-Received: by 10.15.98.3 with SMTP id bi3mr18531837eeb.124.1373184826119;
        Sun, 07 Jul 2013 01:13:46 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id w43sm30763912eez.6.2013.07.07.01.13.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229751>

From: Thomas Rast <trast@inf.ethz.ch>

Add a performance test for index version [23]/4/5 by using
git update-index --index-version=x, thus testing both the reader
and the writer speed of all index formats.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/p0003-index.sh | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 t/perf/p0003-index.sh

diff --git a/t/perf/p0003-index.sh b/t/perf/p0003-index.sh
new file mode 100755
index 0000000..3e02868
--- /dev/null
+++ b/t/perf/p0003-index.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description="Tests index versions [23]/4/5"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success "convert to v3" "
+	git update-index --index-version=2
+"
+
+test_perf "v[23]: update-index" "
+	git update-index --index-version=2 >/dev/null
+"
+
+subdir=$(git ls-files | sed 's#/[^/]*$##' | grep -v '^$' | uniq | tail -n 30 | head -1)
+
+test_perf "v[23]: grep nonexistent -- subdir" "
+	test_must_fail git grep nonexistent -- $subdir >/dev/null
+"
+
+test_perf "v[23]: ls-files -- subdir" "
+	git ls-files $subdir >/dev/null
+"
+
+test_expect_success "convert to v4" "
+	git update-index --index-version=4
+"
+
+test_perf "v4: update-index" "
+	git update-index --index-version=4 >/dev/null
+"
+
+test_perf "v4: grep nonexistent -- subdir" "
+	test_must_fail git grep nonexistent -- $subdir >/dev/null
+"
+
+test_perf "v4: ls-files -- subdir" "
+	git ls-files $subdir >/dev/null
+"
+
+test_expect_success "convert to v5" "
+	git update-index --index-version=5
+"
+
+test_perf "v5: update-index" "
+	git update-index --index-version=5 >/dev/null
+"
+
+test_perf "v5: grep nonexistent -- subdir" "
+	test_must_fail git grep nonexistent -- $subdir >/dev/null
+"
+
+test_perf "v5: ls-files -- subdir" "
+	git ls-files $subdir >/dev/null
+"
+
+test_done
-- 
1.8.3.453.g1dfc63d
