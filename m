From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 09/13] gitweb: Refactor generating of long dates into format_timestamp_html
Date: Thu, 28 Apr 2011 21:04:07 +0200
Message-ID: <1304017451-12283-10-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWu-0003bl-Ir
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933439Ab1D1TFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:05:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63114 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933414Ab1D1TEz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:55 -0400
Received: by wwa36 with SMTP id 36so3481351wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=sr0pv8/PhpYiaaQWAul2C6H2JWEtmZj51NC4qDmCa/o=;
        b=n1kGiH39GLz2qZwrKWdu3DyZ+wNZolQsMKLgg4G7CQOzCVvYNRimoXMdAMKFV64/bV
         8+FFsIfJ2RwEB09SOSEbvVHjnU1fbbIq2lJQ4FC7ZLWzBWFZs90oKuto/k+0IokPO+/m
         ufgNbDASll27aN3S8FzO1knCfC+90TJ1gMLVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=myMPipgE/DXWdw03asRLRjOwLQmpEQt9IJHH/RKV0Ken6e4ZjAlV+BQgXTcpN94q3a
         6jNvRkMOhUY/BwREafxraX1HBcPz3DX8mdGGPjDUHQq3Altv/I0pQnbOHaSZMjOu62jW
         9UAw3FW6RiDugmx7GX2fiFsP6qqpdv8TV7iVM=
Received: by 10.227.196.2 with SMTP id ee2mr3882733wbb.129.1304017493936;
        Thu, 28 Apr 2011 12:04:53 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.52
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172393>

It is pure refactoring and doesn't change gitweb output, though this
could potentially affect 'summary', 'log', and 'commit'-like views
('commit', 'commitdiff', 'tag').

Remove print_local_time and format_local_time, as their use is now
replaced (indirectly) by using format_timestamp_html.


While at it improve whitespace formatting.

Inspired-by-code-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from first version of this series.

This helper subroutine would reduce a bit code repetition that can be
found in original J.H. patch.

 gitweb/gitweb.perl |   45 ++++++++++++++++++++++-----------------------
 1 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ee69ea6..7329db2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3938,22 +3938,21 @@ sub git_print_section {
 	print $cgi->end_div;
 }
 
-sub print_local_time {
-	print format_local_time(@_);
-}
+sub format_timestamp_html {
+	my ($date, %opts) = @_;
+	my $strtime = $date->{'rfc2822'};
 
-sub format_local_time {
-	my $localtime = '';
-	my %date = @_;
-	if ($date{'hour_local'} < 6) {
-		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
-			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
-	} else {
-		$localtime .= sprintf(" (%02d:%02d %s)",
-			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
+	return $strtime unless $opts{'-localtime'};
+
+	my $localtime_format = '(%02d:%02d %s)';
+	if ($date->{'hour_local'} < 6) {
+		$localtime_format = '(<span class="atnight">%02d:%02d</span> %s)';
 	}
+	$strtime .= ' ' .
+	            sprintf($localtime_format,
+	                    $date->{'hour_local'}, $date->{'minute_local'}, $date->{'tz_local'});
 
-	return $localtime;
+	return $strtime;
 }
 
 # Outputs the author name and date in long form
@@ -3966,10 +3965,9 @@ sub git_print_authorship {
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<$tag class=\"author_date\">" .
 	      format_search_author($author, "author", esc_html($author)) .
-	      " [$ad{'rfc2822'}";
-	print_local_time(%ad) if ($opts{-localtime});
-	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
-		  . "</$tag>\n";
+	      " [".format_timestamp_html(\%ad, %opts)."]".
+	      git_get_avatar($co->{'author_email'}, -pad_before => 1) .
+	      "</$tag>\n";
 }
 
 # Outputs table rows containing the full author or committer information,
@@ -3986,16 +3984,16 @@ sub git_print_authorship_rows {
 		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
 		print "<tr><td>$who</td><td>" .
 		      format_search_author($co->{"${who}_name"}, $who,
-			       esc_html($co->{"${who}_name"})) . " " .
+		                           esc_html($co->{"${who}_name"})) . " " .
 		      format_search_author($co->{"${who}_email"}, $who,
-			       esc_html("<" . $co->{"${who}_email"} . ">")) .
+		                           esc_html("<" . $co->{"${who}_email"} . ">")) .
 		      "</td><td rowspan=\"2\">" .
 		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
 		      "</td></tr>\n" .
 		      "<tr>" .
-		      "<td></td><td> $wd{'rfc2822'}";
-		print_local_time(%wd);
-		print "</td>" .
+		      "<td></td><td>" .
+		      format_timestamp_html(\%wd, -localtime=>1) .
+		      "</td>" .
 		      "</tr>\n";
 	}
 }
@@ -5410,7 +5408,8 @@ sub git_summary {
 	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (defined $cd{'rfc2822'}) {
-		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+		print "<tr id=\"metadata_lchange\"><td>last change</td>" .
+		      "<td>".format_timestamp_html(\%cd)."</td></tr>\n";
 	}
 
 	# use per project git URL list in $projectroot/$project/cloneurl
-- 
1.7.3
