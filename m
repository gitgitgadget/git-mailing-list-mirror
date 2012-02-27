From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 3/4] gitweb: Highlight matched part of project description when searching projects
Date: Mon, 27 Feb 2012 02:55:21 +0100
Message-ID: <1330307722-25351-4-git-send-email-jnareb@gmail.com>
References: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 02:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1pp3-0007tu-6X
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab2B0B4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:56:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63475 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab2B0Bzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:55:36 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so561041eek.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 17:55:35 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.28.75 as permitted sender) client-ip=10.14.28.75;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.28.75 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.28.75])
        by 10.14.28.75 with SMTP id f51mr6597463eea.118.1330307735695 (num_hops = 1);
        Sun, 26 Feb 2012 17:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=edBw4jiS7aozyhair0224vYPa+CCdgBJNZbIGmo10kk=;
        b=vK4GjJvNs/XHVm1tpn/TATMXIkXZyIOqGSbYRvixGJdwX4lCrONvYNaQf8fc8Dk5Q+
         He5B+Lmb1Z/iS319SkhBC4I1f7YA9W3IK7APjZfAtwRmsJ97rLPhYUEWDQyQLITKUo78
         5sksIY0FU3/GGaaqVnWBJrJHMoXwDUrFV7CB0=
Received: by 10.14.28.75 with SMTP id f51mr4999715eea.118.1330307735600;
        Sun, 26 Feb 2012 17:55:35 -0800 (PST)
Received: from localhost.localdomain (abvv154.neoplus.adsl.tpnet.pl. [83.8.219.154])
        by mx.google.com with ESMTPS id n17sm52112996eei.3.2012.02.26.17.55.34
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 17:55:35 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191596>

Use esc_html_match_hl() from earlier commit to mark match in the
_whole_ description when searching projects.

Currently, with this commit, when searching projects there is always
shown full description of a project, and not a shortened one (like for
ordinary projects list view), even if the match is on project name and
not project description.  Because we always show full description of a
project, and not possibly shortened name, there is no need for having
full description on mouseover via title attribute.

Showing full description when there is match on it is useful to avoid
situation where match is in shortened, invisible part.  On the other
hand that makes project search different than projects list view; also
there can be problems with overly-long project descriptions.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from v2 and v1:
* Code updated to not use -title attribute in project search; we don't
  need to show full project description on mouseover, as we always
  show description in full, not shortened.

* Commit message updated to changes in previous commits.

* Removed notes (in commit message) about trouble with highlighting
  match of full description using shortened one; we add it in next
  commit, and it is not very complicated.

 gitweb/gitweb.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 829526f..03a8dd9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5411,8 +5411,12 @@ sub git_project_list_rows {
 		                       esc_html_match_hl($pr->{'path'}, $search_regexp)) .
 		      "</td>\n" .
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list", -title => $pr->{'descr_long'}},
-		                        esc_html($pr->{'descr'})) . "</td>\n" .
+		                        -class => "list",
+		                        $search_regexp ? () : -title => $pr->{'descr_long'}},
+		                        $search_regexp
+		                        ? esc_html_match_hl($pr->{'descr_long'}, $search_regexp)
+		                        : esc_html($pr->{'descr'})) .
+		      "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
-- 
1.7.9
