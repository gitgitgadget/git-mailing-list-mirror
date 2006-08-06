From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/6] gitweb: Refactor git_history_body
Date: Sun, 6 Aug 2006 02:17:07 +0200
Message-ID: <200608060217.07512.jnareb@gmail.com>
References: <200608060206.49086.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 02:16:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9WK4-0003bb-I1
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWHFAQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWHFAQj
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:16:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:12338 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751448AbWHFAQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:16:35 -0400
Received: by nf-out-0910.google.com with SMTP id p46so40346nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:16:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W0OkXn+zGJE6RIPsBj3rJf3egQNisJg2xGBY7mBK4mS1jh973MIWSi3/ETdXOhH8Itva9erfhWD40N9bHQpKUEnGWVe9nnA1fnou00Lw0u3lZkaOh5K6kz3SultT1NBipanwCJ3n1kKHYxWCtr8XAY1mqESldI91AmpzoDdI6Fk=
Received: by 10.49.90.4 with SMTP id s4mr6989196nfl;
        Sat, 05 Aug 2006 17:16:35 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r33sm4188262nfc.2006.08.05.17.16.34;
        Sat, 05 Aug 2006 17:16:34 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608060206.49086.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24948>

Separates main part of git_history into git_history_body subroutine,
and make output more similar to git_shortlog.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
We couldn't just modify git_shortlog, because git_shortlog reads full
(--max-count limited) output of rev-list to array, which is needed 
for dividing into pages and pagination navigation bar, while git_history
reads rev-list output line by line.

 gitweb/gitweb.perl |   93 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7ea52b1..2a39145 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1124,6 +1124,62 @@ sub git_shortlog_body {
 	print "</table>\n";
 }
 
+sub git_history_body {
+	# Warning: assumes constant type (blob or tree) during history
+	my ($fd, $refs, $hash_base, $ftype, $extra) = @_;
+
+	print "<table class=\"history\" cellspacing=\"0\">\n";
+	my $alternate = 0;
+	while (my $line = <$fd>) {
+		if ($line !~ m/^([0-9a-fA-F]{40})/) {
+			next;
+		}
+
+		my $commit = $1;
+		my %co = parse_commit($commit);
+		if (!%co) {
+			next;
+		}
+
+		my $ref = format_mark_referencing($refs, $commit);
+
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+		      # shortlog uses      chop_str($co{'author_name'}, 10)
+		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
+		      "<td>";
+		# originally git_history used chop_str($co{'title'}, 50)
+		print_title_html($co{'title'}, $co{'title_short'}, "p=$project;a=commit;h=$commit", 1, $ref);
+		print "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$ftype;hb=$commit;f=$file_name")}, $ftype);
+
+		my $blob_current = git_get_hash_by_path($hash_base, $file_name);
+		my $blob_parent  = git_get_hash_by_path($commit, $file_name);
+		if (defined $blob_current && defined $blob_parent &&
+				$blob_current ne $blob_parent) {
+			print " | " .
+				$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$blob_current;hp=$blob_parent;hb=$commit;f=$file_name")},
+				"diff to current");
+		}
+		print "</td>\n" .
+		      "</tr>\n";
+	}
+	if (defined $extra) {
+		print "<tr>\n" .
+		      "<td colspan=\"4\">$extra</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+}
+
 sub git_tags_body {
 	# uses global variable $project
 	my ($taglist, $from, $to, $extra) = @_;
@@ -2295,42 +2351,7 @@ sub git_history {
 
 	open my $fd, "-|",
 		$GIT, "rev-list", "--full-history", $hash_base, "--", $file_name;
-	print "<table cellspacing=\"0\">\n";
-	my $alternate = 0;
-	while (my $line = <$fd>) {
-		if ($line =~ m/^([0-9a-fA-F]{40})/){
-			my $commit = $1;
-			my %co = parse_commit($commit);
-			if (!%co) {
-				next;
-			}
-			my $ref = format_mark_referencing($refs, $commit);
-			if ($alternate) {
-				print "<tr class=\"dark\">\n";
-			} else {
-				print "<tr class=\"light\">\n";
-			}
-			$alternate ^= 1;
-			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
-			      "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list"}, "<b>" .
-			      esc_html(chop_str($co{'title'}, 50)) . "$ref</b>") . "</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$ftype;hb=$commit;f=$file_name")}, $ftype);
-			my $blob = git_get_hash_by_path($hash_base, $file_name);
-			my $blob_parent = git_get_hash_by_path($commit, $file_name);
-			if (defined $blob && defined $blob_parent && $blob ne $blob_parent) {
-				print " | " .
-				$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$blob;hp=$blob_parent;hb=$commit;f=$file_name")},
-				"diff to current");
-			}
-			print "</td>\n" .
-			      "</tr>\n";
-		}
-	}
-	print "</table>\n";
+	git_history_body($fd, $refs, $hash_base, $ftype);
 	close $fd;
 	git_footer_html();
 }
-- 
1.4.1.1
