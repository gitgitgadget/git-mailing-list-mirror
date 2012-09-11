From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] describe: document and test --first-parent
Date: Tue, 11 Sep 2012 15:51:52 +0200
Message-ID: <a0f0cf4e9cf41577d01d728007250f78e18a9ac0.1347370970.git.git@drmicha.warpmail.net>
References: <cover.1347370970.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 15:52:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBQso-0001KM-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 15:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab2IKNv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 09:51:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51230 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757733Ab2IKNv5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 09:51:57 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5D8A821935
	for <git@vger.kernel.org>; Tue, 11 Sep 2012 09:51:57 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 11 Sep 2012 09:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=2Qq8w6Oh6jQwh7cYERsNf6Dji
	OI=; b=uCQADVQTyPhYwGgY5ZJ2kpYN2JIQb3QelxawSRKtOwOYf7BLW8rccuHpy
	N0PW8Zy9PfYZUYwfRby4wd8rWseEtMVScZpnZoWGjEKRTM6Gm/YGK5soLQ0KH1Q7
	JHBotlQ/mHlpZXyTK4l9bunzbl6JAst+BjbAn0FPLqtbZyYK/g=
X-Sasl-enc: SGMmuIOCV6OvrS9p0TZDiVpYboV9nCA90R+sRvUWpYY7 1347371517
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 00F084825C3;
	Tue, 11 Sep 2012 09:51:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <cover.1347370970.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205230>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-describe.txt | 16 +++++++++++++++-
 t/t6120-describe.sh            |  7 +++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 72d6bb6..9fb5c84 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -84,6 +84,10 @@ OPTIONS
 	Only consider tags matching the given pattern (can be used to avoid
 	leaking private tags made from the repository).
 
+--first-parent::
+	Only consider tags which can be reached from '<committish>' by a first
+	parent walk, i.e. only those which are not on side branches.
+
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
@@ -129,6 +133,14 @@ closest tagname without any suffix:
 	[torvalds@g5 git]$ git describe --abbrev=0 v1.0.5^2
 	tags/v1.0.0
 
+With --first-parent, tags on side branches are not considered:
+
+	$ git describe v1.1.0^
+	v1.0.7-44-ge77f489
+
+	$ git describe --first-parent v1.1.0^
+	v1.0.0-41-ge77f489
+
 Note that the suffix you get if you type these commands today may be
 longer than what Linus saw above when he ran these commands, as your
 git repository may have new commits whose object names begin with
@@ -148,7 +160,9 @@ is found, its name will be output and searching will stop.
 If an exact match was not found, 'git describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input committish's SHA1.
+abbreviation of the input committish's SHA1.  With '--first-parent',
+'git describe' will walk the history only along the first parent
+of each commit.
 
 If multiple tags were found during the walk then the tag which
 has the fewest commits different from the input committish will be
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index f67aa6f..2524236 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -103,6 +103,13 @@ check_describe c-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
 check_describe e --tags HEAD^^^
 
+check_describe R-* --first-parent HEAD
+check_describe R-* --first-parent HEAD^
+check_describe R-* --first-parent HEAD^^
+check_describe B-* --first-parent HEAD^^2
+check_describe B --first-parent HEAD^^2^
+check_describe R-* --first-parent HEAD^^^
+
 check_describe heads/master --all HEAD
 check_describe tags/c-* --all HEAD^
 check_describe tags/e --all HEAD^^^
-- 
1.7.12.463.gbd9d638
