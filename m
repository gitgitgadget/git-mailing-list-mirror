From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH v2] Documentation: merging a tag is a special case
Date: Thu, 21 Mar 2013 22:57:48 +0100
Message-ID: <1363903068-15905-1-git-send-email-ydroneaud@opteya.com>
References: <1363704914.6289.39.camel@test.quest-ce.net> <7vfvzrjrad.fsf@alter.siamese.dyndns.org> <1363802033-26868-1-git-send-email-ydroneaud@opteya.com> <7vboadevpk.fsf@alter.siamese.dyndns.org> <7vmwtwa5xa.fsf@alter.siamese.dyndns.org> <20130321195624.GH29311@google.com> <7vehf8a4ze.fsf@alter.siamese.dyndns.org> <1363902468-14764-1-git-send-email-ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 22:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UInVX-0000KK-An
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 22:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab3CUV6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 17:58:18 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42447 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753595Ab3CUV6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 17:58:14 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id F229D9400B3;
	Thu, 21 Mar 2013 22:58:04 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2LLw3qA015942;
	Thu, 21 Mar 2013 22:58:03 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2LLw2jT015941;
	Thu, 21 Mar 2013 22:58:02 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1363902468-14764-1-git-send-email-ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218765>

From: Junio C Hamano <gitster@pobox.com>

When asking Git to merge a tag (such as a signed tag or annotated tag),
it will always create a merge commit even if fast-forward was possible.
It's like having --no-ff present on the command line.

It's a difference from the default behavior described in git-merge.txt.
It should be documented as an exception of "FAST-FORWARD MERGE" section
and "--ff" option description.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Yann Droneaud <ydroneaud@opteya.com>
---
 Documentation/git-merge.txt     | 24 ++++++++++++++++++++++++
 Documentation/merge-options.txt |  3 ++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c852a26..42391f2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -170,6 +170,30 @@ happens:
 If you tried a merge which resulted in complex conflicts and
 want to start over, you can recover with `git merge --abort`.
 
+MERGING TAG
+-----------
+
+When merging an annotated (and possibly signed) tag, Git always
+creates a merge commit even if a fast-forward merge is possible, and
+the commit message template is prepared with the tag message.
+Additionally, if the tag is signed, the signature check is reported
+as a comment in the message template. See also linkgit:git-tag[1].
+
+When you want to just integrate with the work leading to the commit
+that happens to be tagged, e.g. synchronizing with an upstream
+release point, you may not want to make an unnecessary merge commit.
+
+In such a case, you can "unwrap" the tag yourself before feeding it
+to `git merge`, or pass `--ff-only` when you do not have any work on
+your own. e.g.
+
+---
+git fetch origin
+git merge v1.2.3^0
+git merge --ff-only v1.2.3
+---
+
+
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 0bcbe0a..34a8445 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -30,7 +30,8 @@ set to `no` at the beginning of them.
 
 --no-ff::
 	Create a merge commit even when the merge resolves as a
-	fast-forward.
+	fast-forward.  This is the default behaviour when merging an
+	annotated (and possibly signed) tag.
 
 --ff-only::
 	Refuse to merge and exit with a non-zero status unless the
-- 
1.7.11.7
