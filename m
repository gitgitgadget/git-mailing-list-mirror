From: Mike Crowe <mac@mcrowe.com>
Subject: [PATCH 1/2] push: Fully test --recurse-submodules on command line overrides config
Date: Thu,  3 Dec 2015 13:10:34 +0000
Message-ID: <1449148235-29569-1-git-send-email-mac@mcrowe.com>
References: <20151203131006.GA5119@mcrowe.com>
Cc: Mike Crowe <mac@mcrowe.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 14:11:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4TfI-0000nq-SF
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 14:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759893AbbLCNLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 08:11:11 -0500
Received: from relay.appriver.com ([207.97.230.34]:62491 "EHLO
	relay.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759607AbbLCNLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 08:11:10 -0500
Received: from [86.30.112.98] (HELO elite.brightsign)
  by relay.appriver.com (CommuniGate Pro SMTP 6.1.2)
  with ESMTP id 650626433; Thu, 03 Dec 2015 08:11:09 -0500
Received: from chuckie.brightsign ([172.30.1.25] helo=chuckie)
	by elite.brightsign with esmtp (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1a4Tf5-000B5w-RD; Thu, 03 Dec 2015 13:11:03 +0000
Received: from mac by chuckie with local (Exim 4.84)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1a4Tf5-0007o9-QU; Thu, 03 Dec 2015 13:11:03 +0000
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20151203131006.GA5119@mcrowe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281952>

t5531 only checked that the push.recurseSubmodules config option was
overridden by passing --recurse-submodules=check on the command line.
Add new tests for overriding with --recurse-submodules=no,
--no-recurse-submodules and --recurse-submodules=push too.

Also correct minor typo in test commit message.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 t/t5531-deep-submodule-push.sh | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 9fda7b0..721be32 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -126,24 +126,48 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
 	)
 '
 
-test_expect_success 'push fails if submodule commit not on remote using check from cmdline overriding config' '
+test_expect_success 'push recurse-submodules on command line overrides config' '
 	(
 		cd work/gar/bage &&
 		>recurse-check-on-command-line-overriding-config &&
 		git add recurse-check-on-command-line-overriding-config &&
-		git commit -m "Recurse on command-line overridiing config junk"
+		git commit -m "Recurse on command-line overriding config junk"
 	) &&
 	(
 		cd work &&
 		git add gar/bage &&
 		git commit -m "Recurse on command-line overriding config for gar/bage" &&
+
+		# Ensure that we can override on-demand in the config
+		# to just check submodules
 		test_must_fail git -c push.recurseSubmodules=on-demand push --recurse-submodules=check ../pub.git master &&
 		# Check that the supermodule commit did not get there
 		git fetch ../pub.git &&
 		git diff --quiet FETCH_HEAD master^ &&
 		# Check that the submodule commit did not get there
-		cd gar/bage &&
-		git diff --quiet origin/master master^
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+
+		# Ensure that we can override check in the config to
+		# disable submodule recursion entirely
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+		git -c push.recurseSubmodules=on-demand push --recurse-submodules=no ../pub.git master &&
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+
+		# Ensure that we can override check in the config to
+		# disable submodule recursion entirely (alternative form)
+		git -c push.recurseSubmodules=on-demand push --no-recurse-submodules ../pub.git master &&
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		(cd gar/bage && git diff --quiet origin/master master^) &&
+
+		# Ensure that we can override check in the config to
+		# push the submodule too
+		git -c push.recurseSubmodules=check push --recurse-submodules=on-demand ../pub.git master &&
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		(cd gar/bage && git diff --quiet origin/master master)
 	)
 '
 
-- 
2.1.4
