From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] gitweb: linkify author/committer names with search
Date: Tue, 13 Oct 2009 19:12:24 -0700
Message-ID: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 04:14:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxtNh-0005OC-HL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 04:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760254AbZJNCNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 22:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760102AbZJNCNi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 22:13:38 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:43131 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbZJNCNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 22:13:37 -0400
Received: by ey-out-2122.google.com with SMTP id 9so122100eyd.19
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=5rayNo0qLSC5DnxiQIyKMaxhN3AB4hO/y8pifQKmnrc=;
        b=slUYavk+IfGcOjurQwUqIHfPGN2B34VeHYXmRtUAiSAq/LQrV0Ry2ym2+BdIbRJ8d0
         1Sb+zDq/utU86pu+e2uiwc4DW/6R199Jg7ishDmgvGOEyZGWbEv6DEzD6ZLk+tptLVAH
         CDVKWckKXb0+R1hFnLT7cOYR84ILdqsys3/to=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P5iBf+h8S1r+x+fQgH5mCMTkdge14uZngK+d7wliiuwedC6bwRF0ySQhJAwOgaVpzT
         h7Yan4KDgMwAiMfIFQegMxIaMK/rHiqJd1PUSGjZd/JmcgWpGvv0nNo1DG2icjswcxSH
         R+gKhr07KTsh8hwukd3T9YGt6XVZmW1kjuckM=
Received: by 10.216.93.4 with SMTP id k4mr2672814wef.155.1255486350490;
        Tue, 13 Oct 2009 19:12:30 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id f13sm4386147gvd.21.2009.10.13.19.12.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 19:12:29 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 13 Oct 2009 19:12:24 -0700
X-Mailer: git-send-email 1.6.5.1.g75846.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130235>

It's nice to search for an author by merely clicking on their name in
gitweb. This is usually faster than selecting the name, copying the
selection, pasting it into the search box, selecting between
author/committer and then hitting enter.

Linkify the avatar icon in log/shortlog view because the icon is directly
adjacent to the name and thus more related. The same is not true
when in commit/tag view where the icon is farther away.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is on top of Giuseppe's fix esc_param patch.

 gitweb/gitweb.css  |    1 +
 gitweb/gitweb.perl |   21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 8f68fe3..e2cd9d7 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -30,6 +30,7 @@ img.logo {
 
 img.avatar {
 	vertical-align: middle;
+	border-width: 0px;
 }
 
 div.page_header {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4b21ad2..bdf1037 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1602,8 +1602,12 @@ sub format_author_html {
 	my $co = shift;
 	my $author = chop_and_escape_str($co->{'author_name'}, @_);
 	return "<$tag class=\"author\">" .
-	       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
-	       $author . "</$tag>";
+	       $cgi->a({-href => href(action=>"search", hash=>$hash,
+			searchtext=>$co->{'author_name'},
+			searchtype=>"author"), class=>"list"},
+			git_get_avatar($co->{'author_email'}, -pad_after => 1) .
+			$author) .
+	       "</$tag>";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3372,10 +3376,13 @@ sub git_print_authorship {
 	my $co = shift;
 	my %opts = @_;
 	my $tag = $opts{-tag} || 'div';
+	my $author = $co->{'author_name'};
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<$tag class=\"author_date\">" .
-	      esc_html($co->{'author_name'}) .
+	      $cgi->a({-href => href(action=>"search", searchtext=>$author,
+		      searchtype=>"author"), class=>"list"},
+		      esc_html($author)) .
 	      " [$ad{'rfc2822'}";
 	print_local_time(%ad) if ($opts{-localtime});
 	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
@@ -3394,8 +3401,12 @@ sub git_print_authorship_rows {
 	@people = ('author', 'committer') unless @people;
 	foreach my $who (@people) {
 		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
-		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
-		      "<td rowspan=\"2\">" .
+		print "<tr><td>$who</td><td>" .
+		      $cgi->a({-href => href(action=>"search",
+			       searchtext=>$co->{"${who}_name"},
+			       searchtype=>$who), class=>"list"},
+			       esc_html($co->{$who})) .
+		      "</td><td rowspan=\"2\">" .
 		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
 		      "</td></tr>\n" .
 		      "<tr>" .
-- 
1.6.5.1.g75846.dirty
