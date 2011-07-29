From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 4/6] gitweb: Faster project search
Date: Fri, 29 Jul 2011 13:52:57 +0200
Message-ID: <1311940379-9608-5-git-send-email-jnareb@gmail.com>
References: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmldP-0005xQ-Ob
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab1G2Lxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:53:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65163 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379Ab1G2Lxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:53:30 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2225343fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WyfyO5arSg1SUnMoZMJK02Yk1UpARsO21N2LdlryYcc=;
        b=QwLJh0UgFUjyexp7oNOHeyPdRxB9CWndl0gjOOdwA3WkVmLuzZ8e09pZhw4egcPq0m
         aLZzMyQx7eb6iJ6h2zDNY9D6csP6DqHqpZPFwmWuONenTEuX1MtgGwJ1C7v2gDwJNgN4
         awvARetwiSAdY0jVtxzGxhreoZZA4XQxpmvyI=
Received: by 10.223.97.131 with SMTP id l3mr1713416fan.43.1311940409779;
        Fri, 29 Jul 2011 04:53:29 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id n27sm1049500faa.4.2011.07.29.04.53.28
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 04:53:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178136>

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
I have checked it by running gitweb with 'timed' feature enabled, but
I didn't benchmark it.  

This is a win especially for hosting sites with many projects, though
they either need to have caching, or not show full project list but
only search form by default, or paginate projects list.  

BTW. I am thinking about adding configuration which would make gitweb
show only search form if number of project is higher than some
configured threshold.  What do you think of this idea?

 gitweb/gitweb.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4c66307..9c82d79 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2933,6 +2933,10 @@ sub search_projects_list {
 	return @$projlist
 		unless ($tagfilter || $searchtext);
 
+	# searching projects require filling to be run before it;
+	fill_project_list_info($projlist,
+	                       $tagfilter  ? 'ctags' : (),
+	                       $searchtext ? ('path', 'descr') : ());
 	my @projects;
  PROJECT:
 	foreach my $pr (@$projlist) {
@@ -5171,12 +5175,13 @@ sub git_project_list_body {
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
1.7.5
