From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/4] diff: Do not warn about missing EOL at EOF for symlinks
Date: Thu,  3 Jun 2010 16:35:22 +0200
Message-ID: <c1e0646449aae50fb962108d16b5428fb7d73bae.1275575236.git.git@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 16:36:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBWk-0005AQ-Id
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab0FCOfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:35:53 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:46114 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755452Ab0FCOfv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 10:35:51 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8A517F86A4
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 10:35:50 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 10:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=bpZtrv0/6cUohyjUsijCNt5W0PU=; b=jCrQ2YnTigcDgXFAvgL8SwlA63cU65d3eIsdkLTOOBijbfr/Xz3D/hG9wukpuVMI7pA5Le7IWWhDDy1ZaZRRW0or1VPy83EIkCtuKjWd0YGOUKHq0ZSb0C7db90TqaOClunIAET21MXJStXV8QC2xcnHmbfaycYBvXYIXXVhZaU=
X-Sasl-enc: 89pFs0dWWGYSE6ovuTv6vl1LTkwKqjx6NpyWqDf0oAwL 1275575750
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 025384C3D1C;
	Thu,  3 Jun 2010 10:35:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.351.ge2633e
In-Reply-To: <cover.1275575236.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148323>

Symbolic links are represented by blobs without a trailing newline
(EOL). This cannot be changed because it would encumber the
representation with platform EOL issues.

But seeing a warning about "No newline at end of file" in the diff for
a symbolic link is highly distracting - in particular, it distracts from
the actual mode (120000) and gives the false impression that Git treated
the symlink as a file.

Therefore, change the default behaviour of the diff code so that there
is no warning about missing EOL at EOF if a symlink is involved AND
textconv is allowed. So, --no-textconv restores the old behaviour, and
diff users such as format-patch are not affected by this change so that
apply/am are still able to create files with no EOL at EOF - such as
symlink representations.

Note that a mode change (file<->symlink) is always rewritten as
deletion+addition by the diff engine so that replacing a file without
EOL at EOF by a symlink or vice versa displays the warning for the file.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 diff.c                   |    2 ++
 t/t4030-diff-textconv.sh |    1 -
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 7950df6..cad7339 100644
--- a/diff.c
+++ b/diff.c
@@ -1788,6 +1788,8 @@ static void builtin_diff(const char *name_a,
 		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
+		if (DIFF_OPT_TST(o, ALLOW_TEXTCONV) && (S_ISLNK(one->mode) || S_ISLNK(two->mode)))
+			ecbdata.ws_rule &= ~WS_NO_EOL_AT_EOF;
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.file = o->file;
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 88c5619..b6e537f 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -109,7 +109,6 @@ index 0000000..67be421
 +++ b/file
 @@ -0,0 +1 @@
 +frotz
-\ No newline at end of file
 EOF
 # make a symlink the hard way that works on symlink-challenged file systems
 test_expect_success 'textconv does not act on symlinks' '
-- 
1.7.1.351.ge2633e
