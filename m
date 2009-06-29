From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 1/7] gitweb: refactor author name insertion
Date: Tue, 30 Jun 2009 00:00:48 +0200
Message-ID: <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:01:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOuz-0005Hd-CT
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758581AbZF2WAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758329AbZF2WAu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:00:50 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63590 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758464AbZF2WAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:00:48 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so3551293bwz.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZkhGKI7vzo919m8XkbbMHW5hOd/TrOxioETIdb39dng=;
        b=seQHSzi5Ndn9k9l2EheHX22v1ucgYebQHsU4XCM14GWAZ1B4QZclcD8svRvUwAE1js
         kbgHPDYE1Pt3Q+R1kjvM7e9f7usjuQI8HKUSXF5BBwzxJcKQMGQneHZCvbprU2er3EfQ
         4jZfVoc2+Lrimi7ThG+pQtktehqLm2gTyVphM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qIoeaVDFteDK07YtLJjanqzymveiVxtgXa1g+HuDXTDFUQ8ZBO6ULcc1Ayo4H7mv0W
         RuYqd7BqPo7ZLf2wm/C9goiX8Mx0mMjGRnqSLCpqWw3Ex4rjodOTH4tHcWWAoQGun7Kf
         BgELqqh9IoLeAe+4a/FKCP5JAqS8mU8FY5W2g=
Received: by 10.204.52.135 with SMTP id i7mr7601864bkg.154.1246312849576;
        Mon, 29 Jun 2009 15:00:49 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id z10sm8797395fka.35.2009.06.29.15.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:00:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122469>

Collect all author display code in appropriate functions, making it
easier to extend these functions on the CGI side.

We also move some of the presentation code from hard-coded HTML to CSS,
for easier customization.

A side effect of the refactoring is that now localtime is always
displayed with the 'at night' warning.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    5 ++-
 gitweb/gitweb.perl |   93 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index a01eac8..68b22ff 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -132,11 +132,14 @@ div.list_head {
 	font-style: italic;
 }
 
+.author_date, .author {
+	font-style: italic;
+}
+
 div.author_date {
 	padding: 8px;
 	border: solid #d9d8d1;
 	border-width: 0px 0px 1px 0px;
-	font-style: italic;
 }
 
 a.list {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1e7e2d8..7fd53f6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1469,6 +1469,16 @@ sub format_subject_html {
 	}
 }
 
+# format the author name of the given commit with the given tag
+# the author name is chopped and escaped according to the other
+# optional parameters (see chop_str).
+sub format_author_html {
+	my $tag = shift;
+	my $co = shift;
+	my $author = chop_and_escape_str($co->{'author_name'}, @_);
+	return "<$tag class=\"author\">" . $author . "</$tag>";
+}
+
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
 sub format_git_diff_header_line {
 	my $line = shift;
@@ -3214,21 +3224,50 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+sub print_local_time {
+	my %date = @_;
+	if ($date{'hour_local'} < 6) {
+		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
+	} else {
+		printf(" (%02d:%02d %s)",
+			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
+	}
+}
+
+# Outputs the author name and date in long form
 sub git_print_authorship {
 	my $co = shift;
+	my %opts = @_;
+	my $tag = $opts{-tag} || 'div';
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
-	print "<div class=\"author_date\">" .
+	print "<$tag class=\"author_date\">" .
 	      esc_html($co->{'author_name'}) .
 	      " [$ad{'rfc2822'}";
-	if ($ad{'hour_local'} < 6) {
-		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
-		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
-	} else {
-		printf(" (%02d:%02d %s)",
-		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+	print_local_time(%ad) if ($opts{-localtime});
+	print "]</$tag>\n";
+}
+
+# Outputs table rows containing the full author or committer information,
+# in the format expected for 'commit' view (& similia).
+# Parameters are a commit hash reference, followed by the list of people
+# to output information for. If the list is empty it defalts to both
+# author and committer.
+sub git_print_authorship_rows {
+	my $co = shift;
+	# too bad we can't use @people = @_ || ('author', 'committer')
+	my @people = @_;
+	@people = ('author', 'committer') unless @people;
+	foreach my $who (@people) {
+		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
+		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td></tr>\n".
+		      "<tr>" .
+		      "<td></td><td> $wd{'rfc2822'}";
+		print_local_time(%wd);
+		print "</td>" .
+		      "</tr>\n";
 	}
-	print "]</div>\n";
 }
 
 sub git_print_page_path {
@@ -4142,11 +4181,9 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
-		      "<td>";
+		      format_author_html('td', \%co, 10) . "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
@@ -4193,11 +4230,9 @@ sub git_history_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-	# shortlog uses      chop_str($co{'author_name'}, 10)
-		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
-		      "<td>";
+	# shortlog:   format_author_html('td', \%co, 10)
+		      format_author_html('td', \%co, 15, 3) . "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -4350,9 +4385,8 @@ sub git_search_grep_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
+		      format_author_html('td', \%co, 15, 5) .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 		               -class => "list subject"},
@@ -5094,9 +5128,9 @@ sub git_log {
 		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
-		      "</div>\n" .
-		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
 		      "</div>\n";
+		      git_print_authorship(\%co, -tag => 'span');
+		      print "<br/>\n</div>\n";
 
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
@@ -5115,8 +5149,6 @@ sub git_commit {
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
 	    or die_error(404, "Unknown commit object");
-	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
-	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $parent  = $co{'parent'};
 	my $parents = $co{'parents'}; # listref
@@ -5183,22 +5215,7 @@ sub git_commit {
 	}
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n";
-	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
-	      "<tr>" .
-	      "<td></td><td> $ad{'rfc2822'}";
-	if ($ad{'hour_local'} < 6) {
-		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
-		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
-	} else {
-		printf(" (%02d:%02d %s)",
-		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
-	}
-	print "</td>" .
-	      "</tr>\n";
-	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
-	print "<tr><td></td><td> $cd{'rfc2822'}" .
-	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
-	      "</td></tr>\n";
+	git_print_authorship_rows(\%co);
 	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
 	print "<tr>" .
 	      "<td>tree</td>" .
@@ -5579,7 +5596,7 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		git_print_authorship(\%co);
+		git_print_authorship(\%co, -localtime => 1);
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
-- 
1.6.3.rc1.192.gdbfcb
