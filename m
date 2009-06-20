From: newren@gmail.com
Subject: [PATCH 6/7] Add new fast-export testcases
Date: Fri, 19 Jun 2009 22:37:02 -0600
Message-ID: <1245472623-28103-7-git-send-email-newren@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:39:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsMl-0004Gg-QH
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbZFTEjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZFTEjf
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:39:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:7578 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZFTEjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:39:33 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1018242wfd.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=t0qd+S1gzl/nNyKbJL47g2EnkiP5pTaSdrypHai/ASY=;
        b=QQNLGQoWwTGieklXqpeMiAeatRRInxN0arILnKIQdVJ4x0TfyZFHTpfYtITK18dnGv
         daDE+AdZGl2VD+e/w7ObW9BiSjFeXgPJvxq5PEFlLyOYFQ6GspYI1E6RoirUE0M5lxn2
         0Q1t0SpfvaE/MoSywZE+4yMRIpixFydA/hjS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w/ea0T5cHlJG8gG7iqIzSJzierrvVkRl94c6bqqv0Hbtgbk9GhneYbmiMWTWIWG4Mo
         Es4Iow3odrqDYNzOb+OUiQFZ2JWQJ8KOP3zNqV7JXnnLu4mTfvic4usQtc5yXlmEuroo
         UL8aTZ6O8JKs7wpLoKVzbldq+uVoTa4YEvOsI=
Received: by 10.142.174.20 with SMTP id w20mr1271092wfe.39.1245472776220;
        Fri, 19 Jun 2009 21:39:36 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245472623-28103-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121926>

From: Elijah Newren <newren@gmail.com>

The testcases test the new --tag-of-filtered-object option, and test the
output when limiting what to export by path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9301-fast-export.sh |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index d17f0e4..8b165ff 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -262,6 +262,61 @@ test_expect_success 'cope with tagger-less tags' '
 
 '
 
+test_expect_success 'setup for limiting exports by PATH' '
+	mkdir limit-by-paths &&
+	cd limit-by-paths &&
+	git init &&
+	echo hi > there &&
+	git add there &&
+	git commit -m "First file" &&
+	echo foo > bar &&
+	git add bar &&
+	git commit -m "Second file" &&
+	git tag -a -m msg mytag &&
+	cd ..
+'
+
+cat > limit-by-paths/expected << EOF
+blob
+mark :1
+data 3
+hi
+
+reset refs/tags/mytag
+commit refs/tags/mytag
+mark :2
+author A U Thor <author@example.com> 1112912713 -0700
+committer C O Mitter <committer@example.com> 1112912713 -0700
+data 11
+First file
+M 100644 :1 there
+
+EOF
+
+test_expect_success 'dropping tag of filtered out object' '
+	cd limit-by-paths &&
+	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
+	test_cmp output expected &&
+	cd ..
+'
+
+cat >> limit-by-paths/expected << EOF
+tag mytag
+from :2
+tagger C O Mitter <committer@example.com> 1112912713 -0700
+data 4
+msg
+
+EOF
+
+test_expect_success 'rewriting tag of filtered out object' '
+	cd limit-by-paths &&
+	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
+	test_cmp output expected &&
+	cd ..
+'
+
+
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f master &&
 	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
-- 
1.6.3.2.323.gfb84f
