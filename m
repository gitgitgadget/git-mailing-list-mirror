From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2 3/3] gitweb: Silence stderr in parse_commit*() subroutines
Date: Wed, 15 Feb 2012 16:36:43 +0100
Message-ID: <1329320203-20272-4-git-send-email-jnareb@gmail.com>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
Cc: rajesh boyapati <boyapatisrajesh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 16:37:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxguz-0007s7-AI
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 16:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab2BOPhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 10:37:06 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43242 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2BOPhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 10:37:03 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so595926wic.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gBwQn3RTuMd4Vn1aLnJ+ANIY92o4DuLbsteGqWhkHyI=;
        b=kSoocSvg0tmNv9vHRuEHoo1o5dLMgMv3zV4J4xrIUglqLEiWAdHShBfCajmfGSMnPS
         0AH3GXgDTXv7gaN+uHuw/FEjzNUC3PExvK6I9N9NudCACd042xV3lLnEg2tRkkj//r5H
         WyxERmbzi9yK7uaMqUSyCMNfZUNZ7wc54N+Kg=
Received: by 10.216.131.210 with SMTP id m60mr9898721wei.47.1329320222195;
        Wed, 15 Feb 2012 07:37:02 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id q2sm34200366wiy.7.2012.02.15.07.36.58
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 07:37:01 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190834>

git-rev-list command in parse_commit() and parse_commits() can fail
because $commit_id doesn't point to a valid commit; for example if we
are on unborn branch HEAD doesn't point to a valid commit.

In this case git-rev-list prints

  fatal: bad revision 'HEAD'

on its standard error.  This commit silences this warning, at the cost
of using shell to redirect it to /dev/null, and relying on
quote_command() to protect against code injection.

Note however that such error message from git (from external command)
usually (but not always) does not appear in web server logs.

Reported-by: rajesh boyapati <boyapatisrajesh@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch first appeared on git mailing list in "Fwd: Git-web error"
thread as

  [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
  Message-Id: <201202111402.31684.jnareb@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/190511

More proof of concept rather than real fix for real issue;
it doesn't even fix the issue (for some reason) for original
poster.

 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2eaf585..224ace4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3338,12 +3338,13 @@ sub parse_commit {
 
 	local $/ = "\0";
 
-	open my $fd, "-|", git_cmd(), "rev-list",
+	open my $fd, "-|", quote_command(
+		git_cmd(), "rev-list",
 		"--parents",
 		"--header",
 		"--max-count=1",
 		$commit_id,
-		"--",
+		"--") . ' 2>/dev/null',
 		or die_error(500, "Open git-rev-list failed");
 	my $commit_text = <$fd>;
 	%co = parse_commit_text($commit_text, 1)
@@ -3363,7 +3364,8 @@ sub parse_commits {
 
 	local $/ = "\0";
 
-	open my $fd, "-|", git_cmd(), "rev-list",
+	open my $fd, "-|", quote_command(
+		git_cmd(), "rev-list",
 		"--header",
 		@args,
 		("--max-count=" . $maxcount),
@@ -3371,7 +3373,7 @@ sub parse_commits {
 		@extra_options,
 		$commit_id,
 		"--",
-		($filename ? ($filename) : ())
+		($filename ? ($filename) : ())) . ' 2>/dev/null'
 		or die_error(500, "Open git-rev-list failed");
 	while (my $line = <$fd>) {
 		my %co = parse_commit_text($line);
-- 
1.7.9
