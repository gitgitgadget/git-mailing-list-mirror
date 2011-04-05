From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 7/8] gitk: simplify calculation of gitdir
Date: Mon,  4 Apr 2011 22:14:18 -0400
Message-ID: <1301969659-19703-8-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpZ-0002JM-HA
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1DECRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:17:12 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36444 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab1DECQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:59 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3719730qwk.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=voGzkbaNNOS8Vk8pau7EaBK7FGwfbBQ+s3Gh2I8iPVE=;
        b=dv7NbMm+wCYc7QRkSaENEXPqixPGPDplfl0lKpNnxQN8PY3kqtFQn5PEN5cmaE0IQw
         W0vZnxF8PIWQbcDvjb2ldXXjoM9knuoXE2fxamN+vy6dyspj3riwYpGKaLphWLEwpYtE
         hO741KQOXgpSt3vF0UDF5nf3PtJ1dSo0nRJuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vXtZ/4irhzFary7qgi9autWZBsko5pMwXAzadruB069x1eI5zu1hBiYoCbEfruvm4W
         X6VD4BmIO7wiVxFURP+lVBngLkHPAeylExdJt9mzzrRCWDDA36sDvaXZLANRkQAIj4JA
         kLkUigqKirvhmjiTbn5QGk5SHgZPxUfS0GQOw=
Received: by 10.224.113.142 with SMTP id a14mr6135344qaq.269.1301969818954;
        Mon, 04 Apr 2011 19:16:58 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170859>

Since 5024baa ([PATCH] Make gitk work when launched in a subdirectory,
2007-01-09), gitk has used 'git rev-parse --git-dir' to find the .git
directory. However, gitk still first checks for the $GIT_DIR
environment variable and that the value returned from git-rev-parse
does not point to a file. Since git-rev-parse does both of these
checks already, the checks can safely be removed from gitk. This makes
the gitdir procedure small enough to inline.

This cleanup introduces a UI regression in that the error message will
now be "Cannot find a git repository here." even in the case where
GIT_DIR points to a file, for which the error message was previously
"Cannot find the git directory \"%s\".". It should be noted, though,
that even before this patch, 'gitk --git-dir=path/to/some/file' would
give the former error message.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 gitk-git/gitk |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 0c1c4df..232ea6e 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9,15 +9,6 @@ exec wish "$0" -- "$@"
 
 package require Tk
 
-proc gitdir {} {
-    global env
-    if {[info exists env(GIT_DIR)]} {
-	return $env(GIT_DIR)
-    } else {
-	return [exec git rev-parse --git-dir]
-    }
-}
-
 # A simple scheduler for compute-intensive stuff.
 # The aim is to make sure that event handlers for GUI actions can
 # run at least every 50-100 ms.  Unfortunately fileevent handlers are
@@ -11507,14 +11498,10 @@ setui $uicolor
 setoptions
 
 # check that we can find a .git directory somewhere...
-if {[catch {set gitdir [gitdir]}]} {
+if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
     show_error {} . [mc "Cannot find a git repository here."]
     exit 1
 }
-if {![file isdirectory $gitdir]} {
-    show_error {} . [mc "Cannot find the git directory \"%s\"." $gitdir]
-    exit 1
-}
 
 set selecthead {}
 set selectheadid {}
-- 
1.7.4.79.gcbe20
