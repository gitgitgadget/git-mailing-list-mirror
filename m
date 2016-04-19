From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 08:21:28 -0700
Message-ID: <1461079290-6523-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com,
	peff@peff.net
X-From: git-owner@vger.kernel.org Tue Apr 19 17:21:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXTA-0005DR-2G
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbcDSPVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 11:21:35 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34041 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcDSPVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:21:34 -0400
Received: by mail-pa0-f52.google.com with SMTP id r5so6945772pag.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=svVpgBoc9Pb6sY6VdSy1Qe2RY6PMcCea0TOgY2XgWX0=;
        b=EbjlCfRKtYWr7aps1YHvFdkUXgddRO62cb29wFMOMphG6M77opEWq4+tH9JVkp3COV
         AoFuZ0cw5rp38Aa2ozE7NLKrAS9ANY9owl0ryH7YVi0VRAiMiadKF4W3e6GEDBbp/F7G
         5hDHhFwHGxmU5l/qGfY1YeF18SkTO73F+BG1Uq7fkqlaTydjxq6NcQMI1linFks7dW/S
         uK0bkfbFQ6A4CQPiY+GY5PFGFQKUq8P21gY7eeGXzLTQmVJpjWcZSolLZxCFIZl76CT2
         eR1VHEKKSgps5BaBEWGGoD2LIUQj+DDJmVzYsC1sJPyMDhD8ZnKmsr5+wXZkWawUZ7F1
         PX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=svVpgBoc9Pb6sY6VdSy1Qe2RY6PMcCea0TOgY2XgWX0=;
        b=RuUOPOD1gm2Pr4EzBo4V0g5dXL040rDwn+8bVRIwn9/Cr2BPqjcHwLLKxDLYis3o5L
         0sERLu8rk2woFtju0QM2R9sHTEmfU7L2gPKR4pTq+OyRaPcJSSwXXVrRMejvTiFJ/U0U
         t05UKTeAMqAxLhDXj7xE90CA8SG2XWVdG4JAZsGD94TU/18CAUzv8nZwrtlyfTWVYIZy
         YKnAd8GEGgjxmXTkngSxeQhvwcX2823r2rdwJeia7TXtSq4H2OkJIHiERrhp1W+vheT4
         kj3cJFzq1RqaAWdto/zgNBwgfYaH7zIPxhmBfrq01aq7xEsZrMz3YbbZeHJWBel2T9DW
         R5mg==
X-Gm-Message-State: AOPr4FU7hH6HHZdMocSYEW8aJ9mysQ83NHChvIwq6Frk4Bpnq1hB9RaeRwv4CXrL9M6oLcH2
X-Received: by 10.66.121.197 with SMTP id lm5mr4809044pab.143.1461079293562;
        Tue, 19 Apr 2016 08:21:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7418:717f:4b27:128f])
        by smtp.gmail.com with ESMTPSA id dy6sm91996056pab.48.2016.04.19.08.21.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:21:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.11.2.g96ed4e5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291874>

Thanks Jeff for pointing out issues in the comment!

Thanks,
Stefan

diff to origin/jk/diff-compact-heuristic:
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5a02b15..b3c6848 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -515,12 +515,12 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		}
 
 		/*
-		 * If a group can be moved back and forth, see if there is an
+		 * If a group can be moved back and forth, see if there is a
 		 * blank line in the moving space. If there is a blank line,
 		 * make sure the last blank line is the end of the group.
 		 *
-		 * As we shifted the group forward as far as possible, we only
-		 * need to shift it back if at all.
+		 * As we already shifted the group forward as far as possible
+		 * in the earlier loop, we need to shift it back only if at all.
 		 */
 		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
 			while (ixs > 0 &&


Jacob Keller (1):
  xdiff: add recs_match helper function

Stefan Beller (1):
  xdiff: implement empty line chunk heuristic

 Documentation/diff-config.txt  |  5 +++++
 Documentation/diff-options.txt |  6 ++++++
 diff.c                         | 11 +++++++++++
 xdiff/xdiff.h                  |  2 ++
 xdiff/xdiffi.c                 | 40 ++++++++++++++++++++++++++++++++++++----
 5 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.4.11.2.g96ed4e5.dirty
