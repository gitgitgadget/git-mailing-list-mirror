From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 1/3] gitweb: Refactor checking if part of project info need filling
Date: Thu, 23 Feb 2012 16:54:46 +0100
Message-ID: <1330012488-7970-2-git-send-email-jnareb@gmail.com>
References: <1330012488-7970-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 16:55:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0b0l-0000xs-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 16:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab2BWPzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 10:55:09 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48492 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2BWPzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 10:55:08 -0500
Received: by mail-bk0-f46.google.com with SMTP id jm19so1176822bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 07:55:07 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.205.124.17 as permitted sender) client-ip=10.205.124.17;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.205.124.17 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.205.124.17])
        by 10.205.124.17 with SMTP id gm17mr1070654bkc.12.1330012507802 (num_hops = 1);
        Thu, 23 Feb 2012 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=27dUP7A6WjI0Qdu7pO3FDfS6UxXo3GlPKPUEEVRA/oA=;
        b=jbz7556VSZzGpCS/jzrtRftsYSMiO5HQ7oCn1FivXgJun8VAqChQ1lKvIdiWNLPu0s
         eK40WR+R+3cwVuGPJjMrRHNLiH/yBwqBaMB7zEKjDE4LxS2onUkcT1O+HeqAwOzqR4To
         Ye7m9LmrvE2ZrCdFk84uUZ0hhoQQnLHOdgTVk=
Received: by 10.205.124.17 with SMTP id gm17mr887791bkc.12.1330012507715;
        Thu, 23 Feb 2012 07:55:07 -0800 (PST)
Received: from localhost.localdomain (abvx74.neoplus.adsl.tpnet.pl. [83.8.221.74])
        by mx.google.com with ESMTPS id i2sm3550051bkd.10.2012.02.23.07.55.06
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 07:55:07 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330012488-7970-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191374>

Extract the check if given keys (given parts) of project info needs to
be filled into project_info_needs_filling() subroutine.  It is for now
a thin wrapper around "!exists $project_info->{$key}".

Note that !defined was replaced by more correct !exists.

While at it uniquify treating of all project info, adding checks for
'age' field before running git_get_last_activity(), and also checking
for all keys filled in code protected by conditional, and not only
one.

The code now looks like this

  foreach my $project (@$project_list) {
  	if (given keys need to be filled) {
  		fill given keys
  	}
  	...
  }

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch appeared for first time in v2 of this series, and split off
introduction of project_info_needs_filling() function from partial
filling via @wanted_keys... which in this version of series is not
done in project_info_needs_filling() anyway.

Almost no changes from v2:
* Remove duplication of empty line between project_info_needs_filling()
  and fill_project_list_info()

 gitweb/gitweb.perl |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 057ba5b..cdd84c7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5195,6 +5195,20 @@ sub git_project_search_form {
 	print "</div>\n";
 }
 
+# entry for given @keys needs filling if at least one of keys in list
+# is not present in %$project_info
+sub project_info_needs_filling {
+	my ($project_info, @keys) = @_;
+
+	# return List::MoreUtils::any { !exists $project_info->{$_} } @keys;
+	foreach my $key (@keys) {
+		if (!exists $project_info->{$key}) {
+			return 1;
+		}
+	}
+	return;
+}
+
 # fills project list info (age, description, owner, category, forks)
 # for each project in the list, removing invalid projects from
 # returned list
@@ -5206,24 +5220,28 @@ sub fill_project_list_info {
 	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
-		my (@activity) = git_get_last_activity($pr->{'path'});
-		unless (@activity) {
-			next PROJECT;
+		if (project_info_needs_filling($pr, 'age', 'age_string')) {
+			my (@activity) = git_get_last_activity($pr->{'path'});
+			unless (@activity) {
+				next PROJECT;
+			}
+			($pr->{'age'}, $pr->{'age_string'}) = @activity;
 		}
-		($pr->{'age'}, $pr->{'age_string'}) = @activity;
-		if (!defined $pr->{'descr'}) {
+		if (project_info_needs_filling($pr, 'descr', 'descr_long')) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
 			$descr = to_utf8($descr);
 			$pr->{'descr_long'} = $descr;
 			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
-		if (!defined $pr->{'owner'}) {
+		if (project_info_needs_filling($pr, 'owner')) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
-		if ($show_ctags) {
+		if ($show_ctags &&
+		    project_info_needs_filling($pr, 'ctags')) {
 			$pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		}
-		if ($projects_list_group_categories && !defined $pr->{'category'}) {
+		if ($projects_list_group_categories &&
+		    project_info_needs_filling($pr, 'category')) {
 			my $cat = git_get_project_category($pr->{'path'}) ||
 			                                   $project_list_default_category;
 			$pr->{'category'} = to_utf8($cat);
-- 
1.7.9
