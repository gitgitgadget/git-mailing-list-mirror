From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Faster project search
Date: Sat,  4 Feb 2012 13:47:25 +0100
Message-ID: <1328359648-29511-3-git-send-email-jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:48:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtf2B-0003kS-Lc
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 13:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab2BDMrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 07:47:42 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38040 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2BDMrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 07:47:39 -0500
Received: by eekc14 with SMTP id c14so1494818eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 04:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ny9fHFdDh1NeWLZ4rXRQ/XOExKRG8n2yLvBOzMuDcAo=;
        b=XRkPgAk8tuLHWfWbQG7ZdKffaqH6uCNY4s37hPG+Utn7+H8d+7wsQdX9O+0nUbU6ku
         CEycA/7SQsMhwlEesK1/VhCVZI6Bw9vS24eVQozHamSkJHFGwFls3FmtQ+o/oJAu/D0E
         jWyBxjTIVITXifYWS1CiWdkG8vRfLMydT/lVE=
Received: by 10.14.98.135 with SMTP id v7mr3570476eef.27.1328359657926;
        Sat, 04 Feb 2012 04:47:37 -0800 (PST)
Received: from localhost.localdomain (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id z47sm26890568eeh.9.2012.02.04.04.47.36
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 04:47:37 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189868>

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

 gitweb/gitweb.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b7a3752..95ca00f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2989,6 +2989,10 @@ sub search_projects_list {
 	return @$projlist
 		unless ($tagfilter || $searchtext);
 
+	# searching projects require filling to be run before it;
+	fill_project_list_info($projlist,
+	                       $tagfilter  ? 'ctags' : (),
+	                       $searchtext ? ('path', 'descr') : ());
 	my @projects;
  PROJECT:
 	foreach my $pr (@$projlist) {
@@ -5370,12 +5374,13 @@ sub git_project_list_body {
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
