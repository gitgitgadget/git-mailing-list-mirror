From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 6/7] git-submodule: "update --force" to enforce cloning non-submodule
Date: Wed, 16 Apr 2008 22:19:36 +0800
Message-ID: <1208355577-8734-7-git-send-email-pkufranky@gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-4-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-5-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-6-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:30:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm8VO-00050Q-4U
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbYDPOUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757432AbYDPOUE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:20:04 -0400
Received: from mail.qikoo.org ([60.28.205.235]:52426 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756412AbYDPOTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:19:44 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 75829470B5; Wed, 16 Apr 2008 22:19:38 +0800 (CST)
X-Mailer: git-send-email 1.5.5.70.gd68a
In-Reply-To: <1208355577-8734-6-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79701>

If the update subcommand combines with --force, instead of
issuing a "Not a submodule" warning for non-submodules, non-submodules
(i.e. modules existing in .gitmodules or $GIT_DIR/config but not added
to the super module) will also be cloned and the master branch will be
checked out.

However, if a non-submodule has already been cloned before, the update
will be rejected since we don't know what the update means.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 87d84fa..ed6f698 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -361,6 +361,9 @@ cmd_update()
 		-q|--quiet)
 			quiet=1
 			;;
+		-f | --force)
+			force="$1"
+			;;
 		--)
 			shift
 			break
@@ -381,7 +384,8 @@ cmd_update()
 		test -n "$name" || exit
 		if test $sha1 = 0000000000000000000000000000000000000000
 		then
-			say "Not a submodule: $name @ $path"
+			test -z "$force" &&
+			say "Not a submodule: $name @ $path" &&
 			continue
 		elif test -z "$url"
 		then
@@ -395,8 +399,15 @@ cmd_update()
 		if ! test -d "$path"/.git
 		then
 			module_clone "$path" "$url" || exit
+			test "$sha1" = 0000000000000000000000000000000000000000 &&
+			(unset GIT_DIR; cd "$path" && git checkout -q master) &&
+			say "non-submodule cloned and master checked out: $name @ $path" &&
+			continue
 			subsha1=
 		else
+			test "$sha1" = 0000000000000000000000000000000000000000 &&
+			say "non-submodule already cloned: $name @ $path" &&
+			continue
 			subsha1=$(unset GIT_DIR; cd "$path" &&
 				git rev-parse --verify HEAD) ||
 			die "Unable to find current revision in submodule path '$path'"
-- 
1.5.5.70.gd68a
