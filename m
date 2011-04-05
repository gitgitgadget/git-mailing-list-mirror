From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 4/8] gitk: fix "External diff" with separate work tree
Date: Mon,  4 Apr 2011 22:14:15 -0400
Message-ID: <1301969659-19703-5-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpX-0002JM-9V
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1DECRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:17:00 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57460 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab1DECQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:54 -0400
Received: by mail-qy0-f181.google.com with SMTP id 14so4223854qyg.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=fpDeyP4i/xRXUJkLRpgygaRfsS0HoVqUlNRUVp3Dl20=;
        b=UHBDRvSpvLG/cV86+zTBS+vm9m11EOnmGkk/uQkEh0VyJH6/7JmEQAgLFeCs4D4J1t
         mf0eGN/qGbO7TFKv07E2AJnipuhxLJnpmn9nQUVEegzN9PXuVb76a1sA6xzfg8f52hYH
         4VdLKYD1XnliwIzOGQeqAPPMp2whIICTGz5Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v8EN+skbL2RBmKCd38zYlHP+bRORBOtiUEHD8uIQM5NBUnf8XN253TFZNfdyNSuerF
         +/ZFZOkB4Q7UjzMW5f3rm1R0mKRJWu8yVdgJ68j7sVVX5fg+W91ihZh5Sf40JVc9tsly
         014dkWsqCLKO1v3RtdNP68CCBpfEMYWvfgMvo=
Received: by 10.224.173.212 with SMTP id q20mr6683347qaz.27.1301969813799;
        Mon, 04 Apr 2011 19:16:53 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170856>

Running "External diff" to compare the index and work tree currently
brings up an empty blame view when the work tree is not the parent of
the git directory. This is because the file that is taken from the
work tree is assumed to be in
$GIT_DIR/../<repo-relative-file-name>. Fix it by feeding the diff tool
a path under $GIT_WORK_TREE instead of "$GIT_DIR/..".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 gitk-git/gitk |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b1696de..58b98df 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3365,10 +3365,10 @@ proc save_file_from_commit {filename output what} {
 
 proc external_diff_get_one_file {diffid filename diffdir} {
     global nullid nullid2 nullfile
-    global gitdir
+    global worktree
 
     if {$diffid == $nullid} {
-        set difffile [file join [file dirname $gitdir] $filename]
+        set difffile [file join $worktree $filename]
 	if {[file exists $difffile]} {
 	    return $difffile
 	}
@@ -11634,6 +11634,7 @@ set cdup {}
 if {$isworktree} {
     set cdup [exec git rev-parse --show-cdup]
 }
+set worktree [exec git rev-parse --show-toplevel]
 setcoords
 makewindow
 catch {
-- 
1.7.4.79.gcbe20
