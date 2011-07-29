From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 3/6] gitweb: Option for filling only specified info in fill_project_list_info
Date: Fri, 29 Jul 2011 13:52:56 +0200
Message-ID: <1311940379-9608-4-git-send-email-jnareb@gmail.com>
References: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:53:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmldO-0005xQ-7l
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab1G2Lxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:53:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48460 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab1G2Lx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:53:29 -0400
Received: by fxh19 with SMTP id 19so2225423fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=anuejjbdV2e5bQQdhK4VsQS751k420hkyrA49yNVyCA=;
        b=Pnre6VE1dJBtlxjMbY6tGPwjef2K8SquPPS+xuvXe1L3VokYqmvMj52rtC+fpfXTw8
         rJDO+8S7S5N4cPn234ZL9xo9DQyXMSlJYx97zVhQbyw/EnpC9iRhfITlDKKf5Qhf27zL
         l/SrETEbJknWlyCLpd7OnuTi0HCe8Ekf678sg=
Received: by 10.223.30.87 with SMTP id t23mr1666390fac.51.1311940407995;
        Fri, 29 Jul 2011 04:53:27 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id n27sm1049500faa.4.2011.07.29.04.53.26
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 04:53:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178134>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The API was tweaked to better fit the following patch.

This patch probably needs longer commit message... or squashing with
the following commit.

 gitweb/gitweb.perl |   39 +++++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3e69705..4c66307 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4988,35 +4988,54 @@ sub git_project_search_form {
 	print "</div>\n";
 }
 
+# entry for given $key doesn't need filling if either $key already exists
+# in $project_info hash, or we are interested only in subset of keys
+# and given key is not among @fill_only.
+sub project_info_needs_filling {
+	my ($project_info, $key, @fill_only) = @_;
+
+	if (!@fill_only ||            # we are interested in everything
+	    grep { $key eq $_ } @fill_only) { # or key is in @fill_only
+		return !exists $project_info->{$key};
+	}
+	return 0;
+}
+
 # fills project list info (age, description, owner, category, forks)
 # for each project in the list, removing invalid projects from
-# returned list
+# returned list, or fill only specified info (removing invalid projects
+# only when filling 'age').
+#
 # NOTE: modifies $projlist, but does not remove entries from it
 sub fill_project_list_info {
-	my $projlist = shift;
+	my ($projlist, @fill_only) = @_;
 	my @projects;
 
 	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
-		my (@activity) = git_get_last_activity($pr->{'path'});
-		unless (@activity) {
-			next PROJECT;
+		if (project_info_needs_filling($pr, 'age', @fill_only)) {
+			my (@activity) = git_get_last_activity($pr->{'path'});
+			unless (@activity) {
+				next PROJECT;
+			}
+			($pr->{'age'}, $pr->{'age_string'}) = @activity;
 		}
-		($pr->{'age'}, $pr->{'age_string'}) = @activity;
-		if (!defined $pr->{'descr'}) {
+		if (project_info_needs_filling($pr, 'descr', @fill_only)) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
 			$descr = to_utf8($descr);
 			$pr->{'descr_long'} = $descr;
 			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
-		if (!defined $pr->{'owner'}) {
+		if (project_info_needs_filling($pr, 'owner', @fill_only)) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
-		if ($show_ctags) {
+		if ($show_ctags &&
+		    project_info_needs_filling($pr, 'ctags', @fill_only)) {
 			$pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		}
-		if ($projects_list_group_categories && !defined $pr->{'category'}) {
+		if ($projects_list_group_categories &&
+		    project_info_needs_filling($pr, 'category', @fill_only)) {
 			my $cat = git_get_project_category($pr->{'path'}) ||
 			                                   $project_list_default_category;
 			$pr->{'category'} = to_utf8($cat);
-- 
1.7.5
