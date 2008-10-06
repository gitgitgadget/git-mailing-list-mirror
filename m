From: Abdelrazak Younes <younes@lyx.org>
Subject: [QGIT PATCH] Rework the commit confirmation box a bit
Date: Mon, 06 Oct 2008 11:11:53 +0200
Message-ID: <48E9D659.1090503@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 11:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmm9W-00064i-6s
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 11:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbYJFJMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 05:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbYJFJMF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 05:12:05 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:39096 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbYJFJME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 05:12:04 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 397853EA12D
	for <git@vger.kernel.org>; Mon,  6 Oct 2008 11:11:59 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 1693C3EA0B1
	for <git@vger.kernel.org>; Mon,  6 Oct 2008 11:11:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97575>

The problem was that the dialog was too big for my whenever too many files
were changed. Now, the list of changed files is only shown whenever they are
less than 20; otherwise it is shown in the detailed text accessible though
the 'Show Detail' button.
---
  src/commitimpl.cpp |   25 ++++++++++++++++++++-----
  1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/commitimpl.cpp b/src/commitimpl.cpp
index 1540947..def5209 100644
--- a/src/commitimpl.cpp
+++ b/src/commitimpl.cpp
@@ -236,17 +236,32 @@ bool CommitImpl::checkConfirm(SCRef msg, SCRef 
patchName, SCList selFiles, bool
          (git->isStGITStack() ? "refresh top patch with" :
                          "amend last commit with") :
          (git->isStGITStack() ? "create a new patch with" : "commit");
-    QString text("Do you want to " + whatToDo + " the following 
file(s)?\n\n" +
-                 selFiles.join("\n") + "\n\nwith the message:\n\n");
+    QString text("Do you want to " + whatToDo);
+
+    bool const fullList = selFiles.size() < 20;
+    if (fullList) {
+        text.append(" the following file(s)?\n\n" + selFiles.join("\n")
+            + "\n\nwith the message:\n\n");
+    } else {
+        text.append(" those " + QString::number(selFiles.size())
+            + " files the with the message:\n\n");
+    }
+
      text.append(msg);
      if (git->isStGITStack())
          text.append("\n\nAnd patch name: " + patchName);

      QTextCodec::setCodecForCStrings(tc);

-    int but = QMessageBox::question(this, "Commit changes - QGit",
-                                    text, "&Yes", "&No", QString(), 0, 1);
-    return (but != 1);
+    QMessageBox msgBox(this);
+    msgBox.setWindowTitle("Commit changes - QGit");
+    msgBox.setText(text);
+    if (!fullList)
+        msgBox.setDetailedText(selFiles.join("\n"));
+    msgBox.setStandardButtons(QMessageBox::Yes | QMessageBox::No);
+    msgBox.setDefaultButton(QMessageBox::Yes);
+
+    return msgBox.exec() != QMessageBox::No;
  }

  void CommitImpl::pushButtonSettings_clicked() {
-- 
1.6.0.2.1172.ga5ed0
