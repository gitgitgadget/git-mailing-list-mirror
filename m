From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] gitweb: Option for filling only specified info in fill_project_list_info
Date: Sat,  4 Feb 2012 13:47:24 +0100
Message-ID: <1328359648-29511-2-git-send-email-jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:47:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtf1t-0003Yi-77
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 13:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab2BDMri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 07:47:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45531 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2BDMrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 07:47:36 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so1791879eaa.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Pdlp4+lFc7U+sot9xktHbI0LbBTWxTOUheovMJ5L0l8=;
        b=cH8g4C9BIWuQKWA2bkMvJeHm6ukStlP2aBBDs9lyytOQVddC/FcleSs0EzwlMsGUgr
         X7F64k8AA4K4kL19Aym9jCG2sidSxbocXvi+R10LTHnADU8gu0d5kNhdB2xizB45obff
         a77J46UvdUqns64Z9V1pXPc9uVOT2SrZZrB38=
Received: by 10.213.15.70 with SMTP id j6mr307139eba.52.1328359656250;
        Sat, 04 Feb 2012 04:47:36 -0800 (PST)
Received: from localhost.localdomain (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id z47sm26890568eeh.9.2012.02.04.04.47.34
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 04:47:35 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189863>

Introduce project_info_needs_filling($pr, $key[, @fill_only]), which
is now used in place of simple 'defined $pr->{$key}' to check if
specific slot in project needs to be filled.

This is in preparation of future lazy filling of project info in
project search and pagination of sorted list of projects.  The only
functional change is that fill_project_list_info() now checks if 'age'
is already filled before running git_get_last_activity().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This could have been squashed with the next commit, but this way it is
pure refactoring that shouldn't change gitweb behavior.

Adding project_info_needs_filling() subroutine could have been split
into separate commit, but it would be subroutine without use...

 gitweb/gitweb.perl |   41 +++++++++++++++++++++++++++++++----------
 1 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 913a463..b7a3752 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5185,35 +5185,56 @@ sub git_project_search_form {
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
+		# check if key is already filled
+		return !exists $project_info->{$key};
+	}
+	# uninteresting key, outside @fill_only
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
1.7.9
