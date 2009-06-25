From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 1/8] gitweb: refactor author name insertion
Date: Thu, 25 Jun 2009 12:43:00 +0200
Message-ID: <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQu-0008IK-3n
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324AbZFYKnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757211AbZFYKnN
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:13 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:57268 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756925AbZFYKnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:09 -0400
Received: by fxm9 with SMTP id 9so1350409fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Bt/KWV4hiDHwaKDTxdaZxmF7o/7X2vHbEkm9srWXZZ0=;
        b=QkkESw59hptKgl7I5uhj4r1D1tmnRVZt+itW60BLAro+XBEZLW1uHD7MLXY8lzQlGG
         3N2Zei9YCRWsJ3WU9+Vvhx0pdFAa3pHT3kqcKC8MzZSnsAdEGstI2HnPDIrmnMr8FA8D
         +hsHoGAUv5ixv+uQXXmW4ELZOfgjZOeG7F+bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mu/s2NqJtqCI+OWR4gCmRjURMTtkS8nTr+g9Jvjksu5lF7KtUNLrb+u5DjVQm7qftF
         pU1tAoRjwiH0vJOiNf+I50OFmIADCYVF2CRufSkthTbo17lr+RwKwstoCbO+b56P8omm
         4KCh85YzpiOeDDqpPGGI6j8mCymNlqnVVr/sM=
Received: by 10.204.55.15 with SMTP id s15mr2349280bkg.53.1245926590502;
        Thu, 25 Jun 2009 03:43:10 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 9sm3190568fks.28.2009.06.25.03.43.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122195>

Collect all author display code in appropriate functions, making it
easiser to extend them on the CGI side, and rely on CSS rather than
hard-coded HTML formatting for easier customization.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    5 ++-
 gitweb/gitweb.perl |   80 +++++++++++++++++++++++++++++++---------------------
 2 files changed, 52 insertions(+), 33 deletions(-)

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
index 1e7e2d8..9b60418 100755
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
+	return "<$tag class=\"author\">" . $author . "</$tag>\n";
+}
+
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
 sub format_git_diff_header_line {
 	my $line = shift;
@@ -3214,13 +3224,36 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+# Outputs the author name and date in long form
 sub git_print_authorship {
 	my $co = shift;
+	my %params = @_;
+	my $tag = $params{'tag'} || 'div';
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
-	print "<div class=\"author_date\">" .
+	print "<$tag class=\"author_date\">" .
 	      esc_html($co->{'author_name'}) .
 	      " [$ad{'rfc2822'}";
+	if ($params{'localtime'}) {
+		if ($ad{'hour_local'} < 6) {
+			printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
+			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+		} else {
+			printf(" (%02d:%02d %s)",
+			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+		}
+	}
+	print "]</$tag>\n";
+}
+
+# Outputs table rows containign the full author and commiter information.
+sub git_print_full_authorship {
+	my $co = shift;
+	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
+	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
+	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
+	      "<tr>" .
+	      "<td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
 		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
@@ -3228,7 +3261,12 @@ sub git_print_authorship {
 		printf(" (%02d:%02d %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
-	print "]</div>\n";
+	print "</td>" .
+	      "</tr>\n";
+	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
+	print "<tr><td></td><td> $cd{'rfc2822'}" .
+	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
+	      "</td></tr>\n";
 }
 
 sub git_print_page_path {
@@ -4142,11 +4180,9 @@ sub git_shortlog_body {
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
@@ -4193,11 +4229,9 @@ sub git_history_body {
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
@@ -4350,9 +4384,8 @@ sub git_search_grep_body {
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
@@ -5094,9 +5127,9 @@ sub git_log {
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
@@ -5115,8 +5148,6 @@ sub git_commit {
 	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash)
 	    or die_error(404, "Unknown commit object");
-	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
-	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my $parent  = $co{'parent'};
 	my $parents = $co{'parents'}; # listref
@@ -5183,22 +5214,7 @@ sub git_commit {
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
+	git_print_full_authorship(\%co);
 	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
 	print "<tr>" .
 	      "<td>tree</td>" .
@@ -5579,7 +5595,7 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		git_print_authorship(\%co);
+		git_print_authorship(\%co, 'localtime' => 1);
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
-- 
1.6.3.rc1.192.gdbfcb
