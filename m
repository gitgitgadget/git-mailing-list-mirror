From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 19/24] p0003-index.sh: add perf test for the index formats
Date: Wed, 27 Nov 2013 13:00:54 +0100
Message-ID: <1385553659-9928-20-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldpH-0002E4-1z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab3K0MCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:32 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:48799 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab3K0MCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:31 -0500
Received: by mail-lb0-f180.google.com with SMTP id w6so5203098lbh.25
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dvL2hAbJZHCN9KoarkWgNxE3LfHHTn/QC0I0DvuRevM=;
        b=XGnOpu2OtjP9wv40I1ZEq8KfMfe2fzp6l32dKeHxR2nER1a6CoELUHFEfRZ90BFU9Z
         +Ay2hvgD8KdKCXIDMF8VTpsOTa4E5KDWAd/MqTqH5SpYAdFxXULcj1OCqm+4UJmUxf1l
         uR1wTfHeyakzRf3ISZaM/QBAdVy0m+P1IpWPYXo4d/UZGal844bt171XCf2OjA+t8vKW
         hj4Prbns5HsUTg5R0CvB+Vt12TQQ4CBqelWPY4ioTubYd8K5l89hpEIGekrg/elgxJN0
         DrVyEu4Rp09IqK5lNbiVO+kh9b3CxI6t4hfjLXmAwq+IkigMSl6MqYbg6IgvORQiK5J3
         yzBQ==
X-Received: by 10.152.1.197 with SMTP id 5mr19519410lao.0.1385553749849;
        Wed, 27 Nov 2013 04:02:29 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id m5sm54821390laj.4.2013.11.27.04.02.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:28 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238432>

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
1.8.4.2
