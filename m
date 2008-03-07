From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: do not show local changes for bare repositories
Date: Fri,  7 Mar 2008 01:04:42 -0800
Message-ID: <8875845cb2c0c3a1ac515b8f71e6be77f3266479.1204879048.git.davvid@gmail.com>
References: <64b42ab91804e670057c807fd8265fc07106792c.1204806475.git.davvid@gmail.com>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 09:55:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXYMF-0006CQ-NC
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 09:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbYCGIyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 03:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbYCGIyh
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 03:54:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:51899 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759835AbYCGIyf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 03:54:35 -0500
Received: by wa-out-1112.google.com with SMTP id v27so425823wah.23
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 00:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WMH2XlO+L+YcJrHySUYTVHvwhx1p+McsxThIaKrgK5w=;
        b=rspX/lwhGH8556TVQp2Xb73ETBzU/im1mQAUoWQd4LCyczRqbANtrp2btGXN5sfunK+jgBvsXURr9hQeqJCMFh7GcV+/OIJqDuKGieWT9C2BPpFcoT/ObrbTmYU07lRZ/lC1iXRIltqQPGuj/anGirz/6cn7U952iYZ2SLF9iqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ofkBwbZy9XtnivcKctkyCUWhHauhGHuzwcST84vRWr5NJt7bTdwA5KT5e8jUArs5UHKqhRPcQHW3r/jj83pwr0HT8rd5hiuu9bRExzTECbOB5Uo2F/f3ks96NapaOY9biir/OCjjzGea1l6c+lM082JZwcivQmJDwtsJ+10RIdM=
Received: by 10.114.14.1 with SMTP id 1mr1861029wan.9.1204880074788;
        Fri, 07 Mar 2008 00:54:34 -0800 (PST)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id n22sm7763326pof.1.2008.03.07.00.54.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 00:54:33 -0800 (PST)
X-Mailer: git-send-email 1.5.4
In-Reply-To: <64b42ab91804e670057c807fd8265fc07106792c.1204806475.git.davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76471>

Launching gitk on a bare repository would previously show the
work tree as having removed all files.  We now query for
bare repositories in updatecommits and test the value in
dodiffindex before showing local changes.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..080459d 100755
--- a/gitk
+++ b/gitk
@@ -393,6 +393,7 @@ proc readcommit {id} {
 proc updatecommits {} {
     global viewdata curview phase displayorder ordertok idpending
     global children commitrow selectedline thickerline showneartags
+    global isbare
 
     if {$phase ne {}} {
 	stop_rev_list
@@ -407,6 +408,7 @@ proc updatecommits {} {
     foreach vid [array names idpending "$n,*"] {
 	unset idpending($vid)
     }
+    set isbare [expr {[exec git rev-parse --is-bare-repository] == "true"}]
     set curview -1
     catch {unset selectedline}
     catch {unset thickerline}
@@ -2843,9 +2845,9 @@ proc dohidelocalchanges {} {
 
 # spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
-    global localirow localfrow lserial showlocalchanges
+    global localirow localfrow lserial showlocalchanges isbare
 
-    if {!$showlocalchanges} return
+    if {!$showlocalchanges || $isbare} return
     incr lserial
     set localfrow -1
     set localirow -1
-- 
1.5.4.1

