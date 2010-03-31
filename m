From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4] gitk: Use git-difftool for external diffs
Date: Tue, 30 Mar 2010 19:09:59 -0700
Message-ID: <1270001399-26031-1-git-send-email-davvid@gmail.com>
References: <201003281259.06947.markus.heidelberg@web.de>
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 04:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwnTu-0005X0-9x
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 04:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011Ab0CaCQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 22:16:20 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:57198 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006Ab0CaCQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 22:16:18 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 22:16:18 EDT
Received: by iwn8 with SMTP id 8so545274iwn.16
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QumHlHvMrtfH+Cvz2uGi+wqI3o7fEuNPq/NAD4+TzSc=;
        b=hGEOnjENsfcdgNQOfMQs+9CyIpMnLTgmYpI/YrND66jfG7k8wodZtS4Mcm7muNqZX7
         XFAf3T3RcemcwL/Pa+j3Ru5XVTxngky65v6Q/wqrdIjjdMDwEfIZOmkqMmtm5wtK3yBX
         OV4mwrd6sLMFBTke0xXXXmkLCFN+fY5GJH3ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b68Y2qAUzPQmAUgt+AS077zD5+ANqN4dGH6nR/FGFzUGKSUDb+/9oN77UrFbA1Uzyl
         id2ktIR+4u7cjKPXjbTFBxc6UifHSAbLRp29s3ZBM2AbLQBab95pqK2kjYn+2l/4p4nU
         IHrNBbEK8LovQmBJJSR6DghUkNej+XwjP/z6s=
Received: by 10.231.79.136 with SMTP id p8mr3735895ibk.4.1270001404374;
        Tue, 30 Mar 2010 19:10:04 -0700 (PDT)
Received: from localhost (wdas-1.disneyanimation.com [198.187.190.1])
        by mx.google.com with ESMTPS id co35sm6258422ibb.14.2010.03.30.19.10.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 19:10:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.313.g87b3c
In-Reply-To: <201003281259.06947.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143635>

This teaches gitk about git-difftool.  A benefit of this change
is that gitk's external diff feature now works with read-only
repositories.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk |   58 ++++++++--------------------------------------------------
 1 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..71cb501 100755
--- a/gitk
+++ b/gitk
@@ -3317,39 +3317,6 @@ proc gitknewtmpdir {} {
     return $diffdir
 }
 
-proc save_file_from_commit {filename output what} {
-    global nullfile
-
-    if {[catch {exec git show $filename -- > $output} err]} {
-	if {[string match "fatal: bad revision *" $err]} {
-	    return $nullfile
-	}
-	error_popup "[mc "Error getting \"%s\" from %s:" $filename $what] $err"
-	return {}
-    }
-    return $output
-}
-
-proc external_diff_get_one_file {diffid filename diffdir} {
-    global nullid nullid2 nullfile
-    global gitdir
-
-    if {$diffid == $nullid} {
-        set difffile [file join [file dirname $gitdir] $filename]
-	if {[file exists $difffile]} {
-	    return $difffile
-	}
-	return $nullfile
-    }
-    if {$diffid == $nullid2} {
-        set difffile [file join $diffdir "\[index\] [file tail $filename]"]
-        return [save_file_from_commit :$filename $difffile index]
-    }
-    set difffile [file join $diffdir "\[$diffid\] [file tail $filename]"]
-    return [save_file_from_commit $diffid:$filename $difffile \
-	       "revision $diffid"]
-}
-
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
@@ -3375,24 +3342,15 @@ proc external_diff {} {
         set diffidto [lindex $diffids 1]
     }
 
-    # make sure that several diffs wont collide
-    set diffdir [gitknewtmpdir]
-    if {$diffdir eq {}} return
-
-    # gather files to diff
-    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
-    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
-
-    if {$difffromfile ne {} && $difftofile ne {}} {
-        set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]
-        if {[catch {set fl [open |$cmd r]} err]} {
-            file delete -force $diffdir
-            error_popup "$extdifftool: [mc "command failed:"] $err"
-        } else {
-            fconfigure $fl -blocking 0
-            filerun $fl [list delete_at_eof $fl $diffdir]
-        }
+    set cmd [list "git" "difftool" "--no-prompt" "--extcmd=$extdifftool"]
+    if {$diffidfrom ne $nullid && $diffidfrom ne $nullid2} {
+        lappend cmd $diffidfrom
+    }
+    if {$diffidto ne $nullid && $diffidto ne $nullid2} {
+        lappend cmd $diffidto
     }
+    lappend cmd "--" $flist_menu_file
+    eval exec $cmd &
 }
 
 proc find_hunk_blamespec {base line} {
-- 
1.7.0.3.313.g87b3c
