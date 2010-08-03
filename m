From: Jared Hance <jaredhance@gmail.com>
Subject: [RFC/PATCH] Split resolve_full_httpd to prevent bug.
Date: Tue, 3 Aug 2010 18:34:36 -0400
Message-ID: <c14fac3f8bedfe451e7b06b626632e724c993c52.1280874664.git.jaredhance@gmail.com>
References: <m34ofbpcyr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 00:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgQ4N-0008Fx-NI
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 00:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800Ab0HCWel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 18:34:41 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55054 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab0HCWel (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 18:34:41 -0400
Received: by vws3 with SMTP id 3so3523592vws.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4DWIN3hXoHCGS7zwo8M6u/bUQYOsEXSgxBGoYvYBuAk=;
        b=lHYqpbIyMIINTiwccFXoky6sIuK4DSNGnP2ylhJ7/r02OdgtuVAqoPb8heBR5JSqU+
         zDmP4aXg0l6yPFFNI2WsvpcZ1UCK7xGDIGIErcyNnu2lBQc/BlerTJSdqZZzvwHlrEFc
         6x4U05JF4Vhsue1yANwVuMSuwrZzj2pkNZDQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xPzLfbm+sRbsfSrCBuWVTb2yEbABL9XRpGr5pjhAT/dokqJMDnl/TjvCM7eL+GIyXj
         wol7ZVfkST4HyRBr7kaIcKIRO3C7KzVB8/HbgBa8nC0NFRvsUJEe//wWMRQ0Jr8TXCCk
         qdukTCSIJhjEjCpdooV4Qr7ZpfU3tG4/fR8As=
Received: by 10.220.116.129 with SMTP id m1mr5607153vcq.231.1280874880211;
        Tue, 03 Aug 2010 15:34:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id s20sm3794714vcr.28.2010.08.03.15.34.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 15:34:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m34ofbpcyr.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152545>

resolve_full_httpd tries to find the httpd path, which can break if the
httpd configuration hasn't happened. Specifically, this occurs with
webrick.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---

WARNING: I haven't tested this patch, as I don't use git-instaweb. I
also don't have webrick, so I can't be sure this actually works.
Hopefully this can be used as a foundation for a real fix.

 git-instaweb.sh |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b7342e2..b7950ac 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -41,7 +41,7 @@ test -z "$root" && root='@@GITWEBDIR@@'
 # any untaken local port will do...
 test -z "$port" && port=1234
 
-resolve_full_httpd () {
+resolve_httpd () {
 	case "$httpd" in
 	*apache2*|*lighttpd*|*httpd*)
 		# yes, *httpd* covers *lighttpd* above, but it is there for clarity
@@ -52,14 +52,21 @@ resolve_full_httpd () {
 		fi
 		;;
 	*plackup*)
-		# server is started by running via generated gitweb.psgi in $fqgitdir/gitweb
-		full_httpd="$fqgitdir/gitweb/gitweb.psgi"
 		httpd_only="${httpd%% *}" # cut on first space
 		return
 		;;
 	esac
 
 	httpd_only="$(echo $httpd | cut -f1 -d' ')"
+}
+
+# please run resolve_httpd first
+resolve_full_httpd() {
+	if test $httpd = "plackup"; then
+		# server is started by running via generated gitweb.psgi in $fqgitdir/gitweb
+		full_httpd="$fqgitdir/gitweb/gitweb.psgi"
+	fi
+
 	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null 2>&1;; esac
 	then
 		full_httpd=$httpd
@@ -90,6 +97,7 @@ start_httpd () {
 	fi
 
 	# here $httpd should have a meaningful value
+	resolve_httpd
 	resolve_full_httpd
 
 	# don't quote $full_httpd, there can be arguments to it (-f)
@@ -354,6 +362,7 @@ PerlPassEnv GITWEB_CONFIG
 EOF
 	else
 		# plain-old CGI
+		resolve_httpd
 		resolve_full_httpd
 		list_mods=$(echo "$full_httpd" | sed 's/-f$/-l/')
 		$list_mods | sane_grep 'mod_cgi\.c' >/dev/null 2>&1 || \
@@ -565,7 +574,7 @@ EOF
 
 gitweb_conf
 
-resolve_full_httpd
+resolve_httpd
 mkdir -p "$fqgitdir/gitweb/$httpd_only"
 
 case "$httpd" in
@@ -590,6 +599,7 @@ webrick)
 	;;
 esac
 
+
 start_httpd
 url=http://127.0.0.1:$port
 
-- 
1.7.2
