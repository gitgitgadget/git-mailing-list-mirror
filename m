From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/2] git-p4: Don't edit renamed files if not necessary.
Date: Fri, 19 Nov 2010 01:38:12 +0000
Message-ID: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
References: <1290130693-30855-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 02:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJFvi-0005q8-W0
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 02:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab0KSBiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 20:38:20 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34306 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab0KSBiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 20:38:18 -0500
Received: by wyb28 with SMTP id 28so3920772wyb.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 17:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LXBNybNOA4sDL+064W1m3uQVoQUJYvWERbVT+CvheBE=;
        b=aJpRuI1cq++VK3vwJaxNPu3n6c53VzOhnZ7D24NCINB4zcffHJrWoZl/a1FsS6fOh+
         nojpb/9V4rgM/RfPBNh9UySRVX+q5L2ITJuH27I6FQxStfk7onRbH0I66vCEqmmhv7AO
         eIIrXmdFCTPOWvHA57QYCeC/P1rno5Igwv9Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WHYAoRCc+pE66CajRmJd/ddvn3gHBV9HyjrP21xBOs7prLxVrgEPfGJ9SYxob0TXOs
         0XNApLhk1UP8kD5HwTMq+IhZcijoD5bAaYS8YgD3I4Kz0q3Lx1ipfEwGWBL+ecY0Grh0
         uWW37Icbae97omQ1XgMTnC5ImX4EoxW4/s6Q4=
Received: by 10.216.235.41 with SMTP id t41mr336750weq.55.1290130697605;
        Thu, 18 Nov 2010 17:38:17 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id a2sm540988wer.17.2010.11.18.17.38.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 17:38:16 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1290130693-30855-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161721>

Only open files for edit after integrating if the SHA1 of source and
destination differ from each other.
Also added git config option to allow permanent rename detection.
The detectRenames option should be set to the desired threshold value.
Rename detection can still be enabled through -M option.
---
 contrib/fast-import/git-p4 |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..ba18512 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -613,7 +613,13 @@ class P4Submit(Command):
 
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
-        diffOpts = ("", "-M")[self.detectRename]
+
+        detectRenames = gitConfig("git-p4.detectRenames")
+        if len(detectRenames) > 0:
+            diffOpts = "-M%s" % detectRenames
+        else:
+            diffOpts = ("", "-M")[self.detectRenames]
+
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -640,7 +646,8 @@ class P4Submit(Command):
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
                 p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
-                p4_system("edit \"%s\"" % (dest))
+                if diff['src_sha1'] != diff['dst_sha1']:
+                    p4_system("edit \"%s\"" % (dest))
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
-- 
1.7.2.3
