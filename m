From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit-tree: resurrect command line parsing updates
Date: Tue, 17 Jul 2012 13:22:13 -0700
Message-ID: <7vd33uxhmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keshav Kini <keshav.kini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 22:22:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrEHn-0002wd-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 22:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab2GQUWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 16:22:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206Ab2GQUWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 16:22:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E39F06DCF;
	Tue, 17 Jul 2012 16:22:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	mGfU/pX1bK8TtilK4xuQmlH3Vo=; b=cxlP+wXRQJFc7YxJ2LIkASYJWvxd2wBQw
	12ySbjOk7uMGhG2mkX7oasZmzZm6gVeZY5SKpN3mS1j4VcEvqVkwbIModzgPH9zf
	K2OMEa8Jikw54M/i05Bvq5PnXkWU418R5NZA+ZOOVzTqVaC+J3yuPj8iEMx2Oi8G
	/fRNsw3czs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=A8WR16KB79e/LwLSsnIFqWHrpZxmhKMtxe7MUE1Rwk2drNOu5BXZO8Hc
	qE6pxDcppekrpFoYsTQZhDlnqSJD6tF+VGgzmwJdscXiOGj2SYgD8mzPi0WoQr32
	EYcrDYag9FeTTwebO1HqHWHmS4JZDN9exmjZWlg/5yNDNzkRFXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D15476DCE;
	Tue, 17 Jul 2012 16:22:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FE8A6DC9; Tue, 17 Jul 2012
 16:22:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 192ECB5A-D04D-11E1-A9CE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201620>

79a9312 (commit-tree: update the command line parsing, 2011-11-09)
updated the command line parser to understand the usual "flags first
and then non-flag arguments" order, in addition to the original and
a bit unusual "tree comes first and then zero or more -p <parent>".

Unfortunately, ba3c69a (commit: teach --gpg-sign option, 2011-10-05)
broke it by mistake.  Resurrect it, and protect the feature with a
test from future breakages.

Noticed by Keshav Kini <keshav.kini@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I privately received a patch that is essentially the same from
   Keshav, but I do not see it either on the list or on gmane.  I
   suspect the message was sent via gmane's news submission
   interface and probably it is taking some time propagating back to
   the list, or something.

   The patch in this message is with an updated log message and an
   additional test. It is meant to apply to the 1.7.9.X maintenance
   track and upwards.  For 1.7.11.1 and later, we also need to
   revert d284367 (git-commit-tree(1): update synopsis, 2012-06-19),
   which was done without realizing that the updated command line
   argument order was lost by an earlier mistake.

 builtin/commit-tree.c          |  3 ---
 t/t1100-commit-tree-options.sh | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d5e19af..792670a 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -48,9 +48,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
 
-	if (get_sha1(argv[1], tree_sha1))
-		die("Not a valid object name %s", argv[1]);
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "-p")) {
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index c4414ff..a3b7723 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -7,6 +7,9 @@ test_description='git commit-tree options test
 
 This test checks that git commit-tree can create a specific commit
 object by defining all environment variables that it understands.
+
+Also make sure that command line parser understands the normal
+"flags first and then non flag arguments" command line.
 '
 
 . ./test-lib.sh
@@ -42,4 +45,18 @@ test_expect_success \
     'compare commit' \
     'test_cmp expected commit'
 
+
+test_expect_success 'flags and then non flags' '
+	echo comment text |
+	git commit-tree $(cat treeid) >commitid &&
+	echo comment text |
+	git commit-tree $(cat treeid) -p $(cat commitid) >childid-1 &&
+	echo comment text |
+	git commit-tree -p $(cat commitid) $(cat treeid) >childid-2 &&
+	test_cmp childid-1 childid-2 &&
+	git commit-tree $(cat treeid) -m foo >childid-3 &&
+	git commit-tree -m foo $(cat treeid) >childid-4 &&
+	test_cmp childid-3 childid-4
+'
+
 test_done
-- 
1.7.11.2.308.gd5eadba
