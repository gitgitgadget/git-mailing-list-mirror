From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] p0003-index.sh: add perf test for the index formats
Date: Mon, 23 Sep 2013 23:08:46 +0200
Message-ID: <1379970526-27997-4-git-send-email-t.gummerer@gmail.com>
References: <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
 <1379970526-27997-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, git@vger.kernel.org, t.gummerer@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 23 23:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODOU-00081A-N9
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab3IWVKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:10:03 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45084 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab3IWVKB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:10:01 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so3662059pbc.39
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fotHCECoJubk/Ap8ZQge6gKrtsTM4XzIW3puGIip/Uk=;
        b=VgUQitwVtEK0y+W7im8c1opwRM+E7o/K62CZM+jODf+l+jfvjAUhis7v/5j4wJBblm
         QYUm11jJW0nGFwXuzXe87Qu0YVDw2CFxqgA2c6hJKbEDuZ1d6GXNP6dyo4A0695iK7xb
         YFxcUSxQ/X9yxANPB9xLUZl5cGcermW4Gaufyw+iwOUfZx5DtGEma6hdzmO/59Vu1gme
         xP2IcNln6/eJvdRl2ef97ddG+pdUXMLYpQ/7IqX5KgxW8huG5ujk8YxzBXYJ8J5RHBRD
         uIOoEz4TGxOuDrPxRsbU7gIRVGqYEpNo/ZQRY/BWnE7WlAjT3qC048kAlaRhR0R8qhF7
         lYvQ==
X-Received: by 10.68.114.36 with SMTP id jd4mr6149050pbb.31.1379970599709;
        Mon, 23 Sep 2013 14:09:59 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id kd1sm40352284pab.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:09:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1241.g1ce9896
In-Reply-To: <1379970526-27997-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235244>

From: Thomas Rast <trast@inf.ethz.ch>

Add a performance test for index version [23]/4 by using
git update-index --index-version=x, thus testing both the reader
and the writer speed of all index formats.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/perf/p0003-index.sh | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 t/perf/p0003-index.sh

diff --git a/t/perf/p0003-index.sh b/t/perf/p0003-index.sh
new file mode 100755
index 0000000..f2308c0
--- /dev/null
+++ b/t/perf/p0003-index.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description="Tests index versions [23]/4/5"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_expect_success "convert to v3" "
+	git update-index --index-version=2
+"
+subdir=$(git ls-files | sed 's#/[^/]*$##' | grep -v '^$' | uniq | tail -n 30 | head -1)
+file=$(git ls-files | tail -n 100 | head -1)
+
+test_expect_success "modify a file" "
+	echo 'foo bar' >>$file
+"
+
+test_perf "v[23]: update-index" "
+	git update-index --index-version=2 >/dev/null
+"
+
+test_perf "v[23]: grep nonexistent -- subdir" "
+	test_must_fail git grep nonexistent -- $subdir >/dev/null
+"
+
+test_perf "v[23]: ls-files -- subdir" "
+	git ls-files $subdir >/dev/null
+"
+
+test_perf --cleanup "git reset" "v[23]: update-index -- file" "
+	git update-index $file
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
+test_perf --cleanup "git reset" "v4: update-index -- file" "
+	git update-index $file
+"
+
+test_done
-- 
1.8.3.4.1241.g1ce9896
