From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 6/9] submodule: fix detection of invalid submodule URL
Date: Mon, 28 May 2012 01:34:08 +1000
Message-ID: <1338132851-23497-7-git-send-email-jon.seymour@gmail.com>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 17:36:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYfVs-0006Ww-1X
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 17:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab2E0PfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 11:35:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59885 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab2E0Peo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 11:34:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3669135pbb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w7iuDJDYSRT42tVf3UbRpCRHH26GJB9e5n234nayy14=;
        b=mOurYR4Oqaf6/SYqEtdKq+KrSp1x5s1JFKzIGGr0EVegtv7gbBalJJGXDRWWBKn+oO
         MOvxtMjYJR0dc+BxtGTAkw3MPDZjIttERtmoyNc6YAEu8zs3bM+pLQ1NrQQd/S8ZxbxP
         +bONbkk1bZ6Ur1JgfN2EH/xhiwgyoQadBT0xbzIGBZ9q3vmA3wODlk/rm3hFtpQQamSG
         tn1Bu+DC0jF7hV1MZYfGAtf2rvGqM9d1biGb7ThF9RqWbuJw9+35eyCp96h2qIm1tFsp
         jpVCz1asjzJuQCbeQMmXtAAjBvhPQc/PeORTpRJF0g4lbyOFO3naSJN9RdvhiHnhUX6V
         aG1w==
Received: by 10.68.201.73 with SMTP id jy9mr18325797pbc.19.1338132884609;
        Sun, 27 May 2012 08:34:44 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id rk4sm16128261pbc.48.2012.05.27.08.34.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 08:34:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.g24a6219
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198607>

Currently the superproject origin URL is progressively transformed
by stepping through parts of the submodule URL and removing parts
from the superproject URL for each leading ../ found in the
submodule URL. No attempt is made to check that the edited URL still
has a path part left to remove. This can result in the construction
of an absolute submodule URL where the hostname part of the URL
has been replaced by path components of the submodule URL.

For example: if the origin URL is ssh://hostname/repo and the
submodule URL is ../../subrepo, then the origin URL of the subrepo
will be calculated as ssh://subrepo.

With this change, editing is only performed on the path part
of the superproject origin URL. Any attempt by to consume the
non-path parts of the origin URL results in a failure.

As a side effect of preserving correct handling of support for
URLs of the form user@host:repo, this change also fixes handling,
by submodule init, of origin super project URLs of the form:
foo, foo/bar, ./foo and ./foo/bar.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-submodule.sh           | 41 ++++++++++++++++++++++++++++++++---------
 t/t7400-submodule-basic.sh | 23 ++++++++---------------
 2 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index dbbc905..2550681 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -37,23 +37,42 @@ resolve_relative_url ()
 	remoteurl=$(git config "remote.$remote.url") ||
 		remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
-	remoteurl=${remoteurl%/}
-	sep=/
+	remoteurl="${remoteurl%/}"
+
+	case "$remoteurl" in
+		*//*/*)
+			variant="${remoteurl#*//*/}"
+		;;
+		*::*)
+			variant="${remoteurl#*::}"
+		;;
+		*:*)
+			variant="${remoteurl#*:}"
+		;;
+		/*)
+			variant="${remoteurl#/}"
+		;;
+		*)
+			variant="${remoteurl}"
+		;;
+	esac
+	invariant="${remoteurl%$variant}"
+
 	while test -n "$url"
 	do
 		case "$url" in
 		../*)
 			url="${url#../}"
-			case "$remoteurl" in
+			case "$variant" in
 			*/*)
-				remoteurl="${remoteurl%/*}"
+				variant="${variant%/*}"
 				;;
-			*:*)
-				remoteurl="${remoteurl%:*}"
-				sep=:
+			.)
+				die "$(eval_gettext "cannot strip one component off url '\${invariant}'")"
 				;;
 			*)
-				die "$(eval_gettext "cannot strip one component off url '\$remoteurl'")"
+				# add a sentinel when .. matchs foo
+				variant=.
 				;;
 			esac
 			;;
@@ -64,7 +83,11 @@ resolve_relative_url ()
 			break;;
 		esac
 	done
