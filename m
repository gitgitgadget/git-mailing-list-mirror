From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] fast-import: catch garbage after marks in from/merge
Date: Sun, 1 Apr 2012 18:54:07 -0400
Message-ID: <20120401225407.GA12127@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 00:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SETf7-0002uI-NM
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 00:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab2DAWyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 18:54:13 -0400
Received: from honk.padd.com ([74.3.171.149]:47179 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab2DAWyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 18:54:12 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 1DA941E66;
	Sun,  1 Apr 2012 15:54:11 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E25D4313EC; Sun,  1 Apr 2012 18:54:07 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194490>

A forgotten LF can lead to a confusing bug.  The last
line in this commit command is wrong:

    commit refs/heads/S2
    committer Name <name@example.com> 1112912893 -0400
    data <<COMMIT
    commit message
    COMMIT
    from :1M 100644 :103 hello.c

It is missing a newline and should be:

    from :1
    M 100644 :103 hello.c

Make fast-import complain about the buggy input, for both
from and merge lines that use marks.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
I spent too long tracking down the bug described in the
commit message.  It might help future users if fast-import
were to complain in this case.

 fast-import.c          |   24 +++++++++--
 t/t9300-fast-import.sh |  104 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a85275d..13001bb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2537,8 +2537,16 @@ static int parse_from(struct branch *b)
 		hashcpy(b->branch_tree.versions[0].sha1, t);
 		hashcpy(b->branch_tree.versions[1].sha1, t);
 	} else if (*from == ':') {
-		uintmax_t idnum = strtoumax(from + 1, NULL, 10);
-		struct object_entry *oe = find_mark(idnum);
+		char *eptr;
+		uintmax_t idnum = strtoumax(from + 1, &eptr, 10);
+		struct object_entry *oe;
+		if (eptr) {
+			for (; *eptr && isspace(*eptr); eptr++) ;
+			if (*eptr)
+				die("Garbage after mark: %s",
+				    command_buf.buf);
+		}
+		oe = find_mark(idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
 		hashcpy(b->sha1, oe->idx.sha1);
@@ -2572,8 +2580,16 @@ static struct hash_list *parse_merge(unsigned int *count)
 		if (s)
 			hashcpy(n->sha1, s->sha1);
 		else if (*from == ':') {
-			uintmax_t idnum = strtoumax(from + 1, NULL, 10);
-			struct object_entry *oe = find_mark(idnum);
+			char *eptr;
+			uintmax_t idnum = strtoumax(from + 1, &eptr, 10);
+			struct object_entry *oe;
+			if (eptr) {
+				for (; *eptr && isspace(*eptr); eptr++) ;
+				if (*eptr)
+					die("Garbage after mark: %s",
+					    command_buf.buf);
+			}
+			oe = find_mark(idnum);
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			hashcpy(n->sha1, oe->idx.sha1);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0f5b5e5..46346cd 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2635,4 +2635,108 @@ test_expect_success \
 	'n=$(grep $a verify | wc -l) &&
 	 test 1 = $n'
 
+###
+### series S
+###
+#
+# Set up 1, 2, 3 of this:
+#
+# 1--2--4
+#  \   /
+#   -3-
+#
+# Then typo the merge to create #4, make sure it complains.
+#
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/S
+mark :1
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+blob 1
+COMMIT
+M 100644 inline hello.c
+data <<BLOB
+blob 1
+BLOB
+
+commit refs/heads/S
+mark :2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+blob 2
+COMMIT
+from :1
+M 100644 inline hello.c
+data <<BLOB
+blob 2
+BLOB
+INPUT_END
+
+test_expect_success 'S: add commits' '
+	git fast-import --export-marks=marks <input
+'
+
+cat >input <<INPUT_END
+blob
+mark :103
+data <<BLOB
+blob 3
+BLOB
+
+commit refs/heads/S2
+mark :3
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+blob 3
+COMMIT
+from :1M 100644 :103 hello.c
+INPUT_END
+
+test_expect_success 'S: from mark line overrun' '
+	test_must_fail git fast-import --import-marks=marks <input
+'
+
+cat >input <<INPUT_END
+blob
+mark :103
+data <<BLOB
+blob 3
+BLOB
+
+commit refs/heads/S2
+mark :3
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+blob 3
+COMMIT
+from :1
+M 100644 :103 hello.c
+INPUT_END
+
+test_expect_success 'S: add from commit' '
+	git fast-import --import-marks=marks --export-marks=marks <input
+'
+
+cat >input <<INPUT_END
+blob
+mark :104
+data <<BLOB
+blob 4
+BLOB
+
+commit refs/heads/S
+mark :4
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+blob 4
+COMMIT
+from :2
+merge :3M 100644 :4 hello.c
+INPUT_END
+
+test_expect_success 'S: merge mark line overrun' '
+	test_must_fail git fast-import --import-marks=marks <input
+'
+
 test_done
-- 
1.7.10.rc2.55.gb775a
