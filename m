From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] revision.c: Remove unneeded check for NULL
Date: Fri, 26 Jun 2015 12:40:19 -0700
Message-ID: <1435347619-29410-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 26 21:40:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ZUF-0001lP-LY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 21:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbFZTk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 15:40:27 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33753 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbFZTk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 15:40:26 -0400
Received: by ieqy10 with SMTP id y10so82379747ieq.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Wj4dku2Z9clpCS5GiYOUe07CiQSwnnSntjYvi/EfsH0=;
        b=Z62b9lSP4FuP4v51a7c9ZorbSLzPVlkETCf116+J4uqcDgFFKqfUaMshK5aS40021V
         MY4vAr//gtj7k34F+0pIYEl0fPJjbJnRN5BRmIgyHON0ymDEXvwZFvMoMq4BMHmYd7Jc
         +KvQo8VBS637MwVbP+ALraqJ35+rH/6+tZ+miWTI6Y9XqFArmo9VT1MOpNWy5XzSMSXT
         FSfCV9EODgz4sUvNjoy7RsY7/Ma8FTZOJBtWMZ1uAkyufB980zoQfLBi3hX1yBVKbgIX
         Gziw+CzinLfzT+pCtm+g5ZJ5YzKKa22c5aIWHn+FuM7ZS90P6Vt4zOyDQswejhORA0JF
         PtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wj4dku2Z9clpCS5GiYOUe07CiQSwnnSntjYvi/EfsH0=;
        b=GYZ+/ZnfhlQfafCoj8dJjq0s31d9Yfll1U31HDZ9fZtVBA8kDkEe7ZBwnkjzgevTkQ
         cRNy9EURioKeryhGgEyYjpCXYXaF45I45z2l8zediW6ixmWJvxTaV+g8E/3coL9LDcfa
         /fLxmX/bON9FaghmrRp8LovugGFT7ovbiouF8icGYeRlYhu790PF+6IsryXi+zy7SbUN
         uxzkOR7kTheuOsWMsSowHL0zHINAM+OWYb+CkTSMBvKDFTmrUvEI9erzgby6vj6oqMt7
         5ogw7oIpCqBhbrZV3iSrobUI8qqHJSQreAncEjMvnkEgX6hgGtlxz7XxxDcj+FkPMF1F
         Jr1g==
X-Gm-Message-State: ALoCoQk8ia0fsgaRv3P1t/s4flju/o4S4MTY8De0Hb3rRqx5ASzDHGDLwQBasldBKSa/l6Qh4PTT
X-Received: by 10.42.72.132 with SMTP id o4mr5526037icj.20.1435347625327;
        Fri, 26 Jun 2015 12:40:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5cb3:17a8:2ff6:7709])
        by mx.google.com with ESMTPSA id j20sm1438035igt.16.2015.06.26.12.40.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 12:40:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272816>

The function is called only from one place, which makes sure
to have `interesting_cache` not NULL. Additionally it is a
dereferenced a few lines before unconditionally, which would
result in a segmentation fault.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    > So I think the right solution is just to drop the conditional entirely.
    > The current code is not wrong (it is always a noop). What you have here
    > actually misbehaves; it does not update the cache slot when it has
    > become UNINTERESTING. That does not produce wrong results, but it loses
    > the benefit of the cache in some cases.
    
    After reading the code a bit more, I agree.
    
    > I'm having trouble parsing this sentence.  Do you mean that limit_list()
    > only calls still_interesting() (and thus, indirectly,
    > everybody_uninteresting()), with the second parameter equal to the
    > address of the local interesting_cache variable, so it can never be
    > NULL?
    
    I completely reworded the commit message.
    
    > Should there be
    >
    >        if (!interesting_cache)
    >                die("BUG: &interesting_cache == NULL");
    >
    > checks at the top of still_interesting and everybody_uninteresting to
    > futureproof this?
    
    I don't think this is necessary as these functions are local functions
    so when somebody wants to use them they will be aware of the limitations.
    
    > This code seems to be underdocumented.
    
    I am not a expert in this area of the code, so I hoped Peff
    would document it if he feels like so.

 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 3ff8723..ab97ffd 100644
--- a/revision.c
+++ b/revision.c
@@ -361,8 +361,8 @@ static int everybody_uninteresting(struct commit_list *orig,
 		list = list->next;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
-		if (interesting_cache)
-			*interesting_cache = commit;
+
+		*interesting_cache = commit;
 		return 0;
 	}
 	return 1;
-- 
2.4.1.345.gab207b6.dirty
