X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Use git-for-each-ref to generate list of heads and/or tags
Date: Thu, 2 Nov 2006 20:23:11 +0100
Message-ID: <200611022023.12246.jnareb@gmail.com>
References: <200610281930.05889.jnareb@gmail.com> <7vslh86uz9.fsf@assigned-by-dhcp.cox.net> <200611022017.31351.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 2 Nov 2006 19:39:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ArzYfdWJxUAmRcI0rleiMuxWgd2ox6xgWw8E8hqgzaiX/sdIw+M44ZOHCBsgWFsmGa5VUhfJh6lMlq9SaLExD9DhUFkusYUcVD2B7voJ9sjaG/21AmTBAppqNvouKDN/CMBPD1WodhKx6OuxnPBCEDPkH+J2zjEq9uPMTEdxYsg=
User-Agent: KMail/1.9.3
In-Reply-To: <200611022017.31351.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30764>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfi9h-0003Rw-2S for gcvg-git@gmane.org; Thu, 02 Nov
 2006 20:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752332AbWKBTXK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 14:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbWKBTXK
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 14:23:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:15559 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752334AbWKBTXI
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 14:23:08 -0500
Received: by ug-out-1314.google.com with SMTP id m3so214845ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 11:23:06 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr1230185ugl.1162495385118; Thu, 02
 Nov 2006 11:23:05 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id u6sm753629uge.2006.11.02.11.23.04; Thu, 02 Nov
 2006 11:23:04 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

From 4d86b34d49dd1f18da465952be8306348fef5150 Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Thu, 2 Nov 2006 20:14:15 +0100
Subject: [PATCH 2/2] gitweb: Use git-for-each-ref to generate list of heads and/or tags

Add two subroutines: git_get_heads_list and git_get_refs_list, which
fill out needed parts of refs info (heads and tags respectively) info
using single call to git-for-each-ref, instead of using
git-peek-remote to get list of references and using parse_ref for each
ref to get ref info, which in turn uses at least one call of git
command.

Replace call to git_get_refs_list in git_summary by call to
git_get_references, git_get_heads_list and git_get_tags_list
(simplifying this subroutine a bit). Use git_get_heads_list in
git_heads and git_get_tags_list in git_tags. Modify git_tags_body
slightly to accept output from git_get_tags_list.

Remove no longer used, and a bit hackish, git_get_refs_list.
parse_ref is no longer used, but is left for now.

Generating "summary" and "tags" views should be much faster for
projects which have large number of tags.

CHANGES IN OUTPUT: Before, if ref in refs/tags was tag pointing to
commit we used committer epoch as epoch for ref, and used tagger epoch
as epoch only for tag pointing to object of other type. If ref in
refs/tags was commit, we used committer epoch as epoch for ref (see
parse_ref; we sorted in gitweb by 'epoch' field).

Currently we use committer epoch for refs pointing to commit objects,
and tagger epoch for refs pointing to tag object, even if tag points
to commit. Going back to old behavior needs additional changes to
git-for-each-ref sorting (sort by given field and use other if first
is not available, --sort=<key>|<key>).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Pasky, you asked for faster "summary" and "tags" view. Simple ab benchmark
before and after this patch for my git.git repository (git/jnareb-git.git)
with some heads and tags added as compared to git.git repository, shows
around 2.4-3.0 times speedup for "summary" and "tags" views:

 summary   3134 +/- 24.2 ms  -->   1081 +/- 30.2 ms
 tags      2886 +/- 18.9 ms  -->   1196 +/- 15.6 ms

 gitweb/gitweb.perl |  153 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 92 insertions(+), 61 deletions(-)
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bf5f829..7710cc2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1294,47 +1294,88 @@ sub parse_ls_tree_line ($;%) {
 ## ......................................................................
 ## parse to array of hashes functions
 
-sub git_get_refs_list {
-	my $type = shift || "";
-	my %refs;
-	my @reflist;
-
-	my @refs;
-	open my $fd, "-|", $GIT, "peek-remote", "$projectroot/$project/"
+sub git_get_heads_list {
+	my $limit = shift;
+	my @headslist;
+
+	open my $fd, '-|', git_cmd(), 'for-each-ref',
+		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
+		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
+		'refs/heads'
 		or return;
 	while (my $line = <$fd>) {
-		chomp $line;
-		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?([^\^]+))(\^\{\})?$/) {
-			if (defined $refs{$1}) {
-				push @{$refs{$1}}, $2;
-			} else {
-				$refs{$1} = [ $2 ];
-			}
+		my %ref_item;
 
-			if (! $4) { # unpeeled, direct reference
-				push @refs, { hash => $1, name => $3 }; # without type
-			} elsif ($3 eq $refs[-1]{'name'}) {
-				# most likely a tag is followed by its peeled
-				# (deref) one, and when that happens we know the
-				# previous one was of type 'tag'.
-				$refs[-1]{'type'} = "tag";
-			}
+		chomp $line;
+		my ($refinfo, $committerinfo) = split(/\0/, $line);
+		my ($hash, $name, $title) = split(' ', $refinfo, 3);
+		my ($committer, $epoch, $tz) =
+			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$name =~ s!^refs/heads/!!;
+
+		$ref_item{'name'}  = $name;
+		$ref_item{'id'}    = $hash;
+		$ref_item{'title'} = $title || '(no commit message)';
+		$ref_item{'epoch'} = $epoch;
+		if ($epoch) {
+			$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
+		} else {
+			$ref_item{'age'} = "unknown";
 		}
+
+		push @headslist, \%ref_item;
 	}
 	close $fd;
 
-	foreach my $ref (@refs) {
-		my $ref_file = $ref->{'name'};
-		my $ref_id   = $ref->{'hash'};
+	return wantarray ? @headslist : \@headslist;
+}
+
+sub git_get_tags_list {
+	my $limit = shift;
+	my @tagslist;
 
-		my $type = $ref->{'type'} || git_get_type($ref_id) || next;
-		my %ref_item = parse_ref($ref_file, $ref_id, $type);
+	open my $fd, '-|', git_cmd(), 'for-each-ref',
+		($limit ? '--count='.($limit+1) : ()), '--sort=-creatordate',
+		'--format=%(objectname) %(objecttype) %(refname) '.
+		'%(*objectname) %(*objecttype) %(subject)%00%(creator)',
+		'refs/tags'
+		or return;
+	while (my $line = <$fd>) {
+		my %ref_item;
 
-		push @reflist, \%ref_item;
+		chomp $line;
+		my ($refinfo, $creatorinfo) = split(/\0/, $line);
+		my ($id, $type, $name, $refid, $reftype, $title) = split(' ', $refinfo, 6);
+		my ($creator, $epoch, $tz) =
+			($creatorinfo =~ /^(.*) ([0-9]+) (.*)$/);
+		$name =~ s!^refs/tags/!!;
+
+		$ref_item{'type'} = $type;
+		$ref_item{'id'} = $id;
+		$ref_item{'name'} = $name;
+		if ($type eq "tag") {
+			$ref_item{'subject'} = $title;
+			$ref_item{'reftype'} = $reftype;
+			$ref_item{'refid'}   = $refid;
+		} else {
+			$ref_item{'reftype'} = $type;
+			$ref_item{'refid'}   = $id;
+		}
+
+		if ($type eq "tag" || $type eq "commit") {
+			$ref_item{'epoch'} = $epoch;
+			if ($epoch) {
+				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});
+			} else {
+				$ref_item{'age'} = "unknown";
+			}
+		}
+
+		push @tagslist, \%ref_item;
 	}
-	# sort refs by age
-	@reflist = sort {$b->{'epoch'} <=> $a->{'epoch'}} @reflist;
-	return (\@reflist, \%refs);
+	close $fd;
+
+	return wantarray ? @tagslist : \@tagslist;
 }
 
 ## ----------------------------------------------------------------------
