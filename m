From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 2/7] gitk: Allow forcing branch creation if it already exists.
Date: Wed,  8 Oct 2008 11:05:35 +0400
Message-ID: <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:08:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnT9v-00067l-8A
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbYJHHHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbYJHHHY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20741 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbYJHHHX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2606173fgg.17
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gX+skPWLOLBkzwXJT+HdkD5MMU5gKeLEA2h2Rj3d0GI=;
        b=xV0ULOYpvKWWSjNdELDjoBefWrmcgN4wP0f4/qBqG6WW5BgBv0oYoUX/9mCzSPtumN
         Cz3FsVX4ldLz8N+o9bZCFueUj86ItubxY6hx+/Xl47a8kDhXD6PMJyvsOO9AaJ6MJoAG
         P++V+7/4YzhrhZK+2COySNwCIbrZxuk3pu+Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PrCfDvz+SFPpfogqp4wNVr0ylcJyUyyDn7v818b/xfkgN1lY6cHddtKJ4/wHnSJqE4
         fs7jux/QP+N6o7xOn1ODjv3wwA7EteUB6DPGDGm7tql+nQwDnoJVmHN1E+Cpnqv+fRrQ
         AQfcop6oczqdUKbjDH3f/gFuQa4dGfIUUaL+4=
Received: by 10.181.5.4 with SMTP id h4mr5839604bki.37.1223449642335;
        Wed, 08 Oct 2008 00:07:22 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97774>

If gitk knows that the branch the user tries to create exists,
it should ask whether it should overwrite it. This way the user
can either decide to choose a new name, or move the head while
preserving the reflog.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index a4ef736..96ca965 100755
--- a/gitk
+++ b/gitk
@@ -7669,24 +7669,42 @@ proc mkbrgo {top} {
 
     set name [$top.name get]
     set id [$top.sha1 get]
+    set cmdargs [list]
+    set old_id {}
     if {$name eq {}} {
 	error_popup [mc "Please specify a name for the new branch"] $top
 	return
     }
+    if {[info exists headids($name)]} {
+	if {![confirm_popup [mc \
+		"Branch '%s' already exists. Overwrite?" $name] $top]} {
+	    return
+	}
+	set old_id $headids($name)
+	lappend cmdargs -f
+    }
     catch {destroy $top}
+    lappend cmdargs $name $id
     nowbusy newbranch
     update
     if {[catch {
-	exec git branch $name $id
+	eval exec git branch $cmdargs
     } err]} {
 	notbusy newbranch
 	error_popup $err
     } else {
-	set headids($name) $id
-	lappend idheads($id) $name
-	addedhead $id $name
 	notbusy newbranch
-	redrawtags $id
+	if {$old_id ne {}} {
+	    movehead $id $name
+	    movedhead $id $name
+	    redrawtags $old_id
+	    redrawtags $id
+	} else {
+	    set headids($name) $id
+	    lappend idheads($id) $name
+	    addedhead $id $name
+	    redrawtags $id
+	}
 	dispneartags 0
 	run refill_reflist
     }
-- 
1.6.0.20.g6148bc
