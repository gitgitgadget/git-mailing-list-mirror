From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv3] ref namespaces: tests
Date: Thu, 21 Jul 2011 13:10:54 -0700
Message-ID: <20110721201054.GA2530@leaf>
References: <20110714205055.GA26956@leaf>
 <7v1uxs3177.fsf@alter.siamese.dyndns.org>
 <20110715034538.GD28343@leaf>
 <20110715184045.GA2232@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjzad-0004vp-0d
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 22:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab1GUULM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 16:11:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40963 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab1GUULL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 16:11:11 -0400
X-Originating-IP: 217.70.178.137
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id B0A15A8079;
	Thu, 21 Jul 2011 22:11:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter8-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id ebZ9bZWtfp2K; Thu, 21 Jul 2011 22:11:07 +0200 (CEST)
X-Originating-IP: 131.252.247.123
Received: from leaf (host-247-123.pubnet.pdx.edu [131.252.247.123])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6F41FA8075;
	Thu, 21 Jul 2011 22:10:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110715184045.GA2232@leaf>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177618>

Test pushing, pulling, and mirroring of repositories with ref
namespaces.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---

v3: Change test number to 5509 to avoid conflicts with new tests 5507
and 5508 in pu.

At this point I think we've incorporated all the outstanding feedback.
Does this test need any further changes to allow the ref-namespaces
branch to graduate to next?

(Also, for future reference, do you prefer to see later versions of
patches as replies to the previous version, as I've made this mail a
reply to PATCHv2, or do you prefer to see them as new threads?)

v2: Incorporate feedback from Junio: change test number to 5507 to avoid
conflicting with existing tests, make style consistent with other test
scripts, avoid hardcoding commit hashes, add rationale for mirror test.

 t/t5509-fetch-push-namespaces.sh |   85 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100755 t/t5509-fetch-push-namespaces.sh

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
new file mode 100755
index 0000000..cc0b31f
--- /dev/null
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='fetch/push involving ref namespaces'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	git init original &&
+	(
+		cd original &&
+		echo 0 >count &&
+		git add count &&
+		test_commit 0 &&
+		echo 1 >count &&
+		git add count &&
+		test_commit 1 &&
+		git remote add pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&
+		git remote add pushee-unnamespaced ../pushee
+	) &&
+	commit0=$(cd original && git rev-parse HEAD^) &&
+	commit1=$(cd original && git rev-parse HEAD) &&
+	git init pushee &&
+	git init puller
+'
+
+test_expect_success 'pushing into a repository using a ref namespace' '
+	(
+		cd original &&
+		git push pushee-namespaced master &&
+		git ls-remote pushee-namespaced >actual &&
+		printf "$commit1\trefs/heads/master\n" >expected &&
+		test_cmp expected actual &&
+		git push pushee-namespaced --tags &&
+		git ls-remote pushee-namespaced >actual &&
+		printf "$commit0\trefs/tags/0\n" >>expected &&
+		printf "$commit1\trefs/tags/1\n" >>expected &&
+		test_cmp expected actual &&
+		# Verify that the GIT_NAMESPACE environment variable works as well
+		GIT_NAMESPACE=namespace git ls-remote "ext::git %s ../pushee" >actual &&
+		test_cmp expected actual &&
+		# Verify that --namespace overrides GIT_NAMESPACE
+		GIT_NAMESPACE=garbage git ls-remote pushee-namespaced >actual &&
+		test_cmp expected actual &&
+		# Try a namespace with no content
+		git ls-remote "ext::git --namespace=garbage %s ../pushee" >actual &&
+		test_cmp /dev/null actual &&
+		git ls-remote pushee-unnamespaced >actual &&
+		sed -e "s|refs/|refs/namespaces/namespace/refs/|" expected >expected.unnamespaced &&
+		test_cmp expected.unnamespaced actual
+	)
+'
+
+test_expect_success 'pulling from a repository using a ref namespace' '
+	(
+		cd puller &&
+		git remote add -f pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&
+		git for-each-ref refs/ >actual &&
+		printf "$commit1 commit\trefs/remotes/pushee-namespaced/master\n" >expected &&
+		printf "$commit0 commit\trefs/tags/0\n" >>expected &&
+		printf "$commit1 commit\trefs/tags/1\n" >>expected &&
+		test_cmp expected actual
+	)
+'
+
+# This test with clone --mirror checks for possible regressions in clone
+# or the machinery underneath it. It ensures that no future change
+# causes clone to ignore refs in refs/namespaces/*. In particular, it
+# protects against a regression caused by any future change to the refs
+# machinery that might cause it to ignore refs outside of refs/heads/*
+# or refs/tags/*. More generally, this test also checks the high-level
+# functionality of using clone --mirror to back up a set of repos hosted
+# in the namespaces of a single repo.
+test_expect_success 'mirroring a repository using a ref namespace' '
+	git clone --mirror pushee mirror &&
+	(
+		cd mirror &&
+		git for-each-ref refs/ >actual &&
+		printf "$commit1 commit\trefs/namespaces/namespace/refs/heads/master\n" >expected &&
+		printf "$commit0 commit\trefs/namespaces/namespace/refs/tags/0\n" >>expected &&
+		printf "$commit1 commit\trefs/namespaces/namespace/refs/tags/1\n" >>expected &&
+		test_cmp expected actual
+	)
+'
+
+test_done
-- 
1.7.5.4
