From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8] gitweb: Add git_page_nav for later use
Date: Sun, 30 Jul 2006 14:59:57 +0200
Message-ID: <200607301459.58032.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 14:59:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Atf-0007RS-M3
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 14:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWG3M7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 08:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWG3M7w
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 08:59:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:31918 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932307AbWG3M7w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 08:59:52 -0400
Received: by ug-out-1314.google.com with SMTP id m3so358454ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 05:59:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PMoiEbCNrEQBoRxRXxuG2PmoK5BIujNbo+z911ANVz9t3gIfu9uYoCMb2cs+LiiukE2Q+yaE3sE+Kj5dVt6a2WpY5U0JbGyVvh77pR5xYxS+IY+J/olvZKTgMymr5NzX91+AoJlxQobBrDZtyrbZLAlcRBQYKZFnVS8JeYqVObU=
Received: by 10.67.93.7 with SMTP id v7mr1514405ugl;
        Sun, 30 Jul 2006 05:59:50 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id o1sm3651529uge.2006.07.30.05.59.49;
        Sun, 30 Jul 2006 05:59:50 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24453>

Adds git_page_nav subroutine to factors out the generation of the
navigation bar.  Based on Sven Verdoolaege code
  Message-Id: <20050618113121.GA13122@pc117b.liacs.nl>
  http://marc.theaimsgroup.com/?l=git&m=111909432415478&w=2

I tried for the refactored navbar generate the same result.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index d5248fe..2bc3445 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -385,6 +385,40 @@ sub die_error {
 	exit;
 }
 
+sub git_page_nav {
+	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
+	$extra = '' if !defined $extra; # pager or formats
+
+	my @navs = qw(summary shortlog log commit commitdiff tree);
+	if ($suppress) {
+		@navs = grep { $_ ne $suppress } @navs;
+	}
+
+	my %arg = map { $_, ''} @navs;
+	if (defined $head) {
+		for (qw(commit commitdiff)) {
+			$arg{$_} = ";h=$head";
+		}
+		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
+			for (qw(shortlog log)) {
+				$arg{$_} = ";h=$head";
+			}
+		}
+	}
+	$arg{tree} .= ";h=$treehead" if defined $treehead;
+	$arg{tree} .= ";hb=$treebase" if defined $treebase;
+
+	print "<div class=\"page_nav\">\n" .
+		(join " | ",
+		 map { $_ eq $current
+					 ? $_
+					 : $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$_$arg{$_}")}, "$_")
+				 }
+		 @navs);
+	print "<br/>$extra<br/>\n" .
+	      "</div>\n";
+}
+
 sub git_get_type {
 	my $hash = shift;
 
-- 
1.4.0
