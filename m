From: Richard Maw <richard.maw@codethink.co.uk>
Subject: Some issues when trying to set up a shallow git mirror server
Date: Thu, 7 Jan 2016 16:54:17 +0000
Message-ID: <20160107165417.GB3397@logi.codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 17:54:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHDpY-0004pR-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 17:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcAGQy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 11:54:29 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:37276 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbcAGQy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 11:54:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id A87BA460B89
	for <git@vger.kernel.org>; Thu,  7 Jan 2016 16:54:26 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BK3mOXtwyvF2 for <git@vger.kernel.org>;
	Thu,  7 Jan 2016 16:54:24 +0000 (GMT)
Received: from logi.codethink.co.uk (logi.dyn.ducie.codethink.co.uk [10.24.1.141])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id B1CF6460A89
	for <git@vger.kernel.org>; Thu,  7 Jan 2016 16:54:23 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283495>

Hi all.

I've been working on a service that mirrors open source code into git,
(http://git.baserock.org/cgi-bin/cgit.cgi/?q=delta if interested).

Some repositories are too unwieldy to mirror the whole history,
so we're looking at shallow support,
by fetching specified branches with `--depth=1`.

Since we'll be fetching in only a very shallow history,
we found that most of the time git classifies this as non-fast-forward.

I can see why this happens,
since it ends up with non-overlapping ranges of history
it hasn't fetched enough commits to join the dots.

This is inconvenient for us,
as we were explicitly using refspecs which didn't force the fetch,
since we were using the "non fast-forward update" errors
to detect whether upstream force pushed important refs
which could be a sign of tampering.

While the client doesn't have enough information
the server has those commits.
Would it make sense for the server to be able to tell the client
"trust me, that commit is a descendant of the previous one"?

Here's a patch to the test suite that demonstrates the failure,
since I felt I had to put some commands together to demonstrate,
and I may as well put it in a useful format.

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index a980574..0996d12 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,4 +186,24 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'fetch --depth with discontinuous history' '
+	git init --quiet --bare discontinuous.git &&
+	(
+	cd discontinuous.git &&
+	git fetch --quiet ../.git --depth=1 "refs/*:refs/*"
+	) &&
+	commit 5 &&
+	commit 6 &&
+	(
+	cd discontinuous.git &&
+	git fetch ../.git --depth=1 "refs/*:refs/*" &&
+	git fsck &&
+	git log --format=%s master >actual &&
+	cat <<EOF >expect &&
+6
+EOF
+	test_cmp expect actual
+	)
+'
+
 test_done

I also encountered weird behaviour when trying to push the history,
the general symptom being that the server would only update one ref,
so the client would fail because the server didn't mention all the refs.

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index ceee95b..d0bd538 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -120,4 +120,27 @@ EOF
 	git cat-file blob `echo 1|git hash-object --stdin` >/dev/null
 	)
 '
+
+test_expect_success 'push --mirror from shallow clone' '
+	git --git-dir=full/.git tag r0 &&
+	git init --quiet --bare mirror-pusher.git &&
+	git init --quiet --bare mirror.git &&
+	git --git-dir=mirror.git config receive.shallowUpdate true &&
+	(
+	cd mirror-pusher.git &&
+	git remote add --mirror=fetch origin ../full/.git &&
+	git remote add mirror ../mirror.git &&
+	git fetch --quiet origin --depth=1 &&
+	git push --mirror mirror
# The push should work, but does not.
# The following command works for creations, but not deletions.
#git for-each-ref -s --format "git push mirror +%(refname)" | sh
+	) &&
+	git --git-dir=mirror.git for-each-ref --format "%(refname)" --sort refname >actual &&
+	cat <<EOF >expect &&
+refs/heads/master
+refs/remotes/origin/HEAD
+refs/remotes/origin/master
+refs/tags/r0
+EOF
+	test_cmp expect actual
+'
+
 test_done
