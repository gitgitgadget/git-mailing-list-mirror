From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] mergetool: fix running mergetool in sub-directories
Date: Fri, 30 Jan 2009 23:20:11 +0000
Message-ID: <1233357611-31820-2-git-send-email-charles@hashpling.org>
References: <1233357611-31820-1-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org,
	=?utf-8?q?Jonas=20Flod=C3=A9n?= <jonas.floden@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 00:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT2gV-0001c6-8b
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 00:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbZA3XUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755885AbZA3XUY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 18:20:24 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:21538 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100AbZA3XUX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 18:20:23 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEADAag0nUnw4T/2dsb2JhbADKP4QQBg
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.ptn-ipout02.plus.net with ESMTP; 30 Jan 2009 23:20:21 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1LT2eq-0005rS-VQ; Fri, 30 Jan 2009 23:20:21 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0UNKCin031866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 23:20:12 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0UNKBb4031862;
	Fri, 30 Jan 2009 23:20:11 GMT
X-Mailer: git-send-email 1.6.1.235.gc9d403
In-Reply-To: <1233357611-31820-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: d75fe855849edf1c79f0d82ef3272d2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107886>

The previous fix to mergetool to use checkout-index instead of cat-file
broke running mergetool anywhere except the root of the repository.

This fixes it by using the correct relative paths for temporary files
and index paths.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 git-mergetool.sh     |    9 ++++-----
 t/t7610-mergetool.sh |    2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index aefdca7..87fa88a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -13,7 +13,6 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
-prefix=$(git rev-parse --show-prefix)
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
@@ -131,7 +130,7 @@ checkout_staged_file () {
     tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
 
     if test $? -eq 0 -a -n "$tmpfile" ; then
-	mv -- "$tmpfile" "$3"
+	mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
     fi
 }
 
@@ -161,9 +160,9 @@ merge_file () {
     local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
     remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && checkout_staged_file 1 "$prefix$MERGED" "$BASE"
-    local_present  && checkout_staged_file 2 "$prefix$MERGED" "$LOCAL"
-    remote_present && checkout_staged_file 3 "$prefix$MERGED" "$REMOTE"
+    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
+    local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
+    remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$MERGED':"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index ee8589e..e768c3e 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -66,7 +66,7 @@ test_expect_success 'mergetool crlf' '
     git reset --hard
 '
 
-test_expect_failure 'mergetool in subdir' '
+test_expect_success 'mergetool in subdir' '
     git checkout -b test3 branch1
     cd subdir && (
     test_must_fail git merge master >/dev/null 2>&1 &&
-- 
1.6.1.235.gc9d403
