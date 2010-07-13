From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] rebase: Allow to turn of ignore-if-in-upstream
Date: Tue, 13 Jul 2010 10:13:24 +0200
Message-ID: <645d8a9bf671937c1a6962b49cf1c512e0af0d82.1279008702.git.git@drmicha.warpmail.net>
References: <4C3C1FE9.40605@drmicha.warpmail.net>
Cc: Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 10:14:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYada-000307-Md
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 10:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab0GMIOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 04:14:24 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55947 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116Ab0GMIOW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 04:14:22 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 02EA216E4BE;
	Tue, 13 Jul 2010 04:14:21 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 13 Jul 2010 04:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=VxRemXEv/K/EV/jdmwHcywC0F94=; b=iNL/0QF+J4X3+zAsxg364u70Yehact29zAsLBjW5fkxbFErYmWtKTQXR4eOP3I0/qocTI+bUAfg2JCZsUr378sb7Naa7pxGTaxAFkIRwNQf7WQgrZ8OHuwGTvWzccL7eV1SUJmjYvu300aVJpDqarig/SzmS0BaAwlPqu0tuD+E=
X-Sasl-enc: +IryYn0Ee3BqJaXknGl+B1oTEESSFs7YZB7jUvZfsu+6 1279008861
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6BF0C6DCDB;
	Tue, 13 Jul 2010 04:14:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g850a
In-Reply-To: <4C3C1FE9.40605@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150887>

git-rebase uses "format-patch --ignore-if-in-upstream" do determine
which commits to apply. This may or may not be desired: a user may want
to transplant all commits, or may opt to avoid the possibly time
consuming calculation of patch-ids.

Therefore, introduce rebase.cherry (defaulting to true) and --cherry and
--no-cherry options (to override the config), where --cherry means the
current behavior and --no-cherry avoids "--ignore-if-in-upstream".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
RFC for obvious reasons (doc, tests).

 git-rebase.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ab4afa7..1eb6ad1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -53,6 +53,7 @@ git_am_opt=
 rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
+cherry=$(git config --bool rebase.cherry)
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -307,6 +308,12 @@ do
 		esac
 		do_merge=t
 		;;
+	--cherry)
+		cherry=true
+		;;
+	--no-cherry)
+		cherry=false
+		;;
 	-n|--no-stat)
 		diffstat=
 		;;
@@ -540,9 +547,16 @@ else
 	revisions="$upstream..$orig_head"
 fi
 
+if test "x$cherry" = "xfalse"
+then
+	cherry_opt=""
+else
+	cherry_opt="--ignore-if-in-upstream"
+fi
+
 if test -z "$do_merge"
 then
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	git format-patch -k --stdout --full-index $cherry_opt \
 		$root_flag "$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
-- 
1.7.2.rc1.212.g850a
