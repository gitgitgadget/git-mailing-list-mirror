From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 1/6] gitk: Kill back-end processes on window close.
Date: Sun, 27 Jul 2008 10:18:22 +0400
Organization: TEPKOM
Message-ID: <200807271018.22969.angavrilov@gmail.com>
References: <200807271017.23272.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 08:19:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzbR-0002yF-A7
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbYG0GSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbYG0GSd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:18:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:56071 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbYG0GSc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:18:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1893168fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5N4YjDiMZ59DC5Q0h6vm2osi2uifT2ZM60bK162SmuI=;
        b=BxTHPDk7Ze7unJOYn3CvvQgS8lRE7zPNHtP5j9/vxpAWBwsJUnC23/MTs4OxQpJ5h9
         bh3BpceFPycC1AlVdmuxWcDDsOnE5HKDYKDd5F8e8Ovk7h2Vr1bWMsB4sZTDWl1OOq/f
         m/x6GTDMO5x2qKrBtJf4M2lPWIxi/a0lWu3kI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mxFjczAxozUEvjrBv3SU9L8DHlLOrDkvpfuxwOswrhTj7W3PztE8z2h8y9EWSY1Nio
         tRzXljVYwOLPhIAxlJHAMgEwWggAK/XM5mh6HfH1wiiajx4poSEHxyQYNikQWKsek1Al
         6cTqobOG5mUSxoEoM54UKBvmmtTt1ROxCunjE=
Received: by 10.86.87.5 with SMTP id k5mr1393218fgb.59.1217139511190;
        Sat, 26 Jul 2008 23:18:31 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 12sm1889499fgg.0.2008.07.26.23.18.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:18:30 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807271017.23272.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90314>

Date: Sat, 12 Jul 2008 16:09:28 +0400

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
1.5.6.3.18.gfe82
