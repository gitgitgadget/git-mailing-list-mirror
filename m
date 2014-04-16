From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] git tag --contains : avoid stack overflow
Date: Wed, 16 Apr 2014 16:15:19 +0200
Organization: <)><
Message-ID: <20140416141519.GA9684@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:24:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaQlV-0003oz-7E
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 16:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161482AbaDPOYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 10:24:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55064 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161361AbaDPOYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 10:24:36 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 06B831C00EC
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:15:20 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3GEFJEN009689
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:15:19 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3GEFJ1F009688
	for git@vger.kernel.org; Wed, 16 Apr 2014 16:15:19 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246334>

From: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
Date: Sat, 10 Nov 2012 18:36:10 +0100

In large repos, the recursion implementation of contains(commit,
commit_list) may result in a stack overflow. Replace the recursion with
a loop to fix it.

This problem is more apparent on Windows than on Linux, where the stack
is more limited by default.

See also this thread on the msysGit list:

	https://groups.google.com/d/topic/msysgit/FqT6boJrb2g/discussion

[jes: re-written to imitate the original recursion more closely]

Thomas Braun pointed out several documentation shortcomings.

Signed-off-by: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Tested-by: Stepan Kasal <kasal@ucw.cz>
Thanks-to: Thomas Braun <thomas.braun@byte-physics.de>
---
 builtin/tag.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 t/t7004-tag.sh | 21 +++++++++++++++
 2 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 74d3780..79c8c28 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -73,11 +73,13 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 	return 0;
 }
 
-static int contains_recurse(struct commit *candidate,
+/*
+ * Test whether the candidate or one of its parents is contained in the list.
+ * Do not recurse to find out, though, but return -1 if inconclusive.
+ */
+static int contains_test(struct commit *candidate,
 			    const struct commit_list *want)
 {
-	struct commit_list *p;
-
 	/* was it previously marked as containing a want commit? */
 	if (candidate->object.flags & TMP_MARK)
 		return 1;
@@ -85,26 +87,77 @@ static int contains_recurse(struct commit *candidate,
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
+}
+
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
 }
 
 static int contains(struct commit *candidate, const struct commit_list *want)
 {
-	return contains_recurse(candidate, want);
+	struct stack stack = { 0, 0, NULL };
+	int result = contains_test(candidate, want);
+
+	if (result >= 0)
+		return result;
+
+	push_to_stack(candidate, &stack);
+	while (stack.nr) {
+		struct stack_entry *entry = &stack.stack[stack.nr - 1];
+		struct commit *commit = entry->commit;
+		struct commit_list *parents = entry->parents;
+
+		if (!parents) {
+			commit->object.flags = UNINTERESTING;
+			stack.nr--;
+		}
+		/*
+		 * If we just popped the stack, parents->item has been marked,
+		 * therefore contains_test will return a meaningful 0 or 1.
+		 */
+		else switch (contains_test(parents->item, want)) {
+		case 1:
+			commit->object.flags |= TMP_MARK;
+			stack.nr--;
+			break;
+		case 0:
+			entry->parents = parents->next;
+			break;
+		default:
+			push_to_stack(parents->item, &stack);
+			break;
+		}
+	}
+	free(stack.stack);
+	return contains_test(candidate, want);
 }
 
 static void show_tag_lines(const unsigned char *sha1, int lines)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c8d6e9f..edaff13 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1380,4 +1380,25 @@ test_expect_success 'multiple --points-at are OR-ed together' '
 	test_cmp expect actual
 '
 
+>expect
+# ulimit is a bash builtin; we can rely on that in MinGW, but nowhere else
+test_expect_success MINGW '--contains works in a deep repo' '
+	ulimit -s 64
+	i=1 &&
+	while test $i -lt 1000
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
+	git tag --contains HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.9.2.msysgit.0.154.g978f18d
