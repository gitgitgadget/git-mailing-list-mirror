From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI FIX)] git-gui: Fix commit encoding handling.
Date: Sat, 6 Dec 2008 20:24:35 +0300
Organization: HOME
Message-ID: <200812062024.35986.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 18:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L90vr-0007Xo-BT
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 18:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYLFRZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 12:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYLFRZu
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 12:25:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:17588 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYLFRZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 12:25:49 -0500
Received: by fg-out-1718.google.com with SMTP id 19so337005fgg.17
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cT9vkxsmP6CMHulXzrlX2iRull0Nncc4gutEwAnwxdw=;
        b=E/IwF3c+wCBBKW7txLBajNo8nfa0+PYWYN4WTpfp48KdYX1s8r5bHhm/EWgct9+GF1
         z6ucDhy4AksfsUAr8qTE8m5YDKqJ+rzS/UG+Zw9sSV1GEuC3b69BB6RTjVo9UsVR8QOg
         qGLWebUlV/2raHyHFw+dqYrbAM0FKzVYOxzFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=ChJIU2qddJGZn6gJlESEZnaApP/y7RKuOBxncgwnskFbVPUz+jT2CGyd29l/g4LpeJ
         wUJY7A7RIHY0LXktm5Yz/YRhSAJK7NCxLINKW41XMbITSKNRN5OsrUaCr7CEazMznBrG
         wxP8pA7WgXfBX6mSiswTCkVN0mFcWGw8kcnso=
Received: by 10.223.115.193 with SMTP id j1mr700927faq.98.1228584347655;
        Sat, 06 Dec 2008 09:25:47 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 22sm11934348fkr.24.2008.12.06.09.25.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 09:25:47 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-123.fc10.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102465>

Commits without an encoding header are supposed to
be encoded in utf8. While this apparently hasn't always
been the case, currently it is the active convention, so
it is better to follow it; otherwise people who have to
use commitEncoding on their machines are unable to read
utf-8 commits made by others.

I also think that it is preferrable to display the warning
about an unsupported value of commitEncoding more prominently,
because this condition may lead to surprising behavior and,
eventually, to loss of data.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/blame.tcl  |    5 ++---
 lib/commit.tcl |    7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index c1cd7f3..1f3b08f 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -940,9 +940,8 @@ method _showcommit {cur_w lno} {
 			catch {
 				set fd [git_read cat-file commit $cmit]
 				fconfigure $fd -encoding binary -translation lf
-				if {[catch {set enc $repo_config(i18n.commitencoding)}]} {
-					set enc utf-8
-				}
+				# By default commits are assumed to be in utf-8
+				set enc utf-8
 				while {[gets $fd line] > 0} {
 					if {[string match {encoding *} $line]} {
 						set enc [string tolower [string range $line 9 end]]
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 3345149..9cc8410 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -27,9 +27,8 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 	if {[catch {
 			set fd [git_read cat-file commit $curHEAD]
 			fconfigure $fd -encoding binary -translation lf
-			if {[catch {set enc $repo_config(i18n.commitencoding)}]} {
-				set enc utf-8
-			}
+			# By default commits are assumed to be in utf-8
+			set enc utf-8
 			while {[gets $fd line] > 0} {
 				if {[string match {parent *} $line]} {
 					lappend parents [string range $line 7 end]
@@ -208,7 +207,7 @@ A good commit message has the following format:
 	if {$use_enc ne {}} {
 		fconfigure $msg_wt -encoding $use_enc
 	} else {
-		puts stderr [mc "warning: Tcl does not support encoding '%s'." $enc]
+		error_popup [mc "warning: Tcl does not support encoding '%s'." $enc]
 		fconfigure $msg_wt -encoding utf-8
 	}
 	puts $msg_wt $msg
-- 
1.6.0.4.30.gf4240
