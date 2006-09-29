From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH v2] http/ftp: optionally ask curl to not use EPSV command
Date: Fri, 29 Sep 2006 03:10:44 +0300
Message-ID: <20060929001044.GL10617@sashak.voltaire.com>
References: <20060928192605.GD10617@sashak.voltaire.com> <7vejtvu1ja.fsf@assigned-by-dhcp.cox.net> <20060929000754.GK10617@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 02:06:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5t6-0001TY-4F
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 02:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161413AbWI2AFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWI2AFh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 20:05:37 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:32466 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1161410AbWI2AFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 20:05:36 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 29 Sep 2006 03:05:35 +0300
Received: by sashak (sSMTP sendmail emulation); Fri, 29 Sep 2006 03:10:44 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060929000754.GK10617@sashak.voltaire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 29 Sep 2006 00:05:35.0494 (UTC) FILETIME=[FCD3D260:01C6E35A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28075>

If http.noEPSV config variable is defined and true, or if
GIT_CURL_FTP_NO_EPSV environment variable is defined, disable using
of EPSV ftp command (PASV will be used instead). This is helpful with
some "poor" ftp servers which does not support EPSV mode.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---
 Documentation/config.txt |    6 ++++++
 git-clone.sh             |    4 ++++
 git-fetch.sh             |    6 +++++-
 git-ls-remote.sh         |    4 ++++
 http.c                   |   12 ++++++++++++
 5 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 98c1f3e..84e3891 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -202,6 +202,12 @@ http.lowSpeedLimit, http.lowSpeedTime::
 	Can be overridden by the 'GIT_HTTP_LOW_SPEED_LIMIT' and
 	'GIT_HTTP_LOW_SPEED_TIME' environment variables.
 
+http.noEPSV::
+	A boolean which disables using of EPSV ftp command by curl.
+	This can helpful with some "poor" ftp servers which doesn't
+	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
+	environment variable. Default is false (curl will use EPSV).
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/git-clone.sh b/git-clone.sh
index e1b3bf3..3998c55 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -31,6 +31,10 @@ clone_dumb_http () {
 	cd "$2" &&
 	clone_tmp="$GIT_DIR/clone-tmp" &&
 	mkdir -p "$clone_tmp" || exit 1
+	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
+		"`git-repo-config --bool http.noEPSV`" = true ]; then
+		curl_extra_args="${curl_extra_args} --disable-epsv"
+	fi
 	http_fetch "$1/info/refs" "$clone_tmp/refs" || {
 		echo >&2 "Cannot get remote repository information.
 Perhaps git-update-server-info needs to be run there?"
diff --git a/git-fetch.sh b/git-fetch.sh
index 50ad101..04d4dbb 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -289,6 +289,10 @@ fetch_main () {
 	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	      curl_extra_args="-k"
 	  fi
+	  if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
+	  	"`git-repo-config --bool http.noEPSV`" = true ]; then
+	      noepsv_opt="--disable-epsv"
+	  fi
 	  max_depth=5
 	  depth=0
 	  head="ref: $remote_name"
@@ -300,7 +304,7 @@ fetch_main () {
 	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
 	      print "$u";
 	  ' "$head")
-	    head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted")
+	    head=$(curl -nsfL $curl_extra_args $noepsv_opt "$remote/$remote_name_quoted")
 	    depth=$( expr \( $depth + 1 \) )
 	  done
 	  expr "z$head" : "z$_x40\$" >/dev/null ||
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 2c0b521..0f88953 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -53,6 +53,10 @@ http://* | https://* | ftp://* )
         if [ -n "$GIT_SSL_NO_VERIFY" ]; then
             curl_extra_args="-k"
         fi
+	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
+		"`git-repo-config --bool http.noEPSV`" = true ]; then
+		curl_extra_args="${curl_extra_args} --disable-epsv"
+	fi
 	curl -nsf $curl_extra_args --header "Pragma: no-cache" "$peek_repo/info/refs" ||
 		echo "failed	slurping"
 	;;
diff --git a/http.c b/http.c
index 6c1937b..576740f 100644
--- a/http.c
+++ b/http.c
@@ -23,6 +23,7 @@ #endif
 char *ssl_cainfo = NULL;
 long curl_low_speed_limit = -1;
 long curl_low_speed_time = -1;
+int curl_ftp_no_epsv = 0;
 
 struct curl_slist *pragma_header;
 
@@ -155,6 +156,11 @@ #endif
 		return 0;
 	}
 
+	if (!strcmp("http.noepsv", var)) {
+		curl_ftp_no_epsv = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value);
 }
@@ -196,6 +202,9 @@ #endif
 
 	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
 
+	if (curl_ftp_no_epsv)
+		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
+
 	return result;
 }
 
@@ -251,6 +260,9 @@ #ifdef USE_CURL_MULTI
 		max_requests = DEFAULT_MAX_REQUESTS;
 #endif
 
+	if (getenv("GIT_CURL_FTP_NO_EPSV"))
+		curl_ftp_no_epsv = 1;
+
 #ifndef NO_CURL_EASY_DUPHANDLE
 	curl_default = get_curl_handle();
 #endif
-- 
1.4.2.1
