From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff -- file1 file2: do not default to --no-index inside a
 git repository
Date: Fri, 23 May 2008 23:49:22 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805232309350.30431@racer>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com> <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org> <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org> <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 00:50:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzg5R-0000VZ-RJ
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 00:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758067AbYEWWtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 18:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbYEWWtR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 18:49:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:43513 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753356AbYEWWtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 18:49:16 -0400
Received: (qmail invoked by alias); 23 May 2008 22:49:14 -0000
Received: from R06fc.r.pppool.de (EHLO racer.local) [89.54.6.252]
  by mail.gmx.net (mp010) with SMTP; 24 May 2008 00:49:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lU7xQUUKlZ/lZMJgvsUVmsNFi6L2EepRq1b9klQ
	OvvXspCsKqXLrW
X-X-Sender: gene099@racer
In-Reply-To: <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82767>


When calling "git diff -- a b", as opposed to "git diff a b" without "--",
do not default to --no-index inside a git repository.

For example,

	git mv a b && git diff -- a b

used to have an unexpected result.

Noticed by Catalin Marinas, diagnosed by Linus.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 23 May 2008, Junio C Hamano wrote:

	> Linus Torvalds <torvalds@linux-foundation.org> writes:
	> 
	> > ... So I would suggest that we make it *much* harder to 
	> > trigger the "make it act like a traditional 'diff'" thing.
	> >
	> > I would suggest that we *not* invoce the traditional 'diff' 
	> > behaviour when:
	> >
	> >  - we're called as "git-diff-files". That's clearly a git 
	> >    thing. Don't try to make it act like an external non-git diff. 
	> >    Only do the special case for plain "git diff" itself.

	I am not so sure about that.

	> >  - even for plain "git diff", make it much harder to trigger 
	> >    non-git behaviour. Don't do it if the files don't exist.
	> >    Don't do it if there is '--' there.
	> >
	> > In fact, maybe we should remove that thing entirely, or 
	> > *require* a flag to enable it (at least if we're in a git
	> > directory).  It's a cute hack, but when the cute hack actually 
	> > makes it impossible to do certain real git operations, it's a 
	> > cute hack that is detrimental.
	> 
	> Very well said.  I've always wanted to rip that hack out of the 
	> normal "git diff with two pathspec parameters" codepath.

	Yes, I see how that cute hack does the wrong thing here.

	However, it is pretty convenient to be able to say "git diff a b" 
	and have it fall back to --no-index if either a or b is not in the 
	index.  Most of the time, I would actually expect it to be the 
	right thing, too.

	Hey, but if you disagree, just rip it out.  Actually, I did that 
	already, and will reply with that alternative patch.

 diff-lib.c            |    4 ++--
 t/t4002-diff-basic.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index fe2ccec..b1daad6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -257,8 +257,8 @@ int setup_diff_no_index(struct rev_info *revs,
 		if (argv[i][0] != '-' || argv[i][1] == '\0')
 			break;
 		else if (!strcmp(argv[i], "--")) {
-			i++;
-			break;
+			revs->max_count = -2;
+			return -1;
 		} else if (i < argc - 3 && !strcmp(argv[i], "--no-index")) {
 			i = argc - 3;
 			DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index a4cfde6..678c4a5 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -244,4 +244,35 @@ test_expect_success \
     git diff-tree -r -R $tree_A $tree_B >.test-b &&
     cmp -s .test-a .test-b'
 
+cat > expect << EOF
+diff --git a/AA b/AA
+index ccba72a..6aa2b53 100644
+--- a/AA
++++ b/AA
+@@ -1 +1 @@
+-This is added AA in the branch A.
++This is added AA in the branch B.
+EOF
+
+test_expect_success '"diff -- AA DM" does not imply --no-index' '
+
+	git diff -- AA DM > output &&
+	cmp -s output expect
+
+'
+
+cat > expect << EOF
+diff --git a/AA b/DM
+index 6aa2b53..3c4d8de 100644
+--- a/AA
++++ b/DM
+@@ -1 +1 @@
+-This is added AA in the branch B.
++This is modified DM in the branch B.
+EOF
+
+test_expect_success '"diff AA DM" implies --no-index' '
+
+'
+
 test_done
-- 
1.5.5.1.553.ga1dd7.dirty
