From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH maint review] Fix "git-commit -C $tag"
Date: Sun, 03 Feb 2008 00:08:17 -0800
Message-ID: <7vtzkqxy1a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 09:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLZud-0005hz-Mg
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 09:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759766AbYBCIIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 03:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759692AbYBCIIa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 03:08:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612AbYBCII3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 03:08:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1611B54B6;
	Sun,  3 Feb 2008 03:08:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 860A454B4;
	Sun,  3 Feb 2008 03:08:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72337>

The scripted version might not have handled this correctly
either, but the version rewritten in C definitely does not grok
this and complains $tag is not a commit object.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is meant for "maint" aka 1.5.4.X.  Working with new
   stuff may be more fun, but we would need to first stabilize
   the 'maint' branch a bit further.  Review comments and
   similar bugfix patches meant for 'maint' branch are very much
   appreciated.

 builtin-commit.c  |    2 +-
 t/t7501-commit.sh |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index d8deb1a..c787bed 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -601,7 +601,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 		if (get_sha1(use_message, sha1))
 			die("could not lookup commit %s", use_message);
-		commit = lookup_commit(sha1);
+		commit = lookup_commit_reference(sha1);
 		if (!commit || parse_commit(commit))
 			die("could not parse commit %s", use_message);
 
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d1a415a..55043d1 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -327,4 +327,22 @@ test_expect_success 'amend using the message from another commit' '
 
 '
 
+test_expect_success 'amend using the message from a commit named with tag' '
+
+	git reset --hard &&
+	test_tick &&
+	git commit --allow-empty -m "old commit" &&
+	old=$(git rev-parse --verify HEAD) &&
+	git tag -a -m "tag on old" tagged-old HEAD &&
+	test_tick &&
+	git commit --allow-empty -m "new commit" &&
+	new=$(git rev-parse --verify HEAD) &&
+	test_tick &&
+	git commit --allow-empty --amend -C tagged-old &&
+	git show --pretty="format:%ad %s" "$old" >expected &&
+	git show --pretty="format:%ad %s" HEAD >actual &&
+	diff -u expected actual
+
+'
+
 test_done
-- 
1.5.4.2.g41ac4
