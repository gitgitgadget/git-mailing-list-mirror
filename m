From: Julian Andres Klode <jak@debian.org>
Subject: [PATCH] hooks/update: Add a hooks.denyunsignedtags option
Date: Mon, 21 Dec 2015 18:32:04 +0100
Message-ID: <1450719124-10558-1-git-send-email-jak@debian.org>
Cc: git@vger.kernel.org, Julian Andres Klode <jak@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 21 18:32:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB4K7-0003ij-5h
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 18:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbbLURcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 12:32:36 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34225 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbLURcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 12:32:33 -0500
Received: by mail-wm0-f52.google.com with SMTP id l126so77991962wml.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HoWehhNx6UrcsLl3lbaXyz+M5ZWO3f/DLkaihvcuwVI=;
        b=lxxhhe4LzGbjiuF0pdflv0ciiT7S/Qn+LuxYvPQPaAt7WUd7yafrrzn9oD+WI4kol2
         ORBgBEZztZbMA4YPYw36LaGU02ZMgEBduEmnRtLGY8J/E5P+jhOjTomB3n7+rkn9pd5N
         zQ86IYGkZdG8srGGn+EHJzWDcc+8w9Mj4OpoChHUXG8m0OQj0TLKgPK9pMZJ9WhtqiuJ
         ZThc+nF79oAV3ICgEuqb+NXEejD2JZ6Xw8o2GdyG+1aFs8YHh7rixFA4Tr7sXnsvcyuh
         yJeA47xObcsnEXz9VcZTp5kl2wcvjU6cbBYqY3asrRGkb+tKtKBFruOE/5SrEccW/t6C
         f/4g==
X-Received: by 10.194.203.99 with SMTP id kp3mr22423662wjc.3.1450719151635;
        Mon, 21 Dec 2015 09:32:31 -0800 (PST)
Received: from jak-x230 (p54B91CDB.dip0.t-ipconnect.de. [84.185.28.219])
        by smtp.gmail.com with ESMTPSA id e136sm21017524wma.23.2015.12.21.09.32.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Dec 2015 09:32:31 -0800 (PST)
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282803>

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

Note: Submitted for review on Sep 12, re-asked on Sep 22, but
no feedback, so I assume it's good to go, see
http://thread.gmane.org/gmane.comp.version-control.git/277722
for details

 templates/hooks--update.sample | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index d847583..e261d30 100755
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
+			exit 1
+		fi
+
 		if [ "$allowmodifytag" != "true" ] && git rev-parse $refname > /dev/null 2>&1
 		then
 			echo "*** Tag '$refname' already exists." >&2
-- 
2.6.4
