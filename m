From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v3 4/6] gitk: Make cherry-pick call git-citool on conflicts.
Date: Sun,  2 Nov 2008 21:59:47 +0300
Message-ID: <1225652389-22082-5-git-send-email-angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-3-git-send-email-angavrilov@gmail.com>
 <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:03:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiEF-0005yD-7L
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYKBTB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbYKBTB4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:01:56 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:15346 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbYKBTBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:01:54 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2459943fkq.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qIXVXyrC43x8H7ARPdSuuZH655UfO89s5OK+taPjkcE=;
        b=cSRW++N7kqzkTBRvRt/GAGndRG0rZqjvLegqwLV5OR3juupQB3k1iBYDActsN6oMQB
         A62/FZ5AyuhjTsnJ9QA1miaykICaU3K9/pvPBWXHBWJecxS3/f4L5MclZELh5EI/Lb6X
         WRWHNTRwZY8Sn6Ps9WRAqRjH1BsX55ymBT/zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ua2j4OjtC6IE7XsxgJpsDCqCs3Aw66SGNSCu5uuVduxUtunmx2ELxZMpCP0auHAgSh
         +fihHXgTUWXc8FfvVU0b/6Ryzphf2zABIyfu5GeW6UbFKjFTjJ1AKJTg2s6vfOMWf2Ru
         QENJXFkrMrGHdiTUY//Md0oW/G2VsJzFBqH9s=
Received: by 10.181.146.14 with SMTP id y14mr3932833bkn.16.1225652513049;
        Sun, 02 Nov 2008 11:01:53 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm8536420fks.6.2008.11.02.11.01.51
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Nov 2008 11:01:51 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1225652389-22082-4-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99867>

Now that git-gui has facilities to help users resolve
conflicts, it makes sense to launch it from other GUI
tools when they happen.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f747c70..71f1b27 100755
--- a/gitk
+++ b/gitk
@@ -8110,6 +8110,32 @@ proc mkbrgo {top} {
     }
 }
 
+proc exec_citool {tool_args {baseid {}}} {
+    global commitinfo env
+
+    set save_env [array get env GIT_AUTHOR_*]
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
+    eval exec git citool $tool_args &
+
+    array unset env GIT_AUTHOR_*
+    array set env $save_env
+}
+
 proc cherrypick {} {
     global rowmenuid curview
     global mainhead mainheadid
@@ -8128,7 +8154,19 @@ proc cherrypick {} {
     # no error occurs, and exec takes that as an indication of error...
     if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
 	notbusy cherrypick
-	error_popup $err
+	if {[regexp -line \
+	    {Entry '(.*)' would be overwritten by merge} $err msg fname]} {
+	    error_popup [mc "Cherry-pick failed:
+file '%s' had local modifications.
+
+Please commit, reset or stash your changes." $fname]
+	} elseif {[regexp -line {^CONFLICT \(.*\):} $err msg]} {
+	    # Force citool to read MERGE_MSG
+	    file delete [file join [gitdir] "GITGUI_MSG"]
+	    exec_citool {} $rowmenuid
+	} else {
+	    error_popup $err
+	}
 	return
     }
     set newhead [exec git rev-parse HEAD]
-- 
1.6.0.3.15.gb8d36
