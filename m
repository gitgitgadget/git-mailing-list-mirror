From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 24/24] perf: add partial writing test
Date: Wed, 27 Nov 2013 13:00:59 +0100
Message-ID: <1385553659-9928-25-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VldpV-0002LK-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848Ab3K0MCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:02:48 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:57309 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab3K0MCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:02:45 -0500
Received: by mail-la0-f45.google.com with SMTP id eh20so5164450lab.18
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLgtNCahz9rGG6WDPI7bwun2NPpdxCyWZjAetoKNiH8=;
        b=EkBewA4d2DmRiUp3nI8ZReLO7NQMDYpg8S8ij5IonYexYB1skTM0XkiYPaQNJN7Jut
         5+ibD6szlRjoIeK3M5t9t4j3pzwZBxbChhT+twxJAOYMgq0aLzPQjPQaj3ySimIeTe2f
         202VyYPvxs+ZuIvB/yRqfTpxOGPNKztLO90SNtGbzBik3E1r0Emk71s/I7MRFiWH7HrZ
         bA7wZMb+k/VFFBEEfIgA3vyHsUlyBrvbIu3dnypLDNdtDjSfuJzIKkFuLvqEMtvs6nc9
         x+n/mnr310933h4FqGyUaotv9pVubaBZ8A1vpgOAMwWTYlnPu0ov0TpiuEHclkO7MdJW
         sjdw==
X-Received: by 10.112.53.198 with SMTP id d6mr15780lbp.47.1385553764633;
        Wed, 27 Nov 2013 04:02:44 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id mq10sm44229504lbb.12.2013.11.27.04.02.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:02:43 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238436>

Add a test that uses update-index and exercises the partial writing code
path.
---
 t/perf/p0003-index.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/perf/p0003-index.sh b/t/perf/p0003-index.sh
index 5360175..d1f590b 100755
--- a/t/perf/p0003-index.sh
+++ b/t/perf/p0003-index.sh
@@ -5,6 +5,7 @@ test_description="Tests index versions [23]/4/5"
 . ./perf-lib.sh
 
 test_perf_large_repo
+test_checkout_worktree
 
 test_expect_success "convert to v3" "
 	git update-index --index-version=2
@@ -15,6 +16,7 @@ test_perf "v[23]: update-index" "
 "
 
 subdir=$(git ls-files | sed 's#/[^/]*$##' | grep -v '^$' | uniq | tail -n 30 | head -1)
+file=$(git ls-files | tail -n 30 | head -1)
 
 test_perf "v[23]: grep nonexistent -- subdir" "
 	test_must_fail git grep nonexistent -- $subdir >/dev/null
@@ -24,6 +26,16 @@ test_perf "v[23]: ls-files -- subdir" "
 	git ls-files $subdir >/dev/null
 "
 
+test_expect_success "v[23] update-index prepare" "
+	echo x >$file
+"
+
+test_perf_cleanup "v[23] update-index" "
+	git update-index $file
+" "
+	git reset
+"
+
 test_expect_success "convert to v4" "
 	git update-index --index-version=4
 "
@@ -40,6 +52,17 @@ test_perf "v4: ls-files -- subdir" "
 	git ls-files $subdir >/dev/null
 "
 
+test_expect_success "v4 update-index prepare" "
+	echo x >$file
+"
+
+test_perf_cleanup "v4 update-index" "
+	git update-index $file
+" "
+	git reset
+"
+
+
 test_expect_success "convert to v5" "
 	git update-index --index-version=5
 "
@@ -60,4 +83,14 @@ test_perf "v5: ls-files -- subdir" "
 	git ls-files $subdir >/dev/null
 "
 
+test_expect_success "v5 update-index prepare" "
+	echo x >$file
+"
+
+test_perf_cleanup "v5 update-index" "
+	git update-index $file
+" "
+	git reset
+"
+
 test_done
-- 
1.8.4.2
