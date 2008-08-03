From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH (GITK)] gitk: Allow overriding the default commit.
Date: Sun, 3 Aug 2008 12:49:34 +0400
Organization: TEPKOM
Message-ID: <200808031249.35603.angavrilov@gmail.com>
References: <200807271017.23272.angavrilov@gmail.com> <18577.41259.758690.635991@cargo.ozlabs.ibm.com> <bb6f213e0807310541s383c2938q91543a1c57a4d71f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 10:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPZIm-0006G2-8w
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 10:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbYHCItt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 04:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbYHCItt
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 04:49:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:55641 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbYHCItr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 04:49:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so803563fgg.17
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PgWLz38lhGd+qWfTFCW2fj8XAtJcHfrYg8WY0GmsU0s=;
        b=hvk0PtP+zE0KXr4MMeLr+GzjiL1kEssXnrw9Lfbanch8Z3QcfevyCUc0pnPEGAaVvD
         5BeyTzBcgg9lEBkwlIQySP1/fh8ge04wenAcN14PntN3+8f7teucZjXOXaICvsX4P5lK
         eWEhU9uUHxGrtz6zhJnvIUR7keeNqsLEWqDOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QvxWwUiq1OsqKpyclXXh8/I0RDZXzE969+aTucZF4QKwnknrIdRgcG8AAMcYCUnPmQ
         MWhLLeyNk+Q7OOn5PJaEutGo55zYKTGt7OqKp3eMUpmLKn+lVLERnNs6vMmmLP0aB5dS
         Q2CzrifIQ689achHk1UmCnC8biHRy2wr4WZbA=
Received: by 10.86.79.19 with SMTP id c19mr2413669fgb.79.1217753385478;
        Sun, 03 Aug 2008 01:49:45 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 12sm3441481fgg.0.2008.08.03.01.49.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 01:49:44 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <bb6f213e0807310541s383c2938q91543a1c57a4d71f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91217>

Date: Sun, 27 Jul 2008 08:18:27 +0400

Other GUI tools may occasionally need to start
gitk and make it automatically select a certain
commit. This patch supports doing it through the
environment or command line.

Using the environment allows graceful degradation of
the tool when used with an old version of gitk:
unsupported command line options cause it to die.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	On Thursday 31 July 2008 16:41:20 Alexander Gavrilov wrote:
	> I have a patch WIP that allows specifying a commit on the command line
	> to select instead of the head (I need it to enhance the git gui blame
	> UI). It makes the function somewhat more intelligent. I'll submit it
	> as soon as this series is sorted out.

	I decided to send it now.

	-- Alexander

 gitk |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index d093a39..2da885d 100755
--- a/gitk
+++ b/gitk
@@ -416,10 +416,12 @@ proc stop_rev_list {view} {
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
@@ -1607,6 +1609,7 @@ proc getcommit {id} {
 proc readrefs {} {
     global tagids idtags headids idheads tagobjid
     global otherrefids idotherrefs mainhead mainheadid
+    global selecthead selectheadid
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
 	catch {unset $v}
@@ -1653,6 +1656,12 @@ proc readrefs {} {
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
@@ -9863,6 +9872,13 @@ if {![file isdirectory $gitdir]} {
     exit 1
 }
 
+set selecthead {}
+set selectheadid {}
+
+if {[info exists env(GITK_SELECT_ID)]} {
+    set selecthead $env(GITK_SELECT_ID)
+}
+
 set revtreeargs {}
 set cmdline_files {}
 set i 0
@@ -9874,6 +9890,9 @@ foreach arg $argv {
 	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
 	    break
 	}
+	"--select-commit=*" {
+	    set selecthead [string range $arg 16 end]
+	}
 	"--argscmd=*" {
 	    set revtreeargscmd [string range $arg 10 end]
 	}
@@ -9884,6 +9903,10 @@ foreach arg $argv {
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
1.5.6.3.18.gfe82
