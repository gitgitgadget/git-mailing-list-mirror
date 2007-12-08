From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Teach "a=blob" action to be more lenient about blob/file mime type
Date: Sat,  8 Dec 2007 12:55:13 +0100
Message-ID: <1197114913-15626-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 12:56:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0yHu-0006um-FX
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbXLHLzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbXLHLzp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:55:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:11923 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbXLHLzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:55:44 -0500
Received: by nf-out-0910.google.com with SMTP id g13so531475nfb
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 03:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=1+NA7lmgz8eQvBzud5iRwYqWUWnXsnvsJ6p9aCSDPWE=;
        b=QCyEJlK992C1a78Ak1uPpt9ms9Oe9sfEGo+9D4hB9WitkCQtskjlWZdj3cHZxGGahF8Yi9KzTc4VZijlqy3TjVFrXOmcGgYsn90PWUSLobMta4UyAuiydcQOU4it1FGskgHMy0Gu+XuWXzGD7D3IHh1SS+BvhVp8rB718qGVnfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hDenuYiFgWXOJZl9MqO82o9V/SiPUVVaU9TB/+ucBbg4Ze3Co4JkGhmQzrvCnlExbO8sm/8Wj/FyoQ1uBcEKpJZlbKCxpS6MZzRbd7Aylaa+rkA8G8mojILJilGVpD9hbGXJkz9kRU/mFGLHhib9eRq+uw3NdgoM9PzyFyr9IYc=
Received: by 10.86.76.16 with SMTP id y16mr3236227fga.1197114942377;
        Sat, 08 Dec 2007 03:55:42 -0800 (PST)
Received: from roke.D-201 ( [83.8.198.153])
        by mx.google.com with ESMTPS id j12sm989694fkf.2007.12.08.03.55.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Dec 2007 03:55:40 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB8BtdIN015643;
	Sat, 8 Dec 2007 12:55:40 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB8BtNtO015640;
	Sat, 8 Dec 2007 12:55:23 +0100
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67547>

Since 930cf7dd7cc6b87d173f182230763e1f1913d319 'blob' action knows the
file type; if the file type is not "text/*" or one of common network
image formats/mimetypes (gif, png, jpeg) then the action "blob"
defaulted to "blob_plain".  This caused the problem if mimetypes file
was not well suited for web, for example returning "application/x-sh"
for "*.sh" shell scripts, instead of "text/plain" (or other "text/*").

Now "blob" action defaults to "blob_plain" ('raw' view) only if file
is of type which is neither "text/*" nor "image/{gif,png,jpeg}"
AND it is binary file.  Otherwise it assumes that it can be displayed
either in <img> tag ("image/*" mimetype), or can be displayed line by
line (otherwise).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The patch I've send earlier
  "[RFC/PATCH] gitweb: Try to sanitize mimetype for 'blob_plain' view"
  Message-Id: <1195484054-18164-1-git-send-email-jnareb@gmail.com>
should also do what this patch is about. This one however IMHO
is much less invasive, and much less controversial.

P.S. BTW is there some plumbing for scripts to help with
gitattributes, for example showing all gitattributes (or status of
selected attributes) for given path?

 gitweb/gitweb.perl |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index eac7e16..b833327 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4302,7 +4302,7 @@ sub git_blob {
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
-	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)!) {
+	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)! && -B $fd) {
 		close $fd;
 		return git_blob_plain($mimetype);
 	}
@@ -4343,16 +4343,7 @@ sub git_blob {
 	}
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=\"page_body\">\n";
-	if ($mimetype =~ m!^text/!) {
-		my $nr;
-		while (my $line = <$fd>) {
-			chomp $line;
-			$nr++;
-			$line = untabify($line);
-			printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
-			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
-		}
-	} elsif ($mimetype =~ m!^image/!) {
+	if ($mimetype =~ m!^image/!) {
 		print qq!<img type="$mimetype"!;
 		if ($file_name) {
 			print qq! alt="$file_name" title="$file_name"!;
@@ -4361,7 +4352,16 @@ sub git_blob {
 		      href(action=>"blob_plain", hash=>$hash,
 		           hash_base=>$hash_base, file_name=>$file_name) .
 		      qq!" />\n!;
-	}
+	} else {
+		my $nr;
+		while (my $line = <$fd>) {
+			chomp $line;
+			$nr++;
+			$line = untabify($line);
+			printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
+			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
+		}
+	} els
 	close $fd
 		or print "Reading blob failed.\n";
 	print "</div>";
-- 
1.5.3.7
