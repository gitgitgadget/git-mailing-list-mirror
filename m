From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: work from a subdirectory
Date: Wed, 20 Feb 2008 15:54:54 -0800
Message-ID: <7vy79f18vl.fsf@gitster.siamese.dyndns.org>
References: <20080220223520.GA23642@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Feb 21 00:55:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRyn3-0008TK-MI
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbYBTXzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYBTXzS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:55:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbYBTXzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:55:16 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F28F343CB;
	Wed, 20 Feb 2008 18:55:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 193AC43C9; Wed, 20 Feb 2008 18:55:10 -0500 (EST)
In-Reply-To: <20080220223520.GA23642@localhost> (Clemens Buchacher's message
 of "Wed, 20 Feb 2008 23:35:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74572>

When switching branches from a subdirectory, checkout rewritten
in C extracted the toplevel of the tree in there.

This should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-checkout.c |    1 -
 t/t7201-co.sh      |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 1fc1e56..f51b77a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -237,7 +237,6 @@ static int merge_working_tree(struct checkout_opts *opts,
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
 			topts.dir->show_ignored = 1;
 			topts.dir->exclude_per_dir = ".gitignore";
-			topts.prefix = prefix;
 			tree = parse_tree_indirect(old->commit->object.sha1);
 			init_tree_desc(&trees[0], tree->buffer, tree->size);
 			tree = parse_tree_indirect(new->commit->object.sha1);
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 5492f21..0fa9467 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -263,4 +263,38 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 
 '
 
+test_expect_success 'switch branches while in subdirectory' '
+
+	git reset --hard &&
+	git checkout master &&
+
+	mkdir subs &&
+	(
+		cd subs &&
+		git checkout side
+	) &&
+	! test -f subs/one &&
+	rm -fr subs
+
+'
+
+test_expect_success 'checkout specific path while in subdirectory' '
+
+	git reset --hard &&
+	git checkout side &&
+	mkdir subs &&
+	>subs/bero &&
+	git add subs/bero &&
+	git commit -m "add subs/bero" &&
+
+	git checkout master &&
+	mkdir -p subs &&
+	(
+		cd subs &&
+		git checkout side -- bero
+	) &&
+	test -f subs/bero
+
+'
+
 test_done
