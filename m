From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix "git push $there +HEAD"
Date: Wed, 20 Feb 2008 02:40:11 -0800
Message-ID: <7vprurc3n8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 11:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRmOK-00062A-6Y
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 11:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763313AbYBTKkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 05:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763310AbYBTKkc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 05:40:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbYBTKka (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 05:40:30 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 369D1319E;
	Wed, 20 Feb 2008 05:40:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 1E02E319D; Wed, 20 Feb 2008 05:40:23 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74508>

An earlier commit 47d996a (push: support pushing HEAD to real
branch name) added support for "git push $there HEAD" by
introducing a rewrite rule for the refspecs obtained from the
command line.  However, unlike the usual refspecs, it did not
allow prefixing with '+' to mean forcing the branch.

This refactors the rewriting rule into a separate function, and
teaches it to pay attention to a possible '+' prefix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * If we were to do the "remote.*.push = HEAD" I mentioned
   earlier for defeating the default "matching" behaviour while
   pushing into shared repositories, we would need to apply the
   same rewriting rule for the refspecs obtained from remote at
   the beginning of do_push(), and that is what triggered this
   refactoring.

 builtin-push.c        |   40 +++++++++++++++++++++++++++++++---------
 t/t5516-fetch-push.sh |   21 +++++++++++++++++++++
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 9f727c0..0336ef8 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -28,6 +28,36 @@ static void add_refspec(const char *ref)
 	refspec_nr = nr;
 }
 
+static const char *replace_HEAD(const char *ref)
+{
+	static int checked_HEAD;
+	static char *plus_HEAD;
+	int force = 0;
+	const char *s = ref;
+
+	if (s[0] == '+') {
+		force = 1;
+		s++;
+	}
+	if (strcmp("HEAD", s))
+		return ref;
+	if (!checked_HEAD) {
+		unsigned char sha1[20];
+		size_t len;
+
+		checked_HEAD = 1;
+		s = resolve_ref(s, sha1, 1, NULL);
+		if (!s || prefixcmp(s, "refs/heads/"))
+			die("HEAD cannot be resolved to branch.");
+		len = strlen(s);
+		plus_HEAD = xmalloc(len + 2);
+		plus_HEAD[0] = '+';
+		strcpy(plus_HEAD + 1, s);
+	}
+
+	return plus_HEAD + !force;
+}
+
 static void set_refspecs(const char **refs, int nr)
 {
 	int i;
@@ -44,15 +74,7 @@ static void set_refspecs(const char **refs, int nr)
 			strcat(tag, refs[i]);
 			ref = tag;
 		}
-		if (!strcmp("HEAD", ref)) {
-			unsigned char sha1_dummy[20];
-			ref = resolve_ref(ref, sha1_dummy, 1, NULL);
-			if (!ref)
-				die("HEAD cannot be resolved.");
-			if (prefixcmp(ref, "refs/heads/"))
-				die("HEAD cannot be resolved to branch.");
-			ref = xstrdup(ref + 11);
-		}
+		ref = replace_HEAD(ref);
 		add_refspec(ref);
 	}
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9d2dc33..3370d53 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -271,6 +271,27 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 	check_push_result $the_commit heads/local
 '
 
+test_expect_success 'push with +HEAD' '
+
+	mk_test heads/master &&
+	git checkout master &&
+	git branch -D local &&
+	git checkout -b local &&
+	git push testrepo master local &&
+	check_push_result $the_commit heads/master &&
+	check_push_result $the_commit heads/local &&
+
+	# Without force rewinding should fail
+	git reset --hard HEAD^ &&
+	! git push testrepo HEAD &&
+	check_push_result $the_commit heads/local &&
+
+	# With force rewinding should succeed
+	git push testrepo +HEAD &&
+	check_push_result $the_first_commit heads/local
+
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
