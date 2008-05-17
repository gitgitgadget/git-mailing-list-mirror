From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] builtin-apply: do not declare patch is creation when we
 do not know it
Date: Sat, 17 May 2008 02:19:13 -0700
Message-ID: <7vmympcmpa.fsf_-_@gitster.siamese.dyndns.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
 <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
 <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
 <7vprrpswof.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
 <7vlk2dsujm.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131552410.3019@woody.linux-foundation.org>
 <7vve1hrbct.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131811540.3019@woody.linux-foundation.org>
 <7vve1dcn0m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 17 11:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxIaQ-0001Y8-5m
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 11:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYEQJT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYEQJT1
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 05:19:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbYEQJT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 05:19:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 437314EC7;
	Sat, 17 May 2008 05:19:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 45A104EC5; Sat, 17 May 2008 05:19:21 -0400 (EDT)
In-Reply-To: <7vve1dcn0m.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 17 May 2008 02:12:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57C6123A-23F2-11DD-85F4-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82338>

When we see no context nor deleted line in the patch, we used to declare
that the patch creates a new file.  But some people create an empty file
and then apply a patch to it.  Similarly, a patch that delete everything
is not a deletion patch either.

This commit corrects these two issues.  Together with the previous commit,
it allows a diff between an empty file and a line-ful file to be treated
as both creation patch and "add stuff to an existing empty file",
depending on the context.  A new test t4126 demonstrates the fix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c        |   15 ------------
 t/t4126-apply-empty.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 15 deletions(-)
 create mode 100755 t/t4126-apply-empty.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index 10b1f88..1540f28 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1143,21 +1143,6 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 	if (patch->is_delete < 0 &&
 	    (newlines || (patch->fragments && patch->fragments->next)))
 		patch->is_delete = 0;
-	if (!unidiff_zero || context) {
-		/* If the user says the patch is not generated with
-		 * --unified=0, or if we have seen context lines,
-		 * then not having oldlines means the patch is creation,
-		 * and not having newlines means the patch is deletion.
-		 */
-		if (patch->is_new < 0 && !oldlines) {
-			patch->is_new = 1;
-			patch->old_name = NULL;
-		}
-		if (patch->is_delete < 0 && !newlines) {
-			patch->is_delete = 1;
-			patch->new_name = NULL;
-		}
-	}
 
 	if (0 < patch->is_new && oldlines)
 		die("new file %s depends on old contents", patch->new_name);
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
new file mode 100755
index 0000000..6641571
--- /dev/null
+++ b/t/t4126-apply-empty.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='apply empty'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	>empty &&
+	git add empty &&
+	test_tick &&
+	git commit -m initial &&
+	for i in a b c d e
+	do
+		echo $i
+	done >empty &&
+	cat empty >expect &&
+	git diff |
+	sed -e "/^diff --git/d" \
+	    -e "/^index /d" \
+	    -e "s|a/empty|empty.orig|" \
+	    -e "s|b/empty|empty|" >patch0 &&
+	sed -e "s|empty|missing|" patch0 >patch1 &&
+	>empty &&
+	git update-index --refresh
+'
+
+test_expect_success 'apply empty' '
+	git reset --hard &&
+	>empty &&
+	rm -f missing &&
+	git apply patch0 &&
+	test_cmp expect empty
+'
+
+test_expect_success 'apply --index empty' '
+	git reset --hard &&
+	>empty &&
+	rm -f missing &&
+	git apply --index patch0 &&
+	test_cmp expect empty &&
+	git diff --exit-code
+'
+
+test_expect_success 'apply create' '
+	git reset --hard &&
+	>empty &&
+	rm -f missing &&
+	git apply patch1 &&
+	test_cmp expect missing
+'
+
+test_expect_success 'apply --index create' '
+	git reset --hard &&
+	>empty &&
+	rm -f missing &&
+	git apply --index patch1 &&
+	test_cmp expect missing &&
+	git diff --exit-code
+'
+
-- 
1.5.5.1.443.g123e3
