From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] builtin/fetch.c: ignore merge config when not fetching from branch's remote
Date: Wed, 25 Aug 2010 12:52:56 -0500
Message-ID: <O7UxM6KEqdDAhjJAF7ODSlo_kZavb8gBCJ6laH3QPOlG9a1q29koMQOkS7wDMj0BpyrLYfAcEh4@cipher.nrlssc.navy.mil>
References: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, galak@kernel.crashing.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 25 19:54:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKAm-0001SE-01
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 19:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab0HYRx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 13:53:59 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48733 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0HYRx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 13:53:58 -0400
Received: by mail.nrlssc.navy.mil id o7PHrRA1008127; Wed, 25 Aug 2010 12:53:27 -0500
In-Reply-To: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 25 Aug 2010 17:53:27.0826 (UTC) FILETIME=[6BF94F20:01CB447E]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154452>

From: Brandon Casey <drafnel@gmail.com>

When 'git fetch' is supplied a single argument, it tries to match it
against a configured remote and then fetch the refs specified by the
named remote's fetchspec.  Additionally, or alternatively, if the current
branch has a merge ref configured, and if the name of the remote supplied
to fetch matches the one in the branch's configuration, then git also adds
the merge ref to the list of refs to update.

If the argument to fetch does not specify a named remote, or if the name
supplied does not match the remote configured for the current branch, then
the current branch's merge configuration should not be considered.

git currently mishandles the case when the argument to fetch specifies a
GIT URL(i.e. not a named remote) and the current branch has a configured
merge ref.  In this case, fetch should ignore the branch's merge ref and
attempt to fetch from the remote repository's HEAD branch.  But, since
fetch only checks _whether_ the current branch has a merge ref configured,
and does _not_ check whether the branch's configured remote matches the
command line argument (until later), it will mistakenly enter the wrong
branch of an 'if' statement and will not fall back to fetch the HEAD branch.
The fetch ends up doing nothing and returns with a successful zero status.

Fix this by comparing the remote repository's name to the branch's remote
name, in addition to whether it has a configured merge ref, sooner, so that
fetch can correctly decide whether the branch's configuration is interesting
or not, and fall back to fetching from the remote's HEAD branch when
appropriate.

This fixes the test in t5510.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin/fetch.c  |    3 ++-
 t/t5510-fetch.sh |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea14d5d..be6c27a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -146,7 +146,8 @@ static struct ref *get_ref_map(struct transport *transport,
 		struct remote *remote = transport->remote;
 		struct branch *branch = branch_get(NULL);
 		int has_merge = branch_has_merge_config(branch);
-		if (remote && (remote->fetch_refspec_nr || has_merge)) {
+		if (remote && (remote->fetch_refspec_nr || (has_merge &&
+				!strcmp(branch->remote_name, remote->name)))) {
 			for (i = 0; i < remote->fetch_refspec_nr; i++) {
 				get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
 				if (remote->fetch[i].dst &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3c7569c..8fbd894 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -240,7 +240,7 @@ test_expect_success 'fetch with a non-applying branch.<name>.merge' '
 	git fetch blub
 '
 
-test_expect_failure 'fetch from GIT URL with a non-applying branch.<name>.merge' '
+test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge' '
 	git update-ref -d FETCH_HEAD &&
 	git fetch one &&
 	git rev-parse --verify FETCH_HEAD
-- 
1.7.2.1
