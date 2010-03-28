From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] gitk: Use git-difftool for external diffs
Date: Sat, 27 Mar 2010 17:01:50 -0700
Message-ID: <1269734510-11503-1-git-send-email-davvid@gmail.com>
References: <1269726316-30443-1-git-send-email-davvid@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 01:02:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvfx3-0001Fj-W4
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 01:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259Ab0C1AB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 20:01:57 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:44767 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab0C1AB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 20:01:56 -0400
Received: by ywh2 with SMTP id 2so4247195ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=37A6cZXjKuO1uahp2EdFl/MI6R8Gr7YtTuIR0psfW5I=;
        b=FG+EuGsautxH0EWZLxeyjG3tlfCyTK5LABo9Iw7IqnzShm1wfNNhWGigfHCa3tFueN
         HBegGt/2WQK4oBgW3Mp/i4Tzn0NokRNf95jDtxSfXiQFyK4Xu72RS56sAKRIYMrjgt4P
         szLkvwgp5pKo370oMYoLn/Ra9kCqVtTTc7PJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZETHAqZAc2+qQZq/cu0hmVTMYr0NQAd7Jl8kJ2wzy973VdVW2DldWY92Fs0FrqgLN/
         TFyEFfNp/YUVq2JmZnGItq8pmiYlhkQdfxCqB0MQqjClH/URxUphVG9eWAV4H6NYZtB8
         RqNb13gKC39KNYe3/irruFtbStt5R8GEqzI3E=
Received: by 10.101.111.12 with SMTP id o12mr986anm.8.1269734516011;
        Sat, 27 Mar 2010 17:01:56 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm662273ywe.22.2010.03.27.17.01.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 17:01:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.292.gbeff
In-Reply-To: <1269726316-30443-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143366>

This teaches gitk about git-difftool.  A benefit of this change
is that gitk's external diff feature now works with read-only
repositories.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Differences since the first patch:
This one doesn't pass "--gui" to difftool.

"--gui" was mistakenly included in the first patch and
consequently uncovered a bug in difftool.

 gitk |   58 +++++++++-------------------------------------------------
 1 files changed, 9 insertions(+), 49 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..46c103e 100755
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
@@ -3375,23 +3342,16 @@ proc external_diff {} {
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
+    if {$flist_menu_file ne {}} {
+        set cmd [list "git" "difftool" "--no-prompt" "--extcmd" $extdifftool]
+        if {$diffidfrom ne $nullid && $diffidfrom ne $nullid2} {
+            lappend cmd $diffidfrom
+        }
+        if {$diffidto ne $nullid && $diffidto ne $nullid2} {
+            lappend cmd $diffidto
         }
+        lappend cmd "--" $flist_menu_file
+        eval exec $cmd &
     }
 }
 
-- 
1.7.0.3.292.gbeff
