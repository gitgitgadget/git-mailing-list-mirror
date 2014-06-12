From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] git-am: support any number of signatures
Date: Thu, 12 Jun 2014 19:12:35 +0300
Message-ID: <1402589505-27632-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 18:12:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv7bs-0002dx-UZ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 18:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbaFLQMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 12:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbaFLQMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 12:12:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5CGC6aL023918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 12 Jun 2014 12:12:07 -0400
Received: from redhat.com (ovpn-116-16.ams2.redhat.com [10.36.116.16])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5CGC508015417
	for <git@vger.kernel.org>; Thu, 12 Jun 2014 12:12:05 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251412>

I'm using different signature tags for git am depending on the patch,
project and other factors.

Sometimes I add multiple tags as well, e.g. QEMU
wants both Reviewed-by and Signed-off-by tags.

This patch makes it easy to do so:
1.  new parameter am.signoff can be used any number
	of times:

[am]
	signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
	signoff = "Signed-off-by: Michael S. Tsirkin <mst@redhat.com>"

	if set all signatures are picked up when git am -s is used.

2.  Any number of alternative signatures

[am "a"]
	signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"

	if set the signature type can be specified by passing
	a parameter to the -s flag:

	git am -sa

No docs or tests, sorry, so not yet ready for master, but I'm using this
all the time without any issues so maybe ok for pu.
Early flames/feedback/help welcome.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-am.sh | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ee61a77..e992c34 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -13,7 +13,7 @@ i,interactive   run interactively
 b,binary*       (historical option -- no-op)
 3,3way          allow fall back on 3way merging if needed
 q,quiet         be quiet
-s,signoff       add a Signed-off-by line to the commit message
+s,signoff?      add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 keep-non-patch  pass -b flag to git-mailinfo
@@ -136,7 +136,7 @@ fall_back_3way () {
     eval "$cmd" &&
     GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
     git write-tree >"$dotest/patch-merge-base+" ||
-    cannot_fallback "$(gettext "Repository lacks necessary blobs to fall back on 3-way merge.")"
+    cannot_fallback "$(gettext "Repository lsignoffs necessary blobs to fall back on 3-way merge.")"
 
     say "$(gettext "Using index info to reconstruct a base tree...")"
 
@@ -383,6 +383,7 @@ then
     keepcr=t
 fi
 
+signoffs=
 while test $# != 0
 do
 	case "$1" in
@@ -394,8 +395,15 @@ it will be removed. Please do not use it anymore."
 		;;
 	-3|--3way)
 		threeway=t ;;
-	-s|--signoff)
-		sign=t ;;
+	--signoff)
+		sign=t
+		s=$(git config --get-all am.signoff)
+		signoffs=("${signoffs[@]}" "${s[@]}") ;;
+	--signoff=*)
+		sign=t
+		a="${1#--signoff=}"
+		s=$(git config --get-all am."${a}".signoff)
+		signoffs=("${signoffs[@]}" "${s[@]}") ;;
 	-u|--utf8)
 		utf8=t ;; # this is now default
 	--no-utf8)
@@ -644,14 +652,25 @@ fi
 git_apply_opt=$(cat "$dotest/apply-opt")
 if test "$(cat "$dotest/sign")" = t
 then
-	SIGNOFF=$(git var GIT_COMMITTER_IDENT | sed -e '
-			s/>.*/>/
-			s/^/Signed-off-by: /'
-		)
+	for ack in "${signoffs[@]}"; do
+		if test "$SIGNOFF"
+		then
+			SIGNOFF="$SIGNOFF\n$ack"
+		else
+			SIGNOFF="$ack"
+		fi
+	done
+	if test -z "$SIGNOFF"
+	then
+		SIGNOFF=$(git var GIT_COMMITTER_IDENT | sed -e '
+				s/>.*/>/
+				s/^/Signed-off-by: /'
+			)
+	fi
 else
 	SIGNOFF=
 fi
 
 last=$(cat "$dotest/last")
 this=$(cat "$dotest/next")
 if test "$skip" = t
-- 
MST
