From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 1/3] gitweb: refactor author name insertion
Date: Wed, 24 Jun 2009 23:16:21 +0200
Message-ID: <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 23:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJZpi-0000It-5o
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbZFXVQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZFXVQc
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:16:32 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:46512 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZFXVQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 17:16:30 -0400
Received: by mail-fx0-f213.google.com with SMTP id 9so1056667fxm.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=izPV0Ju+JHKix+BlXIj5MT5jWVNHxs55u+IIhIYfG1o=;
        b=tHRoMql1VGgYk0gaXteKoi/W4JKs1kY+RaZD0vDhc+cPZVChdFt2Ik27bVNz/O2KE2
         i//JHOiWVMPTrX8s/GMKoWTSvRbjlNh5yHhKSOKG7IeJsVn3xChiGlDxq3qtIiAjR+JC
         //cu+qg/EXHgwbdP61r38ogXH+EihQ0NxW3sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rc8yJCaxRBnjNlJhgxqRc8CgK2RvVjNhoqk2bbgJfu52bJNIsN28K9J4e2bVvogZ19
         ZBX5vP7ApzlR+qxVUv/Aog+Oq2kgSUCjiaa6LQDkHYPGtzbX3vTiLPkQdt5C0LKnVFHF
         qxiGxGfFIWPwKe2JfS3xqiY1M1ukuK7j3rMPA=
Received: by 10.103.189.18 with SMTP id r18mr1044294mup.80.1245878192821;
        Wed, 24 Jun 2009 14:16:32 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 23sm7716614mun.46.2009.06.24.14.16.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 14:16:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122155>

The refactoring allows easier customization of the output by means of
CSS and improves extensibility on the CGI side too.

Layout is preserved for all views except for 'commitdiff', which now
uses the same format as 'commit'.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    5 ++-
 gitweb/gitweb.perl |   79 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 51 insertions(+), 33 deletions(-)

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
index 1e7e2d8..223648f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1469,6 +1469,14 @@ sub format_subject_html {
 	}
 }
 
+# format the author name with the given tag and optionally shortening it
+sub format_author_html {
+	my $tag = shift;
+	my $co = shift;
+	my $author = chop_and_escape_str($co->{'author_name'}, @_);
+	return "<$tag class=\"author\">" . $author . "</$tag>\n";
+}
+
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
 sub format_git_diff_header_line {
 	my $line = shift;
@@ -3214,11 +3222,13 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+# Outputs the author name and date in long form
 sub git_print_authorship {
 	my $co = shift;
+	my $tag = shift || 'div';
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
-	print "<div class=\"author_date\">" .
+	print "<$tag class=\"author_date\">" .
 	      esc_html($co->{'author_name'}) .
 	      " [$ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
@@ -3228,7 +3238,30 @@ sub git_print_authorship {
 		printf(" (%02d:%02d %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
-	print "]</div>\n";
+	print "]</$tag>\n";
+}
+
+# Outputs the author and commiter name and date in long form
+sub git_print_who {
+	my $co = shift;
+	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
+	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
+	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
+	      "<tr>" .
+	      "<td></td><td> $ad{'rfc2822'}";
+	if ($ad{'hour_local'} < 6) {
+		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+	} else {
+		printf(" (%02d:%02d %s)",
+		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+	}
+	print "</td>" .
+	      "</tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
+	print "<tr><td></td><td> $cd{'rfc2822'}" .
+	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
+	      "</td></tr>\n";
 }
 
 sub git_print_page_path {
@@ -4142,11 +4175,9 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
-		      "<td>";
+			format_author_html('td', \%co, 10) . "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
@@ -4193,11 +4224,9 @@ sub git_history_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-	# shortlog uses      chop_str($co{'author_name'}, 10)
-		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . $author . "</i></td>\n" .
-		      "<td>";
+	# shortlog uses      format_author_html('td', \%co, 10)
+			format_author_html('td', \%co, 15, 3) . "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -4350,9 +4379,8 @@ sub git_search_grep_body {
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
@@ -5094,9 +5122,9 @@ sub git_log {
 		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
-		      "</div>\n" .
-		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
 		      "</div>\n";
+		      git_print_authorship(\%co);
+		      print "<br/>\n</div>\n";
 
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
@@ -5115,8 +5143,6 @@ sub git_commit {
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
 	    or die_error(404, "Unknown commit object");
-	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
-	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $parent  = $co{'parent'};
 	my $parents = $co{'parents'}; # listref
@@ -5183,22 +5209,7 @@ sub git_commit {
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
+	git_print_who(\%co);
 	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
 	print "<tr>" .
 	      "<td>tree</td>" .
@@ -5579,7 +5590,11 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		git_print_authorship(\%co);
+		print "<div class=\"title_text\">\n" .
+		      "<table class=\"object_header\">\n";
+		git_print_who(\%co);
+		print "</table>".
+		      "</div>\n";
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
-- 
1.6.3.rc1.192.gdbfcb
