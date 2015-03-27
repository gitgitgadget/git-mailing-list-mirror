From: Stefan Beller <sbeller@google.com>
Subject: [PATCH V2 3/6] line-log.c: fix a memleak
Date: Fri, 27 Mar 2015 15:32:46 -0700
Message-ID: <1427495569-10863-4-git-send-email-sbeller@google.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, tr@thomasrast.ch
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 23:33:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybcoa-0005f7-RB
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbbC0WdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:33:16 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38609 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbC0WdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:33:08 -0400
Received: by igbqf9 with SMTP id qf9so32284740igb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=TU2EN/oPND3ZTZtupfBCH4uRFdezopqQ0gF1o12rE4mdXGIMOxbT+2O6KJi0Ih/Y5o
         fSpqqigOE/UKuMWeddRyC9yt3+ouqYwBQCLjvkoVde67QPOmBnmgEjYry2cr0toxTprj
         GIcYqaWvN86B3sUw7tORR0yoDUiwKFwamgd+xM7VVI4FZDHte/gilMxuuwZbPudu3sp2
         eLi6OMZwqSP6ouebioRNLimuYbNyuCzqi8IR4LQgP7oeJ9V6mGL8XIwX2+RFm7LLKfPI
         V0NRIFXDzTZYvnOWXsuouWp/9rog4thI3rIyTT0R+YuS0NqmvhIHgLl2CRzWAIwarj37
         EF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxFZaq4wDCCloOxfbFp4VmiPmh+xSWNXwJ/EsqAoCxE=;
        b=VyksCVoYHVsxomyM0LDZ147RlnBxLVaH1TyVRZIxGNXUBLrg4sKPuoSdHBCcvaUboT
         xVdDEkjKqQHmFAsHywR/U4kwv88pNfmWMPbHt4mihZxzEo5dzLdHk5+c7dxFOpar23S/
         N/f+zaANo6CeKLQvzLA2eRJq3J/bhtR+U5QMrfmGXK3wyE0YjOzdMpN00mlGkn/NI3Wg
         FdYft+Ba/xdOrtcm2nDfRF4c+/wlqbJnJmTjEahQnTUf5jhgCvxfDly4+uFEzcBYkolK
         thN0sdmJKz33v2V+/2XOETFAyru8zt+mLdHMNJ8ygSKfmc46YXc7y9Tltf/heil9TCgi
         ffsQ==
X-Gm-Message-State: ALoCoQlnvdu0Xhc9BbU6bhHqYeeSm4O3VPmw3iz/B+Dk6oSUKxYT6tPn/j1/9SdSlyGzT0Ki6PI9
X-Received: by 10.42.207.206 with SMTP id fz14mr47902882icb.34.1427495587602;
        Fri, 27 Mar 2015 15:33:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id d63sm2181247ioe.34.2015.03.27.15.33.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:33:07 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427495569-10863-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266397>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 line-log.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/line-log.c b/line-log.c
index b43ac58..db6e58d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1129,6 +1129,9 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
+	else
+		free_line_log_data(parent_range);
+
 	return changed;
 }
 
-- 
2.3.0.81.gc37f363
