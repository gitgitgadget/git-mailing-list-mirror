From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Intermittent Failures in t1450-fsck
Date: Wed, 13 Apr 2011 13:11:59 -0400
Message-ID: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:12:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA3bt-0004HX-G2
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 19:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab1DMRMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 13:12:03 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60378 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890Ab1DMRMB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 13:12:01 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 096C31FFC1A3; Wed, 13 Apr 2011 17:11:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from hermes-bcg.wireless.rit.edu (unknown [129.21.62.34])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 5FAD51FFC134
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 17:11:55 +0000 (UTC)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171466>

t1450-fsck fails in test 10 "tag pointing to something else than its type", but only if I run it as part of the full test suite (with either `make test` or `make prove`).  If I run the test separately, it passes.

The output from running with GIT_TEST_OPTS="-v" is:

expecting success: 
	sha=$(echo blob | git hash-object -w --stdin) &&
	test_when_finished "remove_object $sha" &&
	cat >wrong-tag <<-EOF &&
	object $sha
	type commit
	tag wrong
	tagger T A Gger <tagger@example.com> 1234567890 -0000

	This is an invalid tag.
	EOF

	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
	test_when_finished "remove_object $tag" &&
	echo $tag >.git/refs/tags/wrong &&
	test_when_finished "git update-ref -d refs/tags/wrong" &&
	test_must_fail git fsck --tags 2>out &&
	cat out &&
	grep "error in tag.*broken links" out

tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing
not ok - 10 tag pointing to something else than its type
