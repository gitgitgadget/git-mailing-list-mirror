From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rerere: fix an off-by-one non-bug
Date: Sun, 28 Jun 2015 14:47:02 -0700
Message-ID: <xmqqa8vjeca1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 23:47:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9KPx-0000Cf-C4
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 23:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbbF1VrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 17:47:06 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36294 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbF1VrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 17:47:04 -0400
Received: by iecvh10 with SMTP id vh10so104171944iec.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=nN9byYtrwd38O9KvKyC8ZRTIHTa8BB6XD743pM1ijbo=;
        b=Bjag4eLZmZaq4/s8Zn+yPtqBT+ZAyyBgjYLHWGNzGshgQtFIaPrmceODLSscX18WBz
         rQYS7HQ7usqbeHliBwW8wQzkN5Y7UM5/O05AxCim4mXLlmRDANfr12n/RfbCFDj/bZrn
         XGKL8v5XM/oODKDT0w/gdGh2joPrWnwwZyPMew8cdCGpGZ+a4SdJGdEtbqVZuQCE5GkJ
         m7vct0QhYX5T5/z25McrgZu8BGb1KZRV8A7yj5PtLrQOiQQMEXkeTKMdMNAA68iBiZO1
         H1VfRdXvp6Rpz9O7L6xlKFTPDBjzylZg5wGXHaEYn26F+rk8A5MZFEd0YLRrH9hwQDJa
         LxKA==
X-Received: by 10.107.154.70 with SMTP id c67mr15401028ioe.22.1435528024017;
        Sun, 28 Jun 2015 14:47:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a109:3c27:ff77:e0c7])
        by mx.google.com with ESMTPSA id j192sm26293753ioe.27.2015.06.28.14.47.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 14:47:03 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272926>

When ac49f5ca (rerere "remaining", 2011-02-16) created a new helper
function check_one_conflict() out of find_conflict() function, and
made the latter use the returned value from the new helper to update
the loop control variable that is an index into the active_cache[],
the new variable was incremented by one too many when it pointed at
a path with only stage #1 entry at the very end of the cache.

This "strange" return value does not have any effect on the loop
control of two callers of this function, as they all notice that
active_nr+2 is larger than active_nr just like active_nr+1 is, but
nevertheless it puzzles the readers when they are trying to figure
out what the function is trying to do.

Help future readers from unnecessary confusion by dropping an
unnecessary +1 from the returned value..

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 31644de..543df47 100644
--- a/rerere.c
+++ b/rerere.c
@@ -371,7 +371,7 @@ static int check_one_conflict(int i, int *type)
 	*type = PUNTED;
 	if (ce_stage(e) == 1) {
 		if (active_nr <= ++i)
-			return i + 1;
+			return i;
 	}
 
 	/* Only handle regular files with both stages #2 and #3 */
-- 
2.5.0-rc0-168-g2f1df93
