From: Wilhansen Li <wil@nohakostudios.net>
Subject: Re: [PATCH] Add support for the Mongoose web server.
Date: Fri, 21 Aug 2009 22:24:48 +0800
Message-ID: <bc9549a50908210724u66caafadv630c31e6ecc1f28a@mail.gmail.com>
References: <bc9549a50908202339h61525d3fo23199313cabe25e5@mail.gmail.com> 
	<7vvdkhip3a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeV3T-0004Xp-PI
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 16:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbZHUOZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 10:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbZHUOZL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 10:25:11 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:58582 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502AbZHUOZK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 10:25:10 -0400
Received: by vws2 with SMTP id 2so619722vws.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=pywb3ceE62lUwaAvWZPQ7nyPhFHlBNRCklRv+F1p50Y=;
        b=CUZW+7nFoM0XHc3F69MS1s+aAWgojMhvOoKqGSMGqIT7AAYB1jE6bYnsfRHavtK0l4
         hiVw7hwowNwW45DpS4sqcoMHLZWZagzE91tY2VUaN2I67teGfu9ePRNIhTvvbeumEjjn
         hQCJaAsx3o49Oe2gypZjQ1jEc4w0wo6uqUr4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=OWFUVmMECepnAHJLAu+QqC9E49QR2EwbqBqswgf9k+5f0n6FNVM9S8NK4/CcUlpNVy
         pzfcDB0CtMd06+McFY6YvPee2CL51LlyFZ8vmFFZiGv71wIU807eB6UoVJs8m4T62NNY
         m/0cY5F/zBkwX+cpiaHEIak3EuR4HRn1+FkDI=
Received: by 10.220.70.18 with SMTP id b18mr829527vcj.79.1250864708345; Fri, 
	21 Aug 2009 07:25:08 -0700 (PDT)
In-Reply-To: <7vvdkhip3a.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 82b176bde9f1affb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126726>

I hope I did this right (the word wraps). I took the liberty to sort
the server list.
---
Mongoose (http://code.google.com/p/mongoose/) is a lightweight web
server. It's just a single binary so it's a lot simpler to configure and
install.

Signed-off-by: Wilhansen Li <wil@nohakostudios.net>
---
 Documentation/git-instaweb.txt |    2 +-
 git-instaweb.sh                |   57 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 22da21a..0771f25 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -29,7 +29,7 @@ OPTIONS
 	The HTTP daemon command-line that will be executed.
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
-	Currently lighttpd, apache2 and webrick are supported.
+	Currently apache2, lighttpd, mongoose and webrick are supported.
 	(Default: lighttpd)

 -m::
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 5f5cac7..d96eddb 100755
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
@@ -308,6 +327,31 @@ EOF
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
+}
+
+
 script='
 s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
 s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
@@ -344,6 +388,9 @@ case "$httpd" in
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
