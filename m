From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 21/24] gitweb: Wrap die_error to use as error handler for caching engine
Date: Tue,  7 Dec 2010 00:11:06 +0100
Message-ID: <1291677069-6559-22-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkEq-0000Cr-MP
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab0LFXMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:41 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:50271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab0LFXMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:35 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581892ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5kgNl7nbPsUV047fhcXnrFlc6EcpzbuX6nq22WLRfI4=;
        b=hleOuFTY/uM+wwzG2SCGfF7hp3+uHrFSh395+7jodMOvP/4WoiY9dPbVkr9R852ple
         GTXWkYlB2ILQIjtKb4cL3GMMn06iH8vTnPoukQpvUn/7g/3dBIXMQi5hbfqjGkjFRRxW
         przKPc0LieZBi5ta8ZwolyWBgtokYDgE/g6fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KtZjJbg8kydiY6ViwAvQKNqjyP0iz7hBYh7KRfH/OcBDO9eeY06N17HbOjDO2trQ/G
         kuycjmXxA1u5V4LbiCdYEZ20Y/CQ5yAVQcznmW7Mcg8YyBi2TfuUFHsuNeVXDzDWIH6W
         QtO7vTHEj1SGhxly9HrwteA5wwlM+uKb5fE2A=
Received: by 10.213.105.206 with SMTP id u14mr140773ebo.41.1291677154684;
        Mon, 06 Dec 2010 15:12:34 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:34 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163043>

Use cache_error_handler subroutine, wrapping die_error (and
HTML-escaping error message), as 'on_error' handler for
GitwebCache::SimpleFileCache and its derivatives, and as both
'on_get_error' and 'on_set_error' handler for CHI based caching
engine.

Added single test in t9501 that checks if error in caching layer
produces "500 Internal Server Error".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch and previous one this depends on were not present in previous
version of this series.  That is why this patch was marked as an
RFC... well that and we also need to decide how error in caching layer
should be shown.

The error message is slightly more fancy than what "Gitweb caching v7"
series by J.H. would show on error in the caching layer.

 gitweb/gitweb.perl                       |   27 +++++++++++++++++++++++++++
 t/t9501-gitweb-standalone-http-status.sh |    8 ++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c974e79..5904d27 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -365,6 +365,20 @@ our %cache_options = (
 	# finishes within this time, then generating error pages should be safe
 	# from infinite "Generating page..." loop.
 	'generating_info_is_safe' => 1,
+
+	# How to handle runtime errors occurring during cache gets and cache
+	# sets.  Options are:
+	#  * "die" (the default) - call die() with an appropriate message
+	#  * "warn" - call warn() with an appropriate message
+	#  * "ignore" - do nothing
+	#  * <coderef> - call this code reference with an appropriate message
+	# Note that gitweb catches 'die <message>' via custom handle_errors_html
+	# handler, set via set_message() from CGI::Carp.  'warn <message>' are
+	# written to web server logs.
+	#
+	# The default is to use cache_error_handler, which wraps die_error.
+	# Only first argument passed to cache_error_handler is used (c.f. CHI)
+	'on_error' => \&cache_error_handler,
 );
 # You define site-wide options for "Generating..." page (if enabled) here
 # (which means that $cache_options{'generating_info'} is set to coderef);
@@ -1186,6 +1200,17 @@ sub configure_gitweb_features {
 	}
 }
 
+# custom error handler for caching engine (Internal Server Error)
+sub cache_error_handler {
+	my $error = shift;
+
+	$error = to_utf8($error);
+	$error =
+		"Error in caching layer: <i>".ref($cache)."</i><br>\n".
+		CGI::escapeHTML($error);
+	# die_error() would exit
+	die_error(undef, undef, $error);
+}
 # custom error handler: 'die <message>' is Internal Server Error
 sub handle_errors_html {
 	my $msg = shift; # it is already HTML escaped
@@ -1348,6 +1373,8 @@ sub configure_caching {
 			# (CHI compatibile initialization)
 			'root_dir' => $cache_options{'cache_root'},
 			'depth' => $cache_options{'cache_depth'},
+			'on_get_error' => $cache_options{'on_error'},
+			'on_set_error' => $cache_options{'on_error'},
 		});
 	}
 	unless (defined $capture && ref($capture)) {
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 168e494..af89422 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -147,5 +147,13 @@ test_expect_success 'caching enabled (non-existent commit, 404 error)' '
 test_debug 'echo "headers" && cat gitweb.headers'
 test_debug 'echo "body"    && cat gitweb.body'
 
+test_expect_success 'caching errors are 500 Internal Server Error' '
+	chmod 0000 cache/ &&
+	test_when_finished "chmod 0777 cache/" &&
+	gitweb_run "p=.git" &&
+	grep "Status: 500 Internal Server Error" gitweb.headers &&
+	grep "500 - Internal Server Error" gitweb.body
+'
+test_debug 'echo "headers" && cat gitweb.headers'
 
 test_done
-- 
1.7.3
