From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] gitk: Fix "git gui blame" invocation when called from topdir
Date: Wed,  4 Nov 2009 00:21:41 +0100
Message-ID: <1257290501-21093-1-git-send-email-markus.heidelberg@web.de>
References: <19184.2163.760155.285153@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 00:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Skl-0002U8-AL
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 00:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbZKCXZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 18:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbZKCXZT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 18:25:19 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:41633 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZKCXZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 18:25:18 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id D05BA1378310A;
	Wed,  4 Nov 2009 00:21:43 +0100 (CET)
Received: from [89.59.85.220] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N5Sh5-0002Xj-00; Wed, 04 Nov 2009 00:21:43 +0100
X-Mailer: git-send-email 1.6.5.2.155.gaa0e5
In-Reply-To: <19184.2163.760155.285153@cargo.ozlabs.ibm.com>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/q/M7yAuXx+abAvFfin8b2NF/S676pcOYcLCAt
	lpRCgaNSXV+HN7/C7/WSGXPLOVq7N1rDq7eTOWFfGvZGNNZcJ9
	mX9iDXyTzblcL3TzCyeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132008>

In this case "git rev-parse --git-dir" doesn't return an absolute path,
but merely ".git", so the selected file has a relative path.
The function make_relative then tries to make the already relative path
relative, which results in a path like "../../../../Makefile" with as
much ".." as the number of parts [pwd] consists of.

This regression was introduced by commit 9712b81 (gitk: Fix bugs in
blaming code, 2008-12-06), which fixed "git gui blame" when called from
subdirs.

This also fixes it for bare repositories.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

    Paul Mackerras, 03.11.2009:
    > Thanks for the patch, but I'd prefer to just add:
    > 
    >     if {[file pathtype $f] ne "relative"} {
    >         return $f
    >     }
    > 
    > at the start of the function.  I think that's easier to read than
    > having a big if statement.
    
    Definitely yes. But eq instead of ne.
    

 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 32e4ab0..949abfe 100755
--- a/gitk
+++ b/gitk
@@ -3378,6 +3378,9 @@ proc index_sha1 {fname} {
 
 # Turn an absolute path into one relative to the current directory
 proc make_relative {f} {
+    if {[file pathtype $f] eq "relative"} {
+	return $f
+    }
     set elts [file split $f]
     set here [file split [pwd]]
     set ei 0
-- 
1.6.5.2.155.gaa0e5
