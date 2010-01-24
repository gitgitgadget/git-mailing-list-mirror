From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 11/10] gitweb: Ajax-y "Generating..." page when regenerating cache (WIP)
Date: Sun, 24 Jan 2010 14:54:50 +0100
Message-ID: <1264341290-11356-1-git-send-email-jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 14:55:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ2w4-0001K3-Fq
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 14:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab0AXNzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 08:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974Ab0AXNzL
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 08:55:11 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:37482 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab0AXNzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 08:55:08 -0500
Received: by fxm7 with SMTP id 7so1051733fxm.28
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 05:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XF5om8t5O3Ui5/MeFEtRo6YqzOPzU7nGZ54/92mJBTc=;
        b=M0ecF8uPRmtbZiPi368rIO8tpEIGXpYLueo6W6K7oi0lOcocAFIjrKKakrCu9KcQLt
         1a6FRU5j5ByktFbqr4YLixhnvMNBr8bKNLF9l0or9rTx5Ki6SlROLAkY4fViPsCCjrIY
         g0WxeFVBBzwaAB+fU/u+hpswG60Eg+tIzZlUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MMqp0q5iwe8gWkfrZSlsKse04YRLR4uFGXDiBCTLnzi2bonOEwLdm0ELippXWF53/y
         D9ypNKJ0FvLOyoEiNCbifjv2XICdH5s6On76UJ+KfAOfZTHOiulfqNQPQPLIijcm7Len
         M9UROucwxI7aa59leJXRPCIUUzrjgRqnCaZUY=
Received: by 10.87.66.33 with SMTP id t33mr7002838fgk.13.1264341305385;
        Sun, 24 Jan 2010 05:55:05 -0800 (PST)
Received: from localhost.localdomain (abvk247.neoplus.adsl.tpnet.pl [83.8.208.247])
        by mx.google.com with ESMTPS id l12sm7606713fgb.15.2010.01.24.05.55.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 05:55:03 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137896>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch, as you can see, lack proper commit message: it is work in
progress (and very much proof of concept patch).

This is Ajax-y JavaScript-based activity indicator.  It is very
bare-bones, without any error checking or fallback in the case we
misdetected and JavaScript is turned off.  Also currently it would
work only for subsequent links from gitweb, with 'js=1' added.

We need to mark Ajax request to _not_ create "Generating..." page.
I have used there custon 'X-Ajax' HTTP header; we could use 
'Pragma: wait', or ejen additional query parameter for that.

 gitweb/gitweb.perl |   69 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cb46b8c..d422a4b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3219,6 +3219,9 @@ sub blob_contenttype {
 sub git_generating_data_html {
 	my ($cache, $key, $lock_fh) = @_;
 
+	if ($cgi->http('X-Ajax')) {
+		return;
+	}
 	if ($action eq 'atom' || $action eq 'rss' || $action eq 'opml' || # feeds
 	    $action eq 'blob_plain' || # unknown mimetype
 	    $action eq 'commitdiff_plain' || # text/plain
@@ -3241,6 +3244,7 @@ sub git_generating_data_html {
 		}
 	}
 
+	my $use_javascript = $cgi->param('js');
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
 	print STDOUT $cgi->header(-type => 'text/html', -charset => 'utf-8',
 	                          -status=> '200 OK', -expires => 'now');
@@ -3253,31 +3257,58 @@ sub git_generating_data_html {
 <!-- git core binaries version $git_version -->
 <head>
 <meta http-equiv="content-type" content="text/html; charset=utf-8" />
-<meta http-equiv="refresh" content="0" />
+EOF
+	if (!$use_javascript) {
+		print STDOUT qq!<meta http-equiv="refresh" content="0" />\n!;
+	}
+	print STDOUT <<"EOF";
 <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version" />
 <meta name="robots" content="noindex, nofollow" />
 <title>$title</title>
 </head>
 <body>
 EOF
-	print STDOUT 'Generating..';
-
-	my $ready;
-	my ($wait, $wait_step, $wait_max); # in seconds
-	$wait = 0;
-	$wait_step = 2;
-	$wait_max = 20;
-	$| = 1; # autoflush
-	do {
-		print STDOUT '.';
-
-		sleep $wait_step if ($wait > 0);
-		$wait += $wait_step;
-
-		$ready = flock($lock_fh, LOCK_SH|LOCK_NB)
-			if $lock_fh;
-
-	} while (!$ready && ($wait < $wait_max));
+	if ($use_javascript) {
+		my $url_self = href(-replay=>1);
+		print STDOUT <<"EOF";
+Generating...<br />
+<script type="text/javascript" src="$javascript"></script>
+<script type="text/javascript">
+window.onload = function () {
+	xhr = createRequestObject();
+	xhr.onreadystatechange = function () {
+		if (xhr.readyState === 4 && xhr.status === 200) {
+			// intentionally overwrite document
+			document.write(xhr.responseText);
+		}
+	}
+	xhr.open('GET', $url_self);
+	// mark request to not show "Generating..." page
+	xhr.setRequestHeader('X-Ajax', 'Yes');
+	xhr.send(null);
+}
+</script>
+EOF
+	} else {
+		print STDOUT 'Generating..';
+
+		my $ready;
+		my ($wait, $wait_step, $wait_max); # in seconds
+		$wait = 0;
+		$wait_step = 2;
+		$wait_max = 20;
+		$| = 1; # autoflush
+		do {
+			print STDOUT '.';
+			
+			sleep $wait_step if ($wait > 0);
+			$wait += $wait_step;
+			
+			$ready = flock($lock_fh, LOCK_SH|LOCK_NB)
+				if $lock_fh;
+			
+		} while (!$ready && ($wait < $wait_max));
+	}
 
 	print STDOUT <<"EOF";
 
-- 
1.6.6.1
