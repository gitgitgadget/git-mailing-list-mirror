From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] git-checkout: disallow --detach on unborn branch
Date: Tue, 26 Jun 2012 16:06:42 +0100
Message-ID: <b9069a6c6af42f4771c5a5c1c812800c21926622.1340723202.git.chris@arachsys.com>
References: <20120626150436.GU9682@arachsys.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Webb <chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 17:06:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjXLz-0007L5-6d
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 17:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757798Ab2FZPGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 11:06:51 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:47539 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab2FZPGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 11:06:51 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjXLt-0007DL-UI; Tue, 26 Jun 2012 16:06:50 +0100
X-Mailer: git-send-email 1.7.10
In-Reply-To: <20120626150436.GU9682@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200651>

abe199808c (git checkout -b: allow switching out of an unborn branch)
introduced a bug demonstrated by

  git checkout --orphan foo
  git checkout --detach
  git symbolic-ref HEAD

which gives 'refs/heads/(null)'.

This happens because we strbuf_addf(&branch_ref, "refs/heads/%s",
opts->new_branch) when opts->new_branch can be NULL for --detach.

Catch and forbid this case, adding a test to t2017 to catch it in
future.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/checkout.c         |    2 ++
 t/t2017-checkout-orphan.sh |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e8c1b1f..3980d5d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -915,6 +915,8 @@ static int switch_unborn_to_new_branch(struct checkout_opts *opts)
 	int status;
 	struct strbuf branch_ref = STRBUF_INIT;
 
+	if (!opts->new_branch)
+		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
 	status = create_symref("HEAD", branch_ref.buf, "checkout -b");
 	strbuf_release(&branch_ref);
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 0e3b858..655f278 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -116,4 +116,10 @@ test_expect_success '--orphan refuses to switch if a merge is needed' '
 	git reset --hard
 '
 
+test_expect_success 'cannot --detach on an unborn branch' '
+	git checkout master &&
+	git checkout --orphan new &&
+	test_must_fail git checkout --detach
+'
+
 test_done
-- 
1.7.10
