From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 17] gitweb: Ref refactoring - use git_get_referencing for marking tagged/head commits
Date: Mon, 31 Jul 2006 02:21:52 +0200
Message-ID: <200607310221.55445.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 31 02:21:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7LXd-0005Hu-Pg
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 02:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWGaAVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 20:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWGaAVu
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 20:21:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:21875 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750762AbWGaAVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 20:21:50 -0400
Received: by ug-out-1314.google.com with SMTP id m3so499145ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 17:21:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AAUdo2FNubIktt7fXI7cNpCKXjmGTLY4J7WTpM/D0RFjfJj9oiFPdLXsaojGSEzfmk2KxMQjNfohbNeRzBtbwPBNZEBKTUZ+CdJJ6sWNCEBj64z//p+qo2M/Tk5uH5j9+0wlLCiOW7Fb3tHJbxevq0AjEzSQ8WbYvpRp2hPaf+4=
Received: by 10.66.222.9 with SMTP id u9mr1882703ugg;
        Sun, 30 Jul 2006 17:21:48 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id m1sm4576346uge.2006.07.30.17.21.48;
        Sun, 30 Jul 2006 17:21:48 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24479>

Use git_get_referencing to get HTML code for markers showing which
refs (tags and heads) point to current commit.  It would be much
easier to change format of markers in one or two places than thorough
the gitweb.cgi file.

Added comment about read_info_ref subroutine: for $type == "" (empty
argument) it saves only last path part of ref name e.g. from
'refs/heads/jn/gitweb' it would leave only 'gitweb'.

Some reordering.  Added $ref in one place.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |   53 ++++++++++++++++++++++-------------------------------
 1 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 83ea97a..dab6068 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1024,6 +1024,8 @@ sub read_info_ref {
 	open my $fd, "$projectroot/$project/info/refs" or return;
 	while (my $line = <$fd>) {
 		chomp $line;
+		# attention: for $type == "" it saves only last path part of ref name
+		# e.g. from 'refs/heads/jn/gitweb' it would leave only 'gitweb'
 		if ($line =~ m/^([0-9a-fA-F]{40})\t.*$type\/([^\^]+)/) {
 			if (defined $refs{$1}) {
 				$refs{$1} .= " / $2";
@@ -1036,6 +1038,16 @@ sub read_info_ref {
 	return \%refs;
 }
 
+sub git_get_referencing {
+	my ($refs, $id) = @_;
+
+	if (defined $refs->{$id}) {
+		return ' <span class="tag">' . esc_html($refs->{$id}) . '</span>';
+	} else {
+		return "";
+	}
+}
+
 sub git_read_refs {
 	my $ref_dir = shift;
 	my @reflist;
@@ -1151,10 +1163,7 @@ sub git_summary {
 		}
 		$alternate ^= 1;
 		if ($i-- > 0) {
-			my $ref = "";
-			if (defined $refs->{$commit}) {
-				$ref = " <span class=\"tag\">" . esc_html($refs->{$commit}) . "</span>";
-			}
+			my $ref = git_get_referencing($refs, $commit);
 			print "<td><i>$co{'age_string'}</i></td>\n" .
 			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 			      "<td>";
@@ -1728,10 +1737,7 @@ sub git_tree {
 	$/ = "\n";
 
 	my $refs = read_info_ref();
-	my $ref = "";
-	if (defined $refs->{$hash_base}) {
-		$ref = " <span class=\"tag\">" . esc_html($refs->{$hash_base}) . "</span>";
-	}
+	my $ref = git_get_referencing($refs, $hash_base);
 	git_header_html();
 	my $base_key = "";
 	my $base = "";
@@ -1912,10 +1918,7 @@ sub git_log {
 	}
 	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
 		my $commit = $revlist[$i];
-		my $ref = "";
-		if (defined $refs->{$commit}) {
-			$ref = " <span class=\"tag\">" . esc_html($refs->{$commit}) . "</span>";
-		}
+		my $ref = git_get_referencing($refs, $commit);
 		my %co = git_read_commit($commit);
 		next if !%co;
 		my %ad = date_str($co{'author_epoch'});
@@ -1979,16 +1982,13 @@ sub git_commit {
 		$expires = "+1d";
 	}
 	my $refs = read_info_ref();
-	my $ref = "";
-	if (defined $refs->{$co{'id'}}) {
-		$ref = " <span class=\"tag\">" . esc_html($refs->{$co{'id'}}) . "</span>";
-	}
-	git_header_html(undef, $expires);
+	my $ref = git_get_referencing($refs, $co{'id'});
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
 		$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;hb=$parent;f=$file_name")}, "blame");
 	}
+	git_header_html(undef, $expires);
 	git_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff', 
 							 $hash, $co{'tree'}, $hash,
 							 $formats_nav);
@@ -1996,7 +1996,7 @@ sub git_commit {
 	if (defined $co{'parent'}) {
 		git_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
 	} else {
-		git_header_div('tree', esc_html($co{'title'}), $co{'tree'}, $hash);
+		git_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table cellspacing=\"0\">\n";
@@ -2206,13 +2206,10 @@ sub git_commitdiff {
 		$expires = "+1d";
 	}
 	my $refs = read_info_ref();
-	my $ref = "";
-	if (defined $refs->{$co{'id'}}) {
-		$ref = " <span class=\"tag\">" . esc_html($refs->{$co{'id'}}) . "</span>";
-	}
-	git_header_html(undef, $expires);
+	my $ref = git_get_referencing($refs, $co{'id'});
 	my $formats_nav =
 		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
+	git_header_html(undef, $expires);
 	git_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 	git_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 	print "<div class=\"page_body\">\n";
@@ -2364,10 +2361,7 @@ sub git_history {
 			if (!%co) {
 				next;
 			}
-			my $ref = "";
-			if (defined $refs->{$commit}) {
-				$ref = " <span class=\"tag\">" . esc_html($refs->{$commit}) . "</span>";
-			}
+			my $ref = git_get_referencing($refs, $commit);
 			if ($alternate) {
 				print "<tr class=\"dark\">\n";
 			} else {
@@ -2559,10 +2553,7 @@ sub git_shortlog {
 	my $alternate = 0;
 	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
 		my $commit = $revlist[$i];
-		my $ref = "";
-		if (defined $refs->{$commit}) {
-			$ref = " <span class=\"tag\">" . esc_html($refs->{$commit}) . "</span>";
-		}
+		my $ref = git_get_referencing($refs, $commit);
 		my %co = git_read_commit($commit);
 		my %ad = date_str($co{'author_epoch'});
 		if ($alternate) {
-- 
1.4.0
