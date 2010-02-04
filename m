From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-clean: fix the description of the default behavior
Date: Thu,  4 Feb 2010 17:01:16 +0100
Message-ID: <dafb1423c81bc2207d06cf2a97205bcbd9a4968e.1265299086.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 17:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4B4-0003gg-Al
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897Ab0BDQDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:03:25 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56438 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932422Ab0BDQDY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 11:03:24 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C3F3CE0C96;
	Thu,  4 Feb 2010 11:03:23 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 04 Feb 2010 11:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=mUnGv92N+UjOwtON2f0rZLgXKvE=; b=coJ9lfQrWMnSO9sm/w5HcYzix3ElEnPwOcLWuX1eOmd+KhkdAZndxzB+vKsZ9CY09jy8ouLVHaXt9/D4a7m29qHuY6Dvj5rViKttt0WIZCrR7M+QxSU/bySfWp60PObh9oY7rtOLgLjIBwVcePpA8sgzDNpQhl6WvWnza/3npMM=
X-Sasl-enc: ABhEVtnYupvV5aHudBQW4JbkNCVZFTQJKcEsMQ7AJh4a 1265299403
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 289E6DC58;
	Thu,  4 Feb 2010 11:03:23 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138969>

Currently, when called without -n and -f, git clean issues

fatal: clean.requireForce not set and -n or -f not given; refusing to clean

which leaves the user wondering why force is required when requireForce
is not set. Looking up in git-clean(1) does not help because its
description is wrong.

Change it so that git clean issues

fatal: clean.requireForce defaults to true and -n or -f not given; refusing to clean

in this situation (and "...set to true..." when it is set) which makes
it clearer that an unset config means true here, and adjust the
documentation.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I'd actually suggest changing "and -n or -f not given" to "and neither -n nor -f given"
in addition to the above, but the above is a real fix, whereas the latter is a style
issue, and we're close to release.

In fact, having a variable where unset means true is rather unfortunate,
but I don't expect that to be changing.

 Documentation/git-clean.txt |    4 ++--
 builtin-clean.c             |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 335c885..a81cb6c 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -33,8 +33,8 @@ OPTIONS
 
 -f::
 --force::
-	If the git configuration specifies clean.requireForce as true,
-	'git clean' will refuse to run unless given -f or -n.
+	If the git configuration variable clean.requireForce is not set
+	to false, 'git clean' will refuse to run unless given -f or -n.
 
 -n::
 --dry-run::
diff --git a/builtin-clean.c b/builtin-clean.c
index 3a70fa8..6ad5892 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -67,8 +67,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		die("-x and -X cannot be used together");
 
 	if (!show_only && !force)
-		die("clean.requireForce%s set and -n or -f not given; "
-		    "refusing to clean", config_set ? "" : " not");
+		die("clean.requireForce %s to true and -n or -f not given; "
+		    "refusing to clean", config_set ? "set" : "defaults");
 
 	if (force > 1)
 		rm_flags = 0;
-- 
1.7.0.rc1.199.g9253ab
