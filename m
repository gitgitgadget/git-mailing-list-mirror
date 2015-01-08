From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 02/10] receive-pack.c: die instead of error in case of possible future bug
Date: Wed,  7 Jan 2015 19:23:16 -0800
Message-ID: <1420687404-13997-3-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93hS-00062p-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbbAHDXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:23:48 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:51423 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbbAHDXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:46 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so882189igi.0
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmX/RR0UYSiC6s69PHMyVCo2i3yqs4DhBBgbZlPzfEw=;
        b=Gg1l/hqieNHRMDn3bGpXZGJR8LU77VtkIyGEIPXfgMD6MK3wgkP3gbZ9QDWC6X8jUC
         GTKmQpQnhNjEwD1iRbccw8P3YLgkiNFIgrL/c/EE09uY5kr1qdxqUOXkSp4a35kBvmMN
         tgaCjlAkwarWZy5eEN4P7Ga+BDpI5HKY6YgaXIx+CeOYuPAu0IZlZKzVFxMFudS3pUuw
         L1pxB4n1KxVUzodnoOR1o8lCW4AlVTxXc9Pi9OvP7h2Jd7rPn6SzaBzsZ86NSZJub1lt
         lGftwNg5FQcEmYTnZ70J6AJ+ZFuRpOy050awWYIGZS99CzHkLZSkK2UN6ubfKfBVZ+wo
         c8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmX/RR0UYSiC6s69PHMyVCo2i3yqs4DhBBgbZlPzfEw=;
        b=FJnOgpLlO7NYvIp7abirm0R7jW4gfFc6AZjg6tGEJNG6+nb5k3pelP9YHdyCiMwQDQ
         AI+rbhBqijocLsUQx+QEzGx3S2csqecqnhrJ25bsZoqQKrNvR3s1hZLamm9nYv+AjxOc
         R+1x47dgg4e/eVlXMxkuS5ppTgcOOcbAWACDOtzzhCDk/Od+Y5CSk6fSf6zeNQbLxByN
         RE9vO7Qg27oG+nuwvE9RfextTSHczUXxRTrVleE6OqWzkme5O2QRaS+O2rQfsbKp1Gbd
         JpkUd+A0IK8noHOQ7CEe5sRipsuF/EsO2PIqFTQ0xWyh0OehJCE8rkkneGGxbipnTYxV
         wfxg==
X-Gm-Message-State: ALoCoQnwE1x8a2tCv87hazl8juMntK6Uzf86iE8Dc36qRcdl7aVqGHpqU5d5jx6tHFCvEnDD8Ah4
X-Received: by 10.107.37.132 with SMTP id l126mr6408844iol.63.1420687425636;
        Wed, 07 Jan 2015 19:23:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id mi3sm7456259igb.13.2015.01.07.19.23.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:45 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262177>

Discussion on the previous patch revealed we rather want to err on the
safe side. To do so we need to stop receive-pack in case of the possible
future bug when connectivity is not checked on a shallow push.

Also while touching that code we considered that removing the reported
refs may be harmful in some situations. Sound the message more like a
"This Cannot Happen, Please Investigate!" instead of giving advice to
remove refs.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v12:
    * no advice in case we die.
    
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

 builtin/receive-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2ebaf66..3bdb158 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1061,9 +1061,7 @@ static void warn_if_skipped_connectivity_check(struct command *commands,
 		}
 	}
 	if (!checked_connectivity)
-		error("BUG: run 'git fsck' for safety.\n"
-		      "If there are errors, try to remove "
-		      "the reported refs above");
+		die("BUG: connectivity check skipped???");
 }
 
 static void execute_commands(struct command *commands,
-- 
2.2.1.62.g3f15098
