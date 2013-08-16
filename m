From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] create_delta_index: simplify condition always evaluating to true
Date: Fri, 16 Aug 2013 23:22:37 +0200
Message-ID: <1376688157-8374-1-git-send-email-stefanbeller@googlemail.com>
References: <EE5B338564E14F89B349550B37741AFF@PhilipOakley>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, nico@fluxnic.net,
	sunshine@sunshineco.com, philipoakley@iee.org
X-From: git-owner@vger.kernel.org Sat Aug 17 00:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VASSe-00087A-9t
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 00:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab3HPWZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 18:25:30 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:59086 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab3HPWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:25:29 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so1241939eaj.20
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3K1DbsQfux7ufg4kVqlEAdk+YGvUo5lMK8JbBLQBEQ=;
        b=vnRqz6pAxjVuHaS3AYmdK8VgR0VlkYhrNc7BcNwXvJLwq+VSGHyzA5eFxx1yl3xCIO
         v7UPoyLvZecbh2gwQqLt84OmsvB3PrA6E1WnBkLkO4ejjaYMKamX+EA/LGJzkJXRgABb
         fQHg/EFOvMz8aEeMv3MNKmLEj+LEuQ0Ho1pw9j4WgO0fZR7H0TV85GFInCsSKW70kJO0
         Q8iOaoan0dv8NLoURvNYNovPvihInh1ZqEVfm4KDk96ZkgOg+rALoA3QuWjxZ6FoSOpt
         PYXnruDhyQn8kIrzHV/jSK88yOIjMilVZMZFrG8w6FqnElOt69NZkjr3Ej+Jq2BsLUSC
         a+bg==
X-Received: by 10.14.4.1 with SMTP id 1mr4918107eei.21.1376688158032;
        Fri, 16 Aug 2013 14:22:38 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id h52sm5453687eez.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 14:22:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.g2c2b664
In-Reply-To: <EE5B338564E14F89B349550B37741AFF@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232442>

The code sequence  ' (1u << i) < hsize && i < 31 ' is a multi step
process, whose first step requires that 'i' is already less that 31,
otherwise the result (1u << i)  is undefined (and  'undef_val < hsize'
can therefore be assumed to be 'false'), and so the later test  i < 31
can always be optimized away as dead code ('i' is already less than 31,
or the short circuit 'and' applies).

So we need to get rid of that code. One way would be to exchange the 
order of the conditions, so the expression 'i < 31 && (1u << i) < hsize' 
would remove that optimized unstable code already.

However when checking the previous lines in that function, we can deduce
that 'hsize' must always be smaller than (1u<<31), since 506049c7df2c6
(fix >4GiB source delta assertion failure), because 'entries' is
capped at an upper bound of 0xfffffffeU, so 'hsize' contains a maximum
value of 0x3fffffff, which is smaller than (1u<<31), so the value of
'i' will never be larger than 31 and we can remove that condition 
entirely.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---

Philip, 
thanks for the wording of your mail. I get quickly derailed from the
warnings of the STACK tool and write the other commit messages than
I ought to write. I think the wording of your mail nails it pretty
good, so I put it in the commit message as well.

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
1.8.4.rc3.2.g2c2b664
