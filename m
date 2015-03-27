From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] WIP/RFC/entry.c: fix a memleak
Date: Fri, 27 Mar 2015 15:09:10 -0700
Message-ID: <1427494150-8085-11-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSU-0005EL-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbC0WKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:24 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37321 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbbC0WKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:19 -0400
Received: by igcxg11 with SMTP id xg11so32167343igc.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OtS2/gQIjLasUeF4sp8J+nLdEFXVyjrZgBWTQDaHYPc=;
        b=i/hYqMeFWog348OmygRZ2c4QF5AArC963rIMk8SdHca2oRxS6+aStlDWXS85tmYquL
         8YFA1iMEtHQC0YmnLg9ya52cCbT3RYI3Ozlp1869fiLnML5QmnFRNnHL0M99FnHVKgKR
         cUTGU6K3ZlQc4oWUdOGxFaBFdoJ9b49D8aYoi0DjkgQC7T50nyEQ4sodjvbSqOLN71LI
         nHJ9rALAtYWC+oPg/t3FZ5KfBbmJmCSeDCGtJWR+z3msT0N+JRiwNnDziVlhOOulGJDg
         It6T6OGaSD2NqpCHzQx7ZNsjCx+jUHMXZtHLY+Clg8p5L9jdhpmL9oGIE5hN10Dy4/A3
         63qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OtS2/gQIjLasUeF4sp8J+nLdEFXVyjrZgBWTQDaHYPc=;
        b=EXJu92Xh5paudEwbPJUvbAPmrJpxvXViQcwPQDbIAwd5B2/mRKrAUr/qK2RkJRxZiq
         dPbz2zaGcLe2x8zDSR7qQKTNK8zaDX+r+ThhSDOuPrX29wDfmz+I23unzySl3XZw77Xu
         HZiDZQPBCAExB702NXUthGKCIqYAGuTzi4LwZBXRIiUlCO3Q6fjM4X+mQMnzkyNlkCgZ
         d2trXDGK5FVxEly1+0EhwBMHIVo0OLhr90WU/XRKunO4l7gU9LIwUAVUjhGLHc01ltYL
         f5irxLr7OiVdgByCCo5om/jxcUkqbyixNuzbLz3+RsYxaHOFGjcI9FFWkHsHJ0V54fb3
         vyvQ==
X-Gm-Message-State: ALoCoQnHCdypeKKLdh5UI/loXKgdwbkOZMHTlvMfmZ29xBIx/YX6zvAe2tpOQ8FfVOjL9CBCfPH/
X-Received: by 10.107.19.88 with SMTP id b85mr32508499ioj.75.1427494218519;
        Fri, 27 Mar 2015 15:10:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id t5sm2507716ign.12.2015.03.27.15.10.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:18 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266387>

I  observe that filter is going out of scope, but the
implementation proposed in this patch produces just a
crash instead of any helpful fix.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 1eda8e9..5383001 100644
--- a/entry.c
+++ b/entry.c
@@ -152,8 +152,10 @@ static int write_entry(struct cache_entry *ce,
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
-					   &fstat_done, &st))
+					   &fstat_done, &st)) {
+			free_stream_filter(filter);
 			goto finish;
+		}
 	}
 
 	switch (ce_mode_s_ifmt) {
-- 
2.3.0.81.gc37f363
