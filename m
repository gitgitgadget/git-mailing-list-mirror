From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 06/48] t6039: Add failing testcases for rename/rename/add-{source,dest} conflicts
Date: Wed,  8 Jun 2011 01:30:36 -0600
Message-ID: <1307518278-23814-7-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:29:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDCR-0005Ph-4X
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab1FHH3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab1FHH3D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:03 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=sqlGEp0k5Gaf58/qVvxzTkJGEhnDFzDqa0k4t82YgBQ=;
        b=mC4IPUPv3h1i7mUsPeJ1ho4bkYCsn/uwcmeeL6NIIFiEAO2mJ51PG9EH2Nbn1i0hA1
         BX4hBByacmzTQUuZiiBfEVhGi3E3IBOX0T3TX9Q3OriShdB+kaeyawgEPF/6wUcj3Lkz
         7YitSDdQg0CVTKPKGrgmxOZrExuk4lCUAY9q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TwLgNBVHLXxqXBiVdKjxRtUOEU4GmXdnCEyzepHcrtWsz8Xp7QVvkRxeHoxT1DLh3Y
         9OH+OgtvjbvH9F2GkjYWGvSQrkq1GC64s0KI683XUii9TriEYCiel1vtW+Efd7fdGR7y
         CpLwn4pj2ONrUG+5eVLeZ6t+G3hIkEro0VAvk=
Received: by 10.68.23.166 with SMTP id n6mr639418pbf.481.1307518143128;
        Wed, 08 Jun 2011 00:29:03 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.00
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175298>

Add testcases that cover three failures with current git merge, all
involving renaming one file on both sides of history:

Case 1:
If a single file is renamed to two different filenames on different sides
of history, there should be a conflict.  Adding a new file on one of those
sides of history whose name happens to match the rename source should not
cause the merge to suddenly succeed.

Case 2:
If a single file is renamed on both sides of history but renamed
identically, there should not be a conflict.  This works fine.  However,
if one of those sides also added a new file that happened to match the
rename source, then that file should be left alone.  Currently, the
rename/rename conflict handling causes that new file to become untracked.

Case 3:
If a single file is renamed to two different filenames on different sides
of history, there should be a conflict.  This works currently.  However,
if those renames also involve rename/add conflicts (i.e. there are new
files on one side of history that match the destination of the rename of
the other side of history), then the resulting conflict should be recorded
in the index, showing that there were multiple files with a given filename.
Currently, git silently discards one of file versions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6039-merge-rename-corner-cases.sh |  112 ++++++++++++++++++++++++++++++++++
 1 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index b465667..fd8337f 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -339,4 +339,116 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 	test -f sub
 '
 
+# Testcase setup for rename-rename-add-1:
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->c, add completely different a
+#
+# Merging of B & C should NOT be clean; there's a rename/rename conflict
+
+test_expect_success 'setup rename/rename(1to2)/add-source conflict' '
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
+	git mv a b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	echo something completely different >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 &&
+
+	test -f a &&
+	test -f b &&
+	test -f c
+'
+
+test_expect_success 'setup rename/rename(1to2)/add-source resolvable conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	>a &&
+	git add a &&
+	test_tick &&
+	git commit -m base &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	test_tick &&
+	git commit -m one &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	echo important-info >a &&
+	test_tick &&
+	git commit -m two
+'
+
+test_expect_failure 'rename/rename/add-source still tracks new a file' '
+	git checkout C^0 &&
+	git merge -s recursive B^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l)
+'
+
+test_expect_success 'setup rename/rename(1to2)/add-dest conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo stuff >a &&
+	git add a &&
+	test_tick &&
+	git commit -m base &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	echo precious-data >c &&
+	git add c &&
+	test_tick &&
+	git commit -m one &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	echo important-info >b &&
+	git add b &&
+	test_tick &&
+	git commit -m two
+'
+
+test_expect_failure 'rename/rename/add-dest merge still knows about conflicting file versions' '
+	git checkout C^0 &&
+	test_must_fail git merge -s recursive B^0 &&
+
+	test 5 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u b | wc -l) &&
+	test 2 -eq $(git ls-files -u c | wc -l) &&
+
+	test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
+	test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
+	test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
+	test $(git rev-parse :3:c) = $(git rev-parse B:c)
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
