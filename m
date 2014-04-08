From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] gitk: show staged submodules regardless of ignore config
Date: Tue, 08 Apr 2014 21:36:08 +0200
Message-ID: <53444FA8.7020504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXbp0-0004Zd-RO
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 21:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbaDHTge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 15:36:34 -0400
Received: from mout.web.de ([212.227.17.12]:51240 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932159AbaDHTgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 15:36:33 -0400
Received: from [192.168.178.41] ([79.193.64.34]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M5fhI-1Wvstk3IZk-00xfLP; Tue, 08 Apr 2014 21:36:08
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:dSW5iWf7/Dt7yYjXAG38p7REvrsNC4pLikxmUpB/LwLIm3G/S5D
 tddlcePoFONU/FwhxD/N9d5gpekTWn0MMe80DaPlhS2hAVpzg6zfBfqfi40wzK7yFs5r9CT
 B2oQymHVwx5e9m08VJFgwzOvimZt1IYMICkeQsfKgmjBa6Y+PFrPF5a7K7A/ieufpOhOV1j
 mcIJ//SaqEGYSO3zKJyEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245954>

Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
"all" suppresses all output of submodule changes for gitk. This is really
confusing, as even when the user chooses to record a new commit for an
ignored submodule by adding it manually this change won't show up under
"Local changes checked in to index but not committed".

Fix that by using the '--ignore-submodules=dirty' option for both callers
of "git diff-index --cached" when the underlying git version supports that
option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 gitk | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 90764e8..f6efaa6 100755
--- a/gitk
+++ b/gitk
@@ -5205,11 +5205,15 @@ proc dohidelocalchanges {} {
 # spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
     global lserial showlocalchanges vfilelimit curview
-    global hasworktree
+    global hasworktree git_version

     if {!$showlocalchanges || !$hasworktree} return
     incr lserial
-    set cmd "|git diff-index --cached HEAD"
+    if {[package vcompare $git_version "1.7.2"] >= 0} {
+	set cmd "|git diff-index --cached --ignore-submodules=dirty HEAD"
+    } else {
+	set cmd "|git diff-index --cached HEAD"
+    }
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7705,7 +7709,7 @@ proc addtocflist {ids} {
 }

 proc diffcmd {ids flags} {
-    global log_showroot nullid nullid2
+    global log_showroot nullid nullid2 git_version

     set i [lsearch -exact $ids $nullid]
     set j [lsearch -exact $ids $nullid2]
@@ -7726,6 +7730,9 @@ proc diffcmd {ids flags} {
 	    }
 	}
     } elseif {$j >= 0} {
+	if {[package vcompare $git_version "1.7.2"] >= 0} {
+	    set flags "$flags --ignore-submodules=dirty"
+	}
 	set cmd [concat | git diff-index --cached $flags]
 	if {[llength $ids] > 1} {
 	    # comparing index with specific revision
-- 
1.9.1.492.g8149f6f
