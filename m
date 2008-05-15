From: imyousuf@gmail.com
Subject: [PATCH] Use '-f' option to point to the .gitmodules file
Date: Thu, 15 May 2008 13:42:58 +0600
Message-ID: <1210837378-25668-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 09:44:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwY8k-00040m-BK
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 09:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbYEOHns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 03:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbYEOHnr
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 03:43:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:61137 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYEOHnq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 03:43:46 -0400
Received: by nf-out-0910.google.com with SMTP id d3so103652nfc.21
        for <git@vger.kernel.org>; Thu, 15 May 2008 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=fa94U8PUT184Vg2Xz/H9a76EaUx3fAePCw1A1RzooyE=;
        b=rlTdxGK0eEc5pmqmRA4O5UYqdWNJIa/pP+irSJoSCWnVUC8ZpWilMbbwqYg8RVCFzLXmEQRBhuRjre/Lrxe7JqUNC7ffgJjuWILIE7JRNp2tw9LwQLuJl2DnixAvE5WvN4pM157bwm2/7S408fhz/hgqIzNNcoJ3alTBXL69/bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kGad8D4ZFdhYCIf114da8hZNoTFwKANxthLc9RdvKhS2Q0gueBQcpeqeR1n0UAv325GlKoJZANI1P/jUGltjA1EAqUkPnvptiP1P0XnnGwiUJLnCwS/ZtWcoPgIO2bJ1mPBa6g9lhN3VpqF5SEbbDXrsQYZhcY8y2PXTACVozh4=
Received: by 10.210.25.20 with SMTP id 20mr1904762eby.46.1210837424511;
        Thu, 15 May 2008 00:43:44 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id g12sm3241967nfb.28.2008.05.15.00.43.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 May 2008 00:43:43 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82186>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

'git config' has a '-f' option that takes the file to parse.
Using it rather than the environment variable seems more logical
and simplified.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 67f7a28..b4b7d28 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -74,8 +74,7 @@ module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
 	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
-	name=$( GIT_CONFIG=.gitmodules \
-		git config --get-regexp '^submodule\..*\.path$' |
+	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
        test -z "$name" &&
        die "No submodule mapping found in .gitmodules for path '$path'"
@@ -198,8 +197,8 @@ cmd_add()
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
-	GIT_CONFIG=.gitmodules git config submodule."$path".path "$path" &&
-	GIT_CONFIG=.gitmodules git config submodule."$path".url "$repo" &&
+	git config -f .gitmodules submodule."$path".path "$path" &&
+	git config -f .gitmodules submodule."$path".url "$repo" &&
 	git add .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
@@ -240,7 +239,7 @@ cmd_init()
 		url=$(git config submodule."$name".url)
 		test -z "$url" || continue
 
-		url=$(GIT_CONFIG=.gitmodules git config submodule."$name".url)
+		url=$(git config -f .gitmodules submodule."$name".url)
 		test -z "$url" &&
 		die "No url found for submodule path '$path' in .gitmodules"
 
-- 
1.5.4.2
