From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - register module url if adding in place
Date: Mon,  7 Jul 2008 22:37:10 -0400
Message-ID: <1215484630-3784-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 04:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG35u-0003H0-Ea
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 04:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbYGHChN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 22:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbYGHChN
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 22:37:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:22542 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbYGHChM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 22:37:12 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1095276ywe.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 19:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2/4fox2bGwKtp+B9iun13CoDQLSZk90cui/7SBRLbvc=;
        b=OTOyoQ7Ka54K5pW3iKZcJxf2o4170bLBiZ+ScEzUuQ/64N3RvSOhjwkGVaBt0mKaQI
         5DAkEEfdDr73YnGkPLaRaGaJ36Imb2nHWn1SnovRQFGju7VooUlcNqwlJMGQoM5SMajH
         yJ8ZsgRpBeva8456LKH8nRJEmWiKGznofUa88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=q8thnPC7ZnPAw35Ic3Qcdnzw1ShskWo3Ya/saseIUf5cLnEeOlMIS5eQBYztUWxk4i
         zgn6oHMogVstP/MgKoWots/+BVRQ8B1KP9GyC7MIw1Ssu5R/i5tgmWPhgPttxJpFhvg1
         B6EhxCXXQ1uWJAZt0W/pKWpj81BY9yQD7X8+A=
Received: by 10.150.205.13 with SMTP id c13mr9328991ybg.239.1215484631723;
        Mon, 07 Jul 2008 19:37:11 -0700 (PDT)
Received: from localhost.localdomain ( [71.246.235.165])
        by mx.google.com with ESMTPS id 9sm1125682yws.5.2008.07.07.19.37.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 19:37:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.271.g73ad8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87688>

When adding a new submodule in place, meaning the user created the
submodule as a git repo in the tree first, we don't go through
git submodule init to register the module. Thus, the url is
not stored in .git/config, and no git operation will ever do so. In
this case, assume the url the user supplies to git add is the one
that should be registered, and do so.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 099a7d7..7525922 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -173,6 +173,16 @@ cmd_add()
 		else
 			die "'$path' already exists and is not a valid git repo"
 		fi
+
+		case "$repo" in
+		./*|../*)
+			url=$(resolve_relative_url "$repo") || exit
+		    ;;
+		*)
+			url="$repo"
+			;;
+		esac
+		git config submodule."$path".url "$url"
 	else
 		case "$repo" in
 		./*|../*)
-- 
1.5.6.2.271.g73ad8
