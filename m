From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Tue, 31 Jul 2007 13:19:50 +0200
Message-ID: <11858807944170-git-send-email-jnareb@gmail.com>
References: <1185880790812-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 13:20:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFplu-0001hb-NR
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 13:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622AbXGaLUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 07:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbXGaLUL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 07:20:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:35684 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbXGaLUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 07:20:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so62059ugf
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 04:20:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mYUTd/qIuKz9G8m0fBPSw/1dJy/r36af5vcDEDdJsBPKlCbynDOv1/Y0NQK82PHyssoK8kx5lMIZhtHgnH7keRMQwL1l/XAM7bh/3F5lXNbm5gQvrt7axOkRWG74lBO20vCwQCRGHnsDxT+k2N1gBNo9RTA8P6MMjkc85tkCcjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hTIrSrgIfmsM4dxQWMeH8NNTj2YGnnD01kY3P662Lzn/pNUL9gvVPLJT/C/Cq/LWXQI/Qh/TTCtB5rBGVth2bgL3pAG4JCkLxMSFmsucM6xCLmVym5qtAwoEdtM4T8nBFFGvyVOw/9YUfxyVyTzCMGGMt5HwTDJotO9kor6MozI=
Received: by 10.67.15.17 with SMTP id s17mr495075ugi.1185880804762;
        Tue, 31 Jul 2007 04:20:04 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id c25sm8177928ika.2007.07.31.04.19.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 04:19:58 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6VBJsro031951;
	Tue, 31 Jul 2007 13:19:54 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6VBJs3D031950;
	Tue, 31 Jul 2007 13:19:54 +0200
X-Mailer: git-send-email 1.5.3.rc3.28.gd208c6
In-Reply-To: <1185880790812-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54334>

Add support for extra option ('opt' parameter) '-l' for the 'tree'
view, to show (in separate column, between mode and filename) the size
of blobs (files).  This option is passed through to all the 'tree'
links, so from 'tree' view with size of blobs on go to 'tree' view
also with size of blobs.

For the 'tree' and 'commit' (submodule) entries, '-' is shown in place
of size.

Currently you have to add ";opt=-l" to URL by hand to start.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is an example of using infrastructure introduced by the
earlier patch: 
  gitweb: Allow for multivalued parameters passed to href subroutine

It allows to play with 'tree' view with blob size. Currently you
have to start browsing by adding ";opt=-l" to the gitweb URL by
hand.  There is not link which will change view from ordinary 'tree'
view to 'tree' view with blob sizes.

The 'tree' with blob size view is slightly more costly than the
ordinary, old 'tree' view, but not much more (0.018s vs 0.012s
in the hot cache case), so I don't think we need to control it
as a enabled (or disabled) feature, overrideable or not.  It
probably should not be default.

What do you think about this?

 gitweb/gitweb.css  |    5 ++++
 gitweb/gitweb.perl |   53 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 096313b..dd24546 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -326,6 +326,11 @@ td.mode {
 	font-family: monospace;
 }
 
+td.size {
+	font-family: monospace;
+	text-align: right;
+}
+
 /* styling of diffs (patchsets): commitdiff and blobdiff views */
 div.diff.header,
 div.diff.extended_header {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 498b936..97ad1da 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -432,6 +432,7 @@ if (defined $hash_base) {
 
 my %allowed_options = (
 	"--no-merges" => [ qw(rss atom log shortlog history) ],
+	"-l" => [ qw(tree) ],
 );
 
 our @extra_options = $cgi->param('opt');
@@ -1998,16 +1999,31 @@ sub parse_ls_tree_line ($;%) {
 	my %opts = @_;
 	my %res;
 
-	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+	if ($opts{'-l'}) {
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
 
-	$res{'mode'} = $1;
-	$res{'type'} = $2;
-	$res{'hash'} = $3;
-	if ($opts{'-z'}) {
-		$res{'name'} = $4;
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		$res{'size'} = $4;
+		if ($opts{'-z'}) {
+			$res{'name'} = $5;
+		} else {
+			$res{'name'} = unquote($5);
+		}
 	} else {
-		$res{'name'} = unquote($4);
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		if ($opts{'-z'}) {
+			$res{'name'} = $4;
+		} else {
+			$res{'name'} = unquote($4);
+		}
 	}
 
 	return wantarray ? %res : \%res;
@@ -2679,6 +2695,9 @@ sub git_print_tree_entry {
 	# and link is the action links of the entry.
 
 	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
+	if (exists $t->{'size'}) {
+		print "<td class=\"size\">$t->{'size'}</td>\n";
+	}
 	if ($t->{'type'} eq "blob") {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
@@ -4268,8 +4287,9 @@ sub git_tree {
 			$hash = $hash_base;
 		}
 	}
+
 	$/ = "\0";
-	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
+	open my $fd, "-|", git_cmd(), "ls-tree", '-z', @extra_options, $hash
 		or die_error(undef, "Open git-ls-tree failed");
 	my @entries = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading tree failed");
@@ -4280,6 +4300,7 @@ sub git_tree {
 	git_header_html();
 	my $basedir = '';
 	my ($have_blame) = gitweb_check_feature('blame');
+	my $show_sizes = grep(/^-l$/, @extra_options);
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my @views_nav = ();
 		if (defined $file_name) {
@@ -4288,7 +4309,8 @@ sub git_tree {
 				                       hash=>$hash, file_name=>$file_name)},
 				        "history"),
 				$cgi->a({-href => href(action=>"tree",
-				                       hash_base=>"HEAD", file_name=>$file_name)},
+				                       hash_base=>"HEAD", file_name=>$file_name,
+				                       extra_options=>\@extra_options)},
 				        "HEAD"),
 		}
 		my $snapshot_links = format_snapshot_links($hash);
@@ -4296,7 +4318,8 @@ sub git_tree {
 			# FIXME: Should be available when we have no hash base as well.
 			push @views_nav, $snapshot_links;
 		}
-		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
+		git_print_page_nav('tree','', $hash_base, undef, undef,
+		                   join(' | ', @views_nav));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		undef $hash_base;
@@ -4330,8 +4353,10 @@ sub git_tree {
 		# based on git_print_tree_entry
 		print '<td class="mode">' . mode_str('040000') . "</td>\n";
 		print '<td class="list">';
-		print $cgi->a({-href => href(action=>"tree", hash_base=>$hash_base,
-		                             file_name=>$up)},
+		print $cgi->a({-href => href(action=>"tree",
+		                             hash_base=>$hash_base,
+		                             file_name=>$up,
+		                             extra_options=>\@extra_options)},
 		              "..");
 		print "</td>\n";
 		print "<td class=\"link\"></td>\n";
@@ -4339,7 +4364,7 @@ sub git_tree {
 		print "</tr>\n";
 	}
 	foreach my $line (@entries) {
-		my %t = parse_ls_tree_line($line, -z => 1);
+		my %t = parse_ls_tree_line($line, -z => 1, -l => $show_sizes);
 
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
-- 
1.5.2.4
