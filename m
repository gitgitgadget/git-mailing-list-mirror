From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 06/14] gitweb: git_split_heads_body function.
Date: Fri, 31 Aug 2007 13:05:24 +0200
Message-ID: <11885583243085-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:07:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4Le-0007mY-QX
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbXHaLH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbXHaLH2
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:07:28 -0400
Received: from joe.tiscali.it ([213.205.33.54]:60844 "EHLO joe.tiscali.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529AbXHaLH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:07:28 -0400
Received: from localhost.localdomain (84.221.55.162) by joe.tiscali.it (7.3.122)
        id 46A8A46B003891B2; Fri, 31 Aug 2007 13:07:04 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57154>

The purpose of this function is to split a headlist into groups determined by the leading part of the refname, and call git_heads_body() on each group.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c46e982..cacb0d7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3640,6 +3640,37 @@ sub git_tags_body {
 	print "</table>\n";
 }
 
+sub git_split_heads_body {
+	my ($headlist, $head, $from, $to, $extra) = @_;
+	my %headlists;
+	my $leader; my $list; my @list;
+
+	# Split @$headlist into a hash of lists
+	map {
+		my %ref = %$_;
+		$ref{'hname'} = $ref{'name'};
+		if ($ref{'name'} =~ /\//) {
+			$ref{'name'} =~ s!^([^/]+)/!!;
+			$leader = $1;
+		} else {
+			$leader = "\000";
+		}
+		if (defined $headlists{$leader}) {
+			@list = @{$headlists{$leader}}
+		} else {
+			@list = ()
+		}
+		push @list, \%ref;
+		$headlists{$leader} = [@list];
+	} @$headlist;
+
+	foreach $leader (sort(keys %headlists)) {
+		print "<b>$leader</b><br/>\n" unless $leader eq "\000";
+		$list = $headlists{$leader};
+		git_heads_body($list, $head, $from, $to, $extra);
+	}
+}
+
 sub git_heads_body {
 	# uses global variable $project
 	my ($headlist, $head, $from, $to, $extra) = @_;
@@ -3880,7 +3911,7 @@ sub git_summary {
 
 	if (@remotelist) {
 		git_print_header_div('remotes');
-		git_heads_body(\@remotelist, $head, 0, 15,
+		git_split_heads_body(\@remotelist, $head, 0, 15,
 		               $#remotelist <= 15 ? undef :
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
-- 
1.5.2.5
