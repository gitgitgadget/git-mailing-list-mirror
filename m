From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/6] test-lib.sh: introduce test_commit() and test_merge()
 helpers
Date: Tue, 27 Jan 2009 23:34:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272334380.3586@pacific.mpi-cbg.de>
References: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 27 23:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwXh-0002ti-EJ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZA0Wed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZA0Web
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:34:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:38475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755412AbZA0Wea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:34:30 -0500
Received: (qmail invoked by alias); 27 Jan 2009 22:34:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 27 Jan 2009 23:34:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dF78qY0sdn1rgxrffBQbQcdgVDJzCLY7QQImRWf
	1oQc7U8mr1Fxoj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107405>

Often we just need to add a commit with a given (short) name, that will
be tagged with the same name.  Now, relatively complicated graphs can be
constructed easily and in a clear fashion:

	test_commit A &&
	test_commit B &&
	git checkout A &&
	test_commit C &&
	test_merge D B

will construct this graph:

	A - B
	  \   \
	    C - D

For simplicity, files whose name is the lower case version of the commit
message (to avoid a warning about ambiguous names) will be committed, with
the corresponding commit messages as contents.

If you need to provide a different file/different contents, you can use
the more explicit form

	test_commit $MESSAGE $FILENAME $CONTENTS

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/README      |   18 ++++++++++++++++++
 t/test-lib.sh |   25 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 8f12d48..f208cf1 100644
--- a/t/README
+++ b/t/README
@@ -212,6 +212,24 @@ library for your script to use.
    is to summarize successes and failures in the test script and
    exit with an appropriate error code.
 
+ - test_tick
+
+   Make commit and tag names consistent by setting the author and
+   committer times to defined stated.  Subsequent calls will
+   advance the times by a fixed amount.
+
+ - test_commit <message> [<filename> [<contents>]]
+
+   Creates a commit with the given message, committing the given
+   file with the given contents (default for both is to reuse the
+   message string), and adds a tag (again reusing the message
+   string as name).  Calls test_tick to make the SHA-1s
+   reproducible.
+
+ - test_merge <message> <commit-or-tag>
+
+   Merges the given rev using the given message.  Like test_commit,
+   creates a tag and calls test_tick before committing.
 
 Tips for Writing Tests
 ----------------------
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 41d5a59..c1839f7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -193,6 +193,31 @@ test_tick () {
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
 
+# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+#
+# This will commit a file with the given contents and the given commit
+# message.  It will also add a tag with <message> as name.
+#
+# Both <file> and <contents> default to <message>.
+
+test_commit () {
+	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}
+	echo "${3-$1}" > "$file" &&
+	git add "$file" &&
+	test_tick &&
+	git commit -m "$1" &&
+	git tag "$1"
+}
+
+# Call test_merge with the arguments "<message> <commit>", where <commit>
+# can be a tag pointing to the commit-to-merge.
+
+test_merge () {
+	test_tick &&
+	git merge -m "$1" "$2" &&
+	git tag "$1"
+}
+
 # You are not expected to call test_ok_ and test_failure_ directly, use
 # the text_expect_* functions instead.
 
-- 
1.6.1.482.g7d54be
