From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 22/24] p0003-index.sh: add perf test for the index formats
Date: Sun, 18 Aug 2013 21:42:11 +0200
Message-ID: <1376854933-31241-23-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:49:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8yh-0004QY-9P
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab3HRTt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:49:26 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:59553 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab3HRTtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:49:25 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so349366wes.1
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4i6A8xUbXmK8ktSwFufLiR7u3TUH/41PRpdVDkngHk=;
        b=RAW77ERphmUvJTEIySLbY1vKlesYqbBg5YHukIHTrHuVZYBv0IXNqVHPKTGJnaCJeQ
         MWDymnY19hAPLqaCqhkAcNjpuW2T2x9Y9CWQVEIc324JbHUsD9evCCGMmr3km97BJwia
         K/zdUk+PAVxZpoH9Y6QlwVOcqaAD9+CamKcmWs+ud2GZZlAtBVjDCaIRI+NvdS8StQ71
         qW16WS8A3042a2O781Moy6Ot2IzMLieYAO9pY9LmmKuO0CvDXq/rLIYla6zkaRRUS3U2
         SJ0b9jIQX6PVx+/NSfR9iKQbTzFK4/2bvLPagtPpKj5t3futtWdAm9LAJJJCa9WOrQTW
         ErFA==
X-Received: by 10.180.212.51 with SMTP id nh19mr6417733wic.14.1376855364640;
        Sun, 18 Aug 2013 12:49:24 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id jf9sm12406931wic.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:49:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232510>

From: Thomas Rast <trast@inf.ethz.ch>

Add a performance test for index version [23]/4/5 by using
git update-index --index-version=x, thus testing both the reader
and the writer speed of all index formats.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/p0003-index.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 t/perf/p0003-index.sh

diff --git a/t/perf/p0003-index.sh b/t/perf/p0003-index.sh
new file mode 100755
index 0000000..5360175
--- /dev/null
+++ b/t/perf/p0003-index.sh
@@ -0,0 +1,63 @@
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
+test_perf "v5: ls-files" "
+	git ls-files >/dev/null
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
1.8.3.4.1231.g9fbf354.dirty
