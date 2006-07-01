From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] Speed up history generation
Date: Fri, 30 Jun 2006 17:59:24 -0700 (PDT)
Message-ID: <20060701005924.7726.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jul 01 02:59:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwTpa-0003uQ-Tr
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 02:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWGAA70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 20:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWGAA70
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 20:59:26 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:16790 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751886AbWGAA7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 20:59:24 -0400
Received: (qmail 7728 invoked by uid 60001); 1 Jul 2006 00:59:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KV+XRV5r40KRxFbGV7D0eRkLVS6xTPSrqsUaH0+GKLq7Du2B65ccOc/jtyUP5N+29gS2/D2g8wHQ/1XTvO3Xes/ZP94SMwisqu6Bl8PL9vAWmEFXjea7OSrbzKbSo5W6fkyG8o5kE1XXra4ALsnY0IEkNyEJEmvDI3yM7JV3mSU=  ;
Received: from [68.186.62.135] by web31812.mail.mud.yahoo.com via HTTP; Fri, 30 Jun 2006 17:59:24 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23023>

Speed up history generation as suggested by Linus.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 035e76d..2705a93 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -2295,16 +2295,12 @@ sub git_history {
 	      "</div>\n";
 	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
 
-	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin --
\'$file_name\'";
-	my $commit;
+	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
 		if ($line =~ m/^([0-9a-fA-F]{40})/){
-			$commit = $1;
-			next;
-		}
-		if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)\t(.*)$/ &&
(defined $commit)) {
+			my $commit = $1;
 			my %co = git_read_commit($commit);
 			if (!%co) {
 				next;
@@ -2336,7 +2332,6 @@ sub git_history {
 			}
 			print "</td>\n" .
 			      "</tr>\n";
-			undef $commit;
 		}
 	}
 	print "</table>\n";
-- 
1.4.1.rc2.g4ce4
