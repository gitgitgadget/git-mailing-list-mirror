From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] do not use locale specific strftime when preparing 2822 date
Date: Fri,  7 Jul 2006 20:57:55 +0200
Message-ID: <1152298675925-git-send-email-jnareb@gmail.com>
References: <7vlkr7bvc1.fsf@assigned-by-dhcp.cox.net>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 07 20:58:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyvWh-00047t-DC
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 20:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWGGS6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 14:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWGGS6E
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 14:58:04 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:45223 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932249AbWGGS6D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 14:58:03 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k67IvRwk024265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jul 2006 20:57:28 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k67IvtCV013931;
	Fri, 7 Jul 2006 20:57:55 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k67Ivt0n013930;
	Fri, 7 Jul 2006 20:57:55 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <7vlkr7bvc1.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23455>

Signed-off-by: Junio C Hamano <junkio@cox.net>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is sent from patched version of git-send-email.perl
with git tools 1.3.0. This patch is generated from current master
after Junio's patch 
  Message-ID: <7vd5cnv1v5.fsf@assigned-by-dhcp.cox.net>
applied.

 git-send-email.perl |   41 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 38 insertions(+), 3 deletions(-)

f00ff14faf86c376d0ffb3cef24d2e5a5437dfcf
diff --git a/git-send-email.perl b/git-send-email.perl
index b04b8f4..c9c1975 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -34,8 +34,43 @@ sub readline {
 package main;
 
 # most mail servers generate the Date: header, but not all...
-$ENV{LC_ALL} = 'C';
-use POSIX qw/strftime/;
+sub format_2822_time {
+	my ($time) = @_;
+	my @localtm = localtime($time);
+	my @gmttm = gmtime($time);
+	my $localmin = $localtm[1] + $localtm[2] * 60;
+	my $gmtmin = $gmttm[1] + $gmttm[2] * 60;
+	if ($localtm[0] != $gmttm[0]) {
+		die "local zone differs from GMT by a non-minute interval\n";
+	}
+	if ((($gmttm[6] + 1) % 7) == $localtm[6]) {
+		$localmin += 1440;
+	} elsif ((($gmttm[6] - 1) % 7) == $localtm[6]) {
+		$localmin -= 1440;
+	} elsif ($gmttm[6] != $localtm[6]) {
+		die "local time offset greater than or equal to 24 hours\n";
+	}
+	my $offset = $localmin - $gmtmin;
+	my $offhour = $offset / 60;
+	my $offmin = abs($offset % 60);
+	if (abs($offhour) >= 24) {
+		die ("local time offset greater than or equal to 24 hours\n");
+	}
+
+	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
+		       qw(Sun Mon Tue Wed Thu Fri Sat)[$localtm[6]],
+		       $localtm[3],
+		       qw(Jan Feb Mar Apr May Jun
+			  Jul Aug Sep Oct Nov Dec)[$localtm[4]],
+		       $localtm[5]+1900,
+		       $localtm[2],
+		       $localtm[1],
+		       $localtm[0],
+		       ($offset >= 0) ? '+' : '-',
+		       abs($offhour),
+		       $offmin,
+		       );
+}
 
 my $have_email_valid = eval { require Email::Valid; 1 };
 my $smtp;
@@ -387,7 +422,7 @@ sub send_message
 	my @recipients = unique_email_list(@to);
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
-	my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime($time++));
+	my $date = format_2822_time($time++);
 	my $gitversion = '@@GIT_VERSION@@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
 	    $gitversion = `git --version`;
-- 
1.3.0
