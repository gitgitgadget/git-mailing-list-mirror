From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 3/3] fix corner case for relative submodule path calculation
Date: Tue, 13 Nov 2012 09:35:58 +0100
Message-ID: <20121113083558.GD38188@book.hvoigt.net>
References: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com> <20121108185643.GN15560@sigill.intra.peff.net> <20121109184225.GA1190@book.hvoigt.net> <20121113083233.GA38188@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Issues <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:36:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYByk-0005Sd-DC
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 09:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab2KMIgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 03:36:04 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:40759 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab2KMIgD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 03:36:03 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TYByR-0007cp-G5; Tue, 13 Nov 2012 09:35:59 +0100
Content-Disposition: inline
In-Reply-To: <20121113083233.GA38188@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209589>

A trailing /. for the superprojects origin is treated as
a full path component. This is wrong. Lets add a test and
fix this.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh           | 22 ++++++++++++++++++++++
 t/t7400-submodule-basic.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..9f61a9c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -69,6 +69,28 @@ resolve_relative_url ()
 		;;
 	esac
 
+	# strip one dot path components
+	tempurl="$remoteurl"
+	remoteurl=
+	sep=
+	while test -n "$tempurl"
+	do
+		case "$tempurl" in
+		*/.)
+			tempurl="${tempurl%/.}"
+			;;
+		?*/*)
+			remoteurl="${tempurl##*/}$sep$remoteurl"
+			tempurl="${tempurl%/*}"
+			sep=/
+		;;
+		*)
+			remoteurl="$tempurl$sep$remoteurl"
+			tempurl=
+			;;
+		esac
+	done
+
 	while test -n "$url"
 	do
 		case "$url" in
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 3c2afa6..1b4cc00 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -518,6 +518,50 @@ test_expect_success 'subrepo is NOT considered a relative path"' '
 	)
 '
 
+test_expect_success '../subrepo works with absolute local path - "$submodurl/repo/."' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url "$submodurl/repo/." &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = "$submodurl/subrepo"
+	)
+'
+
+test_expect_success '../subrepo works with absolute local path - "$submodurl/repo/./"' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url "$submodurl/repo/./" &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = "$submodurl/subrepo"
+	)
+'
+
+test_expect_success '../subrepo works with absolute local path - "$submodurl/./repo/."' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url "$submodurl/./repo/." &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = "$submodurl/subrepo"
+	)
+'
+
+test_expect_success '../subrepo works with absolute local path - "$submodurl/././repo/."' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url "$submodurl/././repo/." &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = "$submodurl/subrepo"
+	)
+'
+
 test_expect_success '../subrepo works with URL - ssh://hostname/repo' '
 	(
 		cd reltest &&
-- 
1.8.0.3.gaed4666
