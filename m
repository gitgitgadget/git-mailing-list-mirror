From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 4/4] submodule: support superproject origin URLs of the form foo/bar
Date: Mon, 21 May 2012 23:31:42 +1000
Message-ID: <1337607102-14737-4-git-send-email-jon.seymour@gmail.com>
References: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 15:32:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWSim-0006D0-Fs
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 15:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533Ab2EUNcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 09:32:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50612 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab2EUNcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 09:32:12 -0400
Received: by dady13 with SMTP id y13so6816640dad.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w2e2nv4sx5bc1vaMK2qTOIe7E0UQ4eXaLk3sTzCri2o=;
        b=ELNstdWquki6RDzyll3KLU65a1HBdYrwtZh01aART8We/RcDcar2jUpWJncI/iaOFd
         fa4f5v5Ka7V+0KNPC3cURBLZga/KKo3oXIoO9uaq8hC5rBHpsLybf4y3ITDrZk7z0/ER
         AaEwORrOLCIJF+xJbaeQ1GTcP5vigG/qa7TpSS4Cmp2eWHjQ/jlAv5Clwe4Q9QEUyjkR
         cO48sn0oACBhTzFcjJRtzh6O0FiAprAdwcpT5l4FBQpkZjdr/FvjzzFTHnwUI3HVnFst
         3xQqOWk+2acUUkf+uhXgOIYvCaHp0PSD9Sqp3ZGchzxfzjza5SOqY1jDj2bz4f12cXTy
         srzg==
Received: by 10.68.224.103 with SMTP id rb7mr17530639pbc.23.1337607132278;
        Mon, 21 May 2012 06:32:12 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([110.173.237.195])
        by mx.google.com with ESMTPS id wi8sm23153721pbc.11.2012.05.21.06.32.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 06:32:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.594.g5c52315
In-Reply-To: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198104>

When the origin URL of a superproject is of the form foo/bar, submodule
operations such as add, sync or init will configure the URL of any
submodule with an origin URL that points at the incorrect location.

Origin URLs of this form are not expected in most cases, since
the origin URL of a repo will usually point to a location that is not
nested within the current working tree.

However, the situation can arise when the physical location
of an upstream repo is managed with a symbolic link nested within
the working tree itself.

For example, suppose that a toolset is installed in ~/tools and
~/tools/mnt/usb is a occasionally used as the origin for a refresh of the
toolset. Different users with different USB devices may map ~/tools/mnt/usb
to a different subdirectory of /media, but the auto-update function of the
toolset may simply pull an update from mnt/usb, assuming that the user has
done what is required to initialise mnt/usb to refer to the correct subdirectory
of /media.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           | 2 ++
 t/t7400-submodule-basic.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 230c219..b8a7403 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -37,6 +37,7 @@ resolve_relative_url ()
 	remoteurl=$(git config "remote.$remote.url") ||
 		remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
+	remoteurl=$(echo "$remoteurl" | sed "s|^[^/][^:]*\$|./&|")
 	remoteurl=${remoteurl%/}
 	sep=/
 	while test -n "$url"
@@ -47,6 +48,7 @@ resolve_relative_url ()
 			case "$remoteurl" in
 			.*/*)
 				up_path="$(echo "$2" | sed "s/[^/]*/../g")"
+				remoteurl=${remoteurl#./}
 				remoteurl="${up_path%/}/${remoteurl%/*}"
 				;;
 			*/*)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 71f30d8..a4a8363 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -533,7 +533,7 @@ test_expect_sucess 'test that submodule add creates the correct url when super o
 		test "$(git config submodule.sub.url)" = ../../relative/subrepo
 	)
 '
-test_expect_failure 'test that submodule add creates the correct url when super origin url is relative/repo' '
+test_expect_success 'test that submodule add creates the correct url when super origin url is relative/repo' '
 	mkdir reladd &&
 	(
 		cd reladd &&
-- 
1.7.10.2.594.g5c52315