@@ -2264,8 +2305,7 @@ sub git_tags_body {
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $taglist->[$i];
 		my %tag = %$entry;
-		my $comment_lines = $tag{'comment'};
-		my $comment = shift @$comment_lines;
+		my $comment = $tag{'subject'};
 		my $comment_short;
 		if (defined $comment) {
 			$comment_short = chop_str($comment, 30, 5);
@@ -2298,7 +2338,7 @@ sub git_tags_body {
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'})}, $tag{'reftype'});
 		if ($tag{'reftype'} eq "commit") {
 			print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") .
-			      " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'refid'})}, "log");
+			      " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'name'})}, "log");
 		} elsif ($tag{'reftype'} eq "blob") {
 			print " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw");
 		}
@@ -2323,23 +2363,23 @@ sub git_heads_body {
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
-		my %tag = %$entry;
-		my $curr = $tag{'id'} eq $head;
+		my %ref = %$entry;
+		my $curr = $ref{'id'} eq $head;
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td><i>$tag{'age'}</i></td>\n" .
-		      ($tag{'id'} eq $head ? "<td class=\"current_head\">" : "<td>") .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'}),
-		               -class => "list name"},esc_html($tag{'name'})) .
+		print "<td><i>$ref{'age'}</i></td>\n" .
+		      ($curr ? "<td class=\"current_head\">" : "<td>") .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'}),
+		               -class => "list name"},esc_html($ref{'name'})) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") . " | " .
-		      $cgi->a({-href => href(action=>"log", hash=>$tag{'name'})}, "log") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$tag{'name'}, hash_base=>$tag{'name'})}, "tree") .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'})}, "shortlog") . " | " .
+		      $cgi->a({-href => href(action=>"log", hash=>$ref{'name'})}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'name'}, hash_base=>$ref{'name'})}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
@@ -2489,18 +2529,9 @@ sub git_summary {
 
 	my $owner = git_get_project_owner($project);
 
-	my ($reflist, $refs) = git_get_refs_list();
-
-	my @taglist;
-	my @headlist;
-	foreach my $ref (@$reflist) {
-		if ($ref->{'name'} =~ s!^heads/!!) {
-			push @headlist, $ref;
-		} else {
-			$ref->{'name'} =~ s!^tags/!!;
-			push @taglist, $ref;
-		}
-	}
+	my $refs = git_get_references();
+	my @taglist  = git_get_tags_list(15);
+	my @headlist = git_get_heads_list(15);
 
 	git_header_html();
 	git_print_page_nav('summary','', $head);
@@ -2792,9 +2823,9 @@ sub git_tags {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my ($taglist) = git_get_refs_list("tags");
-	if (@$taglist) {
-		git_tags_body($taglist);
+	my @tagslist = git_get_tags_list();
+	if (@tagslist) {
+		git_tags_body(\@tagslist);
 	}
 	git_footer_html();
 }
@@ -2805,9 +2836,9 @@ sub git_heads {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my ($headlist) = git_get_refs_list("heads");
-	if (@$headlist) {
-		git_heads_body($headlist, $head);
+	my @headslist = git_get_heads_list();
+	if (@headslist) {
+		git_heads_body(\@headslist, $head);
 	}
 	git_footer_html();
 }
-- 
1.4.3.3
