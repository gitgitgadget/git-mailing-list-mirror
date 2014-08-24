From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Mon, 25 Aug 2014 03:25:58 +0530
Message-ID: <1408917358-2372-1-git-send-email-arjun024@gmail.com>
References: <53FA057C.3070206@ramsay1.demon.co.uk>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Stefan Beller <stefanbeller@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 23:56:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLflo-0002cY-20
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 23:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbaHXV4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 17:56:11 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45819 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbaHXV4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 17:56:10 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so18968713pde.24
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZh03pZ/ZHZrr46nstWymWwjqBzrpF2ebd8QEbabnzc=;
        b=Jy8iYFpK+inzC1Qdqc93GWyrfGuJGnfYsbfsGALGhiRU+BuRTR5Y0DGig5Ug2q4ukv
         KNX2YSdd8IiOALQ/AGO1Xkozyb/Zowzi3Ff7+VTdc8PjexV25IKDSRW28fa6VidYuSlK
         Oy8q08rZLmY8JmRix2LXmcXrXWrmVhujy1+nw6ce62fbF4E0bKcR1HpvBvQ+oou54N7y
         +pT4eVgFsKaVylyD4Q5uKUfkmurJYt+OIohiOU0FlJyKi3W5rQfk2S8IiT+8OxSdDHe4
         nw2Mkkz8bgZhNLPwUaAMvjgdieFfCRTpM75L/OFCgLa1cxFpY0hZzUAJXGVlR1upkWh2
         OU7Q==
X-Received: by 10.70.130.195 with SMTP id og3mr23005019pdb.59.1408917370065;
        Sun, 24 Aug 2014 14:56:10 -0700 (PDT)
Received: from localhost.localdomain ([117.204.88.13])
        by mx.google.com with ESMTPSA id zc5sm23530854pbc.43.2014.08.24.14.56.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Aug 2014 14:56:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <53FA057C.3070206@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255815>

find and allocate the required amount instead of
allocating extra 100 bytes

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 bisect.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index d6e851d..a52631e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -215,12 +215,16 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 	}
 	qsort(array, cnt, sizeof(*array), compare_commit_dist);
 	for (p = list, i = 0; i < cnt; i++) {
-		struct name_decoration *r = xmalloc(sizeof(*r) + 100);
+		struct strbuf name = STRBUF_INIT;	
+		struct name_decoration *r;
 		struct object *obj = &(array[i].commit->object);
 
-		sprintf(r->name, "dist=%d", array[i].distance);
+		strbuf_addf(&name, "dist=%d", array[i].distance);
+		r = xmalloc(sizeof(*r) + name.len);
+		memcpy(r->name, name.buf, name.len + 1);
 		r->next = add_decoration(&name_decoration, obj, r);
 		p->item = array[i].commit;
+		strbuf_release(&name);
 		p = p->next;
 	}
 	if (p)
-- 
1.7.11.7
