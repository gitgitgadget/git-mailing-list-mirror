From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 2/2] gitweb: refactor author+gravatar insertion
Date: Sun, 21 Jun 2009 19:57:05 +0200
Message-ID: <1245607025-19296-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245607025-19296-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245607025-19296-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 19:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIRJ5-0007oE-LD
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 19:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbZFUR4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZFUR4K
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 13:56:10 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:45440 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZFUR4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 13:56:09 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so2688201bwz.37
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WcDa6Q1qlzghbKFLXI6Dgi8oa2VsOCIA0+5ZTYOiEOY=;
        b=EQSjnfFbWyQl9PJIRrpM9QuLJzffAQJKlFC9mwI1SGvtpo3eeHjZ8sxYTDT6RLM30c
         LZZvGccakxIk8lEIWFXvvwAY0XIHGmYqQneqTn4v3nEsrqy7iSEbBqS2xmJYr1xpiky1
         vdPdJ5SAnEPYSYdv9j7FExSbySAWER6IYuXvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F+RppSBGsy/MWSTjlr03rRlhF33FhPX7+GEQredjxd+F7KcXHDyhCgCcECco3qkAIi
         wg8pFvBDT+pbBJQpUJN9+Cpev8+IHUEoFIYaNDQ6ZAyBacafx42iaY2aIDJefiJzhzE2
         wCH1gnSA5TPwyz9WI9t5xQCtRbCNcXXnSus1Q=
Received: by 10.204.51.210 with SMTP id e18mr5271324bkg.69.1245606972068;
        Sun, 21 Jun 2009 10:56:12 -0700 (PDT)
Received: from localhost (host-78-15-4-45.cust-adsl.tiscali.it [78.15.4.45])
        by mx.google.com with ESMTPS id p17sm10822407fka.12.2009.06.21.10.56.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Jun 2009 10:56:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245607025-19296-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121991>

---
 gitweb/gitweb.css  |    5 +++-
 gitweb/gitweb.perl |   69 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index eaf74c3..ddf982b 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -136,11 +136,14 @@ div.list_head {
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
index f5654d7..cb4ecc3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1496,6 +1496,31 @@ sub format_subject_html {
 	}
 }
 
+# insert a gravatar for the given $email at the given $size if the feature
+# is enabled
+sub git_get_gravatar {
+	if ($git_gravatar_enabled) {
+		my ($email, %params) = @_;
+		my $pre_white = ($params{'space_before'} ? "&nbsp;" : "");
+		my $post_white = ($params{'space_after'} ? "&nbsp;" : "");
+		my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
+		return $pre_white . "<img class=\"avatar\" src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
+		       Digest::MD5::md5_hex(lc $email) . "&amp;size=$size\" />" . $post_white;
+	} else {
+		return "";
+	}
+}
+
+# format, perhaps shortened and preceded by the gravatar, the author name
+sub format_author_html {
+	my $tag = shift;
+	my $co = shift;
+	my $author = chop_and_escape_str($co->{'author_name'}, @_);
+	return "<$tag class=\"author\">" .
+		git_get_gravatar($co->{'author_email'}, 'space_after' => 1) .
+		$author . "</$tag>\n";
+}
+
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
 sub format_git_diff_header_line {
 	my $line = shift;
@@ -3241,28 +3266,14 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
-# insert a gravatar for the given $email at the given $size if the feature
-# is enabled
-sub git_get_gravatar {
-	if ($git_gravatar_enabled) {
-		my ($email, %params) = @_;
-		my $pre_white = ($params{'space_before'} ? "&nbsp;" : "");
-		my $post_white = ($params{'space_after'} ? "&nbsp;" : "");
-		my $size = $avatar_size{$params{'size'}} || $avatar_size{'default'};
-		return $pre_white . "<img class=\"avatar\" src=\"http://www.gravatar.com/avatar.php?gravatar_id=" .
-		       Digest::MD5::md5_hex(lc $email) . "&amp;size=$size\" />" . $post_white;
-	} else {
-		return "";
-	}
-}
-
+# Outputs the author name and date in long form, followed by the gravatar
 sub git_print_authorship {
 	my $co = shift;
+	my $tag = shift || 'div';
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
-	print "<div class=\"author_date\">" .
+	print "<$tag class=\"author_date\">" .
 	      esc_html($co->{'author_name'}) .
-	      git_get_gravatar($co->{'author_email'}, 'space_before' => 1) .
 	      " [$ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
 		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
@@ -3271,7 +3282,9 @@ sub git_print_authorship {
 		printf(" (%02d:%02d %s)",
 		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
-	print "]</div>\n";
+	print "]" .
+	git_get_gravatar($co->{'author_email'}, 'space_before' => 1) .
+	"</$tag>\n";
 }
 
 sub git_print_page_path {
@@ -4185,11 +4198,9 @@ sub git_shortlog_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_and_escape_str($co{'author_name'}, 10);
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td>" . git_get_gravatar($co{'author_email'}, 'space_after' => 1) . "<i>" . $author . "</i></td>\n" .
-		      "<td>";
+			format_author_html('td', \%co, 10) . "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
@@ -4236,11 +4247,9 @@ sub git_history_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-	# shortlog uses      chop_str($co{'author_name'}, 10)
-		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td>" . git_get_gravatar($co{'author_email'}, 'space_after' => 1) . "<i>" . $author . "</i></td>\n" .
-		      "<td>";
+	# shortlog uses      format_author_html('td', \%co, 10)
+			format_author_html('td', \%co, 15, 3) . "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
 		print format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
@@ -4393,9 +4402,8 @@ sub git_search_grep_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td>" . git_get_gravatar($co{'author_email'}, 'space_after' => 1) . "<i>" . $author . "</i></td>\n" .
+		      format_author_html('td', \%co, 15, 5) .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 		               -class => "list subject"},
@@ -5137,10 +5145,9 @@ sub git_log {
 		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
-		      "</div>\n" .
-		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i>&nbsp;" .
-		      git_get_gravatar($co{'author_email'}) .
-		      "<br/>\n</div>\n";
+		      "</div>\n";
+		      git_print_authorship(\%co);
+		      print "<br/>\n</div>\n";
 
 		print "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
-- 
1.6.3.rc1.192.gdbfcb
