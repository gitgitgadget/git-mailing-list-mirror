From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: Use git-difftool for external diffs
Date: Sat, 27 Mar 2010 14:45:16 -0700
Message-ID: <1269726316-30443-1-git-send-email-davvid@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 22:45:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvdp2-00080g-PP
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 22:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab0C0Vp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 17:45:26 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:45242 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969Ab0C0VpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 17:45:25 -0400
Received: by ywh2 with SMTP id 2so4214481ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MG7PXHL35g4CRClwSfG8MTQvBY9E+Vib3Yz/iSbqOlU=;
        b=bDAZMuEz/iugO/jIlqwIiQ/rq0waCGgnoSndaYN0DzLuP8WZFl/EsRinvJ43Qidk4l
         gDbh/jhwTSAr4CLMr2KWz4ZZ3x6FXjyLb/zlIplSz1j5De5xy5nNYfiWrOahs2yOWML5
         I+rl2VfhbGqJUpykpsB/KfuzlljhUSlz66vg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oUpy3Oyd0KoTe5OZq8ZKAgcLaIyOhL3gnuGr+Khi/pC2XK/jC9lCtpH40jclBLePxj
         avldyDfGkfOvEGCeGsnGPLxMRVS9sMocoJkhXHEGWDeBVoRDOKKahR6bfhQdR4PCM5Al
         fS/3HyU04s2GLbYFoUBjcXyGgerW/EptnNYpE=
Received: by 10.100.22.32 with SMTP id 32mr4804585anv.153.1269726324249;
        Sat, 27 Mar 2010 14:45:24 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm559944ywi.6.2010.03.27.14.45.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 14:45:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.291.g5e4f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143358>

This teaches gitk about git-difftool.  A benefit of this change
is that gitk's external diff feature now works with read-only
repositories.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This is still not the final result but it does get us
to a better place (having gitk work in read-only repos).

We may later want to add a radio button with "difftool"
as a choice so that the configured difftool is used
instead of the one specified being specified in --extcmd.

Original thread:
http://thread.gmane.org/gmane.comp.version-control.git/132983

An even older attempt to fix the tempdir problem:
http://thread.gmane.org/gmane.comp.version-control.git/133277

This diffstat alone still makes me happy.

 gitk |   59 ++++++++++-------------------------------------------------
 1 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..7e114da 100755
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
@@ -3375,23 +3342,17 @@ proc external_diff {} {
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
+        set cmd [list "git" "difftool" "--no-prompt" "--gui"]
+        lappend cmd "--extcmd" $extdifftool
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
1.7.0.3.291.g5e4f6
