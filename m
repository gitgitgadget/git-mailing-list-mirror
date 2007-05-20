From: skimo@liacs.nl
Subject: [PATCH 3/3] git-clone: rely on git-fetch for non-bare fetching over http
Date: Sun, 20 May 2007 19:57:45 +0200
Message-ID: <11796838663961-git-send-email-skimo@liacs.nl>
References: <1179683865547-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 19:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HppfY-000640-1R
	for gcvg-git@gmane.org; Sun, 20 May 2007 19:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863AbXETR57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 13:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756846AbXETR55
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 13:57:57 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37077 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756837AbXETR54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 13:57:56 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KHvkpi007625;
	Sun, 20 May 2007 19:57:51 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 791DC7DDA2; Sun, 20 May 2007 19:57:46 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <1179683865547-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47859>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 git-clone.sh |    6 +++---
 git-fetch.sh |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 823b973..8d5dc05 100755
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
index dcb6985..68706db 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -235,11 +235,31 @@ fetch_all_at_once () {
 
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
1.5.1.5.g8fc2
