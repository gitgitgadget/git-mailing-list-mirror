From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] git-instaweb: fix lighttpd configuration on cygwin
Date: Mon, 09 Mar 2009 18:31:55 +0000
Message-ID: <49B5609B.5070705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, pascal@obry.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 19:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgkJY-0004D9-JG
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 19:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbZCISd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 14:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbZCISd1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 14:33:27 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:42328 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751836AbZCISd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 14:33:26 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1LgkHz-0001sh-b2; Mon, 09 Mar 2009 18:33:24 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112731>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

A recent email from Pascal reminded me that I had this patch
kicking around. I haven't tested this on Linux, since I don't
have lighttpd installed there (I already have Apache), but I
don't expect any problems; famous last words!

The essence of the change is the addition of the "mod_setenv"
module, along with the PATH environment variable assignment.
(otherwise gitweb can't find a shell and, therefore, can't
execute any git programs)

Also, I had to add a default mime-type assignment of text/plain
("" => "text/plain").  If my memory serves me, the other additions
to the mime-type mapping was just cosmetic; and why not?

Hmmm, I just noticed that the first hunk, which is needed to
suppress a "lighttpd: not found" error message, could perhaps be
seen as an un-related fix. Dunno.

ATB,
Ramsay Jones


 git-instaweb.sh |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 0843372..5f4419b 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -49,7 +49,7 @@ resolve_full_httpd () {
 	esac
 
 	httpd_only="$(echo $httpd | cut -f1 -d' ')"
-	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null;; esac
+	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null 2>&1;; esac
 	then
 		full_httpd=$httpd
 	else
@@ -179,11 +179,74 @@ lighttpd_conf () {
 	cat > "$conf" <<EOF
 server.document-root = "$fqgitdir/gitweb"
 server.port = $port
-server.modules = ( "mod_cgi" )
+server.modules = ( "mod_setenv", "mod_cgi" )
 server.indexfiles = ( "gitweb.cgi" )
 server.pid-file = "$fqgitdir/pid"
+server.errorlog = "$fqgitdir/gitweb/error.log"
+
+# to enable, add "mod_access", "mod_accesslog" to server.modules
+# variable above and uncomment this
+#accesslog.filename = "$fqgitdir/gitweb/access.log"
+
+setenv.add-environment = ( "PATH" => "/usr/local/bin:/usr/bin:/bin" )
+
 cgi.assign = ( ".cgi" => "" )
-mimetype.assign = ( ".css" => "text/css" )
+
+# mimetype mapping
+mimetype.assign             = (
+  ".pdf"          =>      "application/pdf",
+  ".sig"          =>      "application/pgp-signature",
+  ".spl"          =>      "application/futuresplash",
+  ".class"        =>      "application/octet-stream",
+  ".ps"           =>      "application/postscript",
+  ".torrent"      =>      "application/x-bittorrent",
+  ".dvi"          =>      "application/x-dvi",
+  ".gz"           =>      "application/x-gzip",
+  ".pac"          =>      "application/x-ns-proxy-autoconfig",
+  ".swf"          =>      "application/x-shockwave-flash",
+  ".tar.gz"       =>      "application/x-tgz",
+  ".tgz"          =>      "application/x-tgz",
+  ".tar"          =>      "application/x-tar",
+  ".zip"          =>      "application/zip",
+  ".mp3"          =>      "audio/mpeg",
+  ".m3u"          =>      "audio/x-mpegurl",
+  ".wma"          =>      "audio/x-ms-wma",
+  ".wax"          =>      "audio/x-ms-wax",
+  ".ogg"          =>      "application/ogg",
+  ".wav"          =>      "audio/x-wav",
+  ".gif"          =>      "image/gif",
+  ".jpg"          =>      "image/jpeg",
+  ".jpeg"         =>      "image/jpeg",
+  ".png"          =>      "image/png",
+  ".xbm"          =>      "image/x-xbitmap",
+  ".xpm"          =>      "image/x-xpixmap",
+  ".xwd"          =>      "image/x-xwindowdump",
+  ".css"          =>      "text/css",
+  ".html"         =>      "text/html",
+  ".htm"          =>      "text/html",
+  ".js"           =>      "text/javascript",
+  ".asc"          =>      "text/plain",
+  ".c"            =>      "text/plain",
+  ".cpp"          =>      "text/plain",
+  ".log"          =>      "text/plain",
+  ".conf"         =>      "text/plain",
+  ".text"         =>      "text/plain",
+  ".txt"          =>      "text/plain",
+  ".dtd"          =>      "text/xml",
+  ".xml"          =>      "text/xml",
+  ".mpeg"         =>      "video/mpeg",
+  ".mpg"          =>      "video/mpeg",
+  ".mov"          =>      "video/quicktime",
+  ".qt"           =>      "video/quicktime",
+  ".avi"          =>      "video/x-msvideo",
+  ".asf"          =>      "video/x-ms-asf",
+  ".asx"          =>      "video/x-ms-asf",
+  ".wmv"          =>      "video/x-ms-wmv",
+  ".bz2"          =>      "application/x-bzip",
+  ".tbz"          =>      "application/x-bzip-compressed-tar",
+  ".tar.bz2"      =>      "application/x-bzip-compressed-tar",
+  ""              =>      "text/plain"
+ )
 EOF
 	test x"$local" = xtrue && echo 'server.bind = "127.0.0.1"' >> "$conf"
 }
-- 
1.6.2
