From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 17:38:07 +0530
Message-ID: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 14:06:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUFWC-0001AP-8X
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 14:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab3DVMGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 08:06:43 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:47867 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab3DVMGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 08:06:42 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so733807pde.32
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ajCdZ18DZLO+FD8F27QLT2g4DxNI6mB3iOsg1VPtDhE=;
        b=yPPS5cEWP+z1x3zmOzeXJ8Pl2yjmJ9q+Akr6OBbits5ZMXz/SHbRQ4ilqh/LIxLl0K
         N7+ITVzxVc57e9V+ftaR5ooFK6HjCUYcz/xGImkwIDgr9DCmpaB6NjmFR9TDAp8iZAXM
         pTDM7uxj7ybWvIu+sIcSeWobXB99yHfWgKDTbG6ko+4RWQ8SG4jyMpZl9JQL5X0Jn7aa
         mp6vEbnuE/+Qhmdr//4mOmBjMqC77FL/qCw2uNVaCbVQ26vv7CB8GewMiVPWnzOsRGQH
         hUkUC1Njw6McNFp/G4mywngntimGpvTwDbEufPRSA7eqaOAmhhSZwo2++EEAbxPxjC5N
         cA+g==
X-Received: by 10.66.120.173 with SMTP id ld13mr12163924pab.187.1366632402150;
        Mon, 22 Apr 2013 05:06:42 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ts3sm24926165pbc.12.2013.04.22.05.06.39
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 05:06:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.546.gea3475a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222006>

When using 'git subtree' to add an external project at a given prefix,
log of a pathspec within the prefix fails to give the expected output.
This failure can be interpreted as log expecting all trees to be read
into /.  Document this bug by adding a failing test.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I normally don't use git-subtree, but happened to notice this when I
 was checking it out: a 'git log <pathspec>', when referring to a file
 inside the subtree, doesn't work as expected: it only displays the
 HEAD commit.  I know this is not related to git-subtree at all, and
 has to do with how 'git log' (and probably 'git merge -Xsubtree',
 'git merge -s subtree') works.  I suspect that 'git log' expects all
 trees to be read into /, and I've tried to prove this with a failing
 test.

 I think this is a bug, but I might be missing something.  Can someone
 tell me what is actually happening?

 t/t4202-log.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 9243a97..523c1be 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -168,6 +168,37 @@ test_expect_success 'git log --follow' '
 
 '
 
+test_expect_failure 'log pathspec in tree read into prefix' '
+	git checkout --orphan subtree &&
+	git rm -rf . &&
+	echo foodle >ichi &&
+	git add ichi &&
+	test_tick &&
+	git commit -m foom &&
+	echo moodle >unrelated &&
+	git add unrelated &&
+	test_tick &&
+	git commit -m quux &&
+	subtree_h=$(git rev-parse HEAD) &&
+	git checkout master &&
+	orig_h=$(git rev-parse HEAD) &&
+	git read-tree --prefix=bar $subtree_h &&
+	new_t=$(git write-tree) &&
+	new_h=$(echo "new subtree" |
+	git commit-tree $new_t -p $orig_h -p $subtree_h) &&
+	git reset --hard $new_h &&
+	(
+		cd bar &&
+		git log --oneline ichi >../actual
+	) &&
+	cat >expect <<-\EOF &&
+	61dcd8e new subtree
+	130a8fb foom
+	EOF
+	git reset --hard HEAD~1 &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 804a787 sixth
 394ef78 fifth
-- 
1.8.2.1.546.gea3475a
