From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/48] t6039: Add tests for content issues with modify/rename/directory conflicts
Date: Wed,  8 Jun 2011 01:30:35 -0600
Message-ID: <1307518278-23814-6-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDFv-0007ZU-Pf
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab1FHH3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:02 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab1FHH3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:00 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qApIcGXKcul4trQ2bCZyTQP39J3Y4vDyHIqj3FvL/nk=;
        b=rrQQM87GH86i4LIQ/tlHE910mAzAAwpsXdOcTmyr0cbP+NHOqeZI/u6X0ShOaG1DSk
         7rOLMnxpMNDYUe5qra4AZ2S5kd2mD127EjW4Znx/FmXzhj0m3t2oL+ZvWWwbfoFs4fH+
         qUodQo4Mdsu0I+CMC79KwkP3SLAo/vD/zr7Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nH+LkE3yoiUCqVqnMftZEcdiYBEBCoqH32hDqehWxLzM7v4r7isDhImGwFQhHo8xFE
         oY/X5Y7oqTsnlkCHSAhjCmrb08zQCD592hHyxmv0Q3pdB3F7vETqRHBcsUIi0v5+eLIx
         PvdPn+FnFhZggJIFtzd1mT8FR07alfHy2QPNc=
Received: by 10.68.35.99 with SMTP id g3mr600230pbj.53.1307518140685;
        Wed, 08 Jun 2011 00:29:00 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.28.58
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:28:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175343>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6039-merge-rename-corner-cases.sh |  141 ++++++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index db5560c..b465667 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -198,4 +198,145 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
 '
 
+test_expect_success 'setup content merge + rename/directory conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n" >file &&
+	git add file &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b right &&
+	echo 7 >>file &&
+	mkdir newfile &&
+	echo junk >newfile/realfile &&
+	git add file newfile/realfile &&
+	test_tick &&
+	git commit -m right &&
+
+	git checkout -b left-conflict base &&
+	echo 8 >>file &&
+	git add file &&
+	git mv file newfile &&
+	test_tick &&
+	git commit -m left &&
+
+	git checkout -b left-clean base &&
+	echo 0 >newfile &&
+	cat file >>newfile &&
+	git add newfile &&
+	git rm file &&
+	test_tick &&
+	git commit -m left
+'
+
+test_expect_failure 'rename/directory conflict + clean content merge' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left-clean^0 &&
+
+	test_must_fail git merge -s recursive right^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 1 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	echo 0 >expect &&
+	git cat-file -p base:file >>expect &&
+	echo 7 >>expect &&
+	test_cmp expect newfile~HEAD &&
+
+	test $(git rev-parse :2:newfile) = $(git hash-object expect) &&
+
+	test -f newfile/realfile &&
+	test -f newfile~HEAD
+'
+
+test_expect_failure 'rename/directory conflict + content merge conflict' '
+	git reset --hard &&
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left-conflict^0 &&
+
+	test_must_fail git merge -s recursive right^0 &&
+
+	test 4 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 1 -eq $(git ls-files -o | wc -l) &&
+
+	git cat-file -p left-conflict:newfile >left &&
+	git cat-file -p base:file    >base &&
+	git cat-file -p right:file   >right &&
+	test_must_fail git merge-file \
+		-L "HEAD:newfile" \
+		-L "" \
+		-L "right^0:file" \
+		left base right &&
+	test_cmp left newfile~HEAD &&
+
+	test $(git rev-parse :1:newfile) = $(git rev-parse base:file) &&
+	test $(git rev-parse :2:newfile) = $(git rev-parse left-conflict:newfile) &&
+	test $(git rev-parse :3:newfile) = $(git rev-parse right:file) &&
+
+	test -f newfile/realfile &&
+	test -f newfile~HEAD
+'
+
+test_expect_success 'setup content merge + rename/directory conflict w/ disappearing dir' '
+	git reset --hard &&
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	mkdir sub &&
+	printf "1\n2\n3\n4\n5\n6\n" >sub/file &&
+	git add sub/file &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b right &&
+	echo 7 >>sub/file &&
+	git add sub/file &&
+	test_tick &&
+	git commit -m right &&
+
+	git checkout -b left base &&
+	echo 0 >newfile &&
+	cat sub/file >>newfile &&
+	git rm sub/file &&
+	mv newfile sub &&
+	git add sub &&
+	test_tick &&
+	git commit -m left
+'
+
+test_expect_success 'disappearing dir in rename/directory conflict handled' '
+	git reset --hard &&
+	git clean -fdqx &&
+
+	git checkout left^0 &&
+
+	git merge -s recursive right^0 &&
+
+	test 1 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	echo 0 >expect &&
+	git cat-file -p base:sub/file >>expect &&
+	echo 7 >>expect &&
+	test_cmp expect sub &&
+
+	test -f sub
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
