From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 2/2] git-gui: change to display the diff with the HEAD in 
	the case of conflicts.
Date: Tue, 30 Mar 2010 10:01:21 +1100
Message-ID: <2cfc40321003291601v424caa0dxa5554768230297ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spearce@spearce.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 01:01:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwNxX-00066c-Ov
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 01:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab0C2XBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 19:01:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34894 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab0C2XBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 19:01:21 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so7149816pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=r8Yj4Uu2GJGuJ5seQBKu8ni54NMlF63oG2FjFNIKU0E=;
        b=chIhS27oIFVIbzoGNnmjNUeu7uaI5jPtleAQjGWk/tvkYyYNLvoaU19KS2rW82X54m
         WE8EVCRW/1lXg1KKLnwId1ayYc0I4r+pZznUSft4pq8T8uoohdA/Ad1Ol0L+ZVi/unsJ
         0oVFRpEb0Ee7A8dTD0QGuHYUoO3fu2wqU9DuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=jCYQMy+WjiOrmGnD3txSEWCtQRqf7mO9eazbapK/AnFNiuxiKKo8Isw2ghyPsUkbUj
         auVdIu62yEFN5DswxP2qse7ounHDtllnKT8HWEJSuQOWDBV6PG1SpNMzxlfDjjHo/9sC
         zGVeVJ1ofaDPWfIrBAdV9f5bfVF4Y/LD8dy3c=
Received: by 10.114.13.5 with HTTP; Mon, 29 Mar 2010 16:01:21 -0700 (PDT)
Received: by 10.114.186.40 with SMTP id j40mr1706112waf.93.1269903681571; Mon, 
	29 Mar 2010 16:01:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143528>

The rationale for this change is that the previous behaviour did not allow
the user to make an informed decision about the likely consequences
of "Use Local Version" or "Stage to commit" for conflicted files. The
reason for this is that in the conflicted case, successfully staged
remote hunks are effectively invisible to user (via the git-gui interface)
and hence cannot inform the user's decision making process.

For example, previously use of "Use Local Version" would silently discard
from the index, and the working tree any successfully merged remote hunks.
Since these hunks had never been displayed to the user, this
loss would be unnoticed and unexpected.

In the case of "Stage to commit", the successfully merged remote
hunks would be preserved in the index and the working tree but the fact
that there are successfully merged remote hunks would not be not
visible until after the "Stage to commit" action has been taken.
If the user did not check diff _after_ taking the action, the user
may have unwittingly commit changes from a remote hunk
that she was not aware of.

With this change, in the case of conflicted paths only, git-gui displays
what the index would contain if the current working tree copy was
staged to the index as is. If there are successfully merged hunks
from the remote branch in the index, then these will be visible in diff,
thus making the potential consequences of both "Use Local Version"
and "Stage to commit" directly visible prior to the user's action.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-gui/lib/diff.tcl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index e7b1986..a017fba 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -300,7 +300,11 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 	if {$w eq $ui_index} {
 		lappend cmd [PARENT]
-	}
+	} else {
+		if {$is_unmerged} {
+			lappend cmd "HEAD"
+		}
+        }
 	if {$add_opts ne {}} {
 		eval lappend cmd $add_opts
 	} else {
-- 
1.6.6.1
