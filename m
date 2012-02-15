From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/8] gitweb: Refactor checking if part of project info need filling
Date: Wed, 15 Feb 2012 21:38:45 +0100
Message-ID: <1329338332-30358-2-git-send-email-jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxlfR-0006Ay-K1
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab2BOUl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:28 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58575 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab2BOUl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:28 -0500
Received: by eekc14 with SMTP id c14so521741eek.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=n5/o/nqixUa50l+hKylijcxaLeQKcd90LRYtrp5U9mc=;
        b=hLpLszQ60s8YIEakxd/Y8eyQRT5Ca4m2lQGSbco1a3QbWN81Bbpy/KJkUxQgpNx1C6
         G01Obk/JJJVQeXvCDOA85Ab7DW1buBWsR0Pcye475fXX05U1qYa31HYtlXb+Y8aS/JYi
         yUtqzK8U2LUBzqIqXR+jASovOfpUUPfkyDBok=
Received: by 10.213.15.143 with SMTP id k15mr1531908eba.87.1329338486833;
        Wed, 15 Feb 2012 12:41:26 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.25
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:26 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190853>

Extract the check if given keys (given parts) of project info needs to
be filled into project_info_needs_filling() subroutine.  It is for now
a thin wrapper around "!exists $project_info->{$key}".

Note that "!defined" was replaced by more correct "!exists".

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
This patch is new in this series, and splits off introduction of
project_info_needs_filling() function from partial filling via
@fill_only.

Hopefully this makes change more clear.

Note that this change stands alone, regardless of speeding up project
search.

 gitweb/gitweb.perl |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 057ba5b..e62c2ef 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5195,6 +5195,21 @@ sub git_project_search_form {
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
+
 # fills project list info (age, description, owner, category, forks)
 # for each project in the list, removing invalid projects from
 # returned list
@@ -5206,24 +5221,28 @@ sub fill_project_list_info {
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
