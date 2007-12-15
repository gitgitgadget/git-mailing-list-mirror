From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Teach "a=blob" action to be more lenient about blob/file mime type
Date: Sat, 15 Dec 2007 15:41:49 +0100
Message-ID: <200712151541.50404.jnareb@gmail.com>
References: <200712151534.50951.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 15:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3YEH-0004eE-8i
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 15:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbXLOOmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 09:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbXLOOmS
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 09:42:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:18451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbXLOOmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 09:42:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1336411ugc.16
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 06:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Xu2t/iaLWOKQ4qj5fvTGs2ogV8DBxbkPnyXi4TIOY8I=;
        b=piSC/X5PIJakF7LAliplv02JD30DXVkK54ZMoKvX8CrPZeEdCLSUtIIVvklG72EPSIDftuM/CpCPTtu/DIri7xIi5LcoqCpQFcBQ8G4aUU/PwL3weaiCy+Ku6RL113mBMLZsR/WfDE+7baHRsM8BBMpY2Ei+jgJoJVFQshLiVO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ojUVtfSMyc/Td+kjLmL5VYAqWI4Rc0h0sudMfUaffhOwrRw5Drrrw6cuj70VWNQAaPTfKTUXSOQ2MmZKdIwi4yoKU5Pj9FP/Yt/pJRYrP2I9/D4o36jITu5xGFrv+Q1/1jS8THKMUJ1OsP4iQ7+IdLwyw9Aqk+YTNnFEbSRFrek=
Received: by 10.66.248.5 with SMTP id v5mr670253ugh.17.1197729728570;
        Sat, 15 Dec 2007 06:42:08 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.240.142])
        by mx.google.com with ESMTPS id b17sm14288867fka.2007.12.15.06.42.06
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Dec 2007 06:42:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712151534.50951.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68389>

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
Original version of the patch has a simple bug.

 gitweb/gitweb.perl |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 448dca7..6256641 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4290,7 +4290,7 @@ sub git_blob {
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
-	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)!) {
+	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)! && -B $fd) {
 		close $fd;
 		return git_blob_plain($mimetype);
 	}
@@ -4331,16 +4331,7 @@ sub git_blob {
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
@@ -4349,6 +4340,15 @@ sub git_blob {
 		      href(action=>"blob_plain", hash=>$hash,
 		           hash_base=>$hash_base, file_name=>$file_name) .
 		      qq!" />\n!;
+	} else {
+		my $nr;
+		while (my $line = <$fd>) {
+			chomp $line;
+			$nr++;
+			$line = untabify($line);
+			printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
+			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
+		}
 	}
 	close $fd
 		or print "Reading blob failed.\n";
-- 
1.5.3.7
