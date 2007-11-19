From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Try to sanitize mimetype for 'blob_plain' view
Date: Mon, 19 Nov 2007 15:54:14 +0100
Message-ID: <1195484054-18164-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 15:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu81J-0000Ld-4F
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 15:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbXKSOyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 09:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbXKSOyY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 09:54:24 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:35762 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbXKSOyX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 09:54:23 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1888288mue
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 06:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=dp65WPOVoU7ROeYAUj/XeD8HOljqvAeaHPRqY3NlXE0=;
        b=tQWwp4bktbq11k66/qqw1JMLkTE+jfaI5LP3Jt5n+YKgOHPTb6nXgBZdcehE/QanfawOxvY5fZbmrKhXtxJSUSyc34ZxRx0DGxQAu4iL+uCqYiHXjp/XGlbXRGT+RJ3gPBKpNKD02v8AKDPkwMxeBrP8VijG8NFYoPDhYr3QoeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=m23Vp3k4fqpMsWM4l5E6TcQvxlD0aCMo3Fx/wXwgcXjw11JTqS5XFtKZMHlCCFQ3eeiudQmM/Xh5QFGmeZPwl1zTI+fAHxhlNpDnEpeGW3Qyuk/HzBiVuUM7P4JaFZ1t+0gN8lVM4E//3YDTv65cNc6KffUH/ukZaPfigok2b6M=
Received: by 10.82.119.17 with SMTP id r17mr6125677buc.1195484060240;
        Mon, 19 Nov 2007 06:54:20 -0800 (PST)
Received: from roke.D-201 ( [83.8.241.246])
        by mx.google.com with ESMTPS id p9sm8945823fkb.2007.11.19.06.54.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 06:54:18 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lAJEsF4I018180;
	Mon, 19 Nov 2007 15:54:15 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lAJEsE4m018179;
	Mon, 19 Nov 2007 15:54:14 +0100
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65450>

Use 'text/plain' for files which are text and can be viewed in a
browser, and are not among a few 'text/*' mimetypes universally
recognized by web browsers.  This means files with 'text/*' which are
not text/html, text/css, text/sgml or text/xml, and files with
'application/x-*' mimetype which are nevertheless text: javascript,
shell, Perl, Tcl, (La)TeX,...

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Tired of my web browser (Mozilla) asking me what I want to do with
shell script, Perl script or LaTeX document when using 'blob_plain'
(raw) view, because of declaration in mimetypes file I have added
mimetype sanitizing to gitweb.

It is an RFC partially because list of mimetypes is a bit
arbitrary. Additionally I guess that the mimetype sanitizing should be
separated into subroutine.

But most of all beause proper solution is to create mimetype file for
use by gitweb.

 gitweb/gitweb.perl |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 491a3f4..1cfe293 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2366,7 +2366,28 @@ sub blob_mimetype {
 
 	if ($filename) {
 		my $mime = mimetype_guess($filename);
-		$mime and return $mime;
+
+		if ($mime) {
+			# try to sanitize mimetype
+
+			# return text/plain on unknown text/* mimetype
+			if ($mime =~ m!^text/! &&
+			    $mime !~ m!^text/(?:html|css|sgml|xml)$!) {
+				return 'text/plain' .
+				       ($default_text_plain_charset ?
+				        '; charset='.$default_text_plain_charset : '');
+			}
+			# return text/plain for known programming languages and like
+			if ($mime =~ m!^application/x-(?:
+			                javascript|csshell|shell|csh|perl|
+			                sh|shar|tcl|latex|tex|texinfo)!x) {
+				return 'text/plain' .
+				       ($default_text_plain_charset ?
+				        '; charset='.$default_text_plain_charset : '');
+			}
+			# otherwise return mimetype found in mimetypes file(s)
+			return $mime;
+		}
 	}
 
 	# just in case
-- 
1.5.3.5