-	echo "$remoteurl$sep${url%/}"
+	# ensure a trailing path separator
+	variant="${variant}/"
+	# strip the sentinel, if present
+	variant="${variant#./}"
+	echo "$invariant$variant${url%/}"
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2674088..a94c5e9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -576,7 +576,7 @@ test_expect_success '../subrepo works with helper URL- helper:://hostname/repo'
 	)
 '
 
-test_expect_failure '../../subrepo fails with URL - ssh://hostname/repo' "
+test_expect_success '../../subrepo fails with URL - ssh://hostname/repo' "
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -585,12 +585,11 @@ test_expect_failure '../../subrepo fails with URL - ssh://hostname/repo' "
 		git config -f .gitmodules submodule.sub.url ../../subrepo &&
 		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
 		test_must_fail git submodule init 2>actual &&
-		#actual no failure, url configured as ssh://subrepo
 		test_cmp expected actual
 	)
 "
 
-test_expect_failure '../../subrepo fails with absolute local path - /repo' "
+test_expect_success '../../subrepo fails with absolute local path - /repo' "
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -603,7 +602,7 @@ test_expect_failure '../../subrepo fails with absolute local path - /repo' "
 	)
 "
 
-test_expect_failure '../../../subrepo fails with URL - ssh://hostname/repo' "
+test_expect_success '../../../subrepo fails with URL - ssh://hostname/repo' "
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -612,12 +611,11 @@ test_expect_failure '../../../subrepo fails with URL - ssh://hostname/repo' "
 		git config -f .gitmodules submodule.sub.url ../../../subrepo &&
 		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
 		test_must_fail git submodule init 2>actual &&
-		#actual no failure, url configured as ssh:/subrepo
 		test_cmp expected actual
 	)
 "
 
-test_expect_failure '../../../../subrepo fails with with URL - ssh://hostname/repo' "
+test_expect_success '../../../../subrepo fails with with URL - ssh://hostname/repo' "
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -626,12 +624,11 @@ test_expect_failure '../../../../subrepo fails with with URL - ssh://hostname/re
 		git config -f .gitmodules submodule.sub.url ../../../../subrepo &&
 		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
 		test_must_fail git submodule init 2>actual &&
-		#actual no failure, url configured as ssh:/subrepo
 		test_cmp expected actual
 	)
 "
 
-test_expect_failure '../../../../../subrepo fails with URL - ssh://hostname/repo' "
+test_expect_success '../../../../../subrepo fails with URL - ssh://hostname/repo' "
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
@@ -640,7 +637,6 @@ test_expect_failure '../../../../../subrepo fails with URL - ssh://hostname/repo
 		git config -f .gitmodules submodule.sub.url ../../../../../subrepo &&
 		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
 		test_must_fail git submodule init 2>actual &&
-		#actual cannot strip one component off url 'ssh'
 		test_cmp expected actual
 	)
 "
@@ -711,13 +707,12 @@ test_expect_failure 'relative path works with user@host:path/to/detour/../repo'
 	)
 '
 
-test_expect_failure '../subrepo works with relative local path - foo' '
+test_expect_success '../subrepo works with relative local path - foo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		git config remote.origin.url foo &&
-		# actual: fails with an error
 		git submodule init &&
 		test "$(git config submodule.sub.url)" = subrepo
 	)
@@ -734,26 +729,24 @@ test_expect_success '../subrepo works with relative local path - foo/bar' '
 	)
 '
 
-test_expect_failure '../subrepo works with relative local path - ./foo' '
+test_expect_success '../subrepo works with relative local path - ./foo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		git config remote.origin.url ./foo &&
 		git submodule init &&
-		#actual ./subrepo
 		test "$(git config submodule.sub.url)" = subrepo
 	)
 '
 
-test_expect_failure '../subrepo works with relative local path - ./foo/bar' '
+test_expect_success '../subrepo works with relative local path - ./foo/bar' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
 		cp pristine-.gitmodules .gitmodules &&
 		git config remote.origin.url ./foo/bar &&
 		git submodule init &&
-		#actual: ./foo/subrepo
 		test "$(git config submodule.sub.url)" = foo/subrepo
 	)
 '
-- 
1.7.10.2.656.g24a6219
