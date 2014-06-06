From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitk: show staged submodules regardless of ignore config
Date: Fri, 06 Jun 2014 14:08:29 -0700
Message-ID: <xmqqtx7xpwz6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:10:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt1NQ-0006NE-FW
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 23:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbaFFVIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 17:08:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61805 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbaFFVIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 17:08:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43F511D4B5;
	Fri,  6 Jun 2014 17:08:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	djeaWcdkcZ71tPDWbbNUS/kWMc=; b=Ij/T3T/e227KAifj+sBxONTnIOXWV3Rsy
	IPh6ddoMGIq2gKhlqKk4f0ysUAAjEggAEoXvHgpq0cSk/AuZYFwbTRilIdnJYgwo
	9fDHF8R8nKaC52jioiZtC7yZEGOlc/+9+ujUgzvqZIAMw4LgSoYGQukr/HU1JlVZ
	CM0RuvlHAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=FXnhaz+Hz5QfjbhQpH2gOJ8bBpxo27jjlH7TjjzzhiXthB89tLcoWATE
	hZfISqyCctx8B0UG0EKZZGUQJzwSjbKrOtPNEOwAzNgroRCGEo8XPSIaOhWGZw9g
	h/t/Q2MogzDpBbHjAGDCX0tFoDKfuDlZiaAUgrL3LlOclPObS1w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A7B41D4B4;
	Fri,  6 Jun 2014 17:08:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7B7C61D498;
	Fri,  6 Jun 2014 17:08:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B6A64030-EDBE-11E3-A692-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250967>

From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Tue, 8 Apr 2014 21:36:08 +0200

Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
"all" suppresses all output of submodule changes for gitk. This is really
confusing, as even when the user chooses to record a new commit for an
ignored submodule by adding it manually this change won't show up under
"Local changes checked in to index but not committed".

Fix that by using the '--ignore-submodules=dirty' option for both callers
of "git diff-index --cached" when the underlying git version supports that
option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Paul, I've been carrying this in my 'pu' but I would prefer
   changes to gitk fed to me through you.  Could you apply this so
   that I can drop my tentative copy?

   Thanks.

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
2.0.0-531-gbd04298
