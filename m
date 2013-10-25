From: Milton Soares Filho <milton.soares.filho@gmail.com>
Subject: [PATCH] graph.c: visual difference on subsequent series
Date: Fri, 25 Oct 2013 18:51:27 -0200
Message-ID: <1382734287-31768-1-git-send-email-milton.soares.filho@gmail.com>
Cc: Milton Soares Filho <milton.soares.filho@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 22:51:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZoME-0004XD-VC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 22:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab3JYUvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 16:51:43 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:64553 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab3JYUvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 16:51:42 -0400
Received: by mail-qe0-f51.google.com with SMTP id q19so2711544qeb.38
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=I5AMYyi6HEDTShRPlupMuY9TLKdtcZNoYOL/smN9SiU=;
        b=H6wDIEsAdpFXvKzh2p6jhIB+zXTrinGxAJKQ8RKt8CdKNZkS+h0RqyHH6oUR/tDZvu
         p03G4GjpCH2tHxER1pUQSNqu1CV/0Z3CjSQ7Fyjgr1A5l9H8wh1nH5npdfjzUAF5VjXk
         iFtuwclItuH/Xg2rGW57wwd24tenRL2qQF0mzUOfrrRklaXyPJ8C6JvLS4CFkmQvSlFT
         oBWemIn7VJ1FzlOnC25wCABHvcNlFp7Or0gd/Tg+ibihJ87seUF4bwNmR5D+23PXS7dO
         GRAyjgb8kpKmK96Hfb/02NDyrVTzkgyODD4cuQxDmCYL1cqee2QKe3SVDCge3nqszmrS
         tBNQ==
X-Received: by 10.49.61.9 with SMTP id l9mr13483626qer.64.1382734302289;
        Fri, 25 Oct 2013 13:51:42 -0700 (PDT)
Received: from localhost.localdomain ([186.212.83.148])
        by mx.google.com with ESMTPSA id r1sm23327038qam.4.2013.10.25.13.51.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Oct 2013 13:51:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236714>

For projects with separate history lines and, thus, multiple root-commits, the
linear arrangement of `git log --graph --oneline` does not allow the user to
spot where the sequence ends, giving the impression that it's a contiguous
history. E.g.

History sequence A: a1 -- a2 -- a3 (root-commit)
History sequence B: b1 -- b2 -- b3 (root-commit)

    git log --graph --oneline
    * a1
    * a2
    * a3
    * b1
    * b2
    * b3

In a GUI tool, the root-commit of each series would stand out on the graph.

This modification changes the commit char to a different symbol ('x'), so users
of the command-line graph tool can easily identify root-commits and make sense
of where each series is limited to.

    git log --graph --oneline
    * a1
    * a2
    x a3
    * b1
    * b2
    x b3

UPDATE: dealing with the mark at get_revision_mark() to address Junio C Hamano
concerns and give it a proper priority:

> It is unclear why the update goes to this function. At the first
> glance, I feel that it would be more sensible to add the equivalent
> code to get_revision_mark()---we do not have to worry about what
> else, other than calling get_revision_mark() and adding it to sb,
> would be skipped by the added "return" when we later have to update
> this function and add more code after the existing strbuf_addstr().
>
> The change implemented your way will lose other information when a
> root commit is at the boundary, marked as uninteresting, or on the
> left/right side of traversal (when --left-right is requested).  I
> think these pieces of information your patch seems to be losing are
> a lot more relevant than "have we hit the root?", especially in the
> majority of repositories where there is only one root commit.

Signed-off-by: Milton Soares Filho <milton.soares.filho@gmail.com>
---
 revision.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 0173e01..ab0447f 100644
--- a/revision.c
+++ b/revision.c
@@ -3066,7 +3066,9 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 			return "<";
 		else
 			return ">";
-	} else if (revs->graph)
+	} else if (revs->graph && commit->parents == NULL)
+		return "x"; /* diverges root-commits in subsequent series */
+	else if (revs->graph)
 		return "*";
 	else if (revs->cherry_mark)
 		return "+";
-- 
1.8.1.2
