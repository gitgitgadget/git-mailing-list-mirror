From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] gitk: Honor TMPDIR when viewing diffs externally
Date: Thu, 19 Nov 2009 17:27:02 -0800
Message-ID: <1258680422-42179-1-git-send-email-davvid@gmail.com>
Cc: peff@peff.net, sam@vilain.net, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIHN-0000AO-7P
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbZKTB1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZKTB1F
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:27:05 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:57779 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbZKTB1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:27:04 -0500
Received: by ywh40 with SMTP id 40so1870935ywh.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vOq41WX7xH1Xk27uYgKOIJEGJHwLsEUFwQU4aDX9fYE=;
        b=IC1nDhLJFio8PI7bX+ggX1F3cfMPiH4pko+DDvKH7LL2gA1LfrQAsL9taAsAiCP/t6
         mk7nWHRmvIc3NdtqQbP0GVEhXPnvO223ikBPc5N4/Se1alcRGxPPgGQQCyLXsHVT1Qkh
         L4TkgYyRqzUBITERusvM/3bkW9ZZsx1XacbRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OuoonD6gqBWonKOEnuatrhYd1i80Dx7mhu4F80orhwD4sTX1zYdAK+9vvmW8U8TYaB
         32byxwu1d2QqzCkE4QHOdTg0E7QNAgQI/DGxbcmNoYvs7ZHEHy6QRD2ABghaxmC6qqKV
         7insBpjFg/i0u4dBdTDK3c4+ci8u8pumbAUAA=
Received: by 10.101.128.12 with SMTP id f12mr1433139ann.36.1258680429449;
        Thu, 19 Nov 2009 17:27:09 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 36sm518551yxh.13.2009.11.19.17.27.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:27:08 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.171.ge36e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133277>

gitk's external diff fails when browsing read-only repositories.
This is due to gitk's assumption that the current directory is
always writable.  By honoring TMPDIR we avoid this problem and
allow users to define the location used for temporary files.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This version of the patch is more careful to ensure that
the temporary files and directories created by gitk are not
easily predictable.

 gitk |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/gitk b/gitk
index 364c7a8..84ea8a9 100755
--- a/gitk
+++ b/gitk
@@ -3292,17 +3292,21 @@ proc flist_hl {only} {
     set gdttype [mc "touching paths:"]
 }
 
+proc randstr {} {
+    global initial_rand
+    return [format "%f" [expr rand() + $initial_rand]]
+}
+
 proc gitknewtmpdir {} {
-    global diffnum gitktmpdir gitdir
+    global diffnum gitktmpdir gitdir env
 
     if {![info exists gitktmpdir]} {
-	set gitktmpdir [file join [file dirname $gitdir] \
-			    [format ".gitk-tmp.%s" [pid]]]
-	if {[catch {file mkdir $gitktmpdir} err]} {
-	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
-	    unset gitktmpdir
-	    return {}
+	if {[info exists env(TMPDIR)]} {
+	    set tmpdir $env(TMPDIR)
+	} else {
+	    set tmpdir [file dirname $gitdir]
 	}
+	set gitktmpdir [file join $tmpdir ".gitk-tmp.[pid].[randstr]"]
 	set diffnum 0
     }
     incr diffnum
@@ -3339,10 +3343,12 @@ proc external_diff_get_one_file {diffid filename diffdir} {
 	return $nullfile
     }
     if {$diffid == $nullid2} {
-        set difffile [file join $diffdir "\[index\] [file tail $filename]"]
+        set difffile [file join $diffdir \
+	       "\[index-[randstr]\] [file tail $filename]"]
         return [save_file_from_commit :$filename $difffile index]
     }
-    set difffile [file join $diffdir "\[$diffid\] [file tail $filename]"]
+    set difffile [file join $diffdir \
+	       "\[$diffid-[randstr]\] [file tail $filename]"]
     return [save_file_from_commit $diffid:$filename $difffile \
 	       "revision $diffid"]
 }
@@ -8525,8 +8531,8 @@ proc diffcommits {a b} {
     global diffcontext diffids blobdifffd diffinhdr
 
     set tmpdir [gitknewtmpdir]
-    set fna [file join $tmpdir "commit-[string range $a 0 7]"]
-    set fnb [file join $tmpdir "commit-[string range $b 0 7]"]
+    set fna [file join $tmpdir "commit-[string range $a 0 7]-[randstr]"]
+    set fnb [file join $tmpdir "commit-[string range $b 0 7]-[randstr]"]
     if {[catch {
 	exec git diff-tree -p --pretty $a >$fna
 	exec git diff-tree -p --pretty $b >$fnb
@@ -11321,6 +11327,7 @@ if {[tk windowingsystem] eq "aqua"} {
     set textfont {Courier 9}
     set uifont {Helvetica 9 bold}
 }
+set initial_rand [expr srand([clock scan now])]
 set tabstop 8
 set findmergefiles 0
 set maxgraphpct 50
-- 
1.6.5.3.171.ge36e
