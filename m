From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 3/3] gitweb: Faster project search
Date: Thu, 23 Feb 2012 16:54:48 +0100
Message-ID: <1330012488-7970-4-git-send-email-jnareb@gmail.com>
References: <1330012488-7970-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 16:56:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0b1z-0001tK-NC
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 16:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab2BWP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 10:56:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63750 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab2BWP40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 10:56:26 -0500
Received: by bkcjm19 with SMTP id jm19so1178897bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 07:56:25 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.204.151.77 as permitted sender) client-ip=10.204.151.77;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.204.151.77 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.204.151.77])
        by 10.204.151.77 with SMTP id b13mr1023538bkw.57.1330012585342 (num_hops = 1);
        Thu, 23 Feb 2012 07:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=n/4jN414pY/ygz8kks+P/LNe7pt7a4kut9KcKbx2Z7U=;
        b=c9We7l3JyaCNBHaeb0W4WFU7CQSyxGxoQitMG6NQNqp5WFFZIl0RdaOEqcU8aOEgwY
         e4uNgCRz4wI/OzFVcsD6N+f1UAm9UsXzJIJQG8kKh7g+2YcZsdzXNN6vjXbJtwtbbwUP
         HqNZB9VHRWhNdLzzCdeE3twXvO7xJmf14+13U=
Received: by 10.204.151.77 with SMTP id b13mr849120bkw.57.1330012585219;
        Thu, 23 Feb 2012 07:56:25 -0800 (PST)
Received: from localhost.localdomain (abvx74.neoplus.adsl.tpnet.pl. [83.8.221.74])
        by mx.google.com with ESMTPS id i2sm3550051bkd.10.2012.02.23.07.56.23
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 07:56:24 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330012488-7970-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191376>

Before searching by some field the information we search for must be
filled in, but we do not have to fill other fields that are not
involved in the search.

To be able to request filling only specified fields,
fill_project_list_info() was enhanced in previous commit to take
additional parameters which specify part of projects info to fill.
This way we can limit doing expensive calculations (like running
git-for-each-ref to get 'age' / "Last changed" info) to doing those
only for projects which we will show as search results.

This commit actually uses this interface, changing gitweb code from
the following behavior

  fill all project info on all projects
  search projects

to behaving like this pseudocode

  fill search fields on all projects
  search projects
  fill all project info on search results


With this commit the number of git commands used to generate search
results is 2*<matched projects> + 1, and depends on number of matched
projects rather than number of all projects (all repositories).

Note: this is 'git for-each-ref' to find last activity, and 'git config'
for each project, and 'git --version' once.


Example performance improvements, for search that selects 2
repositories out of 12 in total:

* Before (warm cache):
  "This page took 0.867151 seconds  and 27 git commands to generate."

* After (warm cache):
  "This page took 0.673643 seconds  and 5 git commands to generate."

Now imagine that they are 5 repositories out of 5000, and cold or
trashed cache case.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from v2 (v2 is the same as v1):
* Rewritten and extended commit message (though extending perhaps have
  gone too far...).

  Added paragraphs are "This commit actually uses this interface..."
  and "Example performance improvements..."


Junio C Hamano wrote in
http://thread.gmane.org/gmane.comp.version-control.git/190852/focus=191053
[...]
JC> "must be filled in." is correct, but that happens without the previous
JC> patch.  The first sentence must also say:
JC> 
JC>         In order to search by some field, the information we look for must
JC>         be filled in, but we do not have to fill other fields that are not
JC>         involved in the search.
JC> 
JC> to justify the previous "fill_project_list_info can be asked to return
JC> without getting unused fields" patch.  

Done.  Thanks for a suggestion.

JC> The rest of the log message then makes good sense.

Ooops...

 gitweb/gitweb.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fb7a55..4ceb1a6 100755
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
@@ -5394,12 +5398,13 @@ sub git_project_list_body {
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
