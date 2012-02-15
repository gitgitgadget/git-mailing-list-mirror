From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2/RFC 2/3] gitweb: Harden parse_commit and parse_commits
Date: Wed, 15 Feb 2012 16:36:42 +0100
Message-ID: <1329320203-20272-3-git-send-email-jnareb@gmail.com>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
Cc: rajesh boyapati <boyapatisrajesh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 16:37:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxguy-0007s7-PH
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 16:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab2BOPhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 10:37:03 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58019 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab2BOPg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 10:36:58 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so595904wic.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Dx7mCK+REHPKXSykv1AVDMzQglq67+Gk/UU2p27lTIo=;
        b=O+ZrPJdzvuwoXV4C6sRwGyUKPTc73/Xo8L/2IJbeD7s0xSCDcBNz5OxdLxjWpP9VnW
         K8yBVuHlqJtoLXfmdUhJBq+IfgR7hL7ny7ALMuvrZi8rBYDKXf45fCWJH17cOxRbg+tJ
         AHxlL6QKBowYiGSLah60IwAhXR3VCsjLEYTZA=
Received: by 10.216.134.87 with SMTP id r65mr9693976wei.46.1329320218230;
        Wed, 15 Feb 2012 07:36:58 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id q2sm34200366wiy.7.2012.02.15.07.36.56
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 07:36:57 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190835>

Gitweb has problems and gives errors when repository it shows is on
unborn branch (HEAD doesn't point to a valid commit), but there exist
other branches.

One of errors that shows in gitweb logs is undefined $commit_id in
parse_commits() subroutine.  Therefore we harden both parse_commit()
and parse_commits() against undefined $commit_id, and against no
output from git-rev-list because HEAD doesn't point to a commit.

Reported-by: rajesh boyapati <boyapatisrajesh@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch first appeared on git mailing list in "Fwd: Git-web error"
thread as

  [PATCH] gitweb: Harden parse_commit and parse_commits
  Message-Id: <201202081604.17187.jnareb@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/190237

More prevention of generating warnings, rather than real fix.

 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0fdca5b..2eaf585 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3334,6 +3334,8 @@ sub parse_commit {
 	my ($commit_id) = @_;
 	my %co;
 
+	return unless defined $commit_id;
+
 	local $/ = "\0";
 
 	open my $fd, "-|", git_cmd(), "rev-list",
@@ -3343,7 +3345,9 @@ sub parse_commit {
 		$commit_id,
 		"--",
 		or die_error(500, "Open git-rev-list failed");
-	%co = parse_commit_text(<$fd>, 1);
+	my $commit_text = <$fd>;
+	%co = parse_commit_text($commit_text, 1)
+		if defined $commit_text;
 	close $fd;
 
 	return %co;
@@ -3353,6 +3357,7 @@ sub parse_commits {
 	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
 	my @cos;
 
+	return unless defined $commit_id;
 	$maxcount ||= 1;
 	$skip ||= 0;
 
-- 
1.7.9
