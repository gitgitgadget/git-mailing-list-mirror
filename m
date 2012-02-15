From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/3] gitweb: Deal with HEAD pointing to unborn branch in "heads" view
Date: Wed, 15 Feb 2012 16:36:41 +0100
Message-ID: <1329320203-20272-2-git-send-email-jnareb@gmail.com>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
Cc: rajesh boyapati <boyapatisrajesh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 16:37:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxguw-0007s7-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 16:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab2BOPhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 10:37:01 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43242 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab2BOPg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 10:36:57 -0500
Received: by wics10 with SMTP id s10so595926wic.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OFJcV8vvLGK8AvFCwGQwiAo8XoyAR7dt8d1nU7XEeCs=;
        b=xPK8A8YCyGCv4+zRtTcUT0Ie3xbGOmOHgu0Q6GEMqSYNCy2iLUIVR/7+0KTvnG96QN
         /iK8XnaLa+tC6jxXBevu8WKU0VzfOuPOgV1Za8PgY95CAdQ77nepqCjVSWMYlPCSyLrf
         I1Tygi6DGlWZVFOwoze7qDhqqHPGjeJcDNsEM=
Received: by 10.180.83.70 with SMTP id o6mr9078569wiy.19.1329320216410;
        Wed, 15 Feb 2012 07:36:56 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id q2sm34200366wiy.7.2012.02.15.07.36.54
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 07:36:55 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190833>

Gitweb has problems if HEAD points to an unborn branch, with no
commits on it yet, but there are other branches present (so it is not
newly initialized repository).

This can happen if non-bare repository (with default 'master' branch)
is updated not via committing but by other means like push to it, or
Gerrit.  It can happen also just after running "git checkout --orphan
<new branch>" but before creating any new commit on this branch.

This commit adds test and fixes the issue of being on unborn branch
(of HEAD not pointing to a commit) in "heads" view, and also in
"summary" view -- which includes "heads" excerpt as subview.

While at it rename local variable $head to $head_at, as it points to
current commit rather than current branch name (HEAD contents).

Includes simple test for 'summary' view and being on unborn branch.

Reported-by: rajesh boyapati <boyapatisrajesh@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch first appeared on git mailing list in "Fwd: Git-web error"
as

  [PATCH] gitweb: Deal with HEAD pointing to unborn branch in "heads" view
  Message-Id: <201202032233.05324.jnareb@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/189805

The $head -> $head_at change is not really necessary, but while we are
changing that area of code I felt it would be good to make it better.


What we should do in the future is rework git_heads_body to work with
symbolic references rather than mark branches that point to the same
commit as HEAD does.

That would also help in the "detached HEAD" case...

 gitweb/gitweb.perl                     |    4 ++--
 t/t9500-gitweb-standalone-no-errors.sh |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 87a95e2..0fdca5b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5633,7 +5633,7 @@ sub git_tags_body {
 
 sub git_heads_body {
 	# uses global variable $project
-	my ($headlist, $head, $from, $to, $extra) = @_;
+	my ($headlist, $head_at, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
 	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
 
@@ -5642,7 +5642,7 @@ sub git_heads_body {
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
 		my %ref = %$entry;
-		my $curr = $ref{'id'} eq $head;
+		my $curr = defined $head_at && $ref{'id'} eq $head_at;
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 0f771c6..81246a6 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -739,4 +739,13 @@ test_expect_success \
 	'echo "\$projects_list_group_categories = 1;" >>gitweb_config.perl &&
 	 gitweb_run'
 
+# ----------------------------------------------------------------------
+# unborn branches
+
+test_expect_success \
+	'unborn HEAD: "summary" page (with "heads" subview)' \
+	'git checkout orphan_branch || git checkout --orphan orphan_branch &&
+	 test_when_finished "git checkout master" &&
+	 gitweb_run "p=.git;a=summary"'
+
 test_done
-- 
1.7.9
