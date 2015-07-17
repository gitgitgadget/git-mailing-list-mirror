From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/18] rerere: fix an off-by-one non-bug
Date: Fri, 17 Jul 2015 15:24:23 -0700
Message-ID: <1437171880-21590-2-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:24:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE3o-00043N-J6
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbbGQWYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:45 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32883 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbbGQWYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:44 -0400
Received: by pdbqm3 with SMTP id qm3so68132406pdb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=8GfzR4K5tOQeNLINfcY3iQ6DOYMd4+zPr8bbcdu616g=;
        b=gIjiFspSBsXlFUGJWNk8Sa4HVPyq5e5sU2mPoF7MH/VO9l4OGkJajn0I9i9oAQ0Oz2
         32yq52StRXf5+hEsMBXgIwDJxjzdeo2YEfTKwfF4cKBziV2YnOt8OjjJJ89v4u3/AprE
         LanUPfC6vGsFdPjY4WO9WI9zIXHwYjRy1BO9j/vIeaTuMWSfCqeTazWWwnwDdubylD1W
         CrtT+cjE9UQXyz/OVlqSmeRdA+gH6H97HcEsnr1VZiRlGkHBGOeWGL4iQGctf0nPVkC3
         DUCv7GAo8pVQBWjt19RDYJ/+NXuMq2aDBSRihqfRtkdLobdu/7KA+TQeX3JGZxKFEdy2
         BiaQ==
X-Received: by 10.66.147.131 with SMTP id tk3mr33956317pab.104.1437171883891;
        Fri, 17 Jul 2015 15:24:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id r9sm12377372pdp.5.2015.07.17.15.24.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274108>

When ac49f5ca (rerere "remaining", 2011-02-16) split out a new
helper function check_one_conflict() out of find_conflict()
function, so that the latter will use the returned value from the
new helper to update the loop control variable that is an index into
active_cache[], the new variable incremented the index by one too
many when it found a path with only stage #1 entry at the very end
of active_cache[].

This "strange" return value does not have any effect on the loop
control of two callers of this function, as they all notice that
active_nr+2 is larger than active_nr just like active_nr+1 is, but
nevertheless it puzzles the readers when they are trying to figure
out what the function is trying to do.

In fact, there is no need to do an early return.  The code that
follows after skipping the stage #1 entry is fully prepared to
handle a case where the entry is at the very end of active_cache[].

Help future readers from unnecessary confusion by dropping an early
return.  We skip the stage #1 entry, and if there are stage #2 and
stage #3 entries for the same path, we diagnose the path as
THREE_STAGED (otherwise we say PUNTED), and then we skip all entries
for the same path.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index 31644de..e307711 100644
--- a/rerere.c
+++ b/rerere.c
@@ -369,10 +369,8 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	*type = PUNTED;
-	if (ce_stage(e) == 1) {
-		if (active_nr <= ++i)
-			return i + 1;
-	}
+	if (ce_stage(e) == 1)
+		i++;
 
 	/* Only handle regular files with both stages #2 and #3 */
 	if (i + 1 < active_nr) {
-- 
2.5.0-rc2-340-g0cccc16
