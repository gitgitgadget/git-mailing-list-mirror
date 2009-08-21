From: Wilhansen Li <wil@nohakostudios.net>
Subject: [PATCH] Add support for the Mongoose web server.
Date: Fri, 21 Aug 2009 14:39:05 +0800
Message-ID: <bc9549a50908202339h61525d3fo23199313cabe25e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 08:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeNmf-0006El-J2
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 08:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbZHUGjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 02:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZHUGjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 02:39:25 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:58015 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbZHUGjY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 02:39:24 -0400
Received: by vws2 with SMTP id 2so450836vws.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=6MuQISIuK9jfL6Q+Cg2zeia5h8lCfoz/gCsb4rhTsiw=;
        b=mQYMLP6ZiS3UcgquKxuVYN+xxDin1Cj4HsPFJkBVnSTnLoUCWEYc/mWgA2RYcRol5q
         wKNXB/O63xtZWtYP3e6OOYhFcLeOd44ax8wnc7Jnp13tMo5kCfHuqLmmsx3Ynpdf/Ffj
         c8G9CjzdwN2rLzUos8SQ7oFlN9V8KV0CvMyOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=d2O045uwokNK7UWkZZcg6oIoXdhs/F2JaDOg0WhkIMkkn80jjeQdjYcLGiDwd2Cl31
         rTGNE1VFD76l6Tmskpa6qtl1xIOKJGSn+CW/NWLWYCcpmKhQm9PIvHJyOHx3/MNaOgdM
         MMEq42gVM1+g9j2u9IwvUk1Aka/gs6L1tSEz4=
Received: by 10.220.70.34 with SMTP id b34mr144247vcj.58.1250836765073; Thu, 
	20 Aug 2009 23:39:25 -0700 (PDT)
X-Google-Sender-Auth: ea9d540c4d1d1cd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126689>

Mongoose (http://code.google.com/p/mongoose/) is a lightweight web
server. It's just a single binary so it's a lot simpler to configure and
install.

Signed-off-by: Wilhansen Li <wil@nohakostudios.net>
---
 git-instaweb.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 5f5cac7..2acf707 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -77,11 +77,30 @@ start_httpd () {
 	resolve_full_httpd

 	# don't quote $full_httpd, there can be arguments to it (-f)
-	$full_httpd "$fqgitdir/gitweb/httpd.conf"
-	if test $? != 0; then
-		echo "Could not execute http daemon $httpd."
-		exit 1
-	fi
+	case "$httpd" in
+	*mongoose*)
+		#The mongoose server doesn't have a daemon mode so we'll have to fork it
+		$full_httpd "$fqgitdir/gitweb/httpd.conf" &
+		#Save the pid before doing anything else (we'll print it later)
+		pid=$!
+
+		if test $? != 0; then
+			echo "Could not execute http daemon $httpd."
+			exit 1
+		fi
+
+		cat > "$fqgitdir/pid" <<EOF
+$pid
+EOF
+		;;
+	*)
+		$full_httpd "$fqgitdir/gitweb/httpd.conf"
+		if test $? != 0; then
+			echo "Could not execute http daemon $httpd."
+			exit 1
+		fi
+		;;
+	esac
 }

 stop_httpd () {
@@ -308,6 +327,32 @@ EOF
 	fi
 }

+mongoose_conf() {
+	cat > "$conf" <<EOF
+# Mongoose web server configuration file.
+# Lines starting with '#' and empty lines are ignored.
+# For detailed description of every option, visit
+# http://code.google.com/p/mongoose/wiki/MongooseManual
+
+root		$fqgitdir/gitweb
+ports		$port
+index_files	gitweb.cgi
+#ssl_cert	$fqgitdir/gitweb/ssl_cert.pem
+error_log	$fqgitdir/gitweb/error.log
+access_log	$fqgitdir/gitweb/access.log
+
+#cgi setup
+cgi_env		PATH=/usr/local/bin:/usr/bin:/bin,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
+cgi_interp	$PERL
+cgi_ext		cgi,pl
+
+# mimetype mapping
+mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-tgz,.tar=application/x-tar,.zip=application/zip,.gif=image/gif,.jpg=image/jpeg,.jpeg=image/jpeg,.png=image/png,.css=text/css,.html=text/html,.htm=text/html,.js=text/javascript,.c=text/plain,.cpp=text/plain,.log=text/plain,.conf=text/plain,.text=text/plain,.txt=text/plain,.dtd=text/xml,.bz2=application/x-bzip,.tbz=application/x-bzip-compressed-tar,.tar.bz2=application/x-bzip-compressed-tar
+EOF
+#	test x"$local" = xtrue && echo 'server.bind = "127.0.0.1"' >> "$conf"
+}
+
+
 script='
 s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
 s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
@@ -344,6 +389,9 @@ case "$httpd" in
 webrick)
 	webrick_conf
 	;;
+*mongoose*)
+	mongoose_conf
+	;;
 *)
 	echo "Unknown httpd specified: $httpd"
 	exit 1
-- 
1.6.4
