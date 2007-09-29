From: jean.guyader@linkea.org
Subject: [PATCH] Fix problem with authentification on http repository.
Date: Sun, 30 Sep 2007 00:26:22 +0200
Message-ID: <11911047823308-git-send-email-jean.guyader@linkea.org>
Cc: Jean Guyader <jean.guyader@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 00:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IblFj-0000pA-De
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbXI2W5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbXI2W5c
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:57:32 -0400
Received: from linkea.org ([82.66.115.142]:51382 "EHLO linkea.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754321AbXI2W5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:57:31 -0400
X-Greylist: delayed 1832 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Sep 2007 18:57:31 EDT
Received: from localhost.localdomain (dress.johnweb.linkea [10.68.42.2])
	by linkea.org (Postfix) with ESMTP id 3851C2E90E;
	Sun, 30 Sep 2007 00:15:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59506>

From: Jean Guyader <jean.guyader@gmail.com>

Curl uses the option -u user:passwd and not the user:password
given in the url.
The solution was to extract user:password from the url and set
the option.

Here the regex used :
        sed -re 's-.*http://([^:]*):([^@]+)@.*-\1:\2-g'
---
 git-clone.sh     |    3 ++-
 git-fetch.sh     |    8 ++++----
 git-ls-remote.sh |    3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 5e582fe..57206ac 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -34,7 +34,8 @@ fi
 
 http_fetch () {
 	# $1 = Remote, $2 = Local
-	curl -nsfL $curl_extra_args "$1" >"$2" ||
+        curl_userpw=`echo "$1" | sed -re 's-http://([^:]*):([^@]+)@.*-\1:\2-g'`
+	curl -u "$curl_userpw" -nsfL $curl_extra_args "$1" >"$2" ||
 		case $? in
 		126|127) exit ;;
 		*)	 return $? ;;
diff --git a/git-fetch.sh b/git-fetch.sh
index e44af2c..0b7d055 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -268,13 +268,13 @@ fetch_per_ref () {
 		"`git config --bool http.noEPSV`" = true ]; then
 	      noepsv_opt="--disable-epsv"
 	  fi
-
-	  # Find $remote_name from ls-remote output.
+          pretty_remote=$(echo "$remote" | sed -re 's-http://([^:]+):([^@]+)@-http://\1:******@-g')
+          # Find $remote_name from ls-remote output.
 	  head=$(echo "$ls_remote_result" | \
 		git fetch--tool -s pick-rref "$remote_name" "-")
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
-		die "No such ref $remote_name at $remote"
-	  echo >&2 "Fetching $remote_name from $remote using $proto"
+		die "No such ref $remote_name at $pretty_remote"
+	  echo >&2 "Fetching $remote_name from $pretty_remote using $proto"
 	  case "$quiet" in '') v=-v ;; *) v= ;; esac
 	  git-http-fetch $v -a "$head" "$remote" || exit
 	  ;;
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index d56cf92..d6e9906 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -61,7 +61,8 @@ http://* | https://* | ftp://* )
 		"`git config --bool http.noEPSV`" = true ]; then
 		curl_extra_args="${curl_extra_args} --disable-epsv"
 	fi
-	curl -nsf $curl_extra_args --header "Pragma: no-cache" "$peek_repo/info/refs" ||
+        curl_userpw=`echo "$peek_repo" | sed -re 's-.*http://([^:]*):([^@]+)@.*-\1:\2-g'`
+	curl -u "$curl_userpw" -nsf $curl_extra_args --header "Pragma: no-cache" "$peek_repo/info/refs" ||
 		echo "failed	slurping"
 	;;
 
-- 
1.5.2.4
