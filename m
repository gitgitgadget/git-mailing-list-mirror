From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Sun, 15 Feb 2009 10:18:36 +0100
Message-ID: <1234689516-14415-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0902140629pa1ad038pe898aa0d804d0707@mail.gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 10:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYdBu-0005Ld-M2
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbZBOJSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZBOJSl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:18:41 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:43990 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZBOJSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:18:38 -0500
Received: by fxm13 with SMTP id 13so4796551fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6XkrgFgCQizWB0ooX2syi2iluWcmX+q6EGJbNm8hHq8=;
        b=IrOv8h6uIkYdE9ehPxZEvrPVL+x/5FvQDdj3FfNuVdh2HQZo8m1t5ebuTQJqCW/Lhc
         oeZha2qonmIFcemF6pv85Kop/bbyFkJ/k9bYR8c/MYdSczIurC1o1t2Sl2nk3I2o+PWe
         igvbmexXB/H8rsdduvW7hIqI4f5SF80mZPqxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PW9fvzaykp/YkiVFFSQyIolKsFLBf2zfSj0z1J7oTNLFCpmES9HozyfswryXx74aNN
         qZmUU9Qg8WyGorInGuEN/Na4S9UQQ0HnSTA8ID1OKCbTzR5cY+jDH77fWMdOwOGDqbE0
         zdCrdbSfvOrOwQaMdac3afyvQfBZz2CH4iPIQ=
Received: by 10.103.168.5 with SMTP id v5mr2260329muo.77.1234689516007;
        Sun, 15 Feb 2009 01:18:36 -0800 (PST)
Received: from localhost (host-78-15-2-18.cust-adsl.tiscali.it [78.15.2.18])
        by mx.google.com with ESMTPS id 14sm7128566muo.50.2009.02.15.01.18.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 01:18:35 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <cb7bb73a0902140629pa1ad038pe898aa0d804d0707@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109983>

CGI::url() has some issues when rebuilding the script URL if the script
is a DirectoryIndex.

One of these issue is the inability to strip PATH_INFO, which is why
we had to do it ourselves.

Another issue is that the resulting URL cannot be used for the <base>
tag: it works if we're the DirectoryIndex at the root level, but not
otherwise.

We fix this by building the proper base URL ourselves, and improve the
comment about the need to strip PATH_INFO manually while we're at it.

Additionally t/t9500-gitweb-standalone-no-errors.sh had to be modified
to set SCRIPT_NAME variable (CGI standard states that it MUST be set,
and now gitweb uses it if PATH_INFO is not empty, as is the case for
some of tests in t9500).

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

There was a bug in Jakub's rewritten logic for the PATH_INFO stripping:
using || instead of && meant that $my_uri was not being stripped if
$my_url was, resulting in wrong relative links all around. Instead, if
we can strip PATH_INFO from $my_url then we can (and must) strip it from
$my_uri too (&&), and then check for the definition of SCRIPT_NAME.

This patch also included a quoting patch that apparently didn't make it
to the list: the <base> tag was inserting a literal \n instead of a
newline. Since that line got rewritten anyway, I thought it wasn't a big
deal to squash it in.

 gitweb/gitweb.perl                     |   28 ++++++++++++++++++++++------
 t/t9500-gitweb-standalone-no-errors.sh |    6 ++++--
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8dffa3f..7c48181 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -27,13 +27,29 @@ our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
-# if we're called with PATH_INFO, we have to strip that
-# from the URL to find our real URL
-# we make $path_info global because it's also used later on
+# Base URL for relative URLs in gitweb ($logo, $favicon, ...),
+# needed and used only for URLs with nonempty PATH_INFO
+our $base_url = $my_url;
+
+# When the script is used as DirectoryIndex, the URL does not contain the name
+# of the script file itself, and $cgi->url() fails to strip PATH_INFO, so we
+# have to do it ourselves. We make $path_info global because it's also used
+# later on.
+#
+# Another issue with the script being the DirectoryIndex is that the resulting
+# $my_url data is not the full script URL: this is good, because we want
+# generated links to keep implying the script name if it wasn't explicitly
+# indicated in the URL we're handling, but it means that $my_url cannot be used
+# as base URL.
+# Therefore, if we needed to strip PATH_INFO, then we know that we have
+# to build the base URL ourselves:
 our $path_info = $ENV{"PATH_INFO"};
 if ($path_info) {
-	$my_url =~ s,\Q$path_info\E$,,;
-	$my_uri =~ s,\Q$path_info\E$,,;
+	if ($my_url =~ s,\Q$path_info\E$,, &&
+	    $my_uri =~ s,\Q$path_info\E$,, &&
+	    defined $ENV{'SCRIPT_NAME'}) {
+		$base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
+	}
 }
 
 # core git executable to use
@@ -2908,7 +2924,7 @@ EOF
 	# the stylesheet, favicon etc urls won't work correctly with path_info
 	# unless we set the appropriate base URL
 	if ($ENV{'PATH_INFO'}) {
-		print '<base href="'.esc_url($my_url).'" />\n';
+		print "<base href=\"".esc_url($base_url)."\" />\n";
 	}
 	# print out each stylesheet that exist, providing backwards capability
 	# for those people who defined $stylesheet in a config file
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 43cd6ee..7c6f70b 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -43,9 +43,11 @@ gitweb_run () {
 	GATEWAY_INTERFACE="CGI/1.1"
 	HTTP_ACCEPT="*/*"
 	REQUEST_METHOD="GET"
+	SCRIPT_NAME="$TEST_DIRECTORY/../gitweb/gitweb.perl"
 	QUERY_STRING=""$1""
 	PATH_INFO=""$2""
-	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD QUERY_STRING PATH_INFO
+	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
+		SCRIPT_NAME QUERY_STRING PATH_INFO
 
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
 	export GITWEB_CONFIG
@@ -54,7 +56,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- "$TEST_DIRECTORY/../gitweb/gitweb.perl" \
+	perl -- "$SCRIPT_NAME" \
 		>/dev/null 2>gitweb.log &&
 	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
 
-- 
1.5.6.5
