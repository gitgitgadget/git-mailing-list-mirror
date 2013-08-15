From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] create_delta_index: simplify condition always evaluating to true
Date: Thu, 15 Aug 2013 23:34:22 +0200
Message-ID: <1376602462-32339-1-git-send-email-stefanbeller@googlemail.com>
References: <CAPig+cQmdPo4mo69DsDmUURcw+HbxkAoNEqY08qiuJs8S+=bvQ@mail.gmail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: sunshine@sunshineco.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 15 23:34:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA5BV-0005kl-IY
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab3HOVeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:34:17 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:34520 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3HOVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:34:17 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so608152eek.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vxycgOJtNuTXrBKNm5NlxZYcuKZ+LhQLvrqf+tbXEws=;
        b=pkpZ/65jVZJwR47Ld+J+FrrJ2UoK34RaUhgXtHvCaavKV2qC/gB1dM2uoh0dC7V0nd
         bbGklN/N6uzmm3GTFda7Pa5H7ElZDd1NTSJWpEU/4hyy9/jz8QEndunWLbV3FHoiJ79T
         36aRa8C0i4MzLoUWk7bFQMZO89tJeHYNNntn7Fg96Eik+8LMpEryWaFV0eDsggYmjJGK
         81ReqMqSD2hajQcK9gMDoerOnmEXW4qazvYdnnve2oVbt+xiO4u5oST4Q+BKCe3SPfJo
         vl08svqCcmddcXQoGJOPvefzUYZHGoKsjpOOJKZqiqlzmvQKSuOMfV1sOR32KaZW0hqb
         qMCg==
X-Received: by 10.15.56.8 with SMTP id x8mr172580eew.83.1376602455839;
        Thu, 15 Aug 2013 14:34:15 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a6sm1958170eei.10.2013.08.15.14.34.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 14:34:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
In-Reply-To: <CAPig+cQmdPo4mo69DsDmUURcw+HbxkAoNEqY08qiuJs8S+=bvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232374>

When checking the previous lines in that function, we can deduce that
hsize must always be smaller than (1u<<31), since 506049c7df2c6
(fix >4GiB source delta assertion failure), because entries is
capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
value of 0x3fffffff, which is smaller than (1u<<31), so the value of
'i' will never be larger than 31.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---

Eric, thanks for reviewing my patch.

I applied the first 2 proposals (deduce, entries), but I disagree on
the third, so I reformulated the sentence, as I really meant the variable
i and not it as a pronoun.

Do I understand right, you're suggesting to remove the 
source code comment? I did this now, but I have a bad feeling with it.

The change of this patch surely removes dead code as of now and makes it
more readable. But also it could become alive again, once somebody
changes things nearby and forgets about the assumption, hsize not
exceeding a certain size. That's why I put a comment in there, so 
the future changes nearby may be more careful.

Thanks,
Stefan


 diff-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-delta.c b/diff-delta.c
index 93385e1..3797ce6 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -155,7 +155,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 		entries = 0xfffffffeU / RABIN_WINDOW;
 	}
 	hsize = entries / 4;
-	for (i = 4; (1u << i) < hsize && i < 31; i++);
+	for (i = 4; (1u << i) < hsize; i++);
 	hsize = 1 << i;
 	hmask = hsize - 1;
 
-- 
1.8.4.rc3.1.gc1ebd90
