From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: do not show local changes when we there is no work tree
Date: Mon, 10 Mar 2008 03:54:56 -0700
Message-ID: <309f000ad75b1842c11a04b16940dda8f1cd84af.1205145018.git.davvid@gmail.com>
References: <18386.29988.380116.517508@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 11:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYfVq-0004wE-4W
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 11:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbYCJKok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 06:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYCJKok
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 06:44:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:5857 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYCJKoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 06:44:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1841312wxd.4
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GDGcPo56C+jRgOmfw68waw+Sj+kdz6WT6UrrJeSknBA=;
        b=dQQuaGUUqjgNxfXLr3ewjvxbCKoEhJo6BKTI3woRUUCyF8BADvWCetN2PhxYs1/Kpj9TxCKlqL3Jts0bd0HjiT4C+NWB4o7bm0loa+m1suuDrIVP0boaszzpChvWHl3JGiRlByi7E/mwQKc/QIxZdhl0802X4EYEtXHvlEtWfL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aOxtScM4RQT8NtND8HPu1IUX5WzOK9KNRlk3uz9u2J4mP/aWLgsu7uY2YI2IAUix2Ku87bSXn0g+7bZy3WI13uyNyEyN/K+WN3n0hSI8ssYycPqPBJRufbizOSqySyXDPQT6E5oCIx4aQEgznjl7EzPohCCeEz3anck6top5fKE=
Received: by 10.114.57.1 with SMTP id f1mr3196486waa.78.1205145876801;
        Mon, 10 Mar 2008 03:44:36 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id v39sm17604680wah.44.2008.03.10.03.44.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 03:44:35 -0700 (PDT)
X-Mailer: git-send-email 1.5.4
In-Reply-To: <18386.29988.380116.517508@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76713>

Launching gitk on a bare repository or a .git directory
would previously show the work tree as having removed all
files.  We now inhibit showing local changes when gitk
is not launched from within a work tree.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..ef12845 100755
--- a/gitk
+++ b/gitk
@@ -393,6 +393,9 @@ proc readcommit {id} {
 proc updatecommits {} {
     global viewdata curview phase displayorder ordertok idpending
     global children commitrow selectedline thickerline showneartags
+    global isworktree
+
+    set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
 
     if {$phase ne {}} {
 	stop_rev_list
@@ -2844,8 +2847,9 @@ proc dohidelocalchanges {} {
 # spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
     global localirow localfrow lserial showlocalchanges
+    global isworktree
 
-    if {!$showlocalchanges} return
+    if {!$showlocalchanges || !$isworktree} return
     incr lserial
     set localfrow -1
     set localirow -1
@@ -8643,6 +8647,7 @@ set patchnum 0
 set localirow -1
 set localfrow -1
 set lserial 0
+set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
 setcoords
 makewindow
 # wait for the window to become visible
-- 
1.5.4.3
