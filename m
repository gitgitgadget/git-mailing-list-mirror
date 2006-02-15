From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Print an error if cloning a http repo and NO_CURL is set
Date: Wed, 15 Feb 2006 12:37:30 +0100
Message-ID: <20060215113730.GA12092@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 15 12:37:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Kyc-0005gQ-UH
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 12:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbWBOLhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 06:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945908AbWBOLhj
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 06:37:39 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:61573
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1945913AbWBOLhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 06:37:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 3B5A38D35D;
	Wed, 15 Feb 2006 12:37:21 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02693-02; Wed, 15 Feb 2006 12:37:18 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 23C848D30C;
	Wed, 15 Feb 2006 12:37:16 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Wed, 15 Feb 2006 12:37:31 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16237>

If Git is compiled with NO_CURL=YesPlease and one tries to
clone a http repository, git-clone tries to call the curl
binary. This trivial patch prints an error instead in such
situation.

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>

---

 Makefile     |    1 +
 git-clone.sh |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

896d96a92a13848ccce19c2f3dee9b5570ef02a7
diff --git a/Makefile b/Makefile
index d40aa6a..648469e 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.
 	rm -f $@
 	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    $@.sh >$@
 	chmod +x $@
 
diff --git a/git-clone.sh b/git-clone.sh
index 47f3ec9..e192b08 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -206,7 +206,13 @@ yes,yes)
 		fi
 		;;
 	http://*)
-		clone_dumb_http "$repo" "$D"
+		if test -z "@@NO_CURL@@"
+		then
+			clone_dumb_http "$repo" "$D"
+		else
+			echo >&2 "http transport not supported, rebuild Git with curl support"
+			exit 1
+		fi
 		;;
 	*)
 		cd "$D" && case "$upload_pack" in
-- 
1.2.0
