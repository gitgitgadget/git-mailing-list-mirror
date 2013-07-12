From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 19/19] p0003-index.sh: add perf test for the index formats
Date: Fri, 12 Jul 2013 19:27:04 +0200
Message-ID: <1373650024-3001-20-git-send-email-t.gummerer@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhE4-00077r-NX
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227Ab3GLRdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:33:45 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:51037 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965219Ab3GLRdo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:33:44 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so9229177pbc.16
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DeVsjffc2ErNG7V+l63R8Wze4HMmJGLHBibz8L8hkcM=;
        b=sKYsvSMQgzAx2CGvjfUIATsI3cxY5zYVIG4MMXTq/RfTuAiIzJ75vIcGEB/QLVoHIm
         JjkwuIUGwdr+uY5uHiGTdm/uP/xy65jDtgf5/320ob0lBFtzoy4T0TRiOKAGnLswnXBa
         w16bjeq0n6WsAy5smSiZaAPE8i9b8kLxo6WHxvc+owgnQHXXTFtLLfmX+d40HtezzanA
         gr6jvhm7vqQ9Lld0kBXtaWxNSMtlTyO5VyV/ytYyroeiXafYk4UIARwV/cn/z/gTGEMT
         IbvW4SnlhaD5TWJxkhtlz5q40oKo7hXa70vGGbUhwD1/zp/alHXik2Q1z6F8Rvc0K4+4
         xaKw==
X-Received: by 10.68.101.226 with SMTP id fj2mr42039761pbb.6.1373650423909;
        Fri, 12 Jul 2013 10:33:43 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id py6sm46412002pbb.33.2013.07.12.10.33.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:33:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230231>

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
