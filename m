From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Sun, 24 Aug 2014 19:47:24 +0530
Message-ID: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 16:17:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLYc2-0008Do-DN
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 16:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbaHXORi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 10:17:38 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49512 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbaHXORh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 10:17:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so19426676pab.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7YLp9w1p+geavD+aOq8CHnneofGLr1z3AATtLu6cDcY=;
        b=y10dem4YPvhs1pUAd2Mtha9LQLfWeA+0CFswm47QYxLfERW9pIKyn1OUh20o+0Z99W
         ng8rb2Non2YojyZqFLvMT5DGPM1yDCI9usT+8lagHWJj68dlCTywQKNgUZUjOblpJiyj
         oMFv1GtLOezhqijn0vBfc1b/i0UKKJPNvHvm9E1MDiOJdASldkuIMV+ov6vrb41A4ciZ
         15dn9vem1dLPBJOWuN3q+/Yn4C+QnT1LWlp0ngr7zd+XVRt312SVmt/v0RGtt+tCOP7F
         hGro5ZAsfqboQ1JoNjTXn30QtIVb30Sfj2CsfbA5GRKvGkCi4gAHGhAHhXoCBYlIoIFe
         Zcjw==
X-Received: by 10.66.141.39 with SMTP id rl7mr21210369pab.8.1408889856671;
        Sun, 24 Aug 2014 07:17:36 -0700 (PDT)
Received: from localhost.localdomain ([117.204.88.13])
        by mx.google.com with ESMTPSA id g6sm125059502pat.2.2014.08.24.07.17.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Aug 2014 07:17:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255791>

Find and allocate the required amount instead of
allocating extra 100 bytes

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 bisect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index d6e851d..c96aab0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -215,10 +215,13 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 	}
 	qsort(array, cnt, sizeof(*array), compare_commit_dist);
 	for (p = list, i = 0; i < cnt; i++) {
-		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
+		char name[100];
+		sprintf(name, "dist=%d", array[i].distance);
+		int name_len = strlen(name);
+		struct name_decoration *r = xmalloc(sizeof(*r) + name_len);
 		struct object *obj = &(array[i].commit->object);
 
-		sprintf(r->name, "dist=%d", array[i].distance);
+		memcpy(r->name, name, name_len + 1);
 		r->next = add_decoration(&name_decoration, obj, r);
 		p->item = array[i].commit;
 		p = p->next;
-- 
1.7.11.7
