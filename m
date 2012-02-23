From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 2/3] gitweb: Option for filling only specified info in fill_project_list_info
Date: Thu, 23 Feb 2012 16:54:47 +0100
Message-ID: <1330012488-7970-3-git-send-email-jnareb@gmail.com>
References: <1330012488-7970-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 16:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0b1O-0001R1-Pn
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 16:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab2BWPzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 10:55:50 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49856 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab2BWPzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 10:55:50 -0500
Received: by bkcjm19 with SMTP id jm19so1178058bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 07:55:48 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.205.127.130 as permitted sender) client-ip=10.205.127.130;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.205.127.130 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.205.127.130])
        by 10.205.127.130 with SMTP id ha2mr261019bkc.28.1330012548716 (num_hops = 1);
        Thu, 23 Feb 2012 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sWjPbMuKPPEAgPxH1OlO/Asmfl3sqfDl3qk6dUHytsQ=;
        b=XDkA2ij82e5ugfT21GjYpO8SsKDkhoqpiLWbfYuPt36tYHDmRX/1TqF31x542sUVqB
         l/gTs4U8gtQoWBfS14vYPfVOCOD7ZfooQS78wcn7g1pGl3VjWe4dd8UlDo6omnf5X5hq
         JMh34Dy/cOnD9u736MEReSZmVrwfFrmwT77Uo=
Received: by 10.205.127.130 with SMTP id ha2mr214249bkc.28.1330012548630;
        Thu, 23 Feb 2012 07:55:48 -0800 (PST)
Received: from localhost.localdomain (abvx74.neoplus.adsl.tpnet.pl. [83.8.221.74])
        by mx.google.com with ESMTPS id i2sm3550051bkd.10.2012.02.23.07.55.46
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 07:55:47 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330012488-7970-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191375>

Enhance fill_project_list_info() subroutine to accept optional
parameters that specify which fields in project information needs to
be filled.  If none are specified then fill_project_list_info()
behaves as it used to, and ensure that all project info is filled.

This is in preparation of future lazy filling of project info in
project search and pagination of sorted list of projects.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This could have been squashed with the next commit, but this way it is
pure refactoring that shouldn't change gitweb behavior, and hopefully
makes this patch easier to review.

Changes from v2:
* Instead of overloading project_info_needs_filling() to do both
  handling of which fields need to be filled, and which fields
  we want to have filled, just make its caller filter its arguments.

  This means that in this version of patch there are no changes to
  project_info_needs_filling() subroutine.

# Instead of handling both cases (the one with set of wanted keys,
  and the one where we want to fill all remaining info) in a single
  filtering subroutine, use two different anonymous subroutines
  to filter or not filter keys.

* Expanded comment about fill_project_list_info to include detailed
  description of when it does remove projects from returned list (and
  why it is), and examples for both types of usage of this subroutine.

* Rewritten major part of commit message, which in v2 was not updated
  to reflect new development, and referred to behavior in v1.

[Should I include changes from v1 here, in the future?]


On Mon, 20 Feb 2012, Junio C Hamano wrote
in http://thread.gmane.org/gmane.comp.version-control.git/190852/focus=191046
JH>
JH> I must say that the approach to put the set filtering logic inside
JH> project_info_needs_filling function smells like a bad API design.
JH>
JH> In other words, wouldn't a callchain that uses a more natural set of API
JH> functions be like this?
JH> 
JH>       # the top-level caller that is interested only in these two fields
JH>       fill_project_list_info($projlist, 'age', 'owner');
JH> 
JH>       # in fill_project_list_info()
JH>       my $projlist = shift;
JH>       my %wanted = map { $_ => 1 } @_;
JH> 
JH>       foreach my $pr (@$projlist) {
JH>               if (project_info_needs_filling($pr,
JH>                       filter_set(\%wanted, 'age', 'age_string'))) {

I think this might be an even better solution, instead of handling all
keys / selected keys in filter_set(), provide different $filter_set
subroutines:

        foreach my $pr (@$projlist) {
                  if (project_info_needs_filling($pr,
                          $filter_set->('age', 'age_string'))) {


 gitweb/gitweb.perl |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cdd84c7..7fb7a55 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5209,39 +5209,56 @@ sub project_info_needs_filling {
 	return;
 }
 
-# fills project list info (age, description, owner, category, forks)
+# fills project list info (age, description, owner, category, forks, etc.)
 # for each project in the list, removing invalid projects from
-# returned list
+# returned list, or fill only specified info.
+#
+# Invalid projects are removed from the returned list if and only if you
+# ask 'age' or 'age_string' to be filled, because they are the only fields
+# that run unconditionally git command that requires repository, and
+# therefore do always check if project repository is invalid.
+#
+# USAGE:
+# * fill_project_list_info(\@project_list, 'descr_long', 'ctags')
+#   ensures that 'descr_long' and 'ctags' fields are filled
+# * @project_list = fill_project_list_info(\@project_list)
+#   ensures that all fields are filled (and invalid projects removed)
+#
 # NOTE: modifies $projlist, but does not remove entries from it
 sub fill_project_list_info {
-	my $projlist = shift;
+	my ($projlist, @wanted_keys) = @_;
 	my @projects;
+	my $filter_set = sub { return @_; };
+	if (@wanted_keys) {
+		my %wanted_keys = map { $_ => 1 } @wanted_keys;
+		$filter_set = sub { return grep { $wanted_keys{$_} } @_; };
+	}
 
 	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
-		if (project_info_needs_filling($pr, 'age', 'age_string')) {
+		if (project_info_needs_filling($pr, $filter_set->('age', 'age_string'))) {
 			my (@activity) = git_get_last_activity($pr->{'path'});
 			unless (@activity) {
 				next PROJECT;
 			}
 			($pr->{'age'}, $pr->{'age_string'}) = @activity;
 		}
-		if (project_info_needs_filling($pr, 'descr', 'descr_long')) {
+		if (project_info_needs_filling($pr, $filter_set->('descr', 'descr_long'))) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
 			$descr = to_utf8($descr);
 			$pr->{'descr_long'} = $descr;
 			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
-		if (project_info_needs_filling($pr, 'owner')) {
+		if (project_info_needs_filling($pr, $filter_set->('owner'))) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
 		if ($show_ctags &&
-		    project_info_needs_filling($pr, 'ctags')) {
+		    project_info_needs_filling($pr, $filter_set->('ctags'))) {
 			$pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		}
 		if ($projects_list_group_categories &&
-		    project_info_needs_filling($pr, 'category')) {
+		    project_info_needs_filling($pr, $filter_set->('category'))) {
 			my $cat = git_get_project_category($pr->{'path'}) ||
 			                                   $project_list_default_category;
 			$pr->{'category'} = to_utf8($cat);
-- 
1.7.9
