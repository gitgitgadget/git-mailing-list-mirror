From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 1/2] git-p4: Improve rename detection support
Date: Sun, 20 Feb 2011 01:18:24 +0000
Message-ID: <1298164705-5366-2-git-send-email-vitor.hda@gmail.com>
References: <1298164705-5366-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 02:19:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqxxF-0005rP-Fn
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 02:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab1BTBTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 20:19:03 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44941 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab1BTBTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 20:19:00 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so5016609wwa.1
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 17:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=swVUe1BDKovAZqIuqFSrr/qs8Qj2E46xYSWsPuynads=;
        b=xUcH1NA/W0rRwAkhOKNEzOxTz6sTrsjuCIpWRaW320Y4M2K2pX9gtB3vy7ZXvZRZog
         PCybQkYW7owRa4WF3XKzSgevqrgDy1kAA9MnZ4ZGM94pYV+5v9/EXNNSIvTQZUeduVxO
         LzhxVWI5opgBGo3JJZoQZscrARZsfw4SuDXa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H6Jcae4+u7KAK0i3sU3I1fBtmH1EHFFu35wZAD4ln2xPeo+gAcyfQd1k/DkjtXGe+u
         7/1WDNz7Ai7e5cdtlCjr4S4te1/NZmZYgSvaxXx8Fsck0IPTDNrUR03LowpCMaa/rlB8
         hrTOb2ZURAdY40XdaDVROfAXwxE3RL4g12uEE=
Received: by 10.227.155.15 with SMTP id q15mr2035908wbw.133.1298164740187;
        Sat, 19 Feb 2011 17:19:00 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u9sm2909192wbg.12.2011.02.19.17.18.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 17:18:59 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298164705-5366-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167389>

Only open files for edit after integrating if the SHA1 of source and destination
differ from each other.
Add git config option detectRenames to allow permanent rename detection. This
options should be set to a true/false value.
Rename "detectRename" variable to "detectRenames" to make it more coherent with
the description in git man pages, which always use plural.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Acked-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a92beb6..b0da28a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -543,13 +543,13 @@ class P4Submit(Command):
         self.options = [
                 optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--origin", dest="origin"),
-                optparse.make_option("-M", dest="detectRename", action="store_true"),
+                optparse.make_option("-M", dest="detectRenames", action="store_true"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
         self.interactive = True
         self.origin = ""
-        self.detectRename = False
+        self.detectRenames = False
         self.verbose = False
         self.isWindows = (platform.system() == "Windows")
 
@@ -613,7 +613,16 @@ class P4Submit(Command):
 
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
-        diffOpts = ("", "-M")[self.detectRename]
+
+        if not self.detectRenames:
+            # If not explicitly set check the config variable
+            self.detectRenames = gitConfig("git-p4.detectRenames").lower() == "true"
+
+        if self.detectRenames:
+            diffOpts = "-M"
+        else:
+            diffOpts = ""
+
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -640,8 +649,10 @@ class P4Submit(Command):
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
                 p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
-                p4_system("edit \"%s\"" % (dest))
+                if diff['src_sha1'] != diff['dst_sha1']:
+                    p4_system("edit \"%s\"" % (dest))
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
+                    p4_system("edit \"%s\"" % (dest))
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
                 editedFiles.add(dest)
-- 
1.7.4.1
