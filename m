From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] do not use locale specific strftime when preparing 2822 date
Date: Fri,  7 Jul 2006 20:53:22 +0200
Message-ID: <1152298402442-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 07 20:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyvSE-0003HF-8G
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 20:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWGGSx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 14:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWGGSx1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 14:53:27 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:24807 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932239AbWGGSx1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 14:53:27 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k67IqtvK023892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jul 2006 20:52:55 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k67IrMBm013889;
	Fri, 7 Jul 2006 20:53:22 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k67IrMOu013888;
	Fri, 7 Jul 2006 20:53:22 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: set title 'I_xx(M), lapl'
References: set title 'I_xx(M), lapl'
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23454>

---

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
