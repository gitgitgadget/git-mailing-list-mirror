From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 09:53:25 +0200
Organization: <)><
Message-ID: <20140423075325.GA7268@camelia.ucw.cz>
References: <20140416141519.GA9684@camelia.ucw.cz> <20140416154653.GB4691@sigill.intra.peff.net> <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info> <20140417213238.GA14792@sigill.intra.peff.net> <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info> <20140417215817.GA822@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcrzp-00088c-GT
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 09:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbaDWHx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 03:53:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47145 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaDWHx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 03:53:28 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 24B851C00F5;
	Wed, 23 Apr 2014 09:53:26 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3N7rPhV007485;
	Wed, 23 Apr 2014 09:53:25 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3N7rPCQ007483;
	Wed, 23 Apr 2014 09:53:25 +0200
Mail-Followup-To: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
Content-Disposition: inline
In-Reply-To: <20140417215817.GA822@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246814>

From: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>

In large repos, the recursion implementation of contains(commit,
commit_list) may result in a stack overflow. Replace the recursion with
a loop to fix it.

This problem is more apparent on Windows than on Linux, where the stack
is more limited by default.

See also this thread on the msysGit list:

	https://groups.google.com/d/topic/msysgit/FqT6boJrb2g/discussion

[jes: re-written to imitate the original recursion more closely]

Thomas Braun pointed out several documentation shortcomings.

Tests are run only if ulimit -s is available.  This means they cannot
be run on Windows.

Signed-off-by: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Tested-by: Stepan Kasal <kasal@ucw.cz>
---
Hello,
I have found out that "ulimit -s" does not work on Windows.
Adding this as a prerequisite, we will skip the test there.

On Thu, Apr 17, 2014 at 05:32:38PM -0400, Jeff King wrote:
> So we can bump the depth further; probably 4000 is enough for any system
> to fail with a 64k stack. The deeper we make it, the longer it takes to
> run the test, though. At 4000, my machine seems to take about 300ms to
> run it. That's may be OK.

Consequently, we can accept this proposal.

Stepan Kasal

 builtin/tag.c  | 90 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 t/t7004-tag.sh | 23 +++++++++++++++
 2 files changed, 98 insertions(+), 15 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 6c7c6bd..f344002 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -80,11 +80,19 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 	return 0;
 }
 
-static int contains_recurse(struct commit *candidate,
+enum contains_result {
+	CONTAINS_UNKNOWN = -1,
+	CONTAINS_NO = 0,
+	CONTAINS_YES = 1,
+};
+
+/*
+ * Test whether the candidate or one of its parents is contained in the list.
+ * Do not recurse to find out, though, but return -1 if inconclusive.
+ */
+static enum contains_result contains_test(struct commit *candidate,
 			    const struct commit_list *want)
 {
-	struct commit_list *p;
-
 	/* was it previously marked as containing a want commit? */
 	if (candidate->object.flags & TMP_MARK)
 		return 1;
@@ -92,26 +100,78 @@ static int contains_recurse(struct commit *candidate,
 	if (candidate->object.flags & UNINTERESTING)
 		return 0;
 	/* or are we it? */
-	if (in_commit_list(want, candidate))
+	if (in_commit_list(want, candidate)) {
+		candidate->object.flags |= TMP_MARK;
 		return 1;
+	}
 
 	if (parse_commit(candidate) < 0)
 		return 0;
 
-	/* Otherwise recurse and mark ourselves for future traversals. */
-	for (p = candidate->parents; p; p = p->next) {
-		if (contains_recurse(p->item, want)) {
-			candidate->object.flags |= TMP_MARK;
-			return 1;
-		}
-	}
-	candidate->object.flags |= UNINTERESTING;
-	return 0;
+	return -1;
 }
 
-static int contains(struct commit *candidate, const struct commit_list *want)
+/*
+ * Mimicking the real stack, this stack lives on the heap, avoiding stack
+ * overflows.
+ *
+ * At each recursion step, the stack items points to the commits whose
+ * ancestors are to be inspected.
+ */
+struct stack {
+	int nr, alloc;
+	struct stack_entry {
+		struct commit *commit;
+		struct commit_list *parents;
+	} *stack;
+};
+
+static void push_to_stack(struct commit *candidate, struct stack *stack)
+{
+	int index = stack->nr++;
+	ALLOC_GROW(stack->stack, stack->nr, stack->alloc);
+	stack->stack[index].commit = candidate;
+	stack->stack[index].parents = candidate->parents;
+}
+
+static enum contains_result contains(struct commit *candidate,
+		const struct commit_list *want)
 {
-	return contains_recurse(candidate, want);
+	struct stack stack = { 0, 0, NULL };
+	int result = contains_test(candidate, want);
+
+	if (result != CONTAINS_UNKNOWN)
+		return result;
+
+	push_to_stack(candidate, &stack);
+	while (stack.nr) {
+		struct stack_entry *entry = &stack.stack[stack.nr - 1];
+		struct commit *commit = entry->commit;
+		struct commit_list *parents = entry->parents;
+
+		if (!parents) {
+			commit->object.flags |= UNINTERESTING;
+			stack.nr--;
+		}
+		/*
+		 * If we just popped the stack, parents->item has been marked,
+		 * therefore contains_test will return a meaningful 0 or 1.
+		 */
+		else switch (contains_test(parents->item, want)) {
+		case CONTAINS_YES:
+			commit->object.flags |= TMP_MARK;
+			stack.nr--;
+			break;
+		case CONTAINS_NO:
+			entry->parents = parents->next;
+			break;
+		case CONTAINS_UNKNOWN:
+			push_to_stack(parents->item, &stack);
+			break;
+		}
+	}
+	free(stack.stack);
+	return contains_test(candidate, want);
 }
 
 static void show_tag_lines(const unsigned char *sha1, int lines)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 143a8ea..db82f6d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1423,4 +1423,27 @@ EOF
 	test_cmp expect actual
 '
 
+ulimit_stack="ulimit -s 64"
+test_lazy_prereq ULIMIT 'bash -c "'"$ulimit_stack"'"'
+
+>expect
+# we require bash and ulimit, this excludes Windows
+test_expect_success ULIMIT '--contains works in a deep repo' '
+	i=1 &&
+	while test $i -lt 4000
+	do
+		echo "commit refs/heads/master
+committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
+data <<EOF
+commit #$i
+EOF"
+		test $i = 1 && echo "from refs/heads/master^0"
+		i=$(($i + 1))
+	done | git fast-import &&
+	git checkout master &&
+	git tag far-far-away HEAD^ &&
+	bash -c "'"$ulimit_stack"' && git tag --contains HEAD >actual" &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.9.2.msysgit.0.158.g49754fb
