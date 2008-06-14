From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Fix errors regarding resolve_relative_url
Date: Sat, 14 Jun 2008 13:09:41 -0400
Message-ID: <1213463381-3316-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 19:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ZHP-000730-Ty
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 19:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYFNRKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 13:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbYFNRKF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 13:10:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:55713 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbYFNRJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 13:09:46 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1600084wxd.4
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rw9IgeP9dMP1p1POLchAFelgINT8U3X+82fswbQ9tyE=;
        b=cwm8F17iH8IX02/1emsE3DD8MvoQpc0nAlH3LdmEicmW0WoDFw2BuEUaE49ZLPxP1m
         dPU56Y2z7TBs1YL6r2+ThjGw7t66NOxlcKB6jHUNeEwL4bBLL+ulCmmu18/WLwOiejUH
         okoDnjTDz48rWeBUsUPY9ICdOnx6zTA/nbFBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BNj5OC3PfERUd+WXupggF7AosiJniggFQLWtomOwhwfzJj9PBp/huzfMbkd2IixATU
         0l4moR3QlgKpcNdmBRE7mB88bRY+yGP2dcZC+80I+jKjysq2bPdhh0SQ5xKcE1F4kihA
         cCTk12GU+7N0Tkv4HSQyQnolz8aDClRv6qMRg=
Received: by 10.70.62.14 with SMTP id k14mr4856037wxa.33.1213463385936;
        Sat, 14 Jun 2008 10:09:45 -0700 (PDT)
Received: from localhost.localdomain ( [71.191.242.223])
        by mx.google.com with ESMTPS id h18sm14398882wxd.6.2008.06.14.10.09.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 10:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc2.67.g19fe3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85024>

git-submodule was invoking "die" from within resolve-relative-url, but
this does not actually cause the script to exit. Fix this by returning
the error to the caller and have the caller exit.

While we're at it, clean up the quoting on invocation of
resolve_relative_url as it was wrong.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4bd2b8e..7cb4edf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -45,8 +45,10 @@ resolve_relative_url ()
 	branch="$(git symbolic-ref HEAD 2>/dev/null)"
 	remote="$(git config branch.${branch#refs/heads/}.remote)"
 	remote="${remote:-origin}"
-	remoteurl="$(git config remote.$remote.url)" ||
-		die "remote ($remote) does not have a url in .git/config"
+	remoteurl=$(git config remote.$remote.url) || {
+		echo >&2 "remote ($remote) does not have a url defined in .git/config"
+		return 1
+	}
 	url="$1"
 	while test -n "$url"
 	do
@@ -178,7 +180,8 @@ cmd_add()
 		case "$repo" in
 		./*|../*)
 			# dereference source url relative to parent's url
-			realrepo="$(resolve_relative_url $repo)" ;;
+			realrepo=$(resolve_relative_url "$repo") || exit 1
+			;;
 		*)
 			# Turn the source into an absolute path if
 			# it is local
@@ -246,7 +249,7 @@ cmd_init()
 		# Possibly a url relative to parent
 		case "$url" in
 		./*|../*)
-			url="$(resolve_relative_url "$url")"
+			url=$(resolve_relative_url "$url") || exit 1
 			;;
 		esac
 
-- 
1.5.6.rc2.67.g19fe3
