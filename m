From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] rebase: prepare to write reflog message for checkout
Date: Thu, 13 Jun 2013 19:02:25 +0530
Message-ID: <1371130349-30651-3-git-send-email-artagnon@gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:30:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7c9-0003x5-PI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab3FMNan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:30:43 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:65302 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178Ab3FMNak (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:40 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so6837436pbb.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r0CmykdiMDQ+GM6QTl4MPAQHuSt9DDqDQ/sOeR/7oWA=;
        b=DBcG1oj3fwJ6l/qV/7Aqpq6q+dieni3g/RXqZ11LCOPVFylVR0fu41oRRQMxxfVy0X
         qC7oYaHLQoIswWSFO/Q2M68FuLlgMjCCpRqokYUsi/7F6AZgooVDSFwsTCNvACAS2aTg
         2LcGJD90nMZXCrXfZ/enbw2Gqrxqsx+EIK8b/gxhZIalM6mCMIqANwJ4kKi8rTkik1A2
         DRtSCICQYDYwsBhoq+T1gTpFVxLPc3n5BsDKIr5SmS1lg8RWvuH0eRP7xuUucJeRtiNa
         V1+qCTi/INI4lPrH2tQMHwlcd26vn2udOqnOb7tkKL1cU1FC+hwKfzwW8QoRZaT2IhHg
         Iodg==
X-Received: by 10.68.241.228 with SMTP id wl4mr806378pbc.145.1371130240329;
        Thu, 13 Jun 2013 06:30:40 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id re16sm4581222pac.16.2013.06.13.06.30.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:30:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
In-Reply-To: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227728>

rebase should never write "checkout: " messages to the reflog, since it
is highly confusing to the end user, and breaks
grab_nth_branch_checkout(), as demonstrated by failing tests
in t/checkout-last.  Set a sensible GIT_REFLOG_ACTION: checkout does not
respect GIT_REFLOG_ACTION yet, but this defect will be addressed in a
future patch.

When the defect is addressed, rebase will write the following line to
the reflog when started:

  rebase: checkout master

This is much better than the confusing message it currently writes:

  checkout: moving from master to 1462b67

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..6587019 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -568,6 +568,8 @@ test "$type" = interactive && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
+
+GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 
-- 
1.8.3.1.384.g7cec0b4
