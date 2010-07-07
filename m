From: newren@gmail.com
Subject: [PATCHv3 1/6] Add additional testcases for D/F conflicts
Date: Tue,  6 Jul 2010 23:20:29 -0600
Message-ID: <1278480034-22939-2-git-send-email-newren@gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 07:13:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMwc-0002Ar-RI
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab0GGFNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:13:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61704 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0GGFNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:13:02 -0400
Received: by gwj21 with SMTP id 21so1665527gwj.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=x7B4A0QB2tecPyrolWP2llqnhuZ1KIYQ/s32qUG/bDM=;
        b=p+FsmjC36CS8VJuC3G/2M/1w0lQsKJXKp5ge07vvkmIp06kVSE0/Eq8R4SKcsWb3PE
         TeQWtusMLDmbOh3HBQRwFYvZmBb0LbF0s7T+HEJ8j0ukL9UTTYoF8KhhsINdBEjlSFry
         mApEt0H1Ao5D3ITF7Uq+x4YcemC/4IapPMYcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O56sUWti7mhUNVwYBI2XYgawhiWwnyHWudVetpw1uplWIOsTP3XotZHsNwoaa7lZ+k
         WeXt7brR6nLAUakIu2uhHemSSpEl9f6zLkRIuFdNIBsGuYGy2fulJme8MzWC4/Rsc9vG
         GiPSUszOQHV9K03sAREjvZCTuOJItSn6RFlxs=
Received: by 10.100.254.4 with SMTP id b4mr2325384ani.57.1278479581656;
        Tue, 06 Jul 2010 22:13:01 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id h5sm60464675anb.28.2010.07.06.22.12.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:13:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.10.g6dbc5
In-Reply-To: <1278480034-22939-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150439>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6035-merge-dir-to-symlink.sh |   37 +++++++++++++++++++++++++++++++++++--
 t/t9350-fast-export.sh          |   24 ++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 3202e1d..3c176d7 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -56,7 +56,7 @@ test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
 	test -f a/b-2/c/d
 '
 
-test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_failure 'Handle D/F conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive master &&
@@ -64,6 +64,31 @@ test_expect_failure 'do not lose a/b-2/c/d in merge (recursive)' '
 	test -f a/b-2/c/d
 '
 
+test_expect_failure 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
+	git reset --hard &&
+	git checkout master &&
+	git merge -s recursive baseline^0 &&
+	test -h a/b &&
+	test -f a/b-2/c/d
+'
+
+test_expect_success 'do not lose untracked in merge (recursive)' '
+	git reset --hard &&
+	git checkout baseline^0 &&
+	touch a/b/c/e &&
+	test_must_fail git merge -s recursive master &&
+	test -f a/b/c/e &&
+	test -f a/b-2/c/d
+'
+
+test_expect_success 'do not lose modifications in merge (recursive)' '
+	git add --all &&
+	git reset --hard &&
+	git checkout baseline^0 &&
+	echo more content >> a/b/c/d &&
+	test_must_fail git merge -s recursive master
+'
+
 test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
 	git reset --hard &&
 	git checkout start^0 &&
@@ -82,7 +107,7 @@ test_expect_success 'merge should not have conflicts (resolve)' '
 	test -f a/b/c/d
 '
 
-test_expect_failure 'merge should not have conflicts (recursive)' '
+test_expect_failure 'merge should not have D/F conflicts (recursive)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s recursive test2 &&
@@ -90,4 +115,12 @@ test_expect_failure 'merge should not have conflicts (recursive)' '
 	test -f a/b/c/d
 '
 
+test_expect_failure 'merge should not have F/D conflicts (recursive)' '
+	git reset --hard &&
+	git checkout -b foo test2 &&
+	git merge -s recursive baseline^0 &&
+	test -h a/b-2 &&
+	test -f a/b/c/d
+'
+
 test_done
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d43f37c..69179c6 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -376,4 +376,28 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
+test_expect_failure 'directory becomes symlink'        '
+	git init dirtosymlink &&
+	git init result &&
+	(
+		cd dirtosymlink &&
+		mkdir foo &&
+		mkdir bar &&
+		echo hello > foo/world &&
+		echo hello > bar/world &&
+		git add foo/world bar/world &&
+		git commit -q -mone &&
+		git rm -r foo &&
+		ln -s bar foo &&
+		git add foo &&
+		git commit -q -mtwo
+	) &&
+	(
+		cd dirtosymlink &&
+		git fast-export master -- foo |
+		(cd ../result && git fast-import --quiet)
+	) &&
+	(cd result && git show master:foo)
+'
+
 test_done
-- 
1.7.1.1.10.g2e807
