From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Make git_get_refs_list do work of git_get_references
Date: Tue, 19 Sep 2006 14:33:22 +0200
Message-ID: <200609191433.22878.jnareb@gmail.com>
References: <200609191430.51252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 19 14:33:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPemR-0003P0-Iv
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 14:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWISMcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 08:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWISMcu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 08:32:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:1687 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030217AbWISMct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 08:32:49 -0400
Received: by nf-out-0910.google.com with SMTP id o25so136668nfa
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 05:32:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aAI6YzkUDgTUU7aZiU6Z7roy34fZtMfaj0bt4Ok9cX5nkn2hY2RbEBfKP76/lVUVSEPytQRfA/IjhNb6Vy6YnesFAruR0H15hDEyh8TpXWlSyFU6Jcx95U+L7mvSuRxzsHrwgi9wz+E9kMUNCd09z4UOyNGzB6HpmHZ97FFXKqI=
Received: by 10.78.182.20 with SMTP id e20mr3889140huf;
        Tue, 19 Sep 2006 05:32:48 -0700 (PDT)
Received: from host-81-190-25-93.torun.mm.pl ( [81.190.25.93])
        by mx.gmail.com with ESMTP id 3sm10953092hud.2006.09.19.05.32.45;
        Tue, 19 Sep 2006 05:32:45 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609191430.51252.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27275>

Make git_get_refs_list do also work of git_get_references, to avoid
calling git-peek-remote twice.  Change meaning of git_get_refs_list
meaning: it is now type, and not a full path, e.g. we now use
git_get_refs_list("heads") instead of former
git_get_refs_list("refs/heads").

Modify git_summary to use only one call to git_get_refs_list instead
of one call to git_get_references and two to git_get_refs_list.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Benchmarks show that this version is slightly faster than
"before" version:

  2626.133 +/- 98.1 ms after vs 3086.579 +/- 85.0 ms before (summary)
  2233.814 +/- 13.9 ms after vs 2504.025 +/- 46.1 ms before (tags)
   869.533 +/-  7.7 ms after vs  979.281 +/- 88.1 ms before (heads)


 gitweb/gitweb.perl |   66 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 034a88c..01fae94 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1119,7 +1119,8 @@ ## .....................................
 ## parse to array of hashes functions
 
 sub git_get_refs_list {
-	my $ref_dir = shift;
+	my $type = shift || "";
+	my %refs;
 	my @reflist;
 
 	my @refs;
@@ -1127,14 +1128,21 @@ sub git_get_refs_list {
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
+			} elsif ($3 eq $refs[-1]{'name'}) {
+				# most likely a tag is followed by its peeled
+				# (deref) one, and when that happens we know the
+				# previous one was of type 'tag'.
+				$refs[-1]{'type'} = "tag";
+			}
 		}
 	}
 	close $fd;
@@ -1150,7 +1158,7 @@ sub git_get_refs_list {
 	}
 	# sort refs by age
 	@reflist = sort {$b->{'epoch'} <=> $a->{'epoch'}} @reflist;
-	return \@reflist;
+	return (\@reflist, \%refs);
 }
 
 ## ----------------------------------------------------------------------
@@ -2114,14 +2122,14 @@ sub git_tags_body {
 
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
@@ -2291,7 +2299,19 @@ sub git_summary {
 
 	my $owner = git_get_project_owner($project);
 
-	my $refs = git_get_references();
+	my ($reflist, $refs) = git_get_refs_list();
+
+	my @taglist;
+	my @headlist;
+	foreach my $ref (@$reflist) {
+		if ($ref->{'name'} =~ s!^heads/!!) {
+			push @headlist, $ref;
+		} else {
+			$ref->{'name'} =~ s!^tags/!!;
+			push @taglist, $ref;
+		}
+	}
+
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
@@ -2321,17 +2341,15 @@ sub git_summary {
 	git_shortlog_body(\@revlist, 0, 15, $refs,
 	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
 
-	my $taglist = git_get_refs_list("refs/tags");
-	if (defined @$taglist) {
+	if (@taglist) {
 		git_print_header_div('tags');
-		git_tags_body($taglist, 0, 15,
+		git_tags_body(\@taglist, 0, 15,
 		              $cgi->a({-href => href(action=>"tags")}, "..."));
 	}
 
-	my $headlist = git_get_refs_list("refs/heads");
-	if (defined @$headlist) {
+	if (@headlist) {
 		git_print_header_div('heads');
-		git_heads_body($headlist, $head, 0, 15,
+		git_heads_body(\@headlist, $head, 0, 15,
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
@@ -2542,7 +2560,7 @@ sub git_tags {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my $taglist = git_get_refs_list("refs/tags");
+	my ($taglist) = git_get_refs_list("tags");
 	if (defined @$taglist) {
 		git_tags_body($taglist);
 	}
@@ -2555,9 +2573,9 @@ sub git_heads {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my $taglist = git_get_refs_list("refs/heads");
-	if (defined @$taglist) {
-		git_heads_body($taglist, $head);
+	my ($headlist) = git_get_refs_list("heads");
+	if (defined @$headlist) {
+		git_heads_body($headlist, $head);
 	}
 	git_footer_html();
 }
-- 
1.4.2.1
