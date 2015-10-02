From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 7/9] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Fri,  2 Oct 2015 23:09:04 +0530
Message-ID: <1443807546-5985-8-git-send-email-Karthik.188@gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:39:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4J0-00040e-K5
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbbJBRje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:34 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35727 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbbJBRjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:32 -0400
Received: by pacgz1 with SMTP id gz1so12495091pac.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GWy+kwWy6SifiFYO0gkbNZJcS9Nfvj8YphYj3FLnrMw=;
        b=Cq6D3mzPTvL6CoSS/Ax+mrBxxTAueaRHjpHR8wOyt5zuYKmWHWBMGX7Sigf5UoWvHD
         cvBhntVQnC9RmXy6z5EKt3R5MuWqPiDmH+aX+UohrOmlpTvf88DrYIL9ATmCqXQYGYfA
         2s9uszrnK0Vbb0xgXVFf/kK04TZj4sZboPEYzaV7t1nRiPXezs+YHiIUrlqGcvjdtrL0
         z/LkOFBYkbQjc231q/75g4yaRKtFb55+iWYN5t/sEQW8LOll+fHz9aKwsZMCSgNH9zqc
         cH067nqw4QfwgTp5NCzzeBWSRGf2RMv2mUeIqDKbd+Gjkx5D/yc49uT17rgVTupPobpG
         baJQ==
X-Received: by 10.67.4.230 with SMTP id ch6mr21762715pad.11.1443807572376;
        Fri, 02 Oct 2015 10:39:32 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:31 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278930>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c            | 4 +++-
 t/t6300-for-each-ref.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 099acd6..48b06e3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1133,8 +1133,10 @@ static void populate_value(struct ref_array_item *ref)
 				char buf[40];
 
 				if (stat_tracking_info(branch, &num_ours,
-						       &num_theirs, NULL))
+						       &num_theirs, NULL)) {
+					v->s = xstrdup("[gone]");
 					continue;
+				}
 
 				if (!num_ours && !num_theirs)
 					v->s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7f675d2..2a01645 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -359,7 +359,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.6.0
