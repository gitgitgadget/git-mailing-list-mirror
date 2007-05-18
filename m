From: skimo@liacs.nl
Subject: [PATCH 14/16] git-clone: rely on git-fetch for non-bare fetching over http
Date: Fri, 18 May 2007 21:25:03 +0200
Message-ID: <11795163074010-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:26:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp85g-0002Yo-DH
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653AbXERTZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758509AbXERTZl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:41 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55770 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030AbXERTZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:27 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPIiV005212;
	Fri, 18 May 2007 21:25:23 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 9E00D7DDAD; Fri, 18 May 2007 21:25:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47651>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 git-clone.sh |    6 +++---
 git-fetch.sh |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 44127c5..44387f4 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -262,8 +262,8 @@ yes,yes)
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 	;;
 *)
-	case "$repo" in
-	rsync://*)
+	case "$bare,$repo" in
+	*,rsync://*)
 		case "$depth" in
 		"") ;;
 		*) die "shallow over rsync not supported" ;;
@@ -295,7 +295,7 @@ yes,yes)
 		fi
 		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 		;;
-	https://*|http://*|ftp://*)
+	yes,https://*|yes,http://*|yes,ftp://*)
 		case "$depth" in
 		"") ;;
 		*) die "shallow over http or ftp not supported" ;;
diff --git a/git-fetch.sh b/git-fetch.sh
index e169848..84c2523 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -237,11 +237,31 @@ fetch_all_at_once () {
 
 }
 
+http_fetch () {
+	if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+		curl_extra_args="-k"
+	fi
+	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
+		"`git-config --bool http.noEPSV`" = true ]; then
+		curl_extra_args="${curl_extra_args} --disable-epsv"
+	fi
+
+	# $1 = Remote, $2 = Local
+	curl -nsfL $curl_extra_args "$1" >"$2"
+}
+
 fetch_per_ref () {
   reflist="$1"
   refs=
   rref=
 
+    if test -n "$all"; then
+	reflist=$(canon_refs_list_for_fetch -d "$remote_nick" \
+			"+refs/heads/*:refs/remotes/$remote_nick/*")
+	http_fetch "$remote/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
+	rm -f "$GIT_DIR/REMOTE_HEAD"
+    fi
+
   for ref in $reflist
   do
       refs="$refs$LF$ref"
-- 
1.5.2.rc3.783.gc7476-dirty
