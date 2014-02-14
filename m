From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 4/9] am: add the --gpg-sign option
Date: Fri, 14 Feb 2014 19:51:48 +0000
Message-ID: <1392407513-37443-5-git-send-email-sandals@crustytoothpaste.net>
References: <1392407513-37443-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 20:52:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOnu-0002dg-PQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbaBNTwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:52:01 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51927 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752788AbaBNTwA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 14:52:00 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F208E28085;
	Fri, 14 Feb 2014 19:51:58 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <1392407513-37443-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242128>

From: Nicolas Vigier <boklm@mars-attacks.org>

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-am.txt | 6 +++++-
 git-am.sh                | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 54d8461..17924d0 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
-	 [--[no-]scissors]
+	 [--[no-]scissors] [-S[<keyid>]]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
@@ -119,6 +119,10 @@ default.   You can use `--no-utf8` to override this.
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commits.
+
 --continue::
 -r::
 --resolved::
diff --git a/git-am.sh b/git-am.sh
index 020abf6..78517f2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -38,6 +38,7 @@ abort           restore the original branch and abort the patching operation.
 committer-date-is-author-date    lie about committer date
 ignore-date     use current timestamp for author date
 rerere-autoupdate update the index with reused conflict resolution if possible
+S,gpg-sign?     GPG-sign commits
 rebasing*       (internal use for git-rebase)"
 
 . git-sh-setup
@@ -375,6 +376,7 @@ git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
+gpg_sign_opt=
 
 if test "$(git config --bool --get am.keepcr)" = true
 then
@@ -436,6 +438,10 @@ it will be removed. Please do not use it anymore."
 		keepcr=t ;;
 	--no-keep-cr)
 		keepcr=f ;;
+	--gpg-sign)
+		gpg_sign_opt=-S ;;
+	--gpg-sign=*)
+		gpg_sign_opt="-S${1#--gpg-sign=}" ;;
 	--)
 		shift; break ;;
 	*)
@@ -900,7 +906,8 @@ did you forget to use 'git add'?"
 			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
 			export GIT_COMMITTER_DATE
 		fi &&
-		git commit-tree $tree ${parent:+-p} $parent <"$dotest/final-commit"
+		git commit-tree ${parent:+-p} $parent ${gpg_sign_opt:+"$gpg_sign_opt"} $tree  \
+			<"$dotest/final-commit"
 	) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $FIRSTLINE" HEAD $commit $parent ||
 	stop_here $this
-- 
1.9.0.rc3.1008.gd08b47c.dirty
