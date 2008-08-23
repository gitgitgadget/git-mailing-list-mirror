From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 1/7] gitk: Allow overriding the default commit.
Date: Sat, 23 Aug 2008 12:27:44 +0400
Organization: TEPKOM
Message-ID: <200808231227.45013.angavrilov@gmail.com>
References: <200808231225.12596.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoUd-0003F8-Ed
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYHWI2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYHWI2D
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:28:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:1912 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYHWI17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:27:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so464129fgg.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tRcLc6ydvdm+WBmap5Kzvh0NnDx0WV206zouccFCeMo=;
        b=Jy2TJOyPyP5xuSoCqwdxsS4161LIWYVjWlW1xBzhnsoJ+Dp0AuQ3iour7+hWrbYPth
         b9b5gRizp5+nojrcqJPrmPpQFgnTi9TfyEl6UB3zr962mibTy8c1i8U12kImGJ6krEr/
         0IrSxO0Vv27mxKEMLbcwKX+h6NeVEKs6G6rsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mMhep1esm2e7CLawV8dJrRcldZkvSqszVih02pmO/ipxbDPNn0pZmeIfqMwr+tXEX5
         E16RuYegRYW6FaKAWS6LYUEtOGyEdacxSMQ5NiwcTg0xhekpYy4UO1XQCvw3S5cMm1Pn
         q6gqi46W5R9lmeZ74iGOQTiclRJeq1S6sBBrU=
Received: by 10.181.25.10 with SMTP id c10mr1117898bkj.99.1219480077975;
        Sat, 23 Aug 2008 01:27:57 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id g28sm2003092fkg.8.2008.08.23.01.27.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 01:27:56 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808231225.12596.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93433>

Other GUI tools may occasionally need to start
gitk and make it automatically select a certain
commit. This patch supports doing it using a new
command-line option.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 087c4ac..7698b70 100755
--- a/gitk
+++ b/gitk
@@ -418,10 +418,12 @@ proc stop_rev_list {view} {
 }
 
 proc reset_pending_select {selid} {
-    global pending_select mainheadid
+    global pending_select mainheadid selectheadid
 
     if {$selid ne {}} {
 	set pending_select $selid
+    } elseif {$selectheadid ne {}} {
+	set pending_select $selectheadid
     } else {
 	set pending_select $mainheadid
     }
@@ -1609,6 +1611,7 @@ proc getcommit {id} {
 proc readrefs {} {
     global tagids idtags headids idheads tagobjid
     global otherrefids idotherrefs mainhead mainheadid
+    global selecthead selectheadid
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
 	catch {unset $v}
@@ -1655,6 +1658,12 @@ proc readrefs {} {
 	    set mainhead [string range $thehead 11 end]
 	}
     }
+    set selectheadid {}
+    if {$selecthead ne {}} {
+	catch {
+	    set selectheadid [exec git rev-parse --verify $selecthead]
+	}
+    }
 }
 
 # skip over fake commits
@@ -9865,6 +9874,9 @@ if {![file isdirectory $gitdir]} {
     exit 1
 }
 
+set selecthead {}
+set selectheadid {}
+
 set revtreeargs {}
 set cmdline_files {}
 set i 0
@@ -9876,6 +9888,9 @@ foreach arg $argv {
 	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
 	    break
 	}
+	"--select-commit=*" {
+	    set selecthead [string range $arg 16 end]
+	}
 	"--argscmd=*" {
 	    set revtreeargscmd [string range $arg 10 end]
 	}
@@ -9886,6 +9901,10 @@ foreach arg $argv {
     incr i
 }
 
+if {$selecthead eq "HEAD"} {
+    set selecthead {}
+}
+
 if {$i >= [llength $argv] && $revtreeargs ne {}} {
     # no -- on command line, but some arguments (other than --argscmd)
     if {[catch {
-- 
1.6.0.rc2
