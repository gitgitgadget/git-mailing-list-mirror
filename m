From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/3] git-p4: do not terminate creating tag for unknown commit
Date: Thu, 27 Aug 2015 08:18:57 +0100
Message-ID: <1440659938-12952-3-git-send-email-luke@diamand.org>
References: <1440659938-12952-1-git-send-email-luke@diamand.org>
Cc: marcus.holl@sap.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 09:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUrSy-000571-Qz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 09:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbbH0HTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 03:19:17 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35388 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbH0HTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 03:19:16 -0400
Received: by wicne3 with SMTP id ne3so65320679wic.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TWrb65sKOuo+sA7Oivo7lxZK9zLBBKfdfaQRCHBlL98=;
        b=LGLeA7kkgSz4MRzl8mpIRwlp7/4ql2MvWlxOSFrXFEjwv3UR5PuabhpbVnBcpYtX+c
         mz+vFTe6R7BoOL4idEV1irQj9RvXJTlFtyBbO5vTnaVb+Po0FcfiPIKF3ClNeii81oj1
         PgNJeESOPcQl1KFpGCw39XQjGtaJY47OYvzWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TWrb65sKOuo+sA7Oivo7lxZK9zLBBKfdfaQRCHBlL98=;
        b=WgBKJEa1Ri+6Uec2+qMdjUvslzbvSPTciFGR9PK70I9mm4qotlKmun/RxVmyZo7e6U
         XRjuyFMHWT6G4rfYoCpYAy/0zPvw5ohbs5DGmwJ7A/+O480Owu0S3nS2MSaA0GTes2Su
         sD4t9b4I5vNs9HvsDGxMsRWwbuGQxvoKXe7OGdiL/N9lzV50I2Q/+sovPxT8CRDjvTkc
         Iqtf46OQJ6ufPpwL3swBRrHNucH9f/D8aQZkhmS9AsfSvq+UqQf0Dh0Qb/A1y6wT9fHE
         p9UoDddXonPPPc3dOyjc06jXcH3owIOqEaQvF1R94FoLvJeMh1cylQwAD1IS1iBreyFo
         RrzQ==
X-Gm-Message-State: ALoCoQkRQQ0rcsfc4Uhyeumgkl6fj/XRReDrf8rh8mRvXmchmSiY8pqLblUJkvRzU1TCLxdzKCjv
X-Received: by 10.180.189.17 with SMTP id ge17mr16716038wic.90.1440659954863;
        Thu, 27 Aug 2015 00:19:14 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id ne7sm2140308wic.12.2015.08.27.00.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 00:19:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0
In-Reply-To: <1440659938-12952-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276661>

If p4 reports a tag for a commit that git-p4 does not know
about (e.g. because it references a P4 changelist that was
imported prior to the point at which the repo was cloned into
git), make sure that the error is correctly caught and handled.
rather than just crashing.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 073f87b..a62611a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2494,9 +2494,9 @@ class P4Sync(Command, P4UserMap):
                 # find the corresponding git commit; take the oldest commit
                 changelist = int(change['change'])
                 gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
-                     "--reverse", ":/\[git-p4:.*change = %d\]" % changelist])
+                     "--reverse", ":/\[git-p4:.*change = %d\]" % changelist], ignore_error=True)
                 if len(gitCommit) == 0:
-                    print "could not find git commit for changelist %d" % changelist
+                    print "importing label %s: could not find git commit for changelist %d" % (name, changelist)
                 else:
                     gitCommit = gitCommit.strip()
                     commitFound = True
-- 
2.5.0.rc0
