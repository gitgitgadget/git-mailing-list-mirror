From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revision traversal and pack: notice and die on missing
 commit
Date: Wed, 11 Feb 2009 01:27:43 -0800
Message-ID: <7vfxilgw6o.fsf_-_@gitster.siamese.dyndns.org>
References: <20090209022642.GA19413@atjola.homenet>
 <20090209091303.GA1320@atjola.homenet> <20090209092113.GB1320@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBPH-00032h-39
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbZBKJ1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZBKJ1y
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:27:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbZBKJ1x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:27:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5286A2AE4E;
	Wed, 11 Feb 2009 04:27:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C66C42AE4C; Wed,
 11 Feb 2009 04:27:45 -0500 (EST)
In-Reply-To: <20090209092113.GB1320@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Mon, 9 Feb 2009 10:21:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4055DD82-F81E-11DD-9052-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109390>

cc0e6c5 (Handle return code of parse_commit in revision machinery,
2007-05-04) attempted to tighten error checking in the revision machinery,
but it wasn't enough.  When get_revision_1() was asked for the next commit
to return, it tries to read and simplify the parents of the commit to be
returned, but an error while doing so was silently ignored and reported as
a truncated history to the caller instead.

This resulted in an early end of "git log" output or a pack that lacks
older commits from "git pack-objects", without any error indication in the
exit status from these commands, even though the underlying parse_commit()
issues an error message to the end user.

Note that the codepath in add_parents_list() that paints parents of an
UNINTERESTING commit UNINTERESTING silently ignores the error when
parse_commit() fails; this is deliberate and in line with aeeae1b
(revision traversal: allow UNINTERESTING objects to be missing,
2009-01-27).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Dscho, do not complain that I did not use test_commit, because this is
   meant to apply against maint-1.5.4, which happens to be the oldest
   maintenance track I am still keeping around.  The breakage actually
   goes even older; cc0e6c5 is *not* the culprit, but merely an incomplete
   attempt to fix this issue.

   There is a fairly obvious comflict when this patch is applied to maint
   and master, but I'll be merging the commit upward after a bit more
   testing.

 revision.c                     |    6 ++++--
 t/t5307-pack-missing-commit.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100755 t/t5307-pack-missing-commit.sh

diff --git a/revision.c b/revision.c
index d79f2b3..b8c015e 100644
--- a/revision.c
+++ b/revision.c
@@ -1484,14 +1484,16 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			    (commit->date < revs->max_age))
 				continue;
 			if (add_parents_to_list(revs, commit, &revs->commits) < 0)
-				return NULL;
+				die("Failed to traverse parents of commit %s",
+				    sha1_to_hex(commit->object.sha1));
 		}
 
 		switch (simplify_commit(revs, commit)) {
 		case commit_ignore:
 			continue;
 		case commit_error:
-			return NULL;
+			die("Failed to simplify parents of commit %s",
+			    sha1_to_hex(commit->object.sha1));
 		default:
 			return commit;
 		}
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
new file mode 100755
index 0000000..ae52a18
--- /dev/null
+++ b/t/t5307-pack-missing-commit.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='pack should notice missing commit objects'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	for i in 1 2 3 4 5
+	do
+		echo "$i" >"file$i" &&
+		git add "file$i" &&
+		test_tick &&
+		git commit -m "$i" &&
+		git tag "tag$i"
+	done &&
+	obj=$(git rev-parse --verify tag3) &&
+	fanout=$(expr "$obj" : "\(..\)") &&
+	remainder=$(expr "$obj" : "..\(.*\)") &&
+	rm -f ".git/objects/$fanout/$remainder"
+'
+
+test_expect_success 'check corruption' '
+	test_must_fail git fsck
+'
+
+test_expect_success 'rev-list notices corruption (1)' '
+	test_must_fail git rev-list HEAD
+'
+
+test_expect_success 'rev-list notices corruption (2)' '
+	test_must_fail git rev-list --objects HEAD
+'
+
+test_expect_success 'pack-objects notices corruption' '
+	echo HEAD |
+	test_must_fail git pack-objects --revs pack
+'
+
+test_done
-- 
1.6.2.rc0.50.g0a27
