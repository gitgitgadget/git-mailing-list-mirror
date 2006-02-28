From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 2/2] Speed up history generation
Date: Tue, 28 Feb 2006 04:39:34 -0800 (PST)
Message-ID: <20060228123934.7936.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Feb 28 13:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE48k-0005HA-As
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 13:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWB1Mjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 07:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWB1Mjf
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 07:39:35 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:51814 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932205AbWB1Mjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 07:39:35 -0500
Received: (qmail 7938 invoked by uid 60001); 28 Feb 2006 12:39:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iEEY16pM9s5wjMVbrQX85Fyx5ytMmPGD1lkOcKThrtrWJN/Gzct0iYBa9fDA8aOq042ZCwz8Gtvj+oCMWqKG3hUkAe64EzR3t+swPj4c41BRkZWsS1Iv1lSI6NI4QWv8M0e1xA6fZQWll5N6O+Ak3GAJiEsd4nchK0/hiTfnwDg=  ;
Received: from [68.186.53.141] by web31812.mail.mud.yahoo.com via HTTP; Tue, 28 Feb 2006 04:39:34 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16932>

Speed up history generation as suggested by Linus.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

---

 gitweb.cgi |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

69d694fccacb09059731abe4918f8f9aa8969690
diff --git a/gitweb.cgi b/gitweb.cgi
index 452528f..bfea65d 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -2124,16 +2124,12 @@ sub git_history {
 	      "</div>\n";
 	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
 
-	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin
\'$file_name\'";
-	my $commit;
+	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
-		if ($line =~ m/^([0-9a-fA-F]{40})/){
-			$commit = $1;
-			next;
-		}
-		if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/ &&
(defined $commit)) {
+	        if ($line =~ m/^([0-9a-fA-F]{40})/){
+			my $commit = $1;
 			my %co = git_read_commit($commit);
 			if (!%co) {
 				next;
@@ -2165,7 +2161,6 @@ sub git_history {
 			}
 			print "</td>\n" .
 			      "</tr>\n";
-			undef $commit;
 		}
 	}
 	print "</table>\n";
-- 
1.2.3.g975a
