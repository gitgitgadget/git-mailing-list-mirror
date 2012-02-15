From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 3/8] gitweb: Faster project search
Date: Wed, 15 Feb 2012 21:38:47 +0100
Message-ID: <1329338332-30358-4-git-send-email-jnareb@gmail.com>
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
	id 1RxlfU-0006Ay-72
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab2BOUld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:33 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58575 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab2BOUlb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:31 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so521741eek.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=z9He8NJOuo4fLcU3RRvqkPNWr2gXlJaGrECaIvtT46E=;
        b=i8RNR+qZ7u2A+UWnBZJT48oY7j3wCa9jJpfKWYjWuU+kJA5euv1Rz5kGAhIrk5DpmU
         +kox0N6ZggWE8+CZZUnBdl1WTb8y6ol4iG9vYsd5iJcRUVtNJ1w2Vmy5f2pPdKLnpJiV
         5PHbmgJuXy1JxR+Cll8E7hilE+MHYIcVe3vN8=
Received: by 10.213.33.72 with SMTP id g8mr480047ebd.8.1329338490429;
        Wed, 15 Feb 2012 12:41:30 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.29
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:30 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190854>

Before searching by some field the information we search for must be
filled in.  For this fill_project_list_info() was enhanced in previous
commit to take additional parameters which part of projects info to
fill.  This way we can limit doing expensive calculations (like
running git-for-each-ref to get 'age' / "Last changed" info) only to
projects which we will show as search results.

With this commit the number of git commands used to generate search
results is 2*<matched projects> + 1, and depends on number of matched
projects rather than number of all projects (all repositories).

Note: this is 'git for-each-ref' to find last activity, and 'git config'
for each project, and 'git --version' once.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
search_projects_list() now pre-fills required parts of project info by
itself, so running fill_project_list_info() before calling it is no
longer necessary and actually you should not do it.

No changes from v1

 gitweb/gitweb.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cae71f5..cc2bd6d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2987,6 +2987,10 @@ sub search_projects_list {
 	return @$projlist
 		unless ($tagfilter || $searchtext);
 
+	# searching projects require filling to be run before it;
+	fill_project_list_info($projlist,
+	                       $tagfilter  ? 'ctags' : (),
+	                       $searchtext ? ('path', 'descr') : ());
 	my @projects;
  PROJECT:
 	foreach my $pr (@$projlist) {
@@ -5390,12 +5394,13 @@ sub git_project_list_body {
 	# filtering out forks before filling info allows to do less work
 	@projects = filter_forks_from_projects_list(\@projects)
 		if ($check_forks);
-	@projects = fill_project_list_info(\@projects);
-	# searching projects require filling to be run before it
+	# search_projects_list pre-fills required info
 	@projects = search_projects_list(\@projects,
 	                                 'searchtext' => $searchtext,
 	                                 'tagfilter'  => $tagfilter)
 		if ($tagfilter || $searchtext);
+	# fill the rest
+	@projects = fill_project_list_info(\@projects);
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
-- 
1.7.9
