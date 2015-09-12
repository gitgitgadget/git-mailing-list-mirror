From: Julian Andres Klode <jak@debian.org>
Subject: [PATCH] hooks/update: Add a hooks.denyunsignedtags option
Date: Sat, 12 Sep 2015 12:37:33 +0200
Message-ID: <1442054253-15780-1-git-send-email-jak@debian.org>
Cc: bdwalton@gmail.com, davvid@gmail.com, hvoigt@hvoigt.net,
	johnflux@gmail.com, gitster@pobox.com, madcoder@debian.org,
	Julian Andres Klode <jak@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 12:38:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaiCD-0002pZ-3p
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 12:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbbILKhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 06:37:47 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34706 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbILKhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 06:37:46 -0400
Received: by wicfx3 with SMTP id fx3so88878695wic.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fYuS7fqlBBfZ3fYdesHVfiz7hI9m4YGvr2FB/kZBhrE=;
        b=teyu7a912amCuuiUwbBiEZpr7fn4f/wxbUn4DRjrbKDm1L/+6b/iANHTfA86hJ3DpE
         bycu2dsj8SN2JLsgiTbShdc6oyCNBQIgrM8oEetGXIFHJgFI3dT/E+IHEV0L+3MhcoYN
         viCgSF/W06EtcXdaxE2BntFHToZEEnSaR5j+ZB5301UK1fINU8ZAV5chb4tWWt4pokOT
         4tOfBBN76mKjkUcg91rw2O5xQ6f7xtN7fNKdXhyK3W72lRfqANeXt2S+8SPDxTV7ngqd
         0zQTxOHy32lWEehDvNPrYqGCFOTmruNpWB9lYqKDNIhbhbusNj1/7wFBbXW0PnKefOgZ
         6v1w==
X-Received: by 10.194.109.97 with SMTP id hr1mr6627997wjb.38.1442054265346;
        Sat, 12 Sep 2015 03:37:45 -0700 (PDT)
Received: from jak-x230 (p54B926B6.dip0.t-ipconnect.de. [84.185.38.182])
        by smtp.gmail.com with ESMTPSA id fs2sm3666980wib.12.2015.09.12.03.37.44
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Sep 2015 03:37:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277722>

Introduce an option to deny unsigned tags from entering
a repository. This is useful in teams where members forget
to sign their release tags.

It does not actually check whether the signature is actually
complete or valid, it just checks for the beginning of a
signature, as further checks would be too involved.

This effectively also denies un-annotated tags, as those
are unsigned by definition.

Signed-off-by: Julian Andres Klode <jak@debian.org>
---
 templates/hooks--update.sample | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index d847583..5a0460f 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -16,6 +16,9 @@
 # hooks.allowmodifytag
 #   This boolean sets whether a tag may be modified after creation. By default
 #   it won't be.
+# hooks.denyunsignedtag
+#   This boolean sets whether creating unsigned tags will be denied. By
+#   default this is allowed.
 # hooks.allowdeletebranch
 #   This boolean sets whether deleting branches will be allowed in the
 #   repository.  By default they won't be.
@@ -48,6 +51,7 @@ allowdeletebranch=$(git config --bool hooks.allowdeletebranch)
 denycreatebranch=$(git config --bool hooks.denycreatebranch)
 allowdeletetag=$(git config --bool hooks.allowdeletetag)
 allowmodifytag=$(git config --bool hooks.allowmodifytag)
+denyunsignedtag=$(git config --bool hooks.denyunsignedtag)
 
 # check for no description
 projectdesc=$(sed -e '1q' "$GIT_DIR/description")
@@ -71,7 +75,7 @@ case "$refname","$newrev_type" in
 	refs/tags/*,commit)
 		# un-annotated tag
 		short_refname=${refname##refs/tags/}
-		if [ "$allowunannotated" != "true" ]; then
+		if [ "$allowunannotated" != "true" ] || [ "$denyunsignedtag" = "true" ]; then
 			echo "*** The un-annotated tag, $short_refname, is not allowed in this repository" >&2
 			echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
 			exit 1
@@ -86,6 +90,14 @@ case "$refname","$newrev_type" in
 		;;
 	refs/tags/*,tag)
 		# annotated tag
+		if [ "$denyunsignedtag" != "true" ] || git cat-file -p $newrev | grep -q 'BEGIN PGP SIGNATURE'; then
+			:
+		else
+			echo "*** Tag '$refname' is unsigned"
+			echo "*** Unsigned tags are not allowed in this repository." >&2
+	                exit 1
+		fi
+
 		if [ "$allowmodifytag" != "true" ] && git rev-parse $refname > /dev/null 2>&1
 		then
 			echo "*** Tag '$refname' already exists." >&2
-- 
2.5.1
