From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 5/7] gitk: Make cherry-pick call git-citool on conflicts.
Date: Wed,  8 Oct 2008 11:05:38 +0400
Message-ID: <1223449540-20457-6-git-send-email-angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:09:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTAQ-0006GO-Ey
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbYJHHHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYJHHH3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:14103 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYJHHH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3173789fkq.5
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XPF0oT6ZZiKPnCvOp6MWI5hr780bDcxPk2ns5DXmfmU=;
        b=GQT6OguO8TGjA381VbQ2wDNo1vIzuJhTLOk+DBmdiXAq0VRd5iYsUm5gNqO/IwNOu1
         t3uvsSLq2p4kFA+zp8zWXuFEZHDTPLZbyn2YwN/jU6Y9uR+0z2P0iVvvxKW0RzXSeEKH
         DiFTt1BNlZG8yamB8Vlmh0f2iruSrOvdycmLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QDuFMMv/x4HD/CbP93CWTBZE8wkk1vgzFGL6QVrJFSOYZazCKkF1hXQjWcLUSEWCdW
         fVG35pblL6C1F/5N29iV9MP1HOExK/G7grJW56yg5ZpwCEAkOZxUgVIs4k0QwG4LE8AI
         sce3szoKIsO+YlmSAD/hi2oWAiAJEHEhUXGdY=
Received: by 10.181.34.1 with SMTP id m1mr5818500bkj.85.1223449645604;
        Wed, 08 Oct 2008 00:07:25 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97776>

Now that git-gui has facilities to help users resolve
conflicts, it makes sense to launch it from other gui
tools when they happen.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index cfaf7a1..e84e109 100755
--- a/gitk
+++ b/gitk
@@ -7843,6 +7843,53 @@ proc mkbrgo {top} {
     }
 }
 
+proc exec_citool {args {baseid {}}} {
+    global commitinfo env
+
+    if {[info exists env(GIT_AUTHOR_NAME)]} {
+	set old_name $env(GIT_AUTHOR_NAME)
+    }
+    if {[info exists env(GIT_AUTHOR_EMAIL)]} {
+	set old_email $env(GIT_AUTHOR_EMAIL)
+    }
+    if {[info exists env(GIT_AUTHOR_DATE)]} {
+	set old_date $env(GIT_AUTHOR_DATE)
+    }
+
+    if {$baseid ne {}} {
+	if {![info exists commitinfo($baseid)]} {
+	    getcommit $baseid
+	}
+	set author [lindex $commitinfo($baseid) 1]
+	set date [lindex $commitinfo($baseid) 2]
+	if {[regexp {^\s*(\S.*\S|\S)\s*<(.*)>\s*$} \
+	            $author author name email]
+	    && $date ne {}} {
+	    set env(GIT_AUTHOR_NAME) $name
+	    set env(GIT_AUTHOR_EMAIL) $email
+	    set env(GIT_AUTHOR_DATE) $date
+	}
+    }
+
+    eval exec git citool $args &
+
+    if {[info exists old_name]} {
+	set env(GIT_AUTHOR_NAME) $old_name
+    } else {
+	unset env(GIT_AUTHOR_NAME)
+    }
+    if {[info exists old_email]} {
+	set env(GIT_AUTHOR_EMAIL) $old_email
+    } else {
+	unset env(GIT_AUTHOR_EMAIL)
+    }
+    if {[info exists old_date]} {
+	set env(GIT_AUTHOR_DATE) $old_date
+    } else {
+	unset env(GIT_AUTHOR_DATE)
+    }
+}
+
 proc cherrypick {} {
     global rowmenuid curview
     global mainhead mainheadid
@@ -7861,7 +7908,17 @@ proc cherrypick {} {
     # no error occurs, and exec takes that as an indication of error...
     if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
 	notbusy cherrypick
-	error_popup $err
+	if {[regexp -line \
+	    {Entry '(.*)' would be overwritten by merge} $err msg fname]} {
+	    error_popup [mc "Cherry-pick failed: file '%s' had local modifications.
+Your working directory is in an inconsistent state." $fname]
+	} elseif {[regexp -line {^CONFLICT \(.*\):} $err msg]} {
+	    # Force citool to read MERGE_MSG
+	    file delete [file join [gitdir] "GITGUI_MSG"]
+	    exec_citool [list] $rowmenuid
+	} else {
+	    error_popup $err
+	}
 	return
     }
     set newhead [exec git rev-parse HEAD]
-- 
1.6.0.20.g6148bc
