From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 6/8] gitk: run 'git rev-parse --git-dir' only once
Date: Mon,  4 Apr 2011 22:14:17 -0400
Message-ID: <1301969659-19703-7-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpY-0002JM-F7
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab1DECRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:17:05 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57460 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1DECQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:57 -0400
Received: by mail-qy0-f181.google.com with SMTP id 14so4223854qyg.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=oahmArIG6WrjAneiXGOlcyjA97tLtAasd9fXEKrnvzU=;
        b=leuTOFyw/UUDg6NSveUzmznuJWv7lvf0E2joaLne73zWfwRrbXV2GKWZ7Qyn8Nw57G
         IGVo1bjbl5h134AiSnxoR3xZf8IqUm+buULC0ATANLmWC3oElTRhoau1zakTGvScdLXF
         DAOcens/oGyDJIxqw4GWmWbkE7RpwL1q4RP0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jMKp6zDaAaywgfc6rIuWcC9unplh9lsQaKLSFTChQ79KSqhkRajkcFd7uVdd93HOOn
         pjziVBeu2NuLXI8CB6LD/007K6xA0yaRspbA2aZKLiZ+I/Bw6LWEm0SUiJqh6sO2AFaO
         23/qfc7WXqtV00cEllQUja+UCst0PWbW/eobY=
Received: by 10.229.17.130 with SMTP id s2mr6344644qca.22.1301969817154;
        Mon, 04 Apr 2011 19:16:57 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170861>

It seems like gitk has been setting the global variable 'gitdir' at
startup since aa81d97 (gitk: Fix Update menu item, 2006-02-28). It
should therefore no longer be necessary to call the procedure with the
same name (more than once to set the global variable). Remove the
other call sites and use the global variable instead.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 gitk-git/gitk |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b925f3e..0c1c4df 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9045,6 +9045,7 @@ proc exec_citool {tool_args {baseid {}}} {
 proc cherrypick {} {
     global rowmenuid curview
     global mainhead mainheadid
+    global gitdir
 
     set oldhead [exec git rev-parse HEAD]
     set dheads [descheads $rowmenuid]
@@ -9073,7 +9074,7 @@ proc cherrypick {} {
 			conflict.\nDo you wish to run git citool to\
 			resolve it?"]]} {
 		# Force citool to read MERGE_MSG
-		file delete [file join [gitdir] "GITGUI_MSG"]
+		file delete [file join $gitdir "GITGUI_MSG"]
 		exec_citool {} $rowmenuid
 	    }
 	} else {
@@ -9439,6 +9440,7 @@ proc refill_reflist {} {
 proc getallcommits {} {
     global allcommits nextarc seeds allccache allcwait cachedarcs allcupdate
     global idheads idtags idotherrefs allparents tagobjid
+    global gitdir
 
     if {![info exists allcommits]} {
 	set nextarc 0
@@ -9446,7 +9448,7 @@ proc getallcommits {} {
 	set seeds {}
 	set allcwait 0
 	set cachedarcs 0
-	set allccache [file join [gitdir] "gitk.cache"]
+	set allccache [file join $gitdir "gitk.cache"]
 	if {![catch {
 	    set f [open $allccache r]
 	    set allcwait 1
-- 
1.7.4.79.gcbe20
