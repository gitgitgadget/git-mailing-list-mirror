From: Stephen Boyd <bebarino@gmail.com>
Subject: [RFC/PATCH] gitweb: linkify author/committer names with search
Date: Sun, 11 Oct 2009 23:19:00 -0700
Message-ID: <1255328340-28449-1-git-send-email-bebarino@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 08:22:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxEId-0007CI-7B
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 08:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbZJLGUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 02:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbZJLGUM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 02:20:12 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:44849 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbZJLGUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 02:20:11 -0400
Received: by qw-out-2122.google.com with SMTP id 9so488951qwb.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=bLFIQGV0IN4vpkGhBfa/8xG6qzGlLBjtX1yqehkOSqA=;
        b=LgjLdgv1ORNwQQsO+BxsFu0NsXv9Jr4AflprzK3ujqcC47ucFxI8/2DJk0SSFGaQ3r
         qF2yVUJUOqZyBX63a+FOPHpN4+sZYmkRTRKRbRgRWOgCHbFKrd+te/x1v23mIPovvRbk
         5sVyps0RAPbzgu5W0zZk0z+yjhfXYT8EuLgdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GrRvkLR6Sa/1lvagt4IjsZfE8Ik6KOMSagYyRddC5DBohPscnVjQhKJ4W/jYC8LyZl
         mmjr5dUkNzFLnw4ZSp4dOjpsF++eK6zzaGEhI0gUMCZ2E+sYpShMwDjjtwX3FObOxWFr
         j8uRiQqhEpaBjjHfO/6Ztn6+jK81ffl5mCbfU=
Received: by 10.224.69.231 with SMTP id a39mr4464246qaj.272.1255328344797;
        Sun, 11 Oct 2009 23:19:04 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm550502qwe.54.2009.10.11.23.19.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 23:19:03 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 11 Oct 2009 23:19:00 -0700
X-Mailer: git-send-email 1.6.5.1.g53fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129986>

It's nice to search for an author by merely clicking on their name in
gitweb. This is usually faster than selecting the name, copying the
selection, pasting it into the search box, selecting between
author/committer and then hitting enter.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Cc'ed Jakub as he seems to be resident gitweb expert. 

I thought this might be a nice addition.

The problem is I can't get it to work with UTF-8 characters. I'm not sure
if it's my system or not, so I'm just posting here to see if others
experience the same problem and if there's interest.

 gitweb/gitweb.perl |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..349e734 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1604,7 +1604,10 @@ sub format_author_html {
 	my $author = chop_and_escape_str($co->{'author_name'}, @_);
 	return "<$tag class=\"author\">" .
 	       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
-	       $author . "</$tag>";
+	       $cgi->a({-href => href(action=>"search", hash=>$hash,
+			searchtext=>$co->{'author_name'},
+			searchtype=>"author"), class=>"list"}, $author) .
+	       "</$tag>";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3373,10 +3376,13 @@ sub git_print_authorship {
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
@@ -3395,8 +3401,12 @@ sub git_print_authorship_rows {
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
1.6.5.1.g53fd
