From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] Set User-Agent string in shell scripts used for fetching
Date: Tue, 1 Aug 2006 11:36:54 +0200
Message-ID: <200608011136.54698.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com> <7vd5bk3mqo.fsf@assigned-by-dhcp.cox.net> <200608011134.52006.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 11:37:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7qgH-0001WO-Et
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 11:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWHAJgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 05:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWHAJgt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 05:36:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:228 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932576AbWHAJgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 05:36:49 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1212512ugc
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 02:36:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VSDK6XYjhvL5FOFWcTc3m1LmJLtGHy+EqMDeR9tSzSfBiRLfu/2OwQGZX4aFCXR4pTYHwYMw86CvkYC006xJQG4PPwl3Ze7IvqeK435jssbYB6azJrvkEx7eYEGq3T4Jsc9cMgUHrUT6Qay/BcjePrKtIXZ+rH4s1ReK0x4lbsU=
Received: by 10.67.22.2 with SMTP id z2mr639446ugi;
        Tue, 01 Aug 2006 02:36:47 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id e1sm585036ugf.2006.08.01.02.36.47;
        Tue, 01 Aug 2006 02:36:47 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <200608011134.52006.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24585>

This needs checking for shell portability.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> By the way, I wonder why git when cloning/fetching via http protocol
>> uses e.g. "git/1.4.2.rc2.ge0bed" as User-Agent: string when fetching objects
>> and packs, and e.g. "curl/7.15.4 (i486-pc-linux-gnu) libcurl/7.15.4
>> OpenSSL/0.9.8b zlib/1.2.3 libidn/0.6.5" as User-Agent: when fetching refs
>> (heads and tags) and info/refs.
> 
> "Why?", meaning if we deliberately do so for some good reason?
> 
> There isn't.
> 
> git-http-fetch uses its own User-Agent string, but the shell
> script wrappers that use curl executable do not bother setting
> customized User-Agent string; that is why.

So there :-)

 git-clone.sh     |    4 +++-
 git-fetch.sh     |    5 ++++-
 git-ls-remote.sh |    7 +++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index adb752d..a9676d6 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -20,10 +20,12 @@ get_repo_base() {
 if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	curl_extra_args="-k"
 fi
+curl_user_agent="$(git --version)"
+curl_user_agent="git/${curl_user_agent##git version }"
 
 http_fetch () {
 	# $1 = Remote, $2 = Local
-	curl -nsfL $curl_extra_args "$1" >"$2"
+	curl -nsfL $curl_extra_args $curl_user_agent "$1" >"$2"
 }
 
 clone_dumb_http () {
diff --git a/git-fetch.sh b/git-fetch.sh
index cea6e0b..6635bd5 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -291,6 +291,8 @@ fetch_main () {
 			if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 				curl_extra_args="-k"
 			fi
+			curl_user_agent="$(git --version)"
+			curl_user_agent="git/${curl_user_agent##git version }"
 			max_depth=5
 			depth=0
 			head="ref: $remote_name"
@@ -302,7 +304,8 @@ fetch_main () {
 					$u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
 					print "$u";
 					' "$head")
-				head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted")
+				head=$(curl -nsfL $curl_extra_args $curl_user_agent \
+					"$remote/$remote_name_quoted")
 				depth=$( expr \( $depth + 1 \) )
 			done
 			expr "z$head" : "z$_x40\$" >/dev/null ||
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 38122ad..32b93da 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -53,8 +53,11 @@ http://* | https://* )
 	if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 		curl_extra_args="-k"
 	fi
-	curl -nsf $curl_extra_args --header "Pragma: no-cache" "$peek_repo/info/refs" ||
-		echo "failed	slurping"
+	curl_user_agent="$(git --version)"
+	curl_user_agent="git/${curl_user_agent##git version }"
+	curl -nsf $curl_extra_args $curl_user_agent --header "Pragma: no-cache" \
+		"$peek_repo/info/refs" ||
+		echo "failed slurping"
 	;;
 
 rsync://* )
-- 
1.4.1.1
