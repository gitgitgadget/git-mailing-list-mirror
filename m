From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH/RFC] gitk: Ignore limitdiffs option when displaying commit 
	file list.
Date: Fri, 26 Mar 2010 21:17:51 -0400
Message-ID: <32c343771003261817o131ae413udb9dc579c936f5db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: markb@berlios.de
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, j.sixt@viscovery.net
X-From: git-owner@vger.kernel.org Sat Mar 27 02:18:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvKfC-0007B7-JV
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 02:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014Ab0C0BRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 21:17:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54242 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab0C0BRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 21:17:52 -0400
Received: by wyb39 with SMTP id 39so159732wyb.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:cc:content-type;
        bh=SZl+tIvcpxaeB4B9ulb9sgg9B7Yj3oCrhpJfuJB3IxQ=;
        b=T/kwrUa3kcLyt5KxeTo62ECJ7Oj2hT+N9GVYyGbP67cxVhp8rVo4O53TeGA5Y/+P0p
         uPJR4Abr9a1nkineaC06hQGd1+aaL0Eh1V/Lpb2clGuTa7pqO+dimvvQ+38kqfrtFQJn
         PGDx6OtZeVJxck1UgskmA2oYxsmnL32b5bhPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=bJj4Jf2JcMHlzlc70KgW7G1Tnim2mDpq0GeGppFE3f7nMKdDuOeD1YGlh3MeIHBWV8
         6qSSaSdabIaG9pBWQavIezCPvRC6pqLOemF0C+dOzyS3AHBNWBpK+HOwSp/eX06UcY3x
         FZkq0JxwrHjz/v/uDFBRhA5Hr3pBJ5lXGBi6E=
Received: by 10.216.72.137 with HTTP; Fri, 26 Mar 2010 18:17:51 -0700 (PDT)
Received: by 10.216.86.211 with SMTP id w61mr1042497wee.50.1269652671276; Fri, 
	26 Mar 2010 18:17:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143308>

When gitk is invoked with a path argument (e.g. gitk gitk-git),
the path is used to filter the list of files displayed in the
lower right window.  If a file does not start with the specified
substring, it is not displayed.  This is counter-intuitive for
a couple reasons:
  1) The files continue to be listed in the diff window.
  2) Merge commits (i.e. commits with more than 1 parent still
     show the complete list of files in the lower right since
     these commits are processed by mergediff rather than
     startdiff function.

With this change, the complete list of files affected by a
commit will always be shown in the lower right window.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

I noticed this issue recently when trying gitk.  After some research, I found
this thread [1] which explained the issue.  However, the operation still does
not seem consistent.  This patch fixes the "problem" that I encountered, but
I can't help wondering:
    1) I am breaking another feature?  Especially since the
'$vfilelimit($curview) ne {}'
        check is now ignored.
    2) Can the limitdiffs option be completely removed?  If not, the behavior
        of startdiff and mergediff should at least be made consistent.

[1] http://thread.gmane.org/gmane.comp.version-control.git/133088

 gitk-git/gitk |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1f36a3e..518061e 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7450,17 +7450,7 @@ proc gettreediffline {gdtf ids} {
 	return [expr {$nr >= $max? 2: 1}]
     }
     close $gdtf
-    if {$limitdiffs && $vfilelimit($curview) ne {}} {
-	set flist {}
-	foreach f $treediff {
-	    if {[path_filter $vfilelimit($curview) $f]} {
-		lappend flist $f
-	    }
-	}
-	set treediffs($ids) $flist
-    } else {
-	set treediffs($ids) $treediff
-    }
+    set treediffs($ids) $treediff
     unset treepending
     if {$cmitmode eq "tree" && [llength $diffids] == 1} {
 	gettree $diffids
-- 
1.7.0.3.291.g5e4f6.dirty
