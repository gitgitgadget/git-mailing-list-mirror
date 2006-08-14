From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/9] gitweb: Separate main part of git_history into git_history_body
Date: Mon, 14 Aug 2006 02:09:08 +0200
Message-ID: <200608140209.09189.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZVD-0001tP-1y
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbWHNKQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWHNKQl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:653 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751971AbWHNKQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:39 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20995nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hXStn8QZ+k+1w9kOSJPtITxwJAr7zlOTH5rSBWj+BFtRGEBq5/jKT1zmc4daczy+p8n/CleygI0u3Cl8y8fCKJaGwhIqCvWYoMe8CFPQEOdGaQfwKSGQS1ntLPZGZNgXXDLYuL8ARIlSuPqb6aM+M0yFoo9g+YEvqPBhkW/DHzw=
Received: by 10.49.10.3 with SMTP id n3mr1049738nfi;
        Mon, 14 Aug 2006 03:16:38 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.38;
        Mon, 14 Aug 2006 03:16:38 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25346>

Separates main part of git_history into git_history_body subroutine,
and makes output more similar to git_shortlog.  Adds "diff to current"
link only for history of regular file (blob).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   96 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c4d6eab..5af6e77 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1117,6 +1117,64 @@ sub git_shortlog_body {
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
+		my $ref = format_ref_marker($refs, $commit);
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
+		print format_subject_html($co{'title'}, $co{'title_short'}, "p=$project;a=commit;h=$commit", $ref);
+		print "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$ftype;hb=$commit;f=$file_name")}, $ftype);
+
+		if ($ftype eq 'blob') {
+			my $blob_current = git_get_hash_by_path($hash_base, $file_name);
+			my $blob_parent  = git_get_hash_by_path($commit, $file_name);
+			if (defined $blob_current && defined $blob_parent &&
+					$blob_current ne $blob_parent) {
+				print " | " .
+					$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$blob_current;hp=$blob_parent;hb=$commit;f=$file_name")},
+					        "diff to current");
+			}
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
@@ -2297,42 +2355,8 @@ sub git_history {
 
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
-			my $ref = format_ref_marker($refs, $commit);
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
+
 	close $fd;
 	git_footer_html();
 }
-- 
1.4.1.1
