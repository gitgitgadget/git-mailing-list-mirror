From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 2/8] gitweb: Option for filling only specified info in fill_project_list_info
Date: Wed, 15 Feb 2012 21:38:46 +0100
Message-ID: <1329338332-30358-3-git-send-email-jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:41:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxlfS-0006Ay-Py
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab2BOUlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:31 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58575 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab2BOUl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:29 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so521741eek.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VswTU+PEfZjNV1k3B4LwMhUAY3UjNQQwNN//Dg0V7T4=;
        b=SMzmeDBH/qWZ02WoyPv8p1fbRRF6LjU4isy44mBj0d9I+RI/i37q/KYwve3QoJa4Xr
         a3qlyJF/pXNbRWdKIU1yCj7bVdvAcWjZIqkM81OyFnjoI49iQue1h9lfJ66G+TTZLsb6
         psfQvMuT2AicdEA+95ac8TRSPxMsO6ZgW6jYc=
Received: by 10.213.28.136 with SMTP id m8mr463118ebc.98.1329338488695;
        Wed, 15 Feb 2012 12:41:28 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.27
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:28 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190855>

Introduce project_info_needs_filling($pr, $key[, \%fill_only]), which
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

Changes from v1:
* Introduction of project_info_needs_filling() was moved to separate
  commit; this one just adds @fill_only / %fill_only, without actually 
  using it.

* It uses \%fill_only (reference to hash) rather than @fill_only,
  because project_info_needs_filling() now supports multiple keys,
  and because checking key in hash is faster O(1) than checking every
  element in array O(n).

  Though this shouldn't matter much, as @fill_only has at most two
  or three elements, as we would see in the next commit.

 gitweb/gitweb.perl |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e62c2ef..cae71f5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5195,54 +5195,66 @@ sub git_project_search_form {
 	print "</div>\n";
 }
 
-# entry for given @keys needs filling if at least one of keys in list
-# is not present in %$project_info
+
+# entry for given @keys needs filling if at least one of interesting keys
+# in list is not present in %$project_info; key is interesting if $fill_only
+# is not passed, or is empty (all keys are interesting in both of those cases),
+# or if key is in $fill_only hash
+#
+# USAGE:
+# * project_info_needs_filling($project_info, 'key', ...)
+# * project_info_needs_filling($project_info, 'key', ..., \%fill_only)
+#   where %fill_only = map { $_ => 1 } @fill_only;
 sub project_info_needs_filling {
+	my $fill_only = ref($_[-1]) ? pop : undef;
 	my ($project_info, @keys) = @_;
 
 	# return List::MoreUtils::any { !exists $project_info->{$_} } @keys;
 	foreach my $key (@keys) {
-		if (!exists $project_info->{$key}) {
+		if ((!$fill_only || !%$fill_only || $fill_only->{$key}) &&
+		    !exists $project_info->{$key}) {
 			return 1;
 		}
 	}
 	return;
 }
 
-
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
+	my %fill_only = map { $_ => 1 } @fill_only;
 	my @projects;
 
 	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
-		if (project_info_needs_filling($pr, 'age', 'age_string')) {
+		if (project_info_needs_filling($pr, 'age', 'age_string', \%fill_only)) {
 			my (@activity) = git_get_last_activity($pr->{'path'});
 			unless (@activity) {
 				next PROJECT;
 			}
 			($pr->{'age'}, $pr->{'age_string'}) = @activity;
 		}
-		if (project_info_needs_filling($pr, 'descr', 'descr_long')) {
+		if (project_info_needs_filling($pr, 'descr', 'descr_long', \%fill_only)) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
 			$descr = to_utf8($descr);
 			$pr->{'descr_long'} = $descr;
 			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
-		if (project_info_needs_filling($pr, 'owner')) {
+		if (project_info_needs_filling($pr, 'owner', \%fill_only)) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
 		if ($show_ctags &&
-		    project_info_needs_filling($pr, 'ctags')) {
+		    project_info_needs_filling($pr, 'ctags', \%fill_only)) {
 			$pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		}
 		if ($projects_list_group_categories &&
-		    project_info_needs_filling($pr, 'category')) {
+		    project_info_needs_filling($pr, 'category', \%fill_only)) {
 			my $cat = git_get_project_category($pr->{'path'}) ||
 			                                   $project_list_default_category;
 			$pr->{'category'} = to_utf8($cat);
-- 
1.7.9
