From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb:  Make git_get_refs_list do work of git_get_references
Date: Sun, 17 Sep 2006 02:26:38 +0200
Message-ID: <200609170226.39330.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 17 02:26:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOkUB-0005Hd-1P
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 02:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWIQA0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWIQA0H
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 20:26:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:64262 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964883AbWIQA0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 20:26:04 -0400
Received: by ug-out-1314.google.com with SMTP id o38so263218ugd
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 17:26:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fooXj6c3JD4qlNv2dYEtvhpUTebgva5WjEXnn9+q7709Oi0mTZEkTjH/NW0LkRSKvR+dNAuz+9ISWQ3A1uBxx/3Wa6wN1fA2V/hPxeXZ3mi+WYpMuFEMNipF6zYTT7rymjhuNvdNdHjqS7QLjilJ83HCk8XzeD3xsmnRCWn166A=
Received: by 10.67.105.19 with SMTP id h19mr6280507ugm;
        Sat, 16 Sep 2006 17:26:02 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k28sm1104267ugd.2006.09.16.17.26.02;
        Sat, 16 Sep 2006 17:26:02 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27143>

Make git_get_refs_list do also work of git_get_references, to avoid
calling git-peek-remote twice. It now returns either list of refs as
before in scalar context, or references hash and list of refs in list
context. Change meaning of git_get_refs_list meaning: it is now type,
and not a full path, e.g. we now use git_get_refs_list("heads")
instead of former git_get_refs_list("refs/heads").

Additionally modify git_summary to use only one call to
git_get_refs_list instead of one call to git_get_references and two to
git_get_refs_list.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was supposed to make gitweb performance better, by 
(in the case of git_summary) replacing three calls to git-peek-remote
(or one reading info/refs and two calls to git-peek-remote) by only 
one such a call. ApacheBench shows that after changes summary and tags 
views are slower, while heads remains the same.

  3520.593 +/- 29.2 ms after vs 3086.579 +/- 85.0 ms before (summary)
  3137.274 +/- 26.4 ms after vs 2504.025 +/- 46.1 ms before (tags)

I suspect benchmarks somewhat, but still...

 gitweb/gitweb.perl |   57 ++++++++++++++++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7908793..d5ce675 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1077,7 +1077,8 @@ ## .....................................
 ## parse to array of hashes functions
 
 sub git_get_refs_list {
-	my $ref_dir = shift;
+	my $type = shift || "";
+	my %refs;
 	my @reflist;
 
 	my @refs;
@@ -1085,14 +1086,21 @@ sub git_get_refs_list {
 		or return;
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m/^([0-9a-fA-F]{40})\t$ref_dir\/?([^\^]+)$/) {
-			push @refs, { hash => $1, name => $2 };
-		} elsif ($line =~ m/^[0-9a-fA-F]{40}\t$ref_dir\/?(.*)\^\{\}$/ &&
-		         $1 eq $refs[-1]{'name'}) {
-			# most likely a tag is followed by its peeled
-			# (deref) one, and when that happens we know the
-			# previous one was of type 'tag'.
-			$refs[-1]{'type'} = "tag";
+		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?([^\^]+))(\^\{\})?$/) {
+			if (defined $refs{$1}) {
+				push @{$refs{$1}}, $2;
+			} else {
+				$refs{$1} = [ $2 ];
+			}
+
+			if (! $4) { # unpeeled, direct reference
+				push @refs, { hash => $1, name => $3 }; # without type
+			} elsif ($1 eq $refs[-1]{'name'}) {
+				# most likely a tag is followed by its peeled
+				# (deref) one, and when that happens we know the
+				# previous one was of type 'tag'.
+				$refs[-1]{'type'} = "tag";
+			}
 		}
 	}
 	close $fd;
@@ -1108,7 +1116,7 @@ sub git_get_refs_list {
 	}
 	# sort refs by age
 	@reflist = sort {$b->{'epoch'} <=> $a->{'epoch'}} @reflist;
-	return \@reflist;
+	return wantarray ? (\%refs, \@reflist) : \@reflist;
 }
 
 ## ----------------------------------------------------------------------
@@ -2072,14 +2080,14 @@ sub git_tags_body {
 
 sub git_heads_body {
 	# uses global variable $project
-	my ($taglist, $head, $from, $to, $extra) = @_;
+	my ($headlist, $head, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
-	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
+	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
 
 	print "<table class=\"heads\" cellspacing=\"0\">\n";
 	my $alternate = 0;
 	for (my $i = $from; $i <= $to; $i++) {
-		my $entry = $taglist->[$i];
+		my $entry = $headlist->[$i];
 		my %tag = %$entry;
 		my $curr = $tag{'id'} eq $head;
 		if ($alternate) {
@@ -2249,7 +2257,8 @@ sub git_summary {
 
 	my $owner = git_get_project_owner($project);
 
-	my $refs = git_get_references();
+	my ($refs, $reflist) = git_get_refs_list();
+
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
@@ -2279,17 +2288,17 @@ sub git_summary {
 	git_shortlog_body(\@revlist, 0, 15, $refs,
 	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
 
-	my $taglist = git_get_refs_list("refs/tags");
-	if (defined @$taglist) {
+	my @taglist = map { s!^tags/!! } grep { m!^tags/! } @$reflist;
+	if (@taglist) {
 		git_print_header_div('tags');
-		git_tags_body($taglist, 0, 15,
+		git_tags_body(\@taglist, 0, 15,
 		              $cgi->a({-href => href(action=>"tags")}, "..."));
 	}
 
-	my $headlist = git_get_refs_list("refs/heads");
-	if (defined @$headlist) {
+	my @headlist = map { s!^heads/!! } grep { m!^heads/! } @$reflist;
+	if (@headlist) {
 		git_print_header_div('heads');
-		git_heads_body($headlist, $head, 0, 15,
+		git_heads_body(\@headlist, $head, 0, 15,
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
@@ -2500,7 +2509,7 @@ sub git_tags {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my $taglist = git_get_refs_list("refs/tags");
+	my $taglist = git_get_refs_list("tags");
 	if (defined @$taglist) {
 		git_tags_body($taglist);
 	}
@@ -2513,9 +2522,9 @@ sub git_heads {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my $taglist = git_get_refs_list("refs/heads");
-	if (defined @$taglist) {
-		git_heads_body($taglist, $head);
+	my $headlist = git_get_refs_list("heads");
+	if (defined @$headlist) {
+		git_heads_body($headlist, $head);
 	}
 	git_footer_html();
 }
-- 
1.4.2.1
