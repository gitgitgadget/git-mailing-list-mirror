From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH/RFC 7/7] git-submodule: "update --force" to enforce cloning non-submodule
Date: Thu, 10 Apr 2008 23:50:25 +0800
Message-ID: <1207842625-9210-11-git-send-email-pkufranky@gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-6-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-7-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-8-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-9-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-10-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 17:53:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjz4b-0005Y2-Qg
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973AbYDJPur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757942AbYDJPuq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:50:46 -0400
Received: from mail.qikoo.org ([60.28.205.235]:37789 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757606AbYDJPub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:50:31 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 0A804470BA; Thu, 10 Apr 2008 23:50:25 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1207842625-9210-10-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79226>

If the update subcommand combines with --force, non-submodules
(i.e. modules existing in .gitmodules or $GIT_DIR/config but not added
to the super module) will be cloned and the master branch will be
checked out.

However, if a non-submodule has already been cloned before, the update
will be rejected since we don't know what the update means.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b4db676..153b61e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -384,6 +384,9 @@ cmd_update()
 		-q|--quiet)
 			quiet=1
 			;;
+		-f | --force)
+			force="$1"
+			;;
 		--)
 			shift
 			break
@@ -406,7 +409,8 @@ cmd_update()
 		test -z "$name" && exit_status=1 && continue
 		if test $sha1 = 0000000000000000000000000000000000000000
 		then
-			say "Not a submodule: $name @ $path"
+			test -z "$force" &&
+			say "Not a submodule: $name @ $path" &&
 			continue
 		elif test -z "$url"
 		then
@@ -420,8 +424,15 @@ cmd_update()
 		if ! test -d "$path"/.git
 		then
 			! module_clone "$path" "$url" && exit_status=1 && continue
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
 			{
@@ -431,6 +442,7 @@ cmd_update()
 			}
 		fi
 
+
 		if test "$subsha1" != "$sha1"
 		then
 			(unset GIT_DIR; cd "$path" && git-fetch &&
-- 
1.5.5.23.g2a5f
