From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 07/11] gitweb: Refactor generating of long dates into format_timestamp_html
Date: Fri, 15 Apr 2011 16:44:01 +0200
Message-ID: <1302878645-458-8-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGX-0002G9-22
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab1DOOot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49049 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab1DOOoo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:44 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3299523wwa.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=+d+rucrYLBGVS3EJJSS06JdHlmFjTd11ECt4qnEjkt4=;
        b=N+Q1hrA0HmZMCKITg+7CWmKCnA6EE0aOkJKEk4UBJrcokdo2l4hQHYLsJAri0C3Q4/
         5WTxHVOd+333SYNTeLnyC4qT3KhjWT9WOcMaTLhouzAtkeaMY2n908naDOjbC+2ZzsqE
         HmuC4AllH5gnY7HIUEnjmapqK+rHwM+e5X9Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qvYSw/9PkoDGmZ0ev+NokoFglk3OUvGf/vpz3axknoEBC+/1zlEFbA+dDw2vpqWHep
         XxccGd5s+QFDOaD2Yd/y93L72y75Jox8wQluFDpfY+Tjtva43OXl15Ff3AZyd50vC1Lm
         Wg8HJxoF/zqa2EvgK8l+eDBSKpIL53Jy7Am1M=
Received: by 10.227.196.2 with SMTP id ee2mr2106054wbb.129.1302878683941;
        Fri, 15 Apr 2011 07:44:43 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.41
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171601>

It is pure refactoring and doesn't change gitweb output, though this
could potentially affect 'summary', 'log', and 'commit'-like views
('commit', 'commitdiff', 'tag').

Remove print_local_time and format_local_time, as their use is now
replaced (indirectly) by using format_timestamp_html.


While at it improve whitespace formatting.

Inspired-by-code-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from previous v1 version.

Note that this patch could be squashed with the next patch in series,
but I think that split version (pure refactoring + change in behavior)
is easier to review.

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
