From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] checkout: do not check out unmerged higher stages
 randomly
Date: Fri, 29 Aug 2008 14:39:54 -0700
Message-ID: <7vbpzb4i1h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 23:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZBiO-0006WT-5b
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 23:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756123AbYH2VkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 17:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbYH2VkA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 17:40:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbYH2Vj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 17:39:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B5576DFA1;
	Fri, 29 Aug 2008 17:39:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 726806DFA0; Fri, 29 Aug 2008 17:39:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06E30E4A-7613-11DD-BC85-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94330>

During a conflicted merge when you have unmerged stages for a path F in
the index, if you asked:

    $ git checkout F

we rewrote F as many times as we have stages for it, and the last one
(typically "theirs") was left in the work tree, without resolving the
conflict.

This patch fixes it by noticing that a specified pathspec pattern matches
an unmerged path, and by erroring out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |   27 +++++++++++++++++++++++++++
 t/t7201-co.sh      |   23 +++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b380ad6..9b33f3a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -76,6 +76,15 @@ static int read_tree_some(struct tree *tree, const char **pathspec)
 	return 0;
 }
 
+static int skip_same_name(struct cache_entry *ce, int pos)
+{
+	while (++pos < active_nr &&
+	       !strcmp(active_cache[pos]->name, ce->name))
+		; /* skip */
+	return pos;
+}
+
+
 static int checkout_paths(struct tree *source_tree, const char **pathspec)
 {
 	int pos;
@@ -107,6 +116,20 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec)
 	if (report_path_error(ps_matched, pathspec, 0))
 		return 1;
 
+	/* Any unmerged paths? */
+	for (pos = 0; pos < active_nr; pos++) {
+		struct cache_entry *ce = active_cache[pos];
+		if (pathspec_match(pathspec, NULL, ce->name, 0) &&
+		    ce_stage(ce)) {
+			errs = 1;
+			error("path '%s' is unmerged", ce->name);
+			pos = skip_same_name(ce, pos) - 1;
+			continue;
+		}
+	}
+	if (errs)
+		return 1;
+
 	/* Now we are committed to check them out */
 	memset(&state, 0, sizeof(state));
 	state.force = 1;
@@ -114,6 +137,10 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec)
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
+			if (ce_stage(ce)) {
+				pos = skip_same_name(ce, pos) - 1;
+				continue;
+			}
 			errs |= checkout_entry(ce, &state, NULL);
 		}
 	}
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 1dff84d..303cf62 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -369,4 +369,27 @@ test_expect_success \
     'checkout with --track, but without -b, fails with too short tracked name' '
     test_must_fail git checkout --track renamer'
 
+test_expect_success 'checkout an unmerged path should fail' '
+	rm -f .git/index &&
+	O=$(echo original | git hash-object -w --stdin) &&
+	A=$(echo ourside | git hash-object -w --stdin) &&
+	B=$(echo theirside | git hash-object -w --stdin) &&
+	(
+		echo "100644 $A 0	fild" &&
+		echo "100644 $O 1	file" &&
+		echo "100644 $A 2	file" &&
+		echo "100644 $B 3	file" &&
+		echo "100644 $A 0	filf"
+	) | git update-index --index-info &&
+	echo "none of the above" >sample &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	test_must_fail git checkout fild file filf &&
+	test_cmp sample fild &&
+	test_cmp sample filf &&
+	test_cmp sample file
+'
+
 test_done
+
-- 
1.6.0.1.90.g27a6e
