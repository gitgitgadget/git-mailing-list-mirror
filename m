From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v6] gitk: Use git-difftool for external diffs when available
Date: Tue, 20 Apr 2010 01:11:19 -0700
Message-ID: <1271751079-18884-1-git-send-email-davvid@gmail.com>
References: <20100417085230.GC6681@brick.ozlabs.ibm.com>
Cc: git@vger.kernel.org, Thomas Arcila <thomas.arcila@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 10:11:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O48Ym-0002ps-9R
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 10:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab0DTILh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 04:11:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46161 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0DTILf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 04:11:35 -0400
Received: by gyg13 with SMTP id 13so3094639gyg.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GVslW3DuaZXtIR5rFgirDkWfzCMlpD7lXnEnLOXQf6k=;
        b=EXi2CyIDlB8gYtZzEBRH4HxPMb/+a7pPdPuvmctq7xWzxJ2wHwXgba76VPxcS2h8Il
         4KN+UFauHjaypeaveDmco/9XdyluyyBs1do0USc5q++Cqy8rhji82VhsY/aStR0FiT6f
         AAJAQg/B9Adl09jCZK/5iHgxOVcWICpVYu1pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aiFvMl+aX2lsmHh8zntTk6crFpCaUwNsNKiwXWBjC61+LyT8G6HeY09GJ7Kr9jXj0m
         Ie+YJ6E6I25S5eokiuGFR2sj/nQXIf2ZhTVPo9wLbuHjmSVCnX8+mPrctZilorYD8Th3
         Z3MNOD8UVmBylyLri5wh9Ijr2xD3dty1i9sC8=
Received: by 10.100.224.10 with SMTP id w10mr11473694ang.183.1271751087869;
        Tue, 20 Apr 2010 01:11:27 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm1859321ywd.23.2010.04.20.01.11.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Apr 2010 01:11:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc2.5.gddd02
In-Reply-To: <20100417085230.GC6681@brick.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145355>

git-difftool's '--extcmd=frotz' was added in 1.7.0 and
is the mechanism through which gitk launches the
configured 'extdifftool'.  When 'extdifftool' is
misconfigured an error dialog is used to display
git-difftool's stdout and stderr.

The existing implementation moved into 'proc gitkextdiff'
for use with git < 1.7.0.

One benefit of this change is that gitk's external diff
no longer requires write-access to the current directory.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Changes since last time:

* Errors are shown using 'proc error_popup'
* The existing code moved into a tidy function

 gitk |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1b0e09a..0533baf 100755
--- a/gitk
+++ b/gitk
@@ -3361,6 +3361,7 @@ proc external_diff {} {
     global flist_menu_file
     global diffids
     global extdifftool
+    global git_version
 
     if {[llength $diffids] == 1} {
         # no reference commit given
@@ -3380,6 +3381,30 @@ proc external_diff {} {
         set diffidfrom [lindex $diffids 0]
         set diffidto [lindex $diffids 1]
     }
+    if {[package vcompare $git_version "1.7.0"] < 0} {
+        gitkextdiff $diffidfrom $diffidto
+        return
+    }
+
+    set cmd [list "git" "difftool" "--no-prompt" "--extcmd=$extdifftool"]
+    if {$diffidfrom ne $nullid && $diffidfrom ne $nullid2} {
+        lappend cmd $diffidfrom
+    }
+    if {$diffidto ne $nullid && $diffidto ne $nullid2} {
+        lappend cmd $diffidto
+    }
+    lappend cmd "--" $flist_menu_file
+
+    set pipe [open |$cmd r]
+    set stdout [read $pipe]
+    if {[catch {close $pipe} stderr] != 0} {
+        error_popup "git-difftool: $stdout $stderr"
+    }
+}
+
+proc gitkextdiff {diffidfrom diffidto} {
+    global flist_menu_file
+    global extdifftool
 
     # make sure that several diffs wont collide
     set diffdir [gitknewtmpdir]
-- 
1.7.1.rc2.5.gddd02
