From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] rerere: fix an off-by-one non-bug
Date: Sun, 28 Jun 2015 15:26:21 -0700
Message-ID: <xmqq6167eagi.fsf@gitster.dls.corp.google.com>
References: <xmqqa8vjeca1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 00:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9L2F-00049z-EF
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 00:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbbF1W00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 18:26:26 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38719 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbbF1W0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 18:26:25 -0400
Received: by igrv9 with SMTP id v9so29799691igr.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hpZHyBEohypJKxRjZu6ySiO4okmYOLhvg028vzgx8WY=;
        b=JTHZSVOVw2OHbd7U3FM2UYQFlsI7LgMPr/jdXtxn1QL51l7r09LVY8LMI3t6MRbmRU
         IiTsbO9fLHg6toIWrtf7o1s68Lr1gD2kwtU+XIy5Kakb8pPfaIo0kKddtKfqxLw7KbaJ
         lfrutuGwNr4xkbQidxC7vhKu5GxUfxWpwJpwqHUk52v4kwZu2m6l6wTMhXaOHOXOeObD
         eJoH89qy01B72LNFjaiWvWAAl3VqzO0+uRLo8ywK06gwPDDb6C8UdbshUYFYWQYkjc5r
         FF4pkqx4r5MnyIECCOwe+6JFBZOXuZ3e2AOT3UwqHgjjdYbaZkWqlhulBczk4XhApOB7
         E5pQ==
X-Received: by 10.50.117.35 with SMTP id kb3mr11807635igb.13.1435530384667;
        Sun, 28 Jun 2015 15:26:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a109:3c27:ff77:e0c7])
        by mx.google.com with ESMTPSA id g3sm4063709igi.10.2015.06.28.15.26.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 15:26:23 -0700 (PDT)
In-Reply-To: <xmqqa8vjeca1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sun, 28 Jun 2015 14:47:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272927>

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

 * Heh, I was an idiot.  There is nothing gained by keeping an early
   return in this codepath other than unnecessary complexity.

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
2.5.0-rc0-168-g2f1df93
