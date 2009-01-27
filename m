From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/6] lib-rebase.sh: introduce test_commit() and test_merge()
 helpers
Date: Tue, 27 Jan 2009 18:47:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271847070.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:48:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs32-0008Vu-M1
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbZA0RrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755303AbZA0RrE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:47:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:55427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754138AbZA0RrC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:47:02 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:46:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 27 Jan 2009 18:46:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18V/wYAzmsVB5YxNtX5LzqXrKN+mmPQJXVDd8KOG+
	9RmwlNpnDfQLKs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107367>


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

For simplicity, files of the same name (but in lower case, to avoid
a warning about ambiguous names) will be committed, with the commit
message as contents.

If you need to provide a different file/different contents, you can use
the more explicit form

	test_commit $MESSAGE $FILENAME $CONTENTS

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This may want to live in test-lib.sh instead.

 t/lib-rebase.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index cda7778..37430f3 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -46,3 +46,29 @@ EOF
 	test_set_editor "$(pwd)/fake-editor.sh"
 	chmod a+x fake-editor.sh
 }
+
+# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+#
+# This will commit a file with the given contents and the given commit
+# message.  It will also add a tag with <message> as name.
+#
+# Both <file> and <contents> default to <message>.
+
+test_commit () {
+	file=$2
+	test -z "$2" && file=$(echo "$1" | tr 'A-Z' 'a-z')
+	echo ${3-$1} > $file &&
+	git add $file &&
+	test_tick &&
+	git commit -m $1 &&
+	git tag $1
+}
+
+# Call test_merge with the arguments "<message> <commit>", where <commit>
+# can be a tag pointing to the commit-to-merge.
+
+test_merge () {
+	test_tick &&
+	git merge -m $1 $2 &&
+	git tag $1
+}
-- 
1.6.1.482.g7d54be
