From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] replace: List replacement along with the object
Date: Thu, 25 Aug 2011 16:39:44 +0200
Message-ID: <bae5a8f7d30417864d972390f9f6b4470cf4e5bf.1314283118.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 16:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwb61-0003yH-A5
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 16:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab1HYOjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 10:39:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58126 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407Ab1HYOjr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 10:39:47 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1193C20B6B;
	Thu, 25 Aug 2011 10:39:47 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 25 Aug 2011 10:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=nWlQQIhrjP8Fc5rMkDySlnFzCc0=; b=lfV+Spyn4nY1e73CmHaA
	D5ED+JGkkIovTmHTXOzTSF7dvb7oRrO/Pz2HD9muga0gQz88h/CMQtfkZNcR7HdF
	5kjkoJtX2wWhiAkiaiD8lCR84OzPCnwDRH+UUl8BZiSlLDFkhMKA8eotfN84rbYX
	FNL81brJSLv7W1JUCYVXNRs=
X-Sasl-enc: 6ekqtm5g2c7zmYJOhw75yhes4Tb8JFx3YKH0iGji6iEg 1314283186
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 84EBD9E09E0;
	Thu, 25 Aug 2011 10:39:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180080>

The documentation could be misunderstood as if "git replace -l" lists
the replacements of the specified objects. Currently, it lists the
replaced objects.

Change the output to the form "<object> <replacement>" so that there is
an easy way to find the replacement, besides the more difficult to find
git show-ref $(git replace -l).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Noted in passing while testing decorations.
---
 Documentation/git-replace.txt |    2 +-
 builtin/replace.c             |    2 +-
 t/t6050-replace.sh            |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 17df525..9bf3ff8 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -58,7 +58,7 @@ OPTIONS
 
 -l <pattern>::
 	List replace refs for objects that match the given pattern (or
-	all if no pattern is given).
+	all if no pattern is given) in the form "<object> <replacement>".
 	Typing "git replace" without arguments, also lists all replace
 	refs.
 
diff --git a/builtin/replace.c b/builtin/replace.c
index fe3a647..f8c5a9f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -26,7 +26,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 	const char *pattern = cb_data;
 
 	if (!fnmatch(pattern, refname, 0))
-		printf("%s\n", refname);
+		printf("%s %s\n", refname, sha1_to_hex(sha1));
 
 	return 0;
 }
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 5c87f28..665b308 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -119,10 +119,10 @@ test_expect_success 'repack, clone and fetch work' '
 '
 
 test_expect_success '"git replace" listing and deleting' '
-     test "$HASH2" = "$(git replace -l)" &&
-     test "$HASH2" = "$(git replace)" &&
+     test "$HASH2 $R" = "$(git replace -l)" &&
+     test "$HASH2 $R" = "$(git replace)" &&
      aa=${HASH2%??????????????????????????????????????} &&
-     test "$HASH2" = "$(git replace -l "$aa*")" &&
+     test "$HASH2 $R" = "$(git replace -l "$aa*")" &&
      test_must_fail git replace -d $R &&
      test_must_fail git replace -d &&
      test_must_fail git replace -l -d $HASH2 &&
@@ -137,7 +137,7 @@ test_expect_success '"git replace" replacing' '
      test_must_fail git replace $HASH2 $R &&
      git replace -f $HASH2 $R &&
      test_must_fail git replace -f &&
-     test "$HASH2" = "$(git replace)"
+     test "$HASH2 $R" = "$(git replace)"
 '
 
 # This creates a side branch where the bug in H2
-- 
1.7.6.845.gc3c05
