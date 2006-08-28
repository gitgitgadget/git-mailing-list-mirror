From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add local time and timezone to git_print_authorship
Date: Mon, 28 Aug 2006 23:17:31 +0200
Message-ID: <11567998513000-git-send-email-jnareb@gmail.com>
References: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 23:18:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHoUb-0002fw-NL
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 23:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWH1VRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 17:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWH1VRs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 17:17:48 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:32657 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751445AbWH1VRr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 17:17:47 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SLGISP031205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 23:16:19 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SLHVeV002438;
	Mon, 28 Aug 2006 23:17:31 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SLHVQN002437;
	Mon, 28 Aug 2006 23:17:31 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <Pine.LNX.4.64.0608281016380.27779@g5.osdl.org>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26181>

Linus Torvalds wrote:
> I've got _one_ small beef with gitweb still, which is that it seems to 
> like always showing things in UTC rather than the "native" timezone, but I 
> can see why people would sometimes want that. So I'm not actually sure 
> it's wrong.
> 
> I think it _may_ be worth showing the native timezone in the "commit-diff" 
> view (when you see only one commit), and then show the UTC time in the 
> "log" view (when you see a lot of commits, and might want to compare times 
> in different timezones more easily).
> 
> But I think that timezone thing is probably a matter of taste rather than 
> much anything else.

-- >8 --
Add local time (hours and minutes) and local timezone to the output of
git_print_authorship command, used by git_commitdiff.  The code was
taken from git_commit subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ef09cf5..fa7f62a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1345,10 +1345,18 @@ #sub git_print_authorship (\%) {
 sub git_print_authorship {
 	my $co = shift;
 
-	my %ad = parse_date($co->{'author_epoch'});
+	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<div class=\"author_date\">" .
 	      esc_html($co->{'author_name'}) .
-	      " [$ad{'rfc2822'}]</div>\n";
+	      " [$ad{'rfc2822'}";
+	if ($ad{'hour_local'} < 6) {
+		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+	} else {
+		printf(" (%02d:%02d %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+	}
+	print "]</div>\n";
 }
 
 sub git_print_page_path {
-- 
1.4.1.1
