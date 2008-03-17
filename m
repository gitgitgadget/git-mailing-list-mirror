From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 3/3] gitweb: Fill project details lazily when caching
Date: Mon, 17 Mar 2008 16:09:30 +0100
Message-ID: <1205766570-13550-4-git-send-email-jnareb@gmail.com>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 16:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbGyn-00070S-Ni
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbYCQPJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYCQPJq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:09:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:53008 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbYCQPJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:09:44 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1821629fgb.17
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eromwiduucYOxtRbWJPP1UwjWMAQDCBtANemKZPXKac=;
        b=llbpDfnXXG5FBIhf59Q8VwWvwttyOIBlPQe9MzH4AFtMCYn8t1bqwvnu2INHUNnan/oKC/oSZJHvgxIPfdXTgPu5z+2SecHcJB5b7zfSG8WLQjvDFu5rxkJUEIGmFrEtzzEZkaLk1IYiRyvYgFyu6pjRcbwlfiMhlGVu/p6LiKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ukPJC70/jhHWhZIs6FjH+7AIV9FYwTbLnXc4qyqRphqFpGxVorqfLPVzguJn10BXkDXwWkq+Ym0kJJoUCeWSMR4Z/U99lRxkHxzZ4FBK/UII8CJ7YuYAJUOBpGuSlm4DsLZlbGbhBJjNKmYCcOfeCMXho9tobQhAIZiAihNSe1w=
Received: by 10.82.191.3 with SMTP id o3mr36793500buf.17.1205766582629;
        Mon, 17 Mar 2008 08:09:42 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.232.138])
        by mx.google.com with ESMTPS id 13sm14005969fks.8.2008.03.17.08.09.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 08:09:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2HF9eI0013582;
	Mon, 17 Mar 2008 16:09:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2HF9dh3013581;
	Mon, 17 Mar 2008 16:09:39 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1205766570-13550-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77436>

If caching is turned on project details can be filled in already from
the cache.  When refreshing project info details for all project (when
cache is stale and has to be refreshed) generate projects info only if
modification time (as returned by lstat()) of projects repository
gitdir changed.

This way we can avoid hitting repository refs, object database and
repository config at the cost of additional lstat.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is an idea for further improvement of 'projects list caching'.
Could you please: 

 1.) comment if it is a good idea, or why it works, or why it
     couldn't work :),  

 2.) check if this change gives any improvements in performance on
     real data; note that testing would require updating repositories
     if test on generated data was done, or gathering statistics over
     larger time period if it was tested on "live" set.

Thanks in advance.

 gitweb/gitweb.perl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5527378..1741628 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3487,8 +3487,14 @@ sub git_patchset_body {
 sub git_get_projects_details {
 	my ($projlist, $check_forks) = @_;
 
+	use File::stat;
 	my @projects;
 	foreach my $pr (@$projlist) {
+		my $mtime;
+		if ($cached && $pr->{'mtime'}) {
+			$mtime = lstat("$projectroot/$pr->{'path'}")->mtime;
+			next if ($mtime <= $pr->{'mtime'});
+		}
 		my (@aa) = git_get_last_activity($pr->{'path'});
 		unless (@aa) {
 			next;
@@ -3513,6 +3519,9 @@ sub git_get_projects_details {
 				$pr->{'forks'} = 0;
 			}
 		}
+		if ($cached) {
+			$pr->{'mtime'} = $mtime;
+		}
 		push @projects, $pr;
 	}
 	return @projects;
-- 
1.5.4.3.453.gc1ad83
