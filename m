From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb.cgi: git_blame2: slight optimization reading the blame lines
Date: Sun, 23 Jul 2006 14:17:48 -0700 (PDT)
Message-ID: <20060723211748.77065.qmail@web31814.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-440081174-1153689468=:76202"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 23:18:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4lKo-00011i-3P
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 23:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWGWVRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 17:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWGWVRt
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 17:17:49 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:21344 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750714AbWGWVRs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 17:17:48 -0400
Received: (qmail 77067 invoked by uid 60001); 23 Jul 2006 21:17:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fWqX7fnd2A0ISUWYmWlFb25NrQuJTFFx8jRRrkXMqD+BmJ9vJkxPZsEbJoyTv9oXS7cHnAljKkrGjQ5jQbpHbsrB7dyOoGAgJ1wGJ5LMni6j6MaIDtv4DR1/8SvebAZFMYjgX+8teFWfDOV3rjM7AyJcHb3bdxN1Hk3EZzvUxig=  ;
Received: from [71.80.232.189] by web31814.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 14:17:48 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24107>

--0-440081174-1153689468=:76202
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Eliminate git_read_blame_line() -- move that code inline and
optimize it.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)
--0-440081174-1153689468=:76202
Content-Type: text/inline; name="p1.patch"
Content-Description: 2795696785-p1.patch
Content-Disposition: name="p1.patch"; filename="p1.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 16340f2..7fbfc0d 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1252,15 +1252,6 @@ sub git_tag {
 	git_footer_html();
 }
 
-sub git_read_blame_line {
-	my %bl;
-	$_ = shift;
-
-	($bl{'hash'}, $bl{'lineno'}, $bl{'data'}) = /^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
-
-	return %bl;
-}
-
 sub git_blame2 {
 	my $fd;
 	my $ftype;
@@ -1302,13 +1293,12 @@ sub git_blame2 {
 	print "<div class=\"page_body\">\n";
 	print "<table class=\"blame\">\n";
 	print "<tr><th>Commit</th><th>Line</th><th>Data</th></tr>\n";
-	while (my $line = <$fd>) {
-		my %blame_line = git_read_blame_line($line);
-		my $full_rev = $blame_line{'hash'};
+	while (<$fd>) {
+		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
+		my $full_rev = $1;
 		my $rev = substr($full_rev, 0, 8);
-		my $lineno = $blame_line{'lineno'};
-		my $data = $blame_line{'data'};
+		my $lineno = $2;
+		my $data = $3;
 
 		if (!defined $last_rev) {
 			$last_rev = $full_rev;
-- 
1.4.2.rc1.g9b54


--0-440081174-1153689468=:76202--
