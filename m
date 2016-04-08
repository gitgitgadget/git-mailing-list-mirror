From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 13/18] Add --index-only support with read_tree_trivial merges, kind of
Date: Thu,  7 Apr 2016 23:58:41 -0700
Message-ID: <1460098726-5958-14-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@palantir.com>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQO9-0002VL-UG
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbcDHG7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:22 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34809 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbcDHG7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id d184so8834106pfc.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enweZTJZScc5WPfAVV6xbtkMSt4NNnesyrtGXjUGWC0=;
        b=Cp+KFzYGFe+Ho0jCKIs6TovDMIwiMScDyt4GTSGFL9Oc0u1/lYCaIIEHiqeYzeFfXc
         rkvNdYT+4cSwDXju+r8U4FCM3Tsk6o/hnNrgY3KIo07WpFhkjgYzCTxqIYSRLa1UthEb
         etAxgCVvTAcqTHbf4hPcVfzqk/gs53DosJIsCextY+JYpzosjOyGFbEjMNSxRL7Eo48w
         2mE6KyOTpEHwigBMCpHeOdTssZyeXFrIc/3dFKyQGb3+mljfqPWs/uAIcn9XDu/wJqTl
         33h3u6u+q7d1pudOF5aklT/ojPG3+wCQoqSkkO7hY0fMczOSJehUF+QAGzhvrdiJqbmo
         D7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enweZTJZScc5WPfAVV6xbtkMSt4NNnesyrtGXjUGWC0=;
        b=lLaPB6pTwy0Kdq+f+MCUQyCGHwin08Lq/Uy3dg/7CvGK9v0BBapNO/rJutXxz9fjo2
         e/FPz4lMMinn9MJtUlRlFD9GsGR8m3pT7wXQF1B2ZeWnHQK51bqXquUKf9gQjmodPrJR
         XYpGo3bvowhpxApWnh/5M7NtJQ3MVPFqSEF1RjoonH59nHRRlt5Q9dAFCZSsbLZqcred
         aH7Cep2xX6hovpJImMTh+xMACxlSP/G1vsF7m12DxpHsxvbfsgRemvTM0B76YOFP8e5z
         o9srWNdZbyLCzbPlLkcvM5t8G6Z9gE//GK3btgC2LwbhjajMBVXMKV9H7i/JLfEajUcB
         rszA==
X-Gm-Message-State: AD7BkJLGaH7RTO9Tlm+BW2i3fnyjNPRNNC88qOfwxcTAproYftkUuvR40JUuAkw33DW3WA==
X-Received: by 10.98.10.156 with SMTP id 28mr10478931pfk.130.1460098752181;
        Thu, 07 Apr 2016 23:59:12 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291000>

From: Elijah Newren <newren@palantir.com>

This almost works.  It creates the correct merge commit, updates the
branch, but then if the repo is bare it leaves the index as it was before
the merge (and if the repo is non-bare it updates the index).  I'm
totally lost as to why the testcase behaves differently in the bare and
non-bare cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c             | 3 ++-
 t/t6043-merge-index-only.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ce5be0a..5f463ad 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -606,7 +606,8 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	opts.head_idx = 2;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	opts.update = 1;
+	opts.update = !index_only;
+	opts.index_only = index_only;
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
diff --git a/t/t6043-merge-index-only.sh b/t/t6043-merge-index-only.sh
index 2e1d953..f79782c 100755
--- a/t/t6043-merge-index-only.sh
+++ b/t/t6043-merge-index-only.sh
@@ -265,7 +265,7 @@ test_expect_failure '--index-only ff update, non-bare with uncommitted changes'
 	test ! -d subdir
 '
 
-test_expect_failure '--index-only w/ resolve, trivial, non-bare' '
+test_expect_success '--index-only w/ resolve, trivial, non-bare' '
 	git clean -fdx &&
 	git reset --hard &&
 	git checkout B^0 &&
-- 
2.8.0.18.gc685494
