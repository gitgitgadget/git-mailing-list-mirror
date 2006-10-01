From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: start to generate PATH_INFO URLs.
Date: Sun, 1 Oct 2006 23:57:48 +0200
Message-ID: <20061001215748.GG2871@admingilde.org>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net> <20060930181408.GD2871@admingilde.org> <7vfye9dtv7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 23:58:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU9Jq-0003jj-24
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 23:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWJAV5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 17:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWJAV5v
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 17:57:51 -0400
Received: from agent.admingilde.org ([213.95.21.5]:10911 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932426AbWJAV5u
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 17:57:50 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GU9Jk-00038b-UD; Sun, 01 Oct 2006 23:57:48 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfye9dtv7.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28207>

Instead of providing the project as a ?p= parameter it is simply appended to
the base URI.  All other parameters are appended to that, except for ?a=summary
which is the default and can be omitted.

The old URL generation can be selected by disabling the "pathinfo" feature
in gitweb_config.perl.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 597d29f..edbd3ea 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -102,6 +102,10 @@ our %feature = (
 		'sub' => \&feature_pickaxe,
 		'override' => 0,
 		'default' => [1]},
+
+	'pathinfo' => {
+		'override' => 0,
+		'default' => [1]},
 );
 
 sub gitweb_check_feature {
@@ -355,6 +359,7 @@ ## action links
 
 sub href(%) {
 	my %params = @_;
+	my $href = $my_uri;
 
 	my @mapping = (
 		project => "p",
@@ -373,6 +378,19 @@ sub href(%) {
 
 	$params{'project'} = $project unless exists $params{'project'};
 
+	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
+	if ($use_pathinfo) {
+		# use PATH_INFO for project name
+		$href .= "/$params{'project'}" if defined $params{'project'};
+		delete $params{'project'};
+
+		# Summary just uses the project path URL
+		if (defined $params{'action'} && $params{'action'} eq 'summary') {
+			delete $params{'action'};
+		}
+	}
+
+	# now encode the parameters explicitly
 	my @result = ();
 	for (my $i = 0; $i < @mapping; $i += 2) {
 		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
@@ -380,7 +398,9 @@ sub href(%) {
 			push @result, $symbol . "=" . esc_param($params{$name});
 		}
 	}
-	return "$my_uri?" . join(';', @result);
+	$href .= "?" . join(';', @result) if scalar @result;
+
+	return $href;
 }
 
 
-- 
1.4.2.gb8b6b

-- 
Martin Waitz
