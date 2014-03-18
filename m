From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Tue, 18 Mar 2014 11:00:52 +0100
Message-ID: <1395136856-17225-3-git-send-email-benoit.pierre@gmail.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
 <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 11:01:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPqq2-0003wX-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbaCRKB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:01:26 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:55205 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbaCRKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:01:24 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so5691369wes.30
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=dizJbuGDoshCpap6gUtT6lhUPyKHwq15QZgDFShOaWU=;
        b=wlHtAhRcgljhzSozfnr2NyYd1LePddo/v7AIduHUm24e7j/lp/tvWDzXgbbVcsu3Nm
         AACvoIS5Mxa58vKtcOSwnQwi15PtbxwnGgg73Y5zREnWz07YWLIon3avwH0HuwI1FTWG
         P6PtwQ/xwmXKFSF7Z3/i1JsfmSh8kiIrRsRU73HvwneLNTZ3LxERM6hrmQGZbfRd3Kl9
         5yNYqHuiCs+Duem7NuQGEEWTy2uEA+/qvztjl+y3gpb1e4McqVO/Q43LOrbvnUG90VKD
         uDNjQ8zjMQXatiDvcg2WAB7Q5/koMT1LEMH5Q7qdX3/gPk6nl2OzgzU07RjkLnTjPUGm
         ohsQ==
X-Received: by 10.180.211.239 with SMTP id nf15mr13869571wic.9.1395136883207;
        Tue, 18 Mar 2014 03:01:23 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id em1sm33184095wid.5.2014.03.18.03.01.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Mar 2014 03:01:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244342>

Add (failing) tests: with commit changing the environment to let hooks
know that no editor will be used (by setting GIT_EDITOR to ":"), the
"edit hunk" functionality does not work (no editor is launched and the
whole hunk is committed).

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7514-commit-patch.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 t/t7514-commit-patch.sh

diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
new file mode 100755
index 0000000..41dd37a
--- /dev/null
+++ b/t/t7514-commit-patch.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='hunk edit with "commit -p -m"'
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all="skipping '$test_description' tests, perl not available"
+	test_done
+fi
+
+test_expect_success 'setup (initial)' '
+	echo line1 >file &&
+	git add file &&
+	git commit -m commit1
+'
+
+test_expect_failure 'edit hunk "commit -p -m message"' '
+	test_when_finished "rm -f editor_was_started" &&
+	rm -f editor_was_started &&
+	echo more >>file &&
+	echo e | env GIT_EDITOR=": >editor_was_started" git commit -p -m commit2 file &&
+	test -r editor_was_started
+'
+
+test_expect_failure 'edit hunk "commit --dry-run -p -m message"' '
+	test_when_finished "rm -f editor_was_started" &&
+	rm -f editor_was_started &&
+	echo more >>file &&
+	echo e | env GIT_EDITOR=": >editor_was_started" git commit -p -m commit3 file &&
+	test -r editor_was_started
+'
+
+test_done
-- 
1.9.0
