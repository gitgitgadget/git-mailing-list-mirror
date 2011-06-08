From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 02/48] t6039: Add failing testcase for rename/modify/add-source conflict
Date: Wed,  8 Jun 2011 01:30:32 -0600
Message-ID: <1307518278-23814-3-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:32:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDFv-0007ZU-8C
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab1FHH25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:28:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab1FHH2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:28:54 -0400
Received: by pwi15 with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=F8fuyuuK/UedEZOvs/+acTeIO+zpo5bWgViB8kbkc34=;
        b=aR02KVwJP4IM/+ex/rFPJb52O/CujYUcJoEXrN7jOdIVxLgIll4rkgL8mecSg2wOGD
         jy2sTtXUarg+zSTnYdyraq8GD6SgK81CE8Ythed4E9lGyeiVVUG9Ar8/89Ww3ukmIXA8
         TlrcJLtRSnQqpb6L2EhlmgGlzFFt2eDf0Xzys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tc0LYe7lXzjC1npHXTa671YotrC4ntC6tQie66b9UuQQY8/uhJqH2xyGqQ+SzRI3Br
         EqC5MuKfhKrWLELfDJ/Ej0DEt7qOMv2wZnceugzIyAgiu0KjWpuCgLgzObqKV9se9cP9
         +i2/hgFKxRFZUSWfCzFuemmX/sqUY4RKY9RPw=
Received: by 10.68.19.35 with SMTP id b3mr596341pbe.512.1307518133810;
        Wed, 08 Jun 2011 00:28:53 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.28.51
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:28:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175342>

If there is a cleanly resolvable rename/modify conflict AND there is a new
file introduced on the renamed side of the merge whose name happens to
match that of the source of the rename (but is otherwise unrelated to the
rename), then git fails to cleanly resolve the merge despite the fact that
the new file should not cause any problems.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6039-merge-rename-corner-cases.sh |   39 ++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index 5054459..276d7dd 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -33,4 +33,43 @@ test_expect_failure "Does git preserve Gollum's precious artifact?" '
 	test -f ring
 '
 
+# Testcase setup for rename/modify/add-source:
+#   Commit A: new file: a
+#   Commit B: modify a slightly
+#   Commit C: rename a->b, add completely different a
+#
+# We should be able to merge B & C cleanly
+
+test_expect_success 'setup rename/modify/add-source conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	echo 8 >>a &&
+	git add a &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	echo something completely different >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'rename/modify/add-source conflict resolvable' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test $(git rev-parse B:a) = $(git rev-parse b) &&
+	test $(git rev-parse C:a) = $(git rev-parse a)
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
