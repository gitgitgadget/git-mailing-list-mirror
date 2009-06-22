From: newren@gmail.com
Subject: [PATCH v2] Add new fast-export testcases
Date: Mon, 22 Jun 2009 07:06:40 -0600
Message-ID: <1245676001-14734-6-git-send-email-newren@gmail.com>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:09:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjH0-0004LE-8o
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbZFVNJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 09:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbZFVNI6
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:08:58 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:55508 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZFVNI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 09:08:56 -0400
Received: by mail-pz0-f197.google.com with SMTP id 35so731490pzk.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=feC6VAV62YxYR6mib/nIElz2mkd7O1ndafLXmnKi0WQ=;
        b=hVfT5szF5LtctLPgZdP/xGMziZ/Gg598hI+T2gc7z3La9kkPh+mZCookHX51cZnbaK
         DPTXANhe5sbt2E7j6I08gLiObwJ+mDESA8emRNEpRFB+xSyRlWCu0F4LOE/vWBq44sae
         eNT+yxSeUIFdw9Lc/PLZQTFoo+IopN8hTGzQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E71VwksIbE9cUOK6XlY7imO4kSU//x8X4Okjv42z99QltEyE5fFVhphsm2qiJcIkH5
         Z0JO7pVducVy63coc5LN0UATYmHkjpIHjot4M8qRhP8Wi56HVp/Xz4841upioAa3xcF/
         dtGCdgq7PzSNU4zRy33DWWV7XD7/CtgFjkycA=
Received: by 10.142.142.16 with SMTP id p16mr2642127wfd.231.1245676140088;
        Mon, 22 Jun 2009 06:09:00 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 28sm675507wfd.23.2009.06.22.06.08.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 06:08:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245676001-14734-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122040>

From: Elijah Newren <newren@gmail.com>

The testcases test the new --tag-of-filtered-object option, and test the
output when limiting what to export by path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
(No change to this patch since the first series.)

 t/t9301-fast-export.sh |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 3f13e6b..d03d599 100755
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
1.6.0.6
