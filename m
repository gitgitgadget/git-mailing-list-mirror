From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 09/15] Add tests for communication dealing with sparse repositories
Date: Sat,  4 Sep 2010 18:14:01 -0600
Message-ID: <1283645647-1891-10-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rg-0008IQ-DC
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab0IEANQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65512 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0IEANP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:15 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so647396pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Gdu1DVyFTcnhX17tM4inA9cUd65KeDks9RF8B29QBNI=;
        b=lWGrI5lue8EEaRlIdqic2jncax39DMWlC0UJ6FN91e9RUJAL5G5NUhXOguJIY3lACb
         b3weEKwdqCeMnLhcljJ4LlFWVspaFvhIbS2SJMy5Z1feyMGtYMgpgLd71o3BJ1BgXdbq
         UX+NlyYhB7W2ATPboJyaZSsqzYJf0unodQAF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ujy8KvrJ43HliU0DiguaxM9tmjc9VmzmxbXq1DFkys/BRS2gpMBQOkD6qXXvCUikzV
         rrZBARrdAk5ByU9qPSZzh5pvi8+yXCuLulJ5m2q4NdpOPdJwJrAzm1sO7qQLTA2V6qKC
         LkjTMFGwc0DnYV535WHuFcNShWIUmHC2gHKT4=
Received: by 10.114.52.2 with SMTP id z2mr1556476waz.84.1283645594645;
        Sat, 04 Sep 2010 17:13:14 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155395>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5721-sparse-repository-communication.sh |  106 ++++++++++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100755 t/t5721-sparse-repository-communication.sh

diff --git a/t/t5721-sparse-repository-communication.sh b/t/t5721-sparse-repository-communication.sh
new file mode 100755
index 0000000..35cb6a2
--- /dev/null
+++ b/t/t5721-sparse-repository-communication.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+
+test_description='sparse repository communication'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/sparse-lib.sh
+
+test_expect_success 'setup' '
+	rm -fr .git &&
+	test_create_repo src &&
+	(
+		cd src &&
+
+		mkdir -p sub/{a,b} &&
+		> sub/a/file &&
+		git add sub/a/file &&
+		test_tick &&
+		git commit -q -m initial &&
+
+		> sub/b/file &&
+		git add sub/b/file &&
+		test_tick &&
+		git commit -q -m two &&
+
+		echo unique > sub/file &&
+		git add sub/file &&
+		test_tick &&
+		git commit -q -m three &&
+
+		echo content > sub/b/file &&
+		test_tick &&
+		git commit -q -m subbfile sub/b/file &&
+
+		cp -a sub/b sub/bcopy &&
+		git add sub/bcopy &&
+		test_tick &&
+		git commit -q -m subbcopy &&
+
+		echo stuff > sub/a/file &&
+		test_tick &&
+		git commit -q -m subafile sub/a/file
+	)
+'
+
+test_expect_success 'make comparison sparse repository' '
+	git clone -q "file://$(pwd)/src" compare_dst &&
+	(
+		cd compare_dst &&
+		test 25 = "$(git rev-list --objects master | wc -l)" &&
+		make_sparse sub/b/ &&
+		test 0 = $(find .git/objects/pack -type f | wc -l) &&
+		test 22 = $(find .git/objects -type f | wc -l)
+	)
+'
+
+test_expect_failure 'basic sparse clone succeeds' '
+	rm -fr dst &&
+	git clone "file://$(pwd)/src" dst -- sub/b/ &&
+	(
+		cd dst &&
+		git rev-parse master^{tree} &&
+		git rev-parse master:sub &&
+		git rev-parse master:sub/b &&
+		git rev-parse master:sub/b/file &&
+		git rev-parse master:sub/bcopy &&
+		git rev-parse master:sub/bcopy/file &&
+		git rev-parse master:sub/a &&
+		git rev-parse master:sub/file &&
+
+		git cat-file -p master:sub &&
+		git cat-file -p master:sub/b &&
+		git cat-file -p master:sub/b/file &&
+		git cat-file -p master:sub/bcopy &&
+		git cat-file -p master:sub/bcopy/file &&
+		test_must_fail git cat-file -p master:sub/file &&
+		test_must_fail git cat-file -p master:sub/a &&
+		test_must_fail git rev-parse master:sub/a/file &&
+
+		test -f sub/b/file &&
+		! test -d sub/a &&
+		! test -d sub/bcopy &&
+		! test -f sub/file
+	)
+'
+
+test_expect_failure 'basic sparse clone guts match expectations' '
+	(
+		# Loose objects only, to facilitate comparison
+		cd dst &&
+		mv .git/objects/pack/* . &&
+		for i in $(ls *.pack); do
+			git unpack-objects -q < $i
+		done &&
+		rm -f *.pack *.idx
+	) &&
+	(
+		# Get the names of all loose objects
+		cd dst &&
+		find .git/objects -type f > ../dst-objects &&
+		cd ../compare_dst &&
+		find .git/objects -type f > ../compare_dst-objects
+	) &&
+	test_cmp dst-objects compare_dst-objects &&
+	test_cmp dst/.git/sparse-limits compare_dst/.git/sparse-limits
+'
+
+test_done
-- 
1.7.2.2.140.gd06af
