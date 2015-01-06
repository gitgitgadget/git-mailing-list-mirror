From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 02/11] receive-pack.c: die instead of error in case of possible future bug
Date: Tue,  6 Jan 2015 11:40:47 -0800
Message-ID: <1420573247-10250-1-git-send-email-sbeller@google.com>
References: <20150105212523.GN29365@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 06 20:42:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8a03-0004OK-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbbAFTlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:41:03 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39381 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbbAFTlB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:41:01 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so4593020ieb.3
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 11:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpGQEMKslI6WGVcI/HSkp+7sR3X90H8yF5qf0atLnZo=;
        b=fqUPbc7inzZSkTy8F7apq+P12yEwlieiRgZsJ2HDvRKrhdQmUigste6Jqut1hPHlIN
         6hKO3gdD4sZREfYbwlHvLL0NwTXqAXlT9X4JJ3bbtfL3XgWUGAcSETazKJIYr6J4OyGJ
         pqj9CqNbEfKWdm/x0zq/jYdWV6NrH15IIRd7/OETXwuVUFoqIEFXJx85fYIcTP5GVniW
         rJJNU5Lc9qkHhq1n/3s+f6elwt4Byvy5i6DdUxZF9BcJk/Drs1AHRupbxNPr9RvFShmu
         htVndJcnRvaraI38J0idbAEAwCKc+S500MqNK2JXiss28ppwQIBieSVz5I6hWdKV2lOw
         IPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpGQEMKslI6WGVcI/HSkp+7sR3X90H8yF5qf0atLnZo=;
        b=X1cz834dgIzvp/gnN1gXD1NxacwY4uJ4dFDJ/98xFdMcSkmVjHMKKz/ugDdcDKHWeD
         zHWBhLhSu1hWM3TkWwCb5yScKA57BhqxQ7HKpk5ikWzrZycUgH65qL8oEmOZu6GGZi0A
         XOznQJQhUNLrgS51qQs333ixb8h9Ur8lgXcA4FdFiIajUuPdvRQUZLlQ4tNR3UbfAs+l
         jYStdnsrUoP2OQ+9XKnUtLj9Rk/QnpGPUqkg+xQL70tSrAE4fz31DOFkcfcV1qpg2k79
         Y45OtUArVXYc/PbhME9o1yeGo9UjJmmbK7EVLhik7G5eTrL9Td2t0riulyJgCul9DVb6
         UMgQ==
X-Gm-Message-State: ALoCoQnS5W2QsFI7/X8yrrsRRtZ7i8l+0N74dJA8tdhqOUbd/aBC5HYfMY5bQdESTy0RFkM/QXQP
X-Received: by 10.107.25.74 with SMTP id 71mr87726438ioz.70.1420573260522;
        Tue, 06 Jan 2015 11:41:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:59c9:bff1:416:944d])
        by mx.google.com with ESMTPSA id 23sm28408843ioq.1.2015.01.06.11.41.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 11:41:00 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <20150105212523.GN29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262096>

Discussion on the previous patch revealed we rather want to err on the
safe side. To do so we need to stop receive-pack in case of the possible
future bug when connectivity is not checked on a shallow push.

Also while touching that code we considered that removing the reported
refs may be harmful in some situations. Sound the message more like a
"This Cannot Happen, Please Investigate!" instead of giving advice to
remove refs. Running 'git fsck' should not cause any problems though.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v11:
    * only die at the end so the loop works out for all refs.
    * Remove the advice to delete refs.
    
    > If the message says
    >        fatal: BUG: connectivity check skipped???
    > then it has exactly the right amount of information to tell me what to
    > do.  Now I have
    > - a short string to grep for in the source code (or on the web) to
    >    find out what happened
    
    And do a git blame to see previous versions?
    
    I am not so sure of this patch any more as it actually stops people
    doing work if they want to do so. (They may deliberately choose to
    ignore the BUG:... message, because of a deadline in 2 hours.)
    
    So I do think this helps on getting people to report the bug in the
    future if it arises faster, but on the other hand if we assume the
    faulty hardware scenario and the deadline we actually stop people
    from getting their desired work done.
    
    This patch doesn't actually relate to the topic of the series
    (atomic pushes), but is a cleanup-as-we-go patch. If we need to
    have further discussion on this, I'd rather want to delay this patch
    and have a follow up on top of the atomic series.
    
    Thanks,
    Stefan
    
    v10:
    * new in v10.

 builtin/receive-pack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2ebaf66..7b0d0f4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1061,9 +1061,8 @@ static void warn_if_skipped_connectivity_check(struct command *commands,
 		}
 	}
 	if (!checked_connectivity)
-		error("BUG: run 'git fsck' for safety.\n"
-		      "If there are errors, try to remove "
-		      "the reported refs above");
+		die("BUG: run 'git fsck' for safety.\n"
+		    "BUG: connectivity check skipped???");
 }
 
 static void execute_commands(struct command *commands,
-- 
2.2.1.62.g3f15098
