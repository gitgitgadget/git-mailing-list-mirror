From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 07/10] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Thu,  8 Oct 2015 14:48:02 +0530
Message-ID: <1444295885-1657-8-git-send-email-Karthik.188@gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:20:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7Mw-0000cP-98
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbbJHJSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:31 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33504 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbbJHJS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:28 -0400
Received: by pacex6 with SMTP id ex6so49749163pac.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WmJIYGlyqwuDaDvY0QHjv2eJeaMwSZijXbT/aP/K4QQ=;
        b=NkcSIxveo/HCoWTKSxnWhZxJYcqzzIC71/Xg1pxj6RI3nqSC0LxflosB4Pbr5N370g
         O9q5eIkDKyG2VZ6Zcfs7Dh/LVDVix/iBAgqBEkmctvZ+AIXC79YzmfQuI/fWTKGajUtq
         VGEGtf6SbfPSeFjrVv/jRNJcdmm2wGuXugvUsWlZR0/TyiobQKD4P53S53pVgk6zKRBb
         E514ppm2DMZip9AGOsS253BL3Y2AebxWbuN7VfoDKwHjzamYwjzsPYSYo63JHfCGPXvt
         bqxXvbkeVhrgUGYmpcOmftfcQPHcRr6kSiZRX/E4WIGOHOz4ggcELt48d927drswe+Tw
         gXgA==
X-Received: by 10.68.137.161 with SMTP id qj1mr7004279pbb.14.1444295907423;
        Thu, 08 Oct 2015 02:18:27 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.18.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:18:27 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279233>

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
index 38e4424..6a38089 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1118,8 +1118,10 @@ static void populate_value(struct ref_array_item *ref)
 				char buf[40];
 
 				if (stat_tracking_info(branch, &num_ours,
-						       &num_theirs, NULL))
+						       &num_theirs, NULL)) {
+					v->s = "[gone]";
 					continue;
+				}
 
 				if (!num_ours && !num_theirs)
 					v->s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 6fc569e..4f620bf 100755
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
