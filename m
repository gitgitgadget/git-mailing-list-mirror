From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 3/3] git-p4: fix P4 label import for unprocessed commits
Date: Thu, 27 Aug 2015 08:18:58 +0100
Message-ID: <1440659938-12952-4-git-send-email-luke@diamand.org>
References: <1440659938-12952-1-git-send-email-luke@diamand.org>
Cc: marcus.holl@sap.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 09:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUrT7-0005Dv-0Y
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 09:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbbH0HTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 03:19:21 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33747 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbH0HTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 03:19:16 -0400
Received: by wijn1 with SMTP id n1so45900871wij.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J4txFih1dpA3eHrraJPXeKkod3kQsoCG0DDfzKvN1Jk=;
        b=MZY5NTVImLNT6eqQwE6IZewoMjzl7QDQUlAbtnjkucjsLQ0j/WEfgwFPGLZ4ApplZA
         yHCgdA61exhrPa+E9WfwKUJfDiI9BCOKwhkqMWwn+4Rwr4yjunfsPIyaYyiLY3UiuolE
         Cri4SDQash6JEAL0QLgnEhlTg+7l2ZB+fA5p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J4txFih1dpA3eHrraJPXeKkod3kQsoCG0DDfzKvN1Jk=;
        b=Z8L8lYm7pUTWMqLomc5OOInNWBAJcsS/Hk2nIsIZ+1glyudy4y0IkuFPXNi2ff+d7l
         8dNK1/HYynYLZZA/s628B4BamhSF3c52q7aoKxcqk5JyyGjWOgVCkW7ND5OxbDDWSsLi
         IkNaUq5XNlz8yIAZOd6MtbGARqo7dvEJY569Q6F9s9Wxq1JBfITRNfN+YG3nsL+U3pQG
         QTxUhtIy3kc731JveUdvniNVD491R7sASm3wKUK0YCZ7RY/vFmZEeliibDDnQPTKgV3E
         5TI8+Ow0kiDlgN5W8X3lg3CyDMZMMER+0hqDMdAfvNCkknqs7wZBm+RkOZ71P/ps16pZ
         Fzzw==
X-Gm-Message-State: ALoCoQn3otWG2+6eVs94GDyG05iRUVt3CW+2t5XqxUvFuC5T1C0qTb2+9jyAoluyqYiRPesY/kBi
X-Received: by 10.181.8.200 with SMTP id dm8mr8996672wid.67.1440659955723;
        Thu, 27 Aug 2015 00:19:15 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id ne7sm2140308wic.12.2015.08.27.00.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 00:19:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0
In-Reply-To: <1440659938-12952-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276664>

With --detect-labels enabled, git-p4 will try to create tags
using git fast-import by writing a "tag" clause to the
fast-import stream.

If the commit that the tag references has not yet actually
been processed by fast-import, then the tag can't be created
and git-p4 fails to import the P4 label.

Teach git-p4 to use fast-import "marks" when creating tags
which reference commits created during the current run of the
program.

Commits created before the current run are still referenced
in the old way using a normal git commit.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                      | 25 +++++++++++++++++--------
 t/t9811-git-p4-label-import.sh |  2 +-
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a62611a..2018011 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2322,8 +2322,11 @@ class P4Sync(Command, P4UserMap):
         else:
             return "%s <a@b>" % userid
 
-    # Stream a p4 tag
     def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
+        """ Stream a p4 tag.
+        commit is either a git commit, or a fast-import mark, ":<p4commit>"
+        """
+
         if verbose:
             print "writing tag %s for commit %s" % (labelName, commit)
         gitStream.write("tag %s\n" % labelName)
@@ -2374,7 +2377,7 @@ class P4Sync(Command, P4UserMap):
             self.clientSpecDirs.update_client_spec_path_cache(files)
 
         self.gitStream.write("commit %s\n" % branch)
-#        gitStream.write("mark :%s\n" % details["change"])
+        self.gitStream.write("mark :%s\n" % details["change"])
         self.committedChanges.add(int(details["change"]))
         committer = ""
         if author not in self.users:
@@ -2493,13 +2496,19 @@ class P4Sync(Command, P4UserMap):
             if change.has_key('change'):
                 # find the corresponding git commit; take the oldest commit
                 changelist = int(change['change'])
-                gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
-                     "--reverse", ":/\[git-p4:.*change = %d\]" % changelist], ignore_error=True)
-                if len(gitCommit) == 0:
-                    print "importing label %s: could not find git commit for changelist %d" % (name, changelist)
-                else:
-                    gitCommit = gitCommit.strip()
+                if changelist in self.committedChanges:
+                    gitCommit = ":%d" % changelist       # use a fast-import mark
                     commitFound = True
+                else:
+                    gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
+                        "--reverse", ":/\[git-p4:.*change = %d\]" % changelist], ignore_error=True)
+                    if len(gitCommit) == 0:
+                        print "importing label %s: could not find git commit for changelist %d" % (name, changelist)
+                    else:
+                        commitFound = True
+                        gitCommit = gitCommit.strip()
+
+                if commitFound:
                     # Convert from p4 time format
                     try:
                         tmwhen = time.strptime(labelDetails['Update'], "%Y/%m/%d %H:%M:%S")
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index f7d5048..f994640 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -222,7 +222,7 @@ p4_head_revision() {
 # has not been seen. The presence of a label on a commit
 # we haven't seen should not cause git-p4 to fail. It should
 # merely skip that label, and still import other labels.
-test_expect_failure 'importing labels with missing revisions' '
+test_expect_success 'importing labels with missing revisions' '
 	test_when_finished cleanup_git &&
 	(
 		rm -fr "$cli" "$git" &&
-- 
2.5.0.rc0
