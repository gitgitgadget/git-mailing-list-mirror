From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Sort CGI parameters returned by href()
Date: Tue, 22 Aug 2006 19:05:25 +0200
Message-ID: <11562663261084-git-send-email-jnareb@gmail.com>
References: <200608211739.32993.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 22 19:06:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFZh7-0008LJ-PD
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 19:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWHVRFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 13:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWHVRFg
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 13:05:36 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:31630 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932188AbWHVRFf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 13:05:35 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7MH4HZ7005256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Aug 2006 19:04:17 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7MH5Q5m012463;
	Tue, 22 Aug 2006 19:05:26 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7MH5QJo012462;
	Tue, 22 Aug 2006 19:05:26 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <200608211739.32993.jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25861>

Restore pre-1c2a4f5addce479c619057c6cdc841802139982f
ordering of CGI parameters.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 gitweb/gitweb.perl |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 89ef5e7..da0630e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -260,7 +260,9 @@ ## =====================================
 ## action links
 
 sub href(%) {
-	my %mapping = (
+	my %params = @_;
+
+	my @mapping = (
 		action => "a",
 		project => "p",
 		file_name => "f",
@@ -271,18 +273,18 @@ sub href(%) {
 		page => "pg",
 		searchtext => "s",
 	);
+	my %mapping = @mapping;
 
-	my %params = @_;
 	$params{"project"} ||= $project;
 
-	my $href = "$my_uri?";
-	$href .= esc_param( join(";",
-		map {
-			defined $params{$_} ? "$mapping{$_}=$params{$_}" : ()
-		} keys %params
-	) );
-
-	return $href;
+	my @result = ();
+	for (my $i = 0; $i < @mapping; $i += 2) {
+		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
+		if (defined $params{$name}) {
+			push @result, $symbol . "=" . esc_param($params{$name});
+		}
+	}
+	return "$my_uri?" . join(';', @result);
 }
 
 
-- 
1.4.1.1
