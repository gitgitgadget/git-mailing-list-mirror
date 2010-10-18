From: Andrew Waters <apwaters@googlemail.com>
Subject: [PATCH] Fix handling of git-p4 on deleted files
Date: Mon, 18 Oct 2010 16:39:52 +0100
Message-ID: <AANLkTimzN9ZGwQZ-pi6SMWGY9KS0fjmXu=1gjdfck=W-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 17:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7rol-0007aT-MW
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 17:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765Ab0JRPjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 11:39:54 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38337 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762Ab0JRPjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 11:39:53 -0400
Received: by gxk21 with SMTP id 21so51445gxk.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=22fVmPJjUsl8XTFajsXcdFguebGa9IxVdd66lo+g/Zw=;
        b=vXaK27oGINyaN37eci4SBmyJa9mO/sEh46+66VS7knlolvCXuWguiD/8bbpk2myGAi
         kgaeNOlegfXPFhddSKbjNrda+up5wnwAOU1QEH/3V8wa+UVUAlRaPzsYWmbukPGznYmc
         kCvAJt1ikbVtQVmWG/DJ424XIezNwKg0lu8QM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jwwnV6mXo1OiNzV8fO8C5HMZduFjA1Om77XDo62WaHQRjauZxstgET1Y3NjAjz8mQs
         BJ0aBsj8LUf8CamPg2AcdOcG0NAQVQlajNLJKRl8ZzGc+31XWho77REQBTneWSNjzufE
         4GrNT7bpLyyqySsLgsVy33rLL6bt8BSIK4pmE=
Received: by 10.151.116.15 with SMTP id t15mr6589902ybm.192.1287416392993;
 Mon, 18 Oct 2010 08:39:52 -0700 (PDT)
Received: by 10.100.194.5 with HTTP; Mon, 18 Oct 2010 08:39:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159259>

When you submit changes containing deleted file the command 'p4 diff
-du ...' includes diffs for deleted files. This causes the failure:

open for read: <deleted file>: No such file or directory
Command failed: p4 diff -du ...

The problem is that perforce has been told to delete the file and then
we try to apply diffs to a file which no longer exists.

---
 contrib/fast-import/git-p4 |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c1ea643..04ce7e3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -706,7 +706,9 @@ class P4Submit(Command):
             submitTemplate = self.prepareLogMessage(template, logMessage)
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
-            diff = p4_read_pipe("diff -du ...")
+            diff = ""
+            for editedFile in editedFiles:
+                diff += p4_read_pipe("diff -du %r" % editedFile)

             newdiff = ""
             for newFile in filesToAdd:
-- 
1.7.2.2
