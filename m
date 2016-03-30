From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] bundle: don't leak an fd in case of early return
Date: Tue, 29 Mar 2016 17:38:52 -0700
Message-ID: <1459298333-21899-6-git-send-email-sbeller@google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 02:39:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4AN-0004AB-NT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbcC3AjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:39:16 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33202 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbcC3AjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:39:04 -0400
Received: by mail-pf0-f180.google.com with SMTP id 4so27831789pfd.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxCtztdw6OZAL3FCDPtLmAYETay2aUZT4dOpmy99jU8=;
        b=WsBVkDxsfek1U+rL1WL7deFf3oFRTCqgiWlb/UbfYs1UiGma3UcyUoJyxHxabCe/fz
         aNyDFEQQMkcwXWIOrxP219qvTGq4gjqJD1Q4jFLd6tQ/xBWDNfI7NPcEtuS76O0ui+s1
         RFxQeySOr2wsu0sX9YmsX6CRlGZZ4IS11JZ/WvsDPTSgAQGxY+mQPHZY1hnC87kQHA1q
         wagqoNl8QYCHOIi/6UFii+kqnSmFM4N0xM2wSVVCeaVhHpx1R1LfbV9/Mpjgv6CrU2Em
         bTZsZKGcMPjYLX+uaQcEbreidST+pPgrHI7wfFUC6msXyPppHc78qLGCxCzbPk0huDof
         n6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bxCtztdw6OZAL3FCDPtLmAYETay2aUZT4dOpmy99jU8=;
        b=X6QBXkHEAthPaQf0XRMr4EQXBjpdcM3sFL+abyPGfowlc/9u3eNoe0zlXyR8gGl1tL
         0voajawXKjDYUipaxuNGLkHyfLe8QEOVc31LSoCMjUpRAFaiMqaxjIq3cQ6z9JB+fZZX
         XJVfwQW3Bvd8fZoPnOc4Zy4/U0M/81qX59Q1l01udXkUy8ilSoTz7WLssmYo2KhXOv2y
         uooYJMVck7EIlfNWmRbfiAbZ8YJGwmWfrcStFEGA/njLvi85nxrhpy3Lvu92Qna4qzPx
         imJG6Ynxt3g7dC/5igoVKeOQoUsTpFFm+X/FxdU1FNG2eSslqNLDe3OIlwwUIva8ina6
         ajew==
X-Gm-Message-State: AD7BkJJUFOAPqvpiA3AO220e83/QHaa5Ne0BfNGuB1dHVVXQs/GA4j/eBzslJEuMUy7E15vI
X-Received: by 10.98.12.154 with SMTP id 26mr8265217pfm.20.1459298343462;
        Tue, 29 Mar 2016 17:39:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id fk10sm988812pab.33.2016.03.29.17.39.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 17:39:03 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.8.g27a27a6.dirty
In-Reply-To: <1459298333-21899-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290237>

In successful operation `write_pack_data` will close the `bundle_fd`,
but when we exit early, we need to take care of the file descriptor
ourselves.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 bundle.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 506ac49..04d62af 100644
--- a/bundle.c
+++ b/bundle.c
@@ -434,8 +434,11 @@ int create_bundle(struct bundle_header *header, const char *path,
 	init_revisions(&revs, NULL);
 
 	/* write prerequisites */
-	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
+	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv)) {
+		if (!bundle_to_stdout)
+			close(bundle_fd);
 		return -1;
+	}
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
@@ -447,8 +450,11 @@ int create_bundle(struct bundle_header *header, const char *path,
 	ref_count = write_bundle_refs(bundle_fd, &revs);
 	if (!ref_count)
 		die(_("Refusing to create empty bundle."));
-	else if (ref_count < 0)
+	else if (ref_count < 0) {
+		if (!bundle_to_stdout)
+			close(bundle_fd);
 		return -1;
+	}
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &revs))
-- 
2.8.0.8.g27a27a6.dirty
