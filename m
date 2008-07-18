From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 1/3] gitk: Kill back-end processes on window close.
Date: Fri, 18 Jul 2008 09:45:43 +0400
Organization: TEPKOM
Message-ID: <200807180945.43504.angavrilov@gmail.com>
References: <200807180944.48570.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 07:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJinv-0001yh-NX
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 07:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYGRFpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYGRFpy
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:45:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:4681 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbYGRFpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:45:54 -0400
Received: by nf-out-0910.google.com with SMTP id d3so78636nfc.21
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 22:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pmDqd7H4Y5WI3+yBiw8REMD/I1+jBLiyngg7IudvDPU=;
        b=BsMJJ8imo+gKcIsQMJFmLCDXzSGJJl2Qu+ZkbWh+l6yUELEWa93bi47QVZh2Wf2ie9
         cViT7dVQWzYr/oUnvLg+6sWNkVhkD/5t82PipHiTbXS8PYZcJiyPWtiexTNc6vb2ygQT
         YDujATm1ygQLaDfVWl1Hb1YSWD9G3JoqI7LkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Vx/QaxVKsMYT3F+/rWCgQqweMJ8e1DPP2jLyk7JShumTEY1PCMvmzYADBe4uJ712dN
         BwlWW8PEiiQoR+Zp0dpNl7AA2LQ5020uVW81QIaoUzpid+Wm5zJZWX/8c2kEy+OQ8Zc/
         bzarMDBOkzjJGPb4/RIJaN8I3K3Yf/OKTufeU=
Received: by 10.210.72.19 with SMTP id u19mr1889198eba.55.1216359950481;
        Thu, 17 Jul 2008 22:45:50 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id c22sm1128778ika.1.2008.07.17.22.45.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 22:45:49 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807180944.48570.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88988>

When collecting commits for a rarely changed, or recently
created file or directory, rev-list may work for a noticeable
period of time without producing any output. Such processes
don't receive SIGPIPE for a while after gitk is closed, thus
becoming runaway CPU hogs.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/gitk b/gitk
index fddcb45..29d79d6 100755
--- a/gitk
+++ b/gitk
@@ -375,19 +375,33 @@ proc start_rev_list {view} {
     return 1
 }
 
+proc stop_instance {inst} {
+    global commfd leftover
+
+    set fd $commfd($inst)
+    catch {
+	set pid [pid $fd]
+	exec kill $pid
+    }
+    catch {close $fd}
+    nukefile $fd
+    unset commfd($inst)
+    unset leftover($inst)
+}
+
+proc stop_backends {} {
+    global commfd
+
+    foreach inst [array names commfd] {
+	stop_instance $inst
+    }
+}
+
 proc stop_rev_list {view} {
-    global commfd viewinstances leftover
+    global viewinstances
 
     foreach inst $viewinstances($view) {
-	set fd $commfd($inst)
-	catch {
-	    set pid [pid $fd]
-	    exec kill $pid
-	}
-	catch {close $fd}
-	nukefile $fd
-	unset commfd($inst)
-	unset leftover($inst)
+	stop_instance $inst
     }
     set viewinstances($view) {}
 }
@@ -2103,6 +2117,7 @@ proc makewindow {} {
     bind . <$M1B-minus> {incrfont -1}
     bind . <$M1B-KP_Subtract> {incrfont -1}
     wm protocol . WM_DELETE_WINDOW doquit
+    bind . <Destroy> {stop_backends}
     bind . <Button-1> "click %W"
     bind $fstring <Key-Return> {dofind 1 1}
     bind $sha1entry <Key-Return> gotocommit
-- 
1.5.6.2.39.gd084
