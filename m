From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 5/8] gitweb: Highlight matched part of project name when searching projects
Date: Wed, 15 Feb 2012 21:38:49 +0100
Message-ID: <1329338332-30358-6-git-send-email-jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:42:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxlfo-0006XA-H2
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab2BOUlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:37 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58575 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab2BOUle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:34 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so521741eek.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=h3HhcnVII+LGCvIGJysihlMKgJ9ocWDYyQml5t+xnn0=;
        b=nfk+3aSKGOwzUoKy6FTMB1C7l7ZnrW7vpgXqNzmvJ+PTebGUtUnYJZfKCCj/uX/3sv
         TVMrjlIvSVK+zvUIWmY1K/NjivSZ1gYqYUpC/l+S/jRVJhZ7CXGOYkcXfsn7qD72uGnS
         3zoUpmgwsh9f6VpdgDbdN9q2upHv97UqqOfeg=
Received: by 10.213.28.74 with SMTP id l10mr455209ebc.46.1329338493824;
        Wed, 15 Feb 2012 12:41:33 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.32
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:33 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190860>

Use newly introduced esc_html_match_hl() to escape HTML and mark match
with span element with 'match' class.  Currently only 'path' part
(i.e. project name) is highlighted; match might be on the project
description.

The code makes use of the fact that defined $search_regexp means that
there was search going on.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Introducing esc_html_match_hl() could have been put together with
introduction of esc_html_hl_regions() in previos commit.

Changes from v1:
* Main part of esc_html_match_hl() got split into esc_html_hl_regions(),
  which was introduced in previous commit.

 gitweb/gitweb.perl |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8dcd54b..5596701 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1742,6 +1742,20 @@ sub esc_html_hl_regions {
 	return $out;
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
+	return esc_html_hl_regions($str, 'match', @matches);
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
@@ -5389,7 +5403,9 @@ sub git_project_list_rows {
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
