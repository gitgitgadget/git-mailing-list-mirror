From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3] gitk: Use git-difftool for external diffs
Date: Sat, 27 Mar 2010 17:20:00 -0700
Message-ID: <1269735600-12769-1-git-send-email-davvid@gmail.com>
References: <1269726316-30443-1-git-send-email-davvid@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 01:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvgEg-0007r1-Ud
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 01:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab0C1AUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 20:20:08 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:47785 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328Ab0C1AUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 20:20:06 -0400
Received: by yxe29 with SMTP id 29so1394446yxe.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 17:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fHXtrR72lX9NzfJ4fFDBmhuG6gx6mFB7ARNz95ZE8eg=;
        b=OjODZErkr7dQal4GpQxs+tatdHQVqp1tqJDHfAhQ0Gk0Z9Pkzy8th0zNmnHVcp5AXP
         4cw992PI2pYvJQK9xK8t2834Ntql8hb4wK5Z0hQxutKQNABc6H6+M2Os1ghP2Z3eoyFe
         2MEVipkk9t8xSunqEfs37Qw1NHwedkhLru6q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CzfMmuQMJFop+xo6exWpCTYZRDYkZf/PiOaZH9yGL+ilIfzx6eZayqo+GWH9WuDGcA
         Ho4F8Uf6bg4ppBSgVPY+gitb3w8Jd1WDi/Z0rw+2mHkjf0VS0Mglrc+daHLhu4Vf1kcn
         kN4lQj8f6t1Ra5L9xztbQEKSkRJaj6/PwhzaU=
Received: by 10.151.117.16 with SMTP id u16mr3134322ybm.294.1269735605604;
        Sat, 27 Mar 2010 17:20:05 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 8sm677709ywg.27.2010.03.27.17.20.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 17:20:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.292.gbeff
In-Reply-To: <1269726316-30443-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143367>

This teaches gitk about git-difftool.  A benefit of this change
is that gitk's external diff feature now works with read-only
repositories.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Differences since v1 and v2:

v1: Do not pass "--gui" to difftool
v2: Do not needlessly check if $flist_menu_file is non-empty

 gitk |   58 ++++++++--------------------------------------------------
 1 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..637f8f9 100755
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
+    set cmd [list "git" "difftool" "--no-prompt" "--extcmd" $extdifftool]
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
1.7.0.3.292.gbeff
