From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t/t5510: demonstrate failure to fetch when current branch has merge ref
Date: Wed, 25 Aug 2010 12:52:55 -0500
Message-ID: <O7UxM6KEqdDAhjJAF7ODSonSLShoyHHhaZNp8vb1mx2_JFqmMUj1Op5xiv_-bSd8xW04rLMul2k@cipher.nrlssc.navy.mil>
References: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, galak@kernel.crashing.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 25 19:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKB0-0001ii-2p
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab0HYRyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 13:54:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48735 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0HYRyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 13:54:08 -0400
Received: by mail.nrlssc.navy.mil id o7PHrLt8008114; Wed, 25 Aug 2010 12:53:21 -0500
In-Reply-To: <pzml8liT3RErVlMrdxbSkHmhBs1RMvwYma9UXgvG6WY@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 25 Aug 2010 17:53:21.0607 (UTC) FILETIME=[68445D70:01CB447E]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154453>

From: Brandon Casey <drafnel@gmail.com>

When 'git fetch' is supplied just a repository URL (not a remote name),
and without a fetch refspec, it should fetch from the remote HEAD branch
and update FETCH_HEAD with the fetched ref.  Currently, when 'git fetch'
is called like this, it fails to retrieve anything, and does not update
FETCH_HEAD, if the current checked-out branch has a configured merge ref.

i.e. this fetch fails to retrieve anything nor update FETCH_HEAD:

   git checkout master
   git config branch.master.merge refs/heads/master
   git fetch git://git.kernel.org/pub/scm/git/git.git

but this one does:

   git config --unset branch.master.merge
   git fetch git://git.kernel.org/pub/scm/git/git.git

Add a test to demonstrate this flaw.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5510-fetch.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4eb10f6..3c7569c 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -240,6 +240,12 @@ test_expect_success 'fetch with a non-applying branch.<name>.merge' '
 	git fetch blub
 '
 
+test_expect_failure 'fetch from GIT URL with a non-applying branch.<name>.merge' '
+	git update-ref -d FETCH_HEAD &&
+	git fetch one &&
+	git rev-parse --verify FETCH_HEAD
+'
+
 # the strange name is: a\!'b
 test_expect_success 'quoting of a strangely named repo' '
 	test_must_fail git fetch "a\\!'\''b" > result 2>&1 &&
-- 
1.7.2.1
