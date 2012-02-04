From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Highlight matched part of project name when searching projects
Date: Sat,  4 Feb 2012 13:47:26 +0100
Message-ID: <1328359648-29511-4-git-send-email-jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:48:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtf2B-0003kS-41
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 13:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab2BDMrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 07:47:41 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52260 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab2BDMrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 07:47:40 -0500
Received: by eekc14 with SMTP id c14so1494821eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=go4Cuee/a6Wx5immWLk+xnEASMbrMJHfe8ABKNiiTCM=;
        b=uT8ErfgRi0NR7vJp9jYtF2glyhsnyeKArpMwAJuxVtUzw27sYj9h+P08rbFMw/zbWW
         Fq4gVxHp/8zxedGxk34JJTvxKZwViMWZaf56WHGm/pGRkQTZHdS0wTShvI9JKQvR2/ul
         ajvJzNLGpHoQyYrH26dHnSxnWu39FCLizNDW8=
Received: by 10.14.127.5 with SMTP id c5mr3578298eei.17.1328359659291;
        Sat, 04 Feb 2012 04:47:39 -0800 (PST)
Received: from localhost.localdomain (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id z47sm26890568eeh.9.2012.02.04.04.47.38
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 04:47:38 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189867>

Use newly introduced esc_html_match_hl() to escape HTML and mark match
with span element with 'match' class.  Currently only 'path' part
(i.e. project name) is highlighted; match might be on the project
description.

The code makes use of the fact that defined $search_regexp means that
there was search going on.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Introducing esc_html_match_hl() could have been split into a separate
commit, but it would be subroutine without any use.

 gitweb/gitweb.perl |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 95ca00f..aef15c8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1715,6 +1715,30 @@ sub chop_and_escape_str {
 	}
 }
 
+# highlight match (if any), and escape HTML
+sub esc_html_match_hl {
+	my ($str, $regexp) = @_;
+	return esc_html($str) unless defined $regexp;
+
+	my @matches;
+	while ($str =~ /$regexp/g) {
+		push @matches, [$-[0], $+[0]];
+	}
+	return esc_html($str) unless @matches;
+
+	my $out = '';
+	my $pos = 0;
+	for my $m (@matches) {
+		$out .= esc_html(substr $str, $pos, $m->[0] - $pos);
+		$out .= $cgi->span({-class => 'match'},
+		                   esc_html(substr $str, $m->[0], $m->[1] - $m->[0]));
+		$pos = $m->[1];
+	}
+	$out .= esc_html(substr $str, $pos);
+
+	return $out;
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
@@ -5342,7 +5366,9 @@ sub git_project_list_rows {
 			print "</td>\n";
 		}
 		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		                        -class => "list"},
+		                       esc_html_match_hl($pr->{'path'}, $search_regexp)) .
+		      "</td>\n" .
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
-- 
1.7.9
