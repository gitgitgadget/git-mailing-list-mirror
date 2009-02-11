From: newren@gmail.com
Subject: [PATCH] Add new testcase to show that fast-export can squash merge commits
Date: Tue, 10 Feb 2009 23:03:52 -0700
Message-ID: <1234332233-10017-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 07:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8EK-0000Ba-Ta
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbZBKGEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbZBKGEV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:04:21 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:45732 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbZBKGEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:04:20 -0500
Received: by yx-out-2324.google.com with SMTP id 8so27578yxm.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qS9XYaMbS4XK+WNFkVk0Pi5V/sYqJC0mLKBq+NKl2+w=;
        b=edvmeXy/A4s2+EPq/6BsaJIgMXxKh0sBH3v8eZ2KAKE3jUvphhPzTM3QHHawG5J4tH
         OEueSasYT1sNdTlWnx21pQPzSPNZnIW6cJ8CjVEscG1l5Erdoqm8BcjQoTwloy5IZ6qF
         dmpEEfy9zyfIhbTLHWuujEYVply7LVet3hozg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SM2HjGi7A/N1F5+A0zP4FuQAsYQtwHPuMMAzS2kyDZLyqVoDxHXe43N4wK6/xVQ6hk
         wBZB9SqDVRO8uwgjsT83gVCcHD/DXjbVg5g2e0BPZXYRhIupp9b4CNbfFLizGVigTgRi
         2BqYE7GhRS03zNh5X1v9gImfCvGeMs08Z7Gg0=
Received: by 10.142.144.16 with SMTP id r16mr1139436wfd.163.1234332258812;
        Tue, 10 Feb 2009 22:04:18 -0800 (PST)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id 27sm15478089wff.28.2009.02.10.22.04.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 22:04:18 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.12.g30288
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109378>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
I'm not certain this testcase will actually trigger the bug for everyone,
since I don't know the order of commits used by git rev-list.  It does
trigger it for me.  What you need is a history that looks like
    B--D
   /  /
  A--C
with the master branch pointing at D, and have "git rev-list --all" show
these commits in the order
  C
  D
  B
  A
If you have such a repository, "git fast-export --all" will give
instructions to create a master branch that only contains D, B, and A.
 t/t9301-fast-export.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 9985721..a1ee400 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -259,4 +259,33 @@ test_expect_success 'cope with tagger-less tags' '
 
 '
 
+test_expect_success 'avoid squashing merges' '
+
+	mkdir repo &&
+	cd repo &&
+	git init &&
+	echo fee-fi-fo-fum > giant &&
+	git add giant &&
+	git commit -m "Initial commit" &&
+	git branch alternate_root &&
+	echo hello > world &&
+	git add world &&
+	git commit -m "Commit on master" &&
+	git checkout alternate_root &&
+	echo foo > bar &&
+	git add bar &&
+	git commit -m "Commit on alternate_root" &&
+	git checkout master &&
+	git merge alternate_root &&
+	MASTER=$(git rev-parse --verify refs/heads/master) &&
+	rm -rf ../new &&
+	mkdir ../new &&
+	git --git-dir=../new/.git init &&
+	git fast-export --all |
+	(cd ../new &&
+	 git fast-import &&
+	 test $MASTER = $(git rev-parse --verify refs/heads/master))
+
+'
+
 test_done
-- 
1.6.0.6
