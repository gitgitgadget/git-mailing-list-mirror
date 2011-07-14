From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] ref namespaces: tests
Date: Thu, 14 Jul 2011 13:50:57 -0700
Message-ID: <20110714205055.GA26956@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhSsP-0001YY-VO
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab1GNUvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:51:09 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39039 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab1GNUvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:51:09 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id C1021172076;
	Thu, 14 Jul 2011 22:51:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter4-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id f5r+UaYcGV0O; Thu, 14 Jul 2011 22:51:04 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 465E2172055;
	Thu, 14 Jul 2011 22:50:59 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177176>

Test pushing, pulling, and mirroring of repositories with ref
namespaces.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---

The most recent "What's cooking" suggested that the ref namespaces
patches needed tests.  This test works with PATCHv10, currently in pu.
Please append this patch to the js/ref-namespaces branch.

 t/t5502-fetch-push-namespaces.sh |   77 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100755 t/t5502-fetch-push-namespaces.sh

diff --git a/t/t5502-fetch-push-namespaces.sh b/t/t5502-fetch-push-namespaces.sh
new file mode 100755
index 0000000..85720b6
--- /dev/null
+++ b/t/t5502-fetch-push-namespaces.sh
@@ -0,0 +1,77 @@
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
+		i=0 &&
+		while [ "$i" -lt 2 ]
+		do
+			echo "$i" > count &&
+			git add count &&
+			test_commit "$i" &&
+			i=$(($i + 1))
+		done &&
+		git remote add pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&
+		git remote add pushee-unnamespaced ../pushee
+	) &&
+	git init pushee &&
+	git init puller
+'
+
+test_expect_success 'pushing into a repository using a ref namespace' '
+	(
+		cd original &&
+		git push pushee-namespaced master &&
+		git ls-remote pushee-namespaced > actual &&
+		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba\trefs/heads/master\n" > expected &&
+		test_cmp expected actual &&
+		git push pushee-namespaced --tags &&
+		git ls-remote pushee-namespaced > actual &&
+		printf "fbdf4310c71b916568f04753f603fb24a0544227\trefs/tags/0\n" >> expected &&
+		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba\trefs/tags/1\n" >> expected &&
+		test_cmp expected actual &&
+		# Verify that the GIT_NAMESPACE environment variable works as well
+		GIT_NAMESPACE=namespace git ls-remote "ext::git %s ../pushee" > actual &&
+		test_cmp expected actual &&
+		# Verify that --namespace overrides GIT_NAMESPACE
+		GIT_NAMESPACE=garbage git ls-remote pushee-namespaced > actual &&
+		test_cmp expected actual &&
+		# Try a namespace with no content
+		git ls-remote "ext::git --namespace=garbage %s ../pushee" > actual &&
+		test_cmp /dev/null actual &&
+		git ls-remote pushee-unnamespaced > actual &&
+		sed -e "s|refs/|refs/namespaces/namespace/refs/|" expected > expected.unnamespaced &&
+		test_cmp expected.unnamespaced actual
+	)
+'
+
+test_expect_success 'pulling from a repository using a ref namespace' '
+	(
+		cd puller &&
+		git remote add -f pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&
+		git for-each-ref refs/ > actual &&
+		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/remotes/pushee-namespaced/master\n" > expected &&
+		printf "fbdf4310c71b916568f04753f603fb24a0544227 commit\trefs/tags/0\n" >> expected &&
+		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/tags/1\n" >> expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'mirroring a repository using a ref namespace' '
+	git clone --mirror pushee mirror &&
+	(
+		cd mirror &&
+		git for-each-ref refs/ > actual &&
+		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/namespaces/namespace/refs/heads/master\n" > expected &&
+		printf "fbdf4310c71b916568f04753f603fb24a0544227 commit\trefs/namespaces/namespace/refs/tags/0\n" >> expected &&
+		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/namespaces/namespace/refs/tags/1\n" >> expected &&
+		test_cmp expected actual
+	)
+'
+
+test_done
-- 
1.7.5.4
