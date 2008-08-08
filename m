From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-am: ignore --binary option
Date: Sat,  9 Aug 2008 01:28:54 +0200
Message-ID: <1218238134-14231-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 09 01:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRbPI-0000zS-E6
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 01:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbYHHX3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 19:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbYHHX3A
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 19:29:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:58752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754393AbYHHX27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 19:28:59 -0400
Received: (qmail invoked by alias); 08 Aug 2008 23:28:58 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp024) with SMTP; 09 Aug 2008 01:28:58 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19qQAwhYZFqBHQtmwcSav30nwooqw9+dI5ZQBXdpa
	NgzZz47L0hvn9K
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KRbOA-0003hv-RP; Sat, 09 Aug 2008 01:28:54 +0200
X-Mailer: git-send-email 1.6.0.rc0.49.gd39f
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91726>

The git-apply documentation says that --binary is a historical option.
This patch lets git-am ignore --binary and removes advertisements of this
option.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-am.sh                |   19 +++++++------------
 t/t0023-crlf-am.sh       |    2 +-
 Documentation/git-am.txt |    7 +------
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 8f91a97..aa60261 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -10,7 +10,7 @@ git am [options] (--resolved | --skip | --abort)
 --
 d,dotest=       (removed -- do not use)
 i,interactive   run interactively
-b,binary        pass --allow-binary-replacement to git-apply
+b,binary        (historical option -- no-op)
 3,3way          allow fall back on 3way merging if needed
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
@@ -87,7 +87,7 @@ fall_back_3way () {
 
     echo Using index info to reconstruct a base tree...
     if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-	git apply $binary --cached <"$dotest/patch"
+	git apply --cached <"$dotest/patch"
     then
 	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
 	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
@@ -121,7 +121,7 @@ It does not apply to blobs recorded in its index."
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= binary= rebasing= abort=
+sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -131,7 +131,7 @@ do
 	-i|--interactive)
 		interactive=t ;;
 	-b|--binary)
-		binary=t ;;
+		: ;;
 	-3|--3way)
 		threeway=t ;;
 	-s|--signoff)
@@ -149,7 +149,7 @@ do
 	--abort)
 		abort=t ;;
 	--rebasing)
-		rebasing=t threeway=t keep=t binary=t ;;
+		rebasing=t threeway=t keep=t ;;
 	-d|--dotest)
 		die "-d option is no longer supported.  Do not use."
 		;;
@@ -247,10 +247,9 @@ else
 		exit 1
 	}
 
-	# -b, -s, -u, -k and --whitespace flags are kept for the
+	# -s, -u, -k and --whitespace flags are kept for the
 	# resuming session after a patch failure.
 	# -3 and -i can and must be given when resuming.
-	echo "$binary" >"$dotest/binary"
 	echo " $ws" >"$dotest/whitespace"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
@@ -274,10 +273,6 @@ case "$resolved" in
 	fi
 esac
 
-if test "$(cat "$dotest/binary")" = t
-then
-	binary=--allow-binary-replacement
-fi
 if test "$(cat "$dotest/utf8")" = t
 then
 	utf8=-u
@@ -459,7 +454,7 @@ do
 
 	case "$resolved" in
 	'')
-		git apply $git_apply_opt $binary --index "$dotest/patch"
+		git apply $git_apply_opt --index "$dotest/patch"
 		apply_status=$?
 		;;
 	t)
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index c45c53e..b9c6fac 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
-         [--3way] [--interactive] [--binary]
+	 [--3way] [--interactive]
          [--whitespace=<option>] [-C<n>] [-p<n>]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
@@ -59,11 +59,6 @@ default.   You could use `--no-utf8` to override this.
 	it is supposed to apply to, and we have those blobs
 	available locally.
 
--b::
---binary::
-	Pass `--allow-binary-replacement` flag to 'git-apply'
-	(see linkgit:git-apply[1]).
-
 --whitespace=<option>::
 	This flag is passed to the 'git-apply' (see linkgit:git-apply[1])
 	program that applies
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index 6f8a434..aaed725 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -36,7 +36,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'am' '
 
-	git am --binary -3 <patchfile &&
+	git am -3 <patchfile &&
 	git diff-files --name-status --exit-code
 
 '
-- 
1.6.0.rc0.49.gd39f
