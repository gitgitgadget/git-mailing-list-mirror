From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: safely output binary files for 'blob_plain' action
Date: Sat, 17 Jun 2006 13:32:15 +0200
Message-ID: <200606171332.15591.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 17 13:32:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrZ2K-0004sk-Fm
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 13:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWFQLcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 07:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFQLcR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 07:32:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:29763 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751454AbWFQLcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 07:32:17 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1209576ugf
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 04:32:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Dy955F+BCJfQyaRpWjsLxyXdfKbRB7DRIx2vMhwjJyw++Xpu5y+HzhPqmrgyFUBZTnvMgbAAJv6lZSIklLZNDgGx84BEULvAW1UMD/+DAnMHaeAJ9XCv9ub6T+Jze1aODoNV6HZJ/koQBfmtA3Om+bmCAvjAXS8khwzYMj6dvts=
Received: by 10.67.30.6 with SMTP id h6mr3632614ugj;
        Sat, 17 Jun 2006 04:32:14 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id m1sm4041605ugc.2006.06.17.04.32.14;
        Sat, 17 Jun 2006 04:32:14 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.6.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22012>

gitweb tries now to output correct Content-Type header for 
'blob_plain' action; for now text/plain for text files, 
appropriate image MIME type for *.png, *.gif and *.jpg/*.jpeg files, 
and application/octet-stream for other binary files. 

Introduced new configuration variables: $default_blob_plain_mimetype 
and $default_text_plain_charset (only 'utf-8' is guaranteed to work
for the latter).

binmode changed to ':raw' in git_blob_plain for output of non-text files.

---
 gitweb/gitweb.cgi |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 9d902b7..b37ec50 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -39,12 +39,16 @@ # html text to include at home page
 my $home_text =		"indextext.html";
 
 # URI of default stylesheet
-my $stylesheet = 	"gitweb.css";
+my $stylesheet =	"gitweb.css";
 
 # source of projects list
 #my $projects_list =	$projectroot;
 my $projects_list =	"index/index.aux";
 
+# default blob_plain mimetype and default charset for text/plain blob
+my $default_blob_plain_mimetype = 'text/plain';
+my $default_text_plain_charset  = 'utf-8';	# can be undefined
+
 # input validation and dispatch
 my $action = $cgi->param('a');
 if (defined $action) {
@@ -1354,15 +1358,46 @@ sub git_blob {
 	git_footer_html();
 }
 
+sub git_blob_plain_mimetype {
+	my $fd = shift;
+	my $filename = shift;
+
+	# just in case
+	return $default_blob_plain_mimetype unless $fd;
+
+	if (-T $fd) {
+		return 'text/plain' .
+		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');
+	} elsif (! $filename) {
+		return 'application/octet-stream';
+	} elsif ($filename =~ m/\.png$/i) {
+		return 'image/png';
+	} elsif ($filename =~ m/\.gif$/i) {
+		return 'image/gif';
+	} elsif ($filename =~ m/\.jpe?g$/i) {
+		return 'image/jpeg';
+	} else {
+		return 'application/octet-stream';
+	}
+}
+
 sub git_blob_plain {
-	my $save_as = "$hash.txt";
+	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or return;
+	my $type = git_blob_plain_mimetype($fd, $file_name);
+	
+	# save as filename, even when no $file_name is given
+	my $save_as = "$hash";
 	if (defined $file_name) {
 		$save_as = $file_name;
+	} elsif ($type =~ m/^text\//) {
+		$save_as .= '.txt';
 	}
-	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"$save_as\"");
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or return;
+	
+	print $cgi->header(-type => "$type", '-content-disposition' => "inline; filename=\"$save_as\"");
 	undef $/;
+	binmode STDOUT, ':raw' unless $type =~ m/^text\//;
 	print <$fd>;
+	binmode STDOUT, ':utf8' unless $type =~ m/^text\//;
 	$/ = "\n";
 	close $fd;
 }
-- 
1.3.0
